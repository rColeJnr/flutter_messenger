import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // userData of type dynamic which is kinda like Any in kotlin,
  // add user to firestore db
  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  // retrieve user info from database based on user email

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  // search for specific user name in database

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where("userName", isEqualTo: searchField)
        .getDocuments();
  }

  // create a new chat room between two users

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e.toString());
    });
  }

  // get chat based on chatRoomId (unique for each chat
  // also, order chat by created order descendant
  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  // adds user message to database

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    Firestore.instance
        .collection('chatRoom')
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  // returns snapshot(list) of all user chats

  getUserChats(String userName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: userName)
        .snapshots();
  }
}

// things are not what they used to be.
