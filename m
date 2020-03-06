Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588ECC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A91E2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgCFKjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:39:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52913 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCFKjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAANk-0000CQ-5F; Fri, 06 Mar 2020 11:39:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C96AD1C21BE;
        Fri,  6 Mar 2020 11:39:03 +0100 (CET)
Date:   Fri, 06 Mar 2020 10:39:03 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove {get,drop}_futex_key_refs()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158349114357.28353.3836686464963839935.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4b39f99c222a2aff6a52fddfa6d8d4aef1771737
Gitweb:        https://git.kernel.org/tip/4b39f99c222a2aff6a52fddfa6d8d4aef1771737
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 04 Mar 2020 13:24:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Mar 2020 11:06:19 +01:00

futex: Remove {get,drop}_futex_key_refs()

Now that {get,drop}_futex_key_refs() have become a glorified NOP,
remove them entirely.

The only thing get_futex_key_refs() is still doing is an smp_mb(), and
now that we don't need to (ab)use existing atomic ops to obtain them,
we can place it explicitly where we need it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex.c | 90 +++----------------------------------------------
 1 file changed, 6 insertions(+), 84 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 3463c91..b62cf94 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -135,8 +135,7 @@
  *
  * Where (A) orders the waiters increment and the futex value read through
  * atomic operations (see hb_waiters_inc) and where (B) orders the write
- * to futex and the waiters read -- this is done by the barriers for both
- * shared and private futexes in get_futex_key_refs().
+ * to futex and the waiters read (see hb_waiters_pending()).
  *
  * This yields the following case (where X:=waiters, Y:=futex):
  *
@@ -359,6 +358,10 @@ static inline void hb_waiters_dec(struct futex_hash_bucket *hb)
 static inline int hb_waiters_pending(struct futex_hash_bucket *hb)
 {
 #ifdef CONFIG_SMP
+	/*
+	 * Full barrier (B), see the ordering comment above.
+	 */
+	smp_mb();
 	return atomic_read(&hb->waiters);
 #else
 	return 1;
@@ -396,68 +399,6 @@ static inline int match_futex(union futex_key *key1, union futex_key *key2)
 		&& key1->both.offset == key2->both.offset);
 }
 
-/*
- * Take a reference to the resource addressed by a key.
- * Can be called while holding spinlocks.
- *
- */
-static void get_futex_key_refs(union futex_key *key)
-{
-	if (!key->both.ptr)
-		return;
-
-	/*
-	 * On MMU less systems futexes are always "private" as there is no per
-	 * process address space. We need the smp wmb nevertheless - yes,
-	 * arch/blackfin has MMU less SMP ...
-	 */
-	if (!IS_ENABLED(CONFIG_MMU)) {
-		smp_mb(); /* explicit smp_mb(); (B) */
-		return;
-	}
-
-	switch (key->both.offset & (FUT_OFF_INODE|FUT_OFF_MMSHARED)) {
-	case FUT_OFF_INODE:
-		smp_mb();		/* explicit smp_mb(); (B) */
-		break;
-	case FUT_OFF_MMSHARED:
-		smp_mb();		/* explicit smp_mb(); (B) */
-		break;
-	default:
-		/*
-		 * Private futexes do not hold reference on an inode or
-		 * mm, therefore the only purpose of calling get_futex_key_refs
-		 * is because we need the barrier for the lockless waiter check.
-		 */
-		smp_mb(); /* explicit smp_mb(); (B) */
-	}
-}
-
-/*
- * Drop a reference to the resource addressed by a key.
- * The hash bucket spinlock must not be held. This is
- * a no-op for private futexes, see comment in the get
- * counterpart.
- */
-static void drop_futex_key_refs(union futex_key *key)
-{
-	if (!key->both.ptr) {
-		/* If we're here then we tried to put a key we failed to get */
-		WARN_ON_ONCE(1);
-		return;
-	}
-
-	if (!IS_ENABLED(CONFIG_MMU))
-		return;
-
-	switch (key->both.offset & (FUT_OFF_INODE|FUT_OFF_MMSHARED)) {
-	case FUT_OFF_INODE:
-		break;
-	case FUT_OFF_MMSHARED:
-		break;
-	}
-}
-
 enum futex_access {
 	FUTEX_READ,
 	FUTEX_WRITE
@@ -589,7 +530,6 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_a
 	if (!fshared) {
 		key->private.mm = mm;
 		key->private.address = address;
-		get_futex_key_refs(key);  /* implies smp_mb(); (B) */
 		return 0;
 	}
 
@@ -729,8 +669,6 @@ again:
 		rcu_read_unlock();
 	}
 
-	get_futex_key_refs(key); /* implies smp_mb(); (B) */
-
 out:
 	put_page(page);
 	return err;
@@ -738,7 +676,6 @@ out:
 
 static inline void put_futex_key(union futex_key *key)
 {
-	drop_futex_key_refs(key);
 }
 
 /**
@@ -1873,7 +1810,6 @@ void requeue_futex(struct futex_q *q, struct futex_hash_bucket *hb1,
 		plist_add(&q->list, &hb2->chain);
 		q->lock_ptr = &hb2->lock;
 	}
-	get_futex_key_refs(key2);
 	q->key = *key2;
 }
 
@@ -1895,7 +1831,6 @@ static inline
 void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 			   struct futex_hash_bucket *hb)
 {
-	get_futex_key_refs(key);
 	q->key = *key;
 
 	__unqueue_futex(q);
@@ -2006,7 +1941,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 			 u32 *cmpval, int requeue_pi)
 {
 	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
-	int drop_count = 0, task_count = 0, ret;
+	int task_count = 0, ret;
 	struct futex_pi_state *pi_state = NULL;
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
@@ -2127,7 +2062,6 @@ retry_private:
 		 */
 		if (ret > 0) {
 			WARN_ON(pi_state);
-			drop_count++;
 			task_count++;
 			/*
 			 * If we acquired the lock, then the user space value
@@ -2247,7 +2181,6 @@ retry_private:
 				 * doing so.
 				 */
 				requeue_pi_wake_futex(this, &key2, hb2);
-				drop_count++;
 				continue;
 			} else if (ret) {
 				/*
@@ -2268,7 +2201,6 @@ retry_private:
 			}
 		}
 		requeue_futex(this, hb1, hb2, &key2);
-		drop_count++;
 	}
 
 	/*
@@ -2283,15 +2215,6 @@ out_unlock:
 	wake_up_q(&wake_q);
 	hb_waiters_dec(hb2);
 
-	/*
-	 * drop_futex_key_refs() must be called outside the spinlocks. During
-	 * the requeue we moved futex_q's from the hash bucket at key1 to the
-	 * one at key2 and updated their key pointer.  We no longer need to
-	 * hold the references to key1.
-	 */
-	while (--drop_count >= 0)
-		drop_futex_key_refs(&key1);
-
 out_put_keys:
 	put_futex_key(&key2);
 out_put_key1:
@@ -2421,7 +2344,6 @@ retry:
 		ret = 1;
 	}
 
-	drop_futex_key_refs(&q->key);
 	return ret;
 }
 
