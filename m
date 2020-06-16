Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD28BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B96020707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="WNmzjNDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgFPRW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFPRW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:22:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:22:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s88so1895616pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=hI349iq0jpaes5gOrOUjkTRRq6jgwgdnmBEKZpuYbXw=;
        b=WNmzjNDxocC3uTrE0+Z6DyukoLS7WSH/sqART4Nvk8oGmIq3az752Nd20oLpYejA6z
         OFqb0W+GNHJbrcH4AFLjwLO0MKApHpR6LDH6bcQGXK2diNr9q8MlwST2fj/Y8Qr208zF
         WomTIZ/92w8FgYIOohgPUzfoDWiG82QujSn8B3LzRe4kMn+3PiUGkA3JFGK5VP4PwYDO
         LBQyrnmTGs2dDJAUwPyJYlH3Wy6WtMRME+4my12zarj/akkLIrjXlY0UxzBVwHGRIjGt
         cANxsGiIYA5VaHo81rESOFsA1vKSCcS4RSmOZx/7YgyRtV6/F8TshYmJXvSlH/zcr88W
         arlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=hI349iq0jpaes5gOrOUjkTRRq6jgwgdnmBEKZpuYbXw=;
        b=YhQ3VN9sAcvzS40zioq0z2Skxmgz41yXnE7hkx7ORXkOW4/VAuRL+j73VU9bW3lqUu
         qUhKDIuogxVqDw7xd95F0G5vzRIGZ9mnIKDG8+oURZ21P/HgdkzqTSD40ukJdT1myLlG
         2QSRK+ReOrs+7QrRq6j847yWI5/IiGNmCw9rrdJUVA2Bzu6EkZW4PbXuYEVG7E94VpVc
         Rl6zQmBU4nWkbZE3B7LiO/ibGVzXDoBufehLM6BC9khkVlUxzruRs7+d3xruKnmQRBED
         lDqFv5O++UPpgOIiOzOsRpayPl9C+5dTe4DWPuRJC1723zPfyVf8mQJV4uFKU4JxeaHc
         ar1w==
X-Gm-Message-State: AOAM532XchFi6G9sm0ohqIGtYchAY/u2gbAcFqezZlodfBb9d8RoxlAP
        f/ooE7XuwP+uB5+R+I7pUs3dxWMCQ/2YDA==
X-Google-Smtp-Source: ABdhPJxwW3ADRwonCPX0SEhd3LNGWKyYvs/gA8ks2B0KNVXwIkmcJ2FOR8ML0RDMTl4DgfJ8W++zyA==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr2999473pll.237.1592328147700;
        Tue, 16 Jun 2020 10:22:27 -0700 (PDT)
