Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E49AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5174207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="AxS9IsDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgFOR3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:29:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3975C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:29:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so7055128pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=CwV85kmwg0CSnn8+knIi7OvT9VF5M3faI5DMmrOZWTg=;
        b=AxS9IsDsSARGtv4DG8odxsI4tQToRMY5CwpHcPL1/BYQAtwmiCiZ5YSI7+kRyPNUlV
         irUArWniI0Cyk//1gG0NZJl5p6tlrxdHl/luNoCOBsDMGXL6vFV1M83opcTX8HptaXfQ
         WqzPemwhc7MWSCpHPeUwJa+RTTDuw/m6Wg65G39/Nq4PaSRrOwXDX6bxsMbi7fIX7dA3
         lk5qjCa8E6KkH+z1rK82ux5Vw6YoClGbV1eSEjFM3VudLiJ6woQ4XAKBL9BCMpF/eMwV
         1iRdwPF3N6QFMLOBOuGjtajc1kQKazVSWFF/r8AFegBcd99I8+27t45zZhaP2lNPhboD
         +wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=CwV85kmwg0CSnn8+knIi7OvT9VF5M3faI5DMmrOZWTg=;
        b=f2wiX2CGbHkIJWhjRgEQzuEhbWf57NE4tpsW6HOnLpAB4LIkfXbKh7zbYET1NOcl08
         23+tmvRh8q/VMQ2pQdn/dmzGa26R1tufP61pFQg8gL0Oe2BLgFeJ5YUdMuNi0E7DiZnk
         qv75OC5Ja8uackJm1Qhf5ULiKsbIjiPNW+ERV0tien5S2vaU36BWTrDZS0/z+AP0LbXK
         1vqXoQZFDmXyKfIg9pd7RPhUJjdE9CGVd7sSskh1d4BEJ+A7Bf6eaGwH28eLLM3me+UV
         usNC0MlZjCmsEABVihZRILwymzORouaSMI+5r7Zkm+1byxz9pc+l72TVpNd6/VzMDk86
         1/Hg==
X-Gm-Message-State: AOAM530gx+9lCcEYkyietsNrXecjvr8XpadxoH03UYr0jhGHTLT1Wm8w
        T3gr9uKyhxdZ6/z3/AHad5O7tRPHk1hePYRH
X-Google-Smtp-Source: ABdhPJz209nnYxsBTxVJzh7tcmUyz7P+kc0MnM4wnMgnjrpJJ4t1Wv/8Mfn6PaXCrTelhk50ClHO1w==
X-Received: by 2002:a17:902:49:: with SMTP id 67mr22894017pla.205.1592242189924;
        Mon, 15 Jun 2020 10:29:49 -0700 (PDT)
Received: from posk-x1c (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id c2sm14434167pfi.71.2020.06.15.10.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:29:49 -0700 (PDT)
Message-ID: <48058b850de10f949f96b4f311adb649b1fb3ff2.camel@posk.io>
Subject: [RFC PATCH 1/3] futex: introduce FUTEX_SWAP operation
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Date:   Mon, 15 Jun 2020 10:29:48 -0700
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
Subject: [RFC PATCH 1/3] futex: introduce FUTEX_SWAP operation

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


