Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6036CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334E122522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgAYKnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44200 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgAYKm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:59 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIu1-0008U0-8E; Sat, 25 Jan 2020 11:42:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 32D0E1C1A80;
        Sat, 25 Jan 2020 11:42:47 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:47 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add and update docbook header comments in list.h
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896701.396.11488796985578791857.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     46deb7449d99f37bebf5cbd7f95c136c6fafeaa5
Gitweb:        https://git.kernel.org/tip/46deb7449d99f37bebf5cbd7f95c136c6fafeaa5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 09 Nov 2019 10:35:13 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 10 Jan 2020 14:00:57 -08:00

rcu: Add and update docbook header comments in list.h

[ paulmck: Fix typo found by kbuild test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list.h | 112 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 95 insertions(+), 17 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 61f5aaf..4f3b7f7 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -23,6 +23,13 @@
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
 
+/**
+ * INIT_LIST_HEAD - Initialize a list_head structure
+ * @list: list_head structure to be initialized.
+ *
+ * Initializes the list_head to point to itself.  If it is a list header,
+ * the result is an empty list.
+ */
 static inline void INIT_LIST_HEAD(struct list_head *list)
 {
 	WRITE_ONCE(list->next, list);
@@ -120,12 +127,6 @@ static inline void __list_del_clearprev(struct list_head *entry)
 	entry->prev = NULL;
 }
 
-/**
- * list_del - deletes entry from list.
- * @entry: the element to delete from the list.
- * Note: list_empty() on entry does not return true after this, the entry is
- * in an undefined state.
- */
 static inline void __list_del_entry(struct list_head *entry)
 {
 	if (!__list_del_entry_valid(entry))
@@ -134,6 +135,12 @@ static inline void __list_del_entry(struct list_head *entry)
 	__list_del(entry->prev, entry->next);
 }
 
+/**
+ * list_del - deletes entry from list.
+ * @entry: the element to delete from the list.
+ * Note: list_empty() on entry does not return true after this, the entry is
+ * in an undefined state.
+ */
 static inline void list_del(struct list_head *entry)
 {
 	__list_del_entry(entry);
@@ -157,8 +164,15 @@ static inline void list_replace(struct list_head *old,
 	new->prev->next = new;
 }
 
+/**
+ * list_replace_init - replace old entry by new one and initialize the old one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * If @old was empty, it will be overwritten.
+ */
 static inline void list_replace_init(struct list_head *old,
-					struct list_head *new)
+				     struct list_head *new)
 {
 	list_replace(old, new);
 	INIT_LIST_HEAD(old);
@@ -744,21 +758,36 @@ static inline void INIT_HLIST_NODE(struct hlist_node *h)
 	h->pprev = NULL;
 }
 
+/**
+ * hlist_unhashed - Has node been removed from list and reinitialized?
+ * @h: Node to be checked
+ *
+ * Not that not all removal functions will leave a node in unhashed
+ * state.  For example, hlist_nulls_del_init_rcu() does leave the
+ * node in unhashed state, but hlist_nulls_del() does not.
+ */
 static inline int hlist_unhashed(const struct hlist_node *h)
 {
 	return !h->pprev;
 }
 
-/* This variant of hlist_unhashed() must be used in lockless contexts
- * to avoid potential load-tearing.
- * The READ_ONCE() is paired with the various WRITE_ONCE() in hlist
- * helpers that are defined below.
+/**
+ * hlist_unhashed_lockless - Version of hlist_unhashed for lockless use
+ * @h: Node to be checked
+ *
+ * This variant of hlist_unhashed() must be used in lockless contexts
+ * to avoid potential load-tearing.  The READ_ONCE() is paired with the
+ * various WRITE_ONCE() in hlist helpers that are defined below.
  */
 static inline int hlist_unhashed_lockless(const struct hlist_node *h)
 {
 	return !READ_ONCE(h->pprev);
 }
 
+/**
+ * hlist_empty - Is the specified hlist_head structure an empty hlist?
+ * @h: Structure to check.
+ */
 static inline int hlist_empty(const struct hlist_head *h)
 {
 	return !READ_ONCE(h->first);
@@ -774,6 +803,13 @@ static inline void __hlist_del(struct hlist_node *n)
 		WRITE_ONCE(next->pprev, pprev);
 }
 
+/**
+ * hlist_del - Delete the specified hlist_node from its list
+ * @n: Node to delete.
+ *
+ * Note that this function leaves the node in hashed state.  Use
+ * hlist_del_init() or similar instead to unhash @n.
+ */
 static inline void hlist_del(struct hlist_node *n)
 {
 	__hlist_del(n);
@@ -781,6 +817,12 @@ static inline void hlist_del(struct hlist_node *n)
 	n->pprev = LIST_POISON2;
 }
 
+/**
+ * hlist_del_init - Delete the specified hlist_node from its list and initialize
+ * @n: Node to delete.
+ *
+ * Note that this function leaves the node in unhashed state.
+ */
 static inline void hlist_del_init(struct hlist_node *n)
 {
 	if (!hlist_unhashed(n)) {
@@ -789,6 +831,14 @@ static inline void hlist_del_init(struct hlist_node *n)
 	}
 }
 
+/**
+ * hlist_add_head - add a new entry at the beginning of the hlist
+ * @n: new entry to be added
+ * @h: hlist head to add it after
+ *
+ * Insert a new entry after the specified head.
+ * This is good for implementing stacks.
+ */
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
@@ -799,9 +849,13 @@ static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 	WRITE_ONCE(n->pprev, &h->first);
 }
 
