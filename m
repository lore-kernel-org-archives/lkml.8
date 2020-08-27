Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBD7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8EFC2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kUg9e0Sy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MN54I43C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgH0IAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgH0HyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B19C06121A;
        Thu, 27 Aug 2020 00:54:18 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AkfGLaoqIHqktw//Exf8qq5VjMD1cnxZzW2R3O5WBtw=;
        b=kUg9e0SyDL7+EaO2Fho0u/ATWoOf/v4x3l86RnzWm+3QN2TWOJr5LDfiGZJQ+5BqwcSlwd
        POz9lp8OSNAgIluA0cJu6p+sc7+FtSiTZEGkQsJBkJWPuAYSgFacfSVjz1YBwAvjNUjSlM
        Nn9WvDF8FAnVzz6Whe8JUh3A4k3A5cDzNywDOuIAOheZMaMld85Tv5YC4FRC449Qzpbavt
        qX1pu/pKpAXloebGS2woX2BNwdcWxe0NyfiQ7sjFQvOVY0xGyEz/oUYIPX5Yzb5FZpA9yI
        QS4qkUGXumCKt/jeWqf3p+MHylNJgwOruwXLskl0eFSvRGWmqwTFGrPZ4Z5U/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AkfGLaoqIHqktw//Exf8qq5VjMD1cnxZzW2R3O5WBtw=;
        b=MN54I43CBO4d4eDySfyMDTEycmN/pACLPHNBn5hznmx3JzdgTJIbosVubh0zGS6ruNGqMV
        Ujo6P9Xso3pdEbCA==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Take read/write status in consideration
 when generate chainkey
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-15-boqun.feng@gmail.com>
References: <20200807074238.1632519-15-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485675.20229.7430053417111193715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f611e8cf98ec908b9c2c0da6064a660fc6022487
Gitweb:        https://git.kernel.org/tip/f611e8cf98ec908b9c2c0da6064a660fc6022487
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:33 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:06 +02:00

lockdep: Take read/write status in consideration when generate chainkey

Currently, the chainkey of a lock chain is a hash sum of the class_idx
of all the held locks, the read/write status are not taken in to
consideration while generating the chainkey. This could result into a
problem, if we have:

	P1()
	{
		read_lock(B);
		lock(A);
	}

	P2()
	{
		lock(A);
		read_lock(B);
	}

	P3()
	{
		lock(A);
		write_lock(B);
	}

, and P1(), P2(), P3() run one by one. And when running P2(), lockdep
detects such a lock chain A -> B is not a deadlock, then it's added in
the chain cache, and then when running P3(), even if it's a deadlock, we
could miss it because of the hit of chain cache. This could be confirmed
by self testcase "chain cached mixed R-L/L-W ".

To resolve this, we use concept "hlock_id" to generate the chainkey, the
hlock_id is a tuple (hlock->class_idx, hlock->read), which fits in a u16
type. With this, the chainkeys are different is the lock sequences have
the same locks but different read/write status.

Besides, since we use "hlock_id" to generate chainkeys, the chain_hlocks
array now store the "hlock_id"s rather than lock_class indexes.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-15-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 53 +++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b87766e..cccf4bc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -372,6 +372,21 @@ static struct hlist_head classhash_table[CLASSHASH_SIZE];
 static struct hlist_head chainhash_table[CHAINHASH_SIZE];
 
 /*
+ * the id of held_lock
+ */
+static inline u16 hlock_id(struct held_lock *hlock)
+{
+	BUILD_BUG_ON(MAX_LOCKDEP_KEYS_BITS + 2 > 16);
+
+	return (hlock->class_idx | (hlock->read << MAX_LOCKDEP_KEYS_BITS));
+}
+
+static inline unsigned int chain_hlock_class_idx(u16 hlock_id)
+{
+	return hlock_id & (MAX_LOCKDEP_KEYS - 1);
+}
+
+/*
  * The hash key of the lock dependency chains is a hash itself too:
  * it's a hash of all locks taken up to that lock, including that lock.
  * It's a 64-bit hash, because it's important for the keys to be
@@ -3202,7 +3217,10 @@ static inline void free_chain_hlocks(int base, int size)
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
-	return lock_classes + chain_hlocks[chain->base + i];
+	u16 chain_hlock = chain_hlocks[chain->base + i];
+	unsigned int class_idx = chain_hlock_class_idx(chain_hlock);
+
+	return lock_classes + class_idx - 1;
 }
 
 /*
@@ -3228,12 +3246,12 @@ static inline int get_first_held_lock(struct task_struct *curr,
 /*
  * Returns the next chain_key iteration
  */