Received: from posk-x1c (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id x2sm17745952pff.103.2020.06.16.10.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:22:27 -0700 (PDT)
Message-ID: <cf7c83d0b58aa4912b465392ce8e40a974f250bb.camel@posk.io>
Subject: [RFC PATCH 1/3 v2] futex: introduce FUTEX_SWAP operation
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Date:   Tue, 16 Jun 2020 10:22:26 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 6fbe0261204692a7f488261ab3c4ac696b91db5c Mon Sep 17 00:00:00 2001
From: Peter Oskolkov <posk@google.com>
Date: Tue, 9 Jun 2020 16:03:14 -0700
Subject: [RFC PATCH 1/3 v2] futex: introduce FUTEX_SWAP operation

This is an RFC!

As Paul Turner presented at LPC in 2013 ...
- pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf
- video: https://www.youtube.com/watch?v=KXuZi9aeGTw

... Google has developed an M:N userspace threading subsystem backed
by Google-private SwitchTo Linux Kernel API (page 17 in the pdf referenced
above). This subsystem provides latency-sensitive services at Google with
fine-grained user-space control/scheduling over what is running when,
and this subsystem is used widely internally (called schedulers or fibers).

This RFC patchset is the first step to open-source this work. As explained
in the linked pdf and video, SwitchTo API has three core operations: wait,
resume, and swap (=switch). So this patchset adds a FUTEX_SWAP operation
that, in addition to FUTEX_WAIT and FUTEX_WAKE, will provide a foundation
on top of which user-space threading libraries can be built.

Another common use case for FUTEX_SWAP is message passing a-la RPC
between tasks: task/thread T1 prepares a message,
wakes T2 to work on it, and waits for the results; when T2 is done, it
wakes T1 and waits for more work to arrive. Currently the simplest
way to implement this is

a. T1: futex-wake T2, futex-wait
b. T2: wakes, does what it has been woken to do
c. T2: futex-wake T1, futex-wait

With FUTEX_SWAP, steps a and c above can be reduced to one futex operation
that runs 5-10 times faster.

Patches in this patchset:

Patch 1: (this patch) introduce FUTEX_SWAP futex operation that,
         internally, does wake + wait. The purpose of this patch is
         to work out the API.
Patch 2: a first rough attempt to make FUTEX_SWAP faster than
         what wake + wait can do.
Patch 3: a selftest that can also be used to benchmark FUTEX_SWAP vs
         FUTEX_WAKE + FUTEX_WAIT.

Tested: see patch 3 in this patchset.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/uapi/linux/futex.h |  2 +
 kernel/futex.c             | 97 +++++++++++++++++++++++++++++++-------
 2 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index a89eb0accd5e..c1d151d97dea 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -21,6 +21,7 @@
 #define FUTEX_WAKE_BITSET	10
 #define FUTEX_WAIT_REQUEUE_PI	11
 #define FUTEX_CMP_REQUEUE_PI	12
+#define FUTEX_SWAP		13

 #define FUTEX_PRIVATE_FLAG	128
 #define FUTEX_CLOCK_REALTIME	256
@@ -40,6 +41,7 @@
 					 FUTEX_PRIVATE_FLAG)
 #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
+#define FUTEX_SWAP_PRIVATE		(FUTEX_SWAP | FUTEX_PRIVATE_FLAG)

 /*
  * Support for robust futexes: the kernel cleans up held futexes at
diff --git a/kernel/futex.c b/kernel/futex.c
index b59532862bc0..f3833190886f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1592,16 +1592,16 @@ double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 }

 /*
- * Wake up waiters matching bitset queued on this futex (uaddr).
+ * Prepare wake queue matching bitset queued on this futex (uaddr).
  */
 static int
-futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
+prepare_wake_q(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset,
+	       struct wake_q_head *wake_q)
 {
 	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
 	union futex_key key = FUTEX_KEY_INIT;
 	int ret;
-	DEFINE_WAKE_Q(wake_q);

 	if (!bitset)
 		return -EINVAL;
@@ -1629,20 +1629,34 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 			if (!(this->bitset & bitset))
 				continue;

-			mark_wake_futex(&wake_q, this);
+			mark_wake_futex(wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
 	}

 	spin_unlock(&hb->lock);
-	wake_up_q(&wake_q);
 out_put_key:
 	put_futex_key(&key);
 out:
 	return ret;
 }

+/*
+ * Wake up waiters matching bitset queued on this futex (uaddr).
+ */
+static int
+futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
+{
+	int ret;
+	DEFINE_WAKE_Q(wake_q);
+
+	ret = prepare_wake_q(uaddr, flags, nr_wake, bitset, &wake_q);
+	wake_up_q(&wake_q);
+
+	return ret;
+}
+
 static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 {
 	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
@@ -2600,9 +2614,12 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
  * @hb:		the futex hash bucket, must be locked by the caller
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
+ * @next:	if present, wake next and hint to the scheduler that we'd
+ *		prefer to execute it locally.
  */
 static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
-				struct hrtimer_sleeper *timeout)
+				struct hrtimer_sleeper *timeout,
+				struct task_struct *next)
 {
 	/*
 	 * The task state is guaranteed to be set before another task can
@@ -2627,10 +2644,27 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 		 * flagged for rescheduling. Only call schedule if there
 		 * is no timeout, or if it has yet to expire.
 		 */
-		if (!timeout || timeout->task)
+		if (!timeout || timeout->task) {
+			if (next) {
+				/*
+				 * wake_up_process() below will be replaced
+				 * in the next patch with
+				 * wake_up_process_prefer_current_cpu().
+				 */
+				wake_up_process(next);
+				put_task_struct(next);
+				next = NULL;
+			}
 			freezable_schedule();
+		}
 	}
 	__set_current_state(TASK_RUNNING);
