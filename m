Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958B3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B6D20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390021AbgE0PsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE0PsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:48:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A718C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:48:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id D2CBC2A3AB1
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     mingo@redhat.com, dvhart@infradead.org, kernel@collabora.com,
        krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 2/4] futex: Remove needless goto's
Date:   Wed, 27 May 2020 12:47:45 -0300
Message-Id: <20200527154747.36931-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527154747.36931-1-andrealmeid@collabora.com>
References: <20200527154747.36931-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the coding style documentation[1], "if there is no cleanup
needed then just return directly", instead of jumping to a label and
then returning. Remove such goto's and replace with a return statement.
When there's a ternary operator on the return value, replace with the
result of the operation when is logically possible to determine it by
the control flow.

[1] https://www.kernel.org/doc/html/latest/process/coding-style.html#centralized-exiting-of-functions

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 1f0287a51dce..ec07de620d1e 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1604,13 +1604,13 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 
 	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
 	if (unlikely(ret != 0))
-		goto out;
+		return ret;
 
 	hb = hash_futex(&key);
 
 	/* Make sure we really have tasks to wakeup */
 	if (!hb_waiters_pending(hb))
-		goto out;
+		return ret;
 
 	spin_lock(&hb->lock);
 
@@ -1633,7 +1633,6 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 
 	spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
-out:
 	return ret;
 }
 
@@ -1700,10 +1699,10 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 retry:
 	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
 	if (unlikely(ret != 0))
-		goto out;
+		return ret;
 	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
 	if (unlikely(ret != 0))
-		goto out;
+		return ret;
 
 	hb1 = hash_futex(&key1);
 	hb2 = hash_futex(&key2);
@@ -1721,13 +1720,13 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 			 * an MMU, but we might get them from range checking
 			 */
 			ret = op_ret;
-			goto out;
+			return ret;
 		}
 
 		if (op_ret == -EFAULT) {
 			ret = fault_in_user_writeable(uaddr2);
 			if (ret)
-				goto out;
+				return ret;
 		}
 
 		if (!(flags & FLAGS_SHARED)) {
@@ -1770,7 +1769,6 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 out_unlock:
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
-out:
 	return ret;
 }
 
@@ -1977,20 +1975,18 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 retry:
 	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
 	if (unlikely(ret != 0))
-		goto out;
+		return ret;
 	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
 			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
 	if (unlikely(ret != 0))
-		goto out;
+		return ret;
 
 	/*
 	 * The check above which compares uaddrs is not sufficient for
 	 * shared futexes. We need to compare the keys:
 	 */
-	if (requeue_pi && match_futex(&key1, &key2)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (requeue_pi && match_futex(&key1, &key2))
+		return -EINVAL;
 
 	hb1 = hash_futex(&key1);
 	hb2 = hash_futex(&key2);
@@ -2010,7 +2006,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 
 			ret = get_user(curval, uaddr1);
 			if (ret)
-				goto out;
+				return ret;
 
 			if (!(flags & FLAGS_SHARED))
 				goto retry_private;
@@ -2076,7 +2072,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 			ret = fault_in_user_writeable(uaddr2);
 			if (!ret)
 				goto retry;
-			goto out;
+			return ret;
 		case -EBUSY:
 		case -EAGAIN:
 			/*
@@ -2195,8 +2191,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
 	hb_waiters_dec(hb2);
-
-out:
 	return ret ? ret : task_count;
 }
 
@@ -2542,7 +2536,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 		 */
 		if (q->pi_state->owner != current)
 			ret = fixup_pi_state_owner(uaddr, q, current);
-		goto out;
+		return ret ? ret : locked;
 	}
 
 	/*
@@ -2555,7 +2549,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 	 */
 	if (q->pi_state->owner == current) {
 		ret = fixup_pi_state_owner(uaddr, q, NULL);
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -2569,8 +2563,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 				q->pi_state->owner);
 	}
 
-out:
-	return ret ? ret : locked;
+	return ret;
 }
 
 /**
@@ -2667,7 +2660,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 
 		ret = get_user(uval, uaddr);
 		if (ret)
-			goto out;
+			return ret;
 
 		if (!(flags & FLAGS_SHARED))
 			goto retry_private;
@@ -2680,7 +2673,6 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 		ret = -EWOULDBLOCK;
 	}
 
-out:
 	return ret;
 }
 
-- 
2.26.2

