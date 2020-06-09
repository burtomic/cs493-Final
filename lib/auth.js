const jwt = require('jsonwebtoken');

const secretKey = 'SuperSecret123';

exports.generateAuthToken = function (userId, role) {
  const payload = { sub: userId, role: role };
  return jwt.sign(payload, secretKey, { expiresIn: '24h' });
};



exports.requireAuthentication = function (req, res, next) {
  /*
   * Authorization: Bearer <token>
   */
  const authHeader = req.get('Authorization') || '';
  const authHeaderParts = authHeader.split(' ');
  const token = authHeaderParts[0] === 'Bearer' ?
    authHeaderParts[1] : null;
  try {
    const payload = jwt.verify(token, secretKey);
    req.user = payload.sub;
    req.role = payload.role;
    next();
  } catch (err) {
    console.error("  -- error:", err);
    res.status(401).send({
      error: "Invalid authentication token"
    });
  }
};

exports.checkAuthentication = function (req, res, next) {
    /*
     * Authorization: Bearer <token>
     */
    const authHeader = req.get('Authorization') || '';
    const authHeaderParts = authHeader.split(' ');
    const token = authHeaderParts[0] === 'Bearer' ?
      authHeaderParts[1] : null;
    if(!token) {
        console.log("No token provided");
        next();
    } else {
        try {
            const payload = jwt.verify(token, secretKey);
            req.user = payload.sub;
            req.role = payload.role;
            next();
        } catch (err) {
            console.error("  -- error:", err);
            res.status(401).send({
                error: "Invalid authentication token"
            });
        }
    }
  };