+
+	if (next) {
+		/* Maybe call wake_up_process_prefer_current_cpu()? */
+		wake_up_process(next);
+		put_task_struct(next);
+	}
 }

 /**
@@ -2710,7 +2744,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 }

 static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
-		      ktime_t *abs_time, u32 bitset)
+		      ktime_t *abs_time, u32 bitset, struct task_struct *next)
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct restart_block *restart;
@@ -2734,7 +2768,8 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		goto out;

 	/* queue_me and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue_me(hb, &q, to, next);
+	next = NULL;

 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret = 0;
@@ -2767,6 +2802,10 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	ret = -ERESTART_RESTARTBLOCK;

 out:
+	if (next) {
+		wake_up_process(next);
+		put_task_struct(next);
+	}
 	if (to) {
 		hrtimer_cancel(&to->timer);
 		destroy_hrtimer_on_stack(&to->timer);
@@ -2774,7 +2813,6 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	return ret;
 }

-
 static long futex_wait_restart(struct restart_block *restart)
 {
 	u32 __user *uaddr = restart->futex.uaddr;
@@ -2786,10 +2824,35 @@ static long futex_wait_restart(struct restart_block *restart)
 	}
 	restart->fn = do_no_restart_syscall;

-	return (long)futex_wait(uaddr, restart->futex.flags,
-				restart->futex.val, tp, restart->futex.bitset);
+	return (long)futex_wait(uaddr, restart->futex.flags, restart->futex.val,
+				tp, restart->futex.bitset, NULL);
 }

+static int futex_swap(u32 __user *uaddr, unsigned int flags, u32 val,
+		      ktime_t *abs_time, u32 __user *uaddr2)
+{
+	u32 bitset = FUTEX_BITSET_MATCH_ANY;
+	struct task_struct *next = NULL;
+	DEFINE_WAKE_Q(wake_q);
+	int ret;
+
+	ret = prepare_wake_q(uaddr2, flags, 1, bitset, &wake_q);
+	if (!wake_q_empty(&wake_q)) {
+		/* Pull the first wakee out of the queue to swap into. */
+		next = container_of(wake_q.first, struct task_struct, wake_q);
+		wake_q.first = wake_q.first->next;
+		next->wake_q.next = NULL;
+		/*
+		 * Note that wake_up_q does not touch wake_q.last, so we
+		 * do not bother with it here.
+		 */
+		wake_up_q(&wake_q);
+	}
+	if (ret < 0)
+		return ret;
+
+	return futex_wait(uaddr, flags, val, abs_time, bitset, next);
+}

 /*
  * Userspace tried a 0 -> TID atomic transition of the futex value
@@ -3275,7 +3338,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	}

 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue_me(hb, &q, to, NULL);

 	spin_lock(&hb->lock);
 	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
@@ -3805,7 +3868,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		val3 = FUTEX_BITSET_MATCH_ANY;
 		/* fall through */
 	case FUTEX_WAIT_BITSET:
-		return futex_wait(uaddr, flags, val, timeout, val3);
+		return futex_wait(uaddr, flags, val, timeout, val3, NULL);
 	case FUTEX_WAKE:
 		val3 = FUTEX_BITSET_MATCH_ANY;
 		/* fall through */
@@ -3829,6 +3892,8 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 					     uaddr2);
 	case FUTEX_CMP_REQUEUE_PI:
 		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 1);
+	case FUTEX_SWAP:
+		return futex_swap(uaddr, flags, val, timeout, uaddr2);
 	}
 	return -ENOSYS;
 }
@@ -3845,7 +3910,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,

 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
 		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+		      cmd == FUTEX_WAIT_REQUEUE_PI || cmd == FUTEX_SWAP)) {
 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
 			return -EFAULT;
 		if (get_timespec64(&ts, utime))
@@ -3854,7 +3919,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 			return -EINVAL;

 		t = timespec64_to_ktime(ts);
-		if (cmd == FUTEX_WAIT)
+		if (cmd == FUTEX_WAIT || cmd == FUTEX_SWAP)
 			t = ktime_add_safe(ktime_get(), t);
 		tp = &t;
 	}
--
2.25.1


