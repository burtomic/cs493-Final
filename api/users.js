const router = require('express').Router();


const { validateAgainstSchema } = require('../lib/validation');

const {
  UserSchema,
  insertNewUser,
  getUserById,
  getUserByEmail,
  validateUser
} = require('../models/users');
const { generateAuthToken, requireAuthentication, checkAuthentication } = require('../lib/auth');

router.post('/', checkAuthentication, async (req, res) => {

  if((req.body.role == "instructor" || req.body.role == "admin")  && req.role != "admin") {
    res.status(403).send({
      error: "Must be logged in as admin to create another admin."
    });
  } else {
    if (validateAgainstSchema(req.body, UserSchema)) {
      try {
        const id = await insertNewUser(req.body);
        res.status(201).send({
          _id: id
        });
      } catch (err) {
        console.error("  -- Error:", err);
        res.status(500).send({
          error: "Error inserting new user.  Try again later."
        });
      }
    } else {
      res.status(400).send({
        error: "Request body does not contain a valid User."
      });
    }
  }
});

router.get('/:id', requireAuthentication, async (req, res, next) => {

  if (req.user !== req.params.id) {
    console.log(req.user);
    res.status(403).send({
      error: "Unauthorized to access the specified resource"
    });
  } else {
    try {
      const user = await getUserById(req.params.id);
      if (user) {
        res.status(200).send(user);
      } else {
        next();
      }
    } catch (err) {
      console.error("  -- Error:", err);
      res.status(500).send({
        error: "Error fetching user.  Try again later."
      });
    }
  }
});

router.post('/login', async (req, res) => {
  console.log("here");
  if (req.body && req.body.email && req.body.password) {
    try {
      const authenticated = await validateUser(
        req.body.email,
        req.body.password
      );
      console.log(req.body.email);
      if (authenticated) {
        const user =  await getUserByEmail(req.body.email, false);
        console.log("User:", user)
        const token = generateAuthToken(user.id, user.role);
        res.status(200).send({
          token: token
        });
      } else {
        res.status(401).send({
          error: "Invalid authentication credentials."
        })
      }
    } catch (err) {
      console.error("  -- error:", err);
      res.status(500).send({
        error: "Error logging in.  Try again later."
      });
    }
  } else {
    res.status(400).send({
      error: "Request body needs a user email and password."
    });
  }
});

module.exports = router;
