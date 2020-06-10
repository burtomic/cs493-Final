const router = require('express').Router();

const { validateAgainstSchema } = require('../lib/validation');

const {
  AssignmentSchema,
  AssignmentPatchSchema,
  insertNewAssignment,
  getCourse,
  getAssignmentById,
  patchAssignment
} = require('../models/assignments');

const { generateAuthToken, requireAuthentication, checkAuthentication } = require('../lib/auth');

router.post('/', checkAuthentication, async (req, res) => {

    const course = await getCourse( req.body.courseId );
  if(!(req.role == "instructor" && ( course.instructorId == req.user )) && req.role != "admin") {
    res.status(403).send({
      error: "The request was not made by an authenticated Admin or Instructor with a matching Course instructorId."
    });
  } else {
    if (validateAgainstSchema(req.body, AssignmentSchema)) {
      try {
        const id = await insertNewAssignment(req.body);
        res.status(201).send({
            _id: id
        });
      } catch (err) {
        console.error("  -- Error:", err);
        res.status(500).send({
          error: "Error inserting new assignment.  Try again later."
        });
      }
    } else {
      res.status(400).send({
        error: "The request body was either not present or did not contain a valid Assignment object."
      });
    }
  }
});

router.get('/:id', async (req, res, next) => {
    
    try {
    const user = await getAssignmentById(req.params.id);
    if (user) {
        res.status(200).send(user);
    } else {
        next();
    }
    } catch (err) {
    console.error("  -- Error:", err);
    res.status(500).send({
        error: "Error fetching assignment by id.  Try again later."
    });
    }
  });

  router.patch('/:id', checkAuthentication, async (req, res, next) => {
    
    const assignment = await getAssignmentById( req.params.id );
    const course = await getCourse( assignment.courseId );
    console.log(course);
    if(!(req.role == "instructor" && ( course.instructorId == req.user )) && req.role != "admin") {
        res.status(403).send({
        error: "The request was not made by an authenticated Admin or Instructor with a matching Course instructorId."
        });
    } else {
        if (validateAgainstSchema(req.body, AssignmentPatchSchema)) {
        try {
            const result = await patchAssignment(req.body, req.params.id);
            res.status(200).send({
                Message: "Success"
            });
        } catch (err) {
            console.error("  -- Error:", err);
            res.status(500).send({
            error: "Error patching new assignment. Try again later."
            });
        }
        } else {
        res.status(400).send({
            error: "The request body was either not present or did not contain any fields related to Assignment objects."
        });
        }
    }
  });


module.exports = router;