const bcrypt = require('bcryptjs');
const { extractValidFields } = require('../lib/validation');
const mysqlPool = require('../lib/mysqlPool');

const UserSchema = {
    name: {required: true },
    email: {required: true},
    password:{required: true},
    role: {required: false}
  };

  exports.UserSchema=UserSchema;


  exports.insertNewUser = async function (user) {
    const userToInsert = extractValidFields(user, UserSchema);
    console.log("  -- userToInsert:", userToInsert);
    userToInsert.password = await bcrypt.hash(
      userToInsert.password,
      8
    );
    console.log("  -- userToInsert after hash:", userToInsert);
    const [ result ] = await mysqlPool.query(
        'INSERT INTO users SET ?',
        userToInsert
    );
    return result.insertId;
  };
  
  
  /*
   * Fetch a user from the DB based on user ID.
   */
  exports.getUserById = async function (id, includePassword) {
    if(includePassword) {
        const [ results ] = await mysqlPool.query(
            'SELECT * FROM users WHERE id = ?',
            [ id ]
        );
        return results[0];

    } else {
        const [ results ] = await mysqlPool.query(
            'SELECT id, name, email, role FROM users WHERE id = ?',
            [ id ]
        );
        console.log("results:", results[0]);
        return results[0];
    }
  };

  exports.getUserByEmail = async function (id, includePassword) {
    if(includePassword) {
        const [ results ] = await mysqlPool.query(
            'SELECT * FROM users WHERE email = ?',
            [ id ]
        );
        return results[0];

    } else {
        const [ results ] = await mysqlPool.query(
            'SELECT * from users'
        );
        return results;
    }
  };
  
  exports.validateUser = async function(id, password) {
    const user = await exports.getUserByEmail(id, true);
    return user &&
      await bcrypt.compare(password, user.password);
  };