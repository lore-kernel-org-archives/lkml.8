Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA91C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A9722BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02K9v/Ea";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="psnWegaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgH0H7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbgH0HyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24669C061264;
        Thu, 27 Aug 2020 00:54:21 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m8Ciqs3YM2g+c8NPG6PBkKuWuAFXhMXbrMXHn1msgxo=;
        b=02K9v/Ea0CLcbCRE4mWjcI7bXOjJMyoe/R6z8vE4WnBsiVd3qJBCXdqrmT3eGXhj/CtQxj
        Q5Wvdpu2Jk+eOa3iRZIiCSNwPR7QvljTQ0DaFcLuNSdmVnSLZn7NhP0YpC95/wHHl6/An3
        X2g18xbokxMhRfl6pBb8mkI+q5hMDRbvB+KOmW278+BIa39FuJh1HFQFIkOyI9g9whecW+
        1Svv9YpuUkcGadvMrJhKYiVxoRuRDS2TcCGrTt8Hle28HkNukESCasouPeXiDQvMo7j+kH
        lkkamJPlz0MpidDnyFLipfqfsTmUwqnhKQIGwpiJWU9ZtN/Wx8J1Jt9klveZPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m8Ciqs3YM2g+c8NPG6PBkKuWuAFXhMXbrMXHn1msgxo=;
        b=psnWegaYfW/gT3mykIbuwKdBqLhTojfkg28tgrgGXNGDrtKz6IUvICqeGt83IQTXoDp3vC
        eOr4Z6z415esaGCw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Support deadlock detection for recursive
 read locks in check_noncircular()
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-10-boqun.feng@gmail.com>
References: <20200807074238.1632519-10-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485875.20229.3863601787426044121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9de0c9bbcedf752e762c67f105bff342e30f9105
Gitweb:        https://git.kernel.org/tip/9de0c9bbcedf752e762c67f105bff342e30f9105
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:28 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:05 +02:00

lockdep: Support deadlock detection for recursive read locks in check_noncircular()

Currently, lockdep only has limit support for deadlock detection for
recursive read locks.

This patch support deadlock detection for recursive read locks. The
basic idea is:

We are about to add dependency B -> A in to the dependency graph, we use
check_noncircular() to find whether we have a strong dependency path
A -> .. -> B so that we have a strong dependency circle (a closed strong
dependency path):

	 A -> .. -> B -> A

, which doesn't have two adjacent dependencies as -(*R)-> L -(S*)->.

Since A -> .. -> B is already a strong dependency path, so if either
B -> A is -(E*)-> or A -> .. -> B is -(*N)->, the circle A -> .. -> B ->
A is strong, otherwise not. So we introduce a new match function
hlock_conflict() to replace the class_equal() for the deadlock check in
check_noncircular().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-10-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 43 +++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 78cd74d..9160f1d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1838,10 +1838,37 @@ static inline bool class_equal(struct lock_list *entry, void *data)
 	return entry->class == data;
 }
 
+/*
+ * We are about to add B -> A into the dependency graph, and in __bfs() a
+ * strong dependency path A -> .. -> B is found: hlock_class equals
+ * entry->class.
+ *
+ * We will have a deadlock case (conflict) if A -> .. -> B -> A is a strong
+ * dependency cycle, that means:
+ *
+ * Either
+ *
+ *     a) B -> A is -(E*)->
+ *
+ * or
+ *
+ *     b) A -> .. -> B is -(*N)-> (i.e. A -> .. -(*N)-> B)
+ *
+ * as then we don't have -(*R)-> -(S*)-> in the cycle.
+ */
+static inline bool hlock_conflict(struct lock_list *entry, void *data)
+{
+	struct held_lock *hlock = (struct held_lock *)data;
+
+	return hlock_class(hlock) == entry->class && /* Found A -> .. -> B */
+	       (hlock->read == 0 || /* B -> A is -(E*)-> */
+		!entry->only_xr); /* A -> .. -> B is -(*N)-> */
+}
+
 static noinline void print_circular_bug(struct lock_list *this,
-					struct lock_list *target,
-					struct held_lock *check_src,
-					struct held_lock *check_tgt)
+				struct lock_list *target,
+				struct held_lock *check_src,
+				struct held_lock *check_tgt)
 {
 	struct task_struct *curr = current;
 	struct lock_list *parent;
@@ -1950,13 +1977,13 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
  * <target> or not.
  */
 static noinline enum bfs_result
-check_path(struct lock_class *target, struct lock_list *src_entry,
+check_path(struct held_lock *target, struct lock_list *src_entry,
+	   bool (*match)(struct lock_list *entry, void *data),
 	   struct lock_list **target_entry)
 {
 	enum bfs_result ret;
 
-	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
-			     target_entry);
+	ret = __bfs_forwards(src_entry, target, match, target_entry);
 
 	if (unlikely(bfs_error(ret)))
 		print_bfs_bug(ret);
@@ -1983,7 +2010,7 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+	ret = check_path(target, &src_entry, hlock_conflict, &target_entry);
 
 	if (unlikely(ret == BFS_RMATCH)) {
 		if (!*trace) {
@@ -2021,7 +2048,7 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+	ret = check_path(target, &src_entry, class_equal, &target_entry);
 
 	if (ret == BFS_RMATCH)
 		debug_atomic_inc(nr_redundant);
