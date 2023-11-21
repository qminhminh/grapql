const mongoose = require('mongoose');

const db = "mongodb+srv://hqminh050503:minh050503@cluster0.p17pjk0.mongodb.net/?retryWrites=true&w=majority";

const dbConnect = async () => {
    try {
        await mongoose.connect(db, {
            useNewUrlParser: true,
            useUnifiedTopology: true
        });
        console.log('Connected to MongoDB');
    } catch (e) {
        console.error(e);
    }
};

module.exports = { dbConnect };
