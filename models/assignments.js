const bcrypt = require('bcryptjs');
const { extractValidFields } = require('../lib/validation');
const mysqlPool = require('../lib/mysqlPool');

const AssignmentSchema = {
    courseId: {required: true },
    title: {required: true},
    points: {required: true},
    due: {required: true}
  };

  exports.AssignmentSchema=AssignmentSchema;

  const AssignmentPatchSchema = {
    courseId: {required: false },
    title: {required: false},
    points: {required: false},
    due: {required: false}
  };

  exports.AssignmentPatchSchema=AssignmentPatchSchema;

  exports.insertNewAssignment = async function (assignment) {
    const assignmentToInsert = extractValidFields(assignment, AssignmentSchema);
    console.log("  -- assignmentToInsert:", assignmentToInsert);

    const [ result ] = await mysqlPool.query(
        'INSERT INTO assignments SET ?',
        assignmentToInsert
    );
    return result.insertId;
  };

  exports.getCourse = async function (courseId) {
    const [ results ] = await mysqlPool.query(
        'SELECT instructorId FROM courses WHERE number = ?',
        courseId
    );
    return results[0];
  };

  exports.getAssignmentById = async function (assignment) {
    const [ results ] = await mysqlPool.query(
        'SELECT id, courseId, title, points, CONVERT_TZ(due,\'+00:00\',\'-7:00\') FROM assignments WHERE id = ?',
        assignment
    );

    return results[0];
  };

  exports.patchAssignment = async function (assignment, id) {
    const assignmentToInsert = extractValidFields(assignment, AssignmentSchema);
    console.log("  -- assignmentToInsert:", assignmentToInsert);

    sql = extractValidFields( assignment, AssignmentSchema );
    
    const [ results ] = await mysqlPool.query(
      'UPDATE assignments SET ? WHERE id = ?',
      [ assignment, id ]
  );

    return true;
  };