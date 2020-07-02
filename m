Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B206CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919212088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGBU2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:28:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34554 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBU2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:28:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id A32662A60FD
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     mingo@redhat.com, dvhart@infradead.org, kernel@collabora.com,
        krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RESEND PATCH 1/4] futex: Remove put_futex_key()
Date:   Thu,  2 Jul 2020 17:28:40 -0300
Message-Id: <20200702202843.520764-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702202843.520764-1-andrealmeid@collabora.com>
References: <20200702202843.520764-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 4b39f99c ("futex: Remove {get,drop}_futex_key_refs()"),
function put_futex_key() is empty. Remove all references for this
function and redundant labels.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex.c | 61 ++++++++++----------------------------------------
 1 file changed, 12 insertions(+), 49 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e646661f6282..bd9adfca5d51 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -677,10 +677,6 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_a
 	return err;
 }
 
-static inline void put_futex_key(union futex_key *key)
-{
-}
-
 /**
  * fault_in_user_writeable() - Fault in user address and verify RW access
  * @uaddr:	pointer to faulting user space address
@@ -1617,7 +1613,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 
 	/* Make sure we really have tasks to wakeup */
 	if (!hb_waiters_pending(hb))
-		goto out_put_key;
+		goto out;
 
 	spin_lock(&hb->lock);
 
@@ -1640,8 +1636,6 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 
 	spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
-out_put_key:
-	put_futex_key(&key);
 out:
 	return ret;
 }
@@ -1712,7 +1706,7 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 		goto out;
 	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
 	if (unlikely(ret != 0))
-		goto out_put_key1;
+		goto out;
 
 	hb1 = hash_futex(&key1);
 	hb2 = hash_futex(&key2);
@@ -1730,13 +1724,13 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 			 * an MMU, but we might get them from range checking
 			 */
 			ret = op_ret;
-			goto out_put_keys;
+			goto out;
 		}
 
 		if (op_ret == -EFAULT) {
 			ret = fault_in_user_writeable(uaddr2);
 			if (ret)
-				goto out_put_keys;
+				goto out;
 		}
 
 		if (!(flags & FLAGS_SHARED)) {
@@ -1744,8 +1738,6 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 			goto retry_private;
 		}
 
-		put_futex_key(&key2);
-		put_futex_key(&key1);
 		cond_resched();
 		goto retry;
 	}
@@ -1781,10 +1773,6 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 out_unlock:
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
-out_put_keys:
-	put_futex_key(&key2);
-out_put_key1:
-	put_futex_key(&key1);
 out:
 	return ret;
 }
@@ -1996,7 +1984,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
 			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
 	if (unlikely(ret != 0))
-		goto out_put_key1;
+		goto out;
 
 	/*
 	 * The check above which compares uaddrs is not sufficient for
@@ -2004,7 +1992,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	 */
 	if (requeue_pi && match_futex(&key1, &key2)) {
 		ret = -EINVAL;
-		goto out_put_keys;
+		goto out;
 	}
 
 	hb1 = hash_futex(&key1);
@@ -2025,13 +2013,11 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 
 			ret = get_user(curval, uaddr1);
 			if (ret)
-				goto out_put_keys;
+				goto out;
 
 			if (!(flags & FLAGS_SHARED))
 				goto retry_private;
 
-			put_futex_key(&key2);
-			put_futex_key(&key1);
 			goto retry;
 		}
 		if (curval != *cmpval) {
@@ -2090,8 +2076,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		case -EFAULT:
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
-			put_futex_key(&key2);
-			put_futex_key(&key1);
 			ret = fault_in_user_writeable(uaddr2);
 			if (!ret)
 				goto retry;
@@ -2106,8 +2090,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 			 */
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
-			put_futex_key(&key2);
-			put_futex_key(&key1);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -2217,10 +2199,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	wake_up_q(&wake_q);
 	hb_waiters_dec(hb2);
 
-out_put_keys:
-	put_futex_key(&key2);
-out_put_key1:
-	put_futex_key(&key1);
 out:
 	return ret ? ret : task_count;
 }
@@ -2697,7 +2675,6 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 		if (!(flags & FLAGS_SHARED))
 			goto retry_private;
 
-		put_futex_key(&q->key);
 		goto retry;
 	}
 
@@ -2707,8 +2684,6 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 	}
 
 out:
-	if (ret)
-		put_futex_key(&q->key);
 	return ret;
 }
 
@@ -2853,7 +2828,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 			 * - EAGAIN: The user space value changed.
 			 */
 			queue_unlock(hb);
-			put_futex_key(&q.key);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -2961,13 +2935,11 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 		put_pi_state(pi_state);
 	}
 
-	goto out_put_key;
+	goto out;
 
 out_unlock_put_key:
 	queue_unlock(hb);
 
-out_put_key:
-	put_futex_key(&q.key);
 out:
 	if (to) {
 		hrtimer_cancel(&to->timer);
@@ -2980,12 +2952,11 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 
 	ret = fault_in_user_writeable(uaddr);
 	if (ret)
-		goto out_put_key;
+		goto out;
 
 	if (!(flags & FLAGS_SHARED))
 		goto retry_private;
 
-	put_futex_key(&q.key);
 	goto retry;
 }
 
@@ -3114,16 +3085,13 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 out_unlock:
 	spin_unlock(&hb->lock);
 out_putkey:
-	put_futex_key(&key);
 	return ret;
 
 pi_retry:
-	put_futex_key(&key);
 	cond_resched();
 	goto retry;
 
 pi_faulted:
-	put_futex_key(&key);
 
 	ret = fault_in_user_writeable(uaddr);
 	if (!ret)
@@ -3265,7 +3233,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	 */
 	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
-		goto out_key2;
+		goto out;
 
 	/*
 	 * The check above which compares uaddrs is not sufficient for
@@ -3274,7 +3242,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	if (match_futex(&q.key, &key2)) {
 		queue_unlock(hb);
 		ret = -EINVAL;
-		goto out_put_keys;
+		goto out;
 	}
 
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
@@ -3284,7 +3252,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
 	spin_unlock(&hb->lock);
 	if (ret)
-		goto out_put_keys;
+		goto out;
 
 	/*
 	 * In order for us to be here, we know our q.key == key2, and since
@@ -3374,11 +3342,6 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		ret = -EWOULDBLOCK;
 	}
 
-out_put_keys:
-	put_futex_key(&q.key);
-out_key2:
-	put_futex_key(&key2);
-
 out:
 	if (to) {
 		hrtimer_cancel(&to->timer);
-- 
2.27.0

