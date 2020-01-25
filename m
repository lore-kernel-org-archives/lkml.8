Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE362C35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815A2218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgAYKoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:44:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44393 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbgAYKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuJ-0000DG-1M; Sat, 25 Jan 2020 11:43:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 14D321C1A81;
        Sat, 25 Jan 2020 11:42:56 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:55 -0000
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] list: Add hlist_unhashed_lockless()
Cc:     Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897583.396.200500521803121544.tip-bot2@tip-bot2>
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

Commit-ID:     c54a2744497db4b6887b9c905ef7aa0b3620c956
Gitweb:        https://git.kernel.org/tip/c54a2744497db4b6887b9c905ef7aa0b3620c956
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Thu, 07 Nov 2019 11:37:37 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:36:58 -08:00

list: Add hlist_unhashed_lockless()

We would like to use hlist_unhashed() from timer_pending(),
which runs without protection of a lock.

Note that other callers might also want to use this variant.

Instead of forcing a READ_ONCE() for all hlist_unhashed()
callers, add a new helper with an explicit _lockless suffix
in the name to better document what is going on.

Also add various WRITE_ONCE() in __hlist_del(), hlist_add_head()
and hlist_add_before()/hlist_add_behind() to pair with
the READ_ONCE().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
[ paulmck: Also add WRITE_ONCE() to rculist.h. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list.h    | 32 +++++++++++++++++++++-----------
 include/linux/rculist.h | 24 ++++++++++++------------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 85c9255..61f5aaf 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -749,6 +749,16 @@ static inline int hlist_unhashed(const struct hlist_node *h)
 	return !h->pprev;
 }
 
+/* This variant of hlist_unhashed() must be used in lockless contexts
+ * to avoid potential load-tearing.
+ * The READ_ONCE() is paired with the various WRITE_ONCE() in hlist
+ * helpers that are defined below.
+ */
+static inline int hlist_unhashed_lockless(const struct hlist_node *h)
+{
+	return !READ_ONCE(h->pprev);
+}
+
 static inline int hlist_empty(const struct hlist_head *h)
 {
 	return !READ_ONCE(h->first);
@@ -761,7 +771,7 @@ static inline void __hlist_del(struct hlist_node *n)
 
 	WRITE_ONCE(*pprev, next);
 	if (next)
-		next->pprev = pprev;
+		WRITE_ONCE(next->pprev, pprev);
 }
 
 static inline void hlist_del(struct hlist_node *n)
@@ -782,32 +792,32 @@ static inline void hlist_del_init(struct hlist_node *n)
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
-	n->next = first;
+	WRITE_ONCE(n->next, first);
 	if (first)
-		first->pprev = &n->next;
+		WRITE_ONCE(first->pprev, &n->next);
 	WRITE_ONCE(h->first, n);
-	n->pprev = &h->first;
+	WRITE_ONCE(n->pprev, &h->first);
 }
 
 /* next must be != NULL */
 static inline void hlist_add_before(struct hlist_node *n,
 					struct hlist_node *next)
 {
-	n->pprev = next->pprev;
-	n->next = next;
-	next->pprev = &n->next;
+	WRITE_ONCE(n->pprev, next->pprev);
+	WRITE_ONCE(n->next, next);
+	WRITE_ONCE(next->pprev, &n->next);
 	WRITE_ONCE(*(n->pprev), n);
 }
 
 static inline void hlist_add_behind(struct hlist_node *n,
 				    struct hlist_node *prev)
 {
-	n->next = prev->next;
-	prev->next = n;
-	n->pprev = &prev->next;
+	WRITE_ONCE(n->next, prev->next);
+	WRITE_ONCE(prev->next, n);
+	WRITE_ONCE(n->pprev, &prev->next);
 
 	if (n->next)
-		n->next->pprev  = &n->next;
+		WRITE_ONCE(n->next->pprev, &n->next);
 }
 
 /* after that we'll appear to be on some hlist and hlist_del will work */
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 61c6728..4b7ae1b 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -173,7 +173,7 @@ static inline void hlist_del_init_rcu(struct hlist_node *n)
 {
 	if (!hlist_unhashed(n)) {
 		__hlist_del(n);
-		n->pprev = NULL;
+		WRITE_ONCE(n->pprev, NULL);
 	}
 }
 
@@ -473,7 +473,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 static inline void hlist_del_rcu(struct hlist_node *n)
 {
 	__hlist_del(n);
-	n->pprev = LIST_POISON2;
+	WRITE_ONCE(n->pprev, LIST_POISON2);
 }
 
 /**
@@ -489,11 +489,11 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
 	struct hlist_node *next = old->next;
 
 	new->next = next;
-	new->pprev = old->pprev;
+	WRITE_ONCE(new->pprev, old->pprev);
 	rcu_assign_pointer(*(struct hlist_node __rcu **)new->pprev, new);
 	if (next)
-		new->next->pprev = &new->next;
-	old->pprev = LIST_POISON2;
+		WRITE_ONCE(new->next->pprev, &new->next);
+	WRITE_ONCE(old->pprev, LIST_POISON2);
 }
 
 /*
@@ -528,10 +528,10 @@ static inline void hlist_add_head_rcu(struct hlist_node *n,
 	struct hlist_node *first = h->first;
 
 	n->next = first;
-	n->pprev = &h->first;
+	WRITE_ONCE(n->pprev, &h->first);
 	rcu_assign_pointer(hlist_first_rcu(h), n);
 	if (first)
-		first->pprev = &n->next;
+		WRITE_ONCE(first->pprev, &n->next);
 }
 
 /**
@@ -564,7 +564,7 @@ static inline void hlist_add_tail_rcu(struct hlist_node *n,
 
 	if (last) {
 		n->next = last->next;
-		n->pprev = &last->next;
+		WRITE_ONCE(n->pprev, &last->next);
 		rcu_assign_pointer(hlist_next_rcu(last), n);
 	} else {
 		hlist_add_head_rcu(n, h);
@@ -592,10 +592,10 @@ static inline void hlist_add_tail_rcu(struct hlist_node *n,
 static inline void hlist_add_before_rcu(struct hlist_node *n,
 					struct hlist_node *next)
 {
-	n->pprev = next->pprev;
+	WRITE_ONCE(n->pprev, next->pprev);
 	n->next = next;
 	rcu_assign_pointer(hlist_pprev_rcu(n), n);
-	next->pprev = &n->next;
+	WRITE_ONCE(next->pprev, &n->next);
 }
 
 /**
@@ -620,10 +620,10 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
 					struct hlist_node *prev)
 {
 	n->next = prev->next;
-	n->pprev = &prev->next;
+	WRITE_ONCE(n->pprev, &prev->next);
 	rcu_assign_pointer(hlist_next_rcu(prev), n);
 	if (n->next)
-		n->next->pprev = &n->next;
+		WRITE_ONCE(n->next->pprev, &n->next);
 }
 
 #define __hlist_for_each_rcu(pos, head)				\