-/* next must be != NULL */
+/**
+ * hlist_add_before - add a new entry before the one specified
+ * @n: new entry to be added
+ * @next: hlist node to add it before, which must be non-NULL
+ */
 static inline void hlist_add_before(struct hlist_node *n,
-					struct hlist_node *next)
+				    struct hlist_node *next)
 {
 	WRITE_ONCE(n->pprev, next->pprev);
 	WRITE_ONCE(n->next, next);
@@ -809,6 +863,11 @@ static inline void hlist_add_before(struct hlist_node *n,
 	WRITE_ONCE(*(n->pprev), n);
 }
 
+/**
+ * hlist_add_behing - add a new entry after the one specified
+ * @n: new entry to be added
+ * @prev: hlist node to add it after, which must be non-NULL
+ */
 static inline void hlist_add_behind(struct hlist_node *n,
 				    struct hlist_node *prev)
 {
@@ -820,20 +879,35 @@ static inline void hlist_add_behind(struct hlist_node *n,
 		WRITE_ONCE(n->next->pprev, &n->next);
 }
 
-/* after that we'll appear to be on some hlist and hlist_del will work */
+/**
+ * hlist_add_fake - create a fake hlist consisting of a single headless node
+ * @n: Node to make a fake list out of
+ *
+ * This makes @n appear to be its own predecessor on a headless hlist.
+ * The point of this is to allow things like hlist_del() to work correctly
+ * in cases where there is no list.
+ */
 static inline void hlist_add_fake(struct hlist_node *n)
 {
 	n->pprev = &n->next;
 }
 
+/**
+ * hlist_fake: Is this node a fake hlist?
+ * @h: Node to check for being a self-referential fake hlist.
+ */
 static inline bool hlist_fake(struct hlist_node *h)
 {
 	return h->pprev == &h->next;
 }
 
-/*
+/**
+ * hlist_is_singular_node - is node the only element of the specified hlist?
+ * @n: Node to check for singularity.
+ * @h: Header for potentially singular list.
+ *
  * Check whether the node is the only node of the head without
- * accessing head:
+ * accessing head, thus avoiding unnecessary cache misses.
  */
 static inline bool
 hlist_is_singular_node(struct hlist_node *n, struct hlist_head *h)
@@ -841,7 +915,11 @@ hlist_is_singular_node(struct hlist_node *n, struct hlist_head *h)
 	return !n->next && n->pprev == &h->first;
 }
 
-/*
+/**
+ * hlist_move_list - Move an hlist
+ * @old: hlist_head for old list.
+ * @new: hlist_head for new list.
+ *
  * Move a list from one list head to another. Fixup the pprev
  * reference of the first entry if it exists.
  */