-static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
+static u64 print_chain_key_iteration(u16 hlock_id, u64 chain_key)
 {
-	u64 new_chain_key = iterate_chain_key(chain_key, class_idx);
+	u64 new_chain_key = iterate_chain_key(chain_key, hlock_id);
 
-	printk(" class_idx:%d -> chain_key:%016Lx",
-		class_idx,
+	printk(" hlock_id:%d -> chain_key:%016Lx",
+		(unsigned int)hlock_id,
 		(unsigned long long)new_chain_key);
 	return new_chain_key;
 }
@@ -3250,12 +3268,12 @@ print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_ne
 		hlock_next->irq_context);
 	for (; i < depth; i++) {
 		hlock = curr->held_locks + i;
-		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
+		chain_key = print_chain_key_iteration(hlock_id(hlock), chain_key);
 
 		print_lock(hlock);
 	}
 
-	print_chain_key_iteration(hlock_next->class_idx, chain_key);
+	print_chain_key_iteration(hlock_id(hlock_next), chain_key);
 	print_lock(hlock_next);
 }
 
@@ -3263,14 +3281,14 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 {
 	int i;
 	u64 chain_key = INITIAL_CHAIN_KEY;
-	int class_id;
+	u16 hlock_id;
 
 	printk("depth: %u\n", chain->depth);
 	for (i = 0; i < chain->depth; i++) {
-		class_id = chain_hlocks[chain->base + i];
-		chain_key = print_chain_key_iteration(class_id, chain_key);
+		hlock_id = chain_hlocks[chain->base + i];
+		chain_key = print_chain_key_iteration(hlock_id, chain_key);
 
-		print_lock_name(lock_classes + class_id);
+		print_lock_name(lock_classes + chain_hlock_class_idx(hlock_id) - 1);
 		printk("\n");
 	}
 }
@@ -3319,7 +3337,7 @@ static int check_no_collision(struct task_struct *curr,
 	}
 
 	for (j = 0; j < chain->depth - 1; j++, i++) {
-		id = curr->held_locks[i].class_idx;
+		id = hlock_id(&curr->held_locks[i]);
 
 		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
 			print_collision(curr, hlock, chain);
@@ -3368,7 +3386,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 				  struct held_lock *hlock,
 				  u64 chain_key)
 {
-	struct lock_class *class = hlock_class(hlock);
 	struct hlist_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 	int i, j;
@@ -3411,11 +3428,11 @@ static inline int add_chain_cache(struct task_struct *curr,
 
 	chain->base = j;
 	for (j = 0; j < chain->depth - 1; j++, i++) {
-		int lock_id = curr->held_locks[i].class_idx;
+		int lock_id = hlock_id(curr->held_locks + i);
 
 		chain_hlocks[chain->base + j] = lock_id;
 	}
-	chain_hlocks[chain->base + j] = class - lock_classes;
+	chain_hlocks[chain->base + j] = hlock_id(hlock);
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
 	inc_chains(chain->irq_context);
@@ -3602,7 +3619,7 @@ static void check_chain_key(struct task_struct *curr)
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
 			chain_key = INITIAL_CHAIN_KEY;
-		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
+		chain_key = iterate_chain_key(chain_key, hlock_id(hlock));
 		prev_hlock = hlock;
 	}
 	if (chain_key != curr->curr_chain_key) {
@@ -4749,7 +4766,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		chain_key = INITIAL_CHAIN_KEY;
 		chain_head = 1;
 	}
-	chain_key = iterate_chain_key(chain_key, class_idx);
+	chain_key = iterate_chain_key(chain_key, hlock_id(hlock));
 
 	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
 		print_lock_nested_lock_not_held(curr, hlock, ip);
@@ -5648,7 +5665,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++) {
-		if (chain_hlocks[i] != class - lock_classes)
+		if (chain_hlock_class_idx(chain_hlocks[i]) != class - lock_classes)
 			continue;
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
