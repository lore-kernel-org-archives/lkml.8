Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90676C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBB720825
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="a5EzuJ5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbgGVXpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgGVXpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:45:46 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB184C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:45:45 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so3444170oik.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbrD/xou7w/KcHuqGWHeyFBLahEZyuXDhUgdpGw59Kc=;
        b=a5EzuJ5t4+WSvoRrrkrCN72VXvDgGFjX/d8UsQZFSfsJ9yRVykSnqNeLS8tCjDQ7sN
         /wdU92W8hiD/5MHIBy8IAPQtYA1YAUdcCyQfxgwq0YwwQGuYqWIqepcSCyankesU5HtR
         wooN8yHcZMV9vFiDb8JYa200YKmNxt8C3tWeGHh4yh1jg6oz8wZmyVFB69YDsID8N72Q
         wXfQwQgLRdNp1n8AvLr9iZyi9ErG5r3VxFGvMY6YLj/qvitk22ID9TXRlLHKpcGgrDy8
         OM9U4z6/jA+oM/RSCGJAUmmVFtVcolz9qapEF7vW1ODZNTsoQod6PwDsmv4pzP+dNz9H
         i50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbrD/xou7w/KcHuqGWHeyFBLahEZyuXDhUgdpGw59Kc=;
        b=hF26DgEhaOjWEs2bXwuRcFAduWHU/3Yat4g0ze29YjqmmNhAdNyE3vwENnRC9fz38V
         EtW8jeD9G5N1CLNvXrBYokH9bsA9Ic23PzwaqtHfAnrsKNFLXcWXe4fdMlp4yMriNtVk
         R1pIRggr4tDROZ+ySSB/UeBDJHRECLeH6zsH8FOO7zdLmN8tyCJbsiymYESksPzR7AvW
         JhAACnUdUesGOyNbMjjhYXf1hVUIN385FrXIhH5B8KskD0ugNDfcp3IpcY+oBheZiOJ3
         mnCP+SwQlkOb4HwRyLR2UbcHclqOP3LHsOXrIv11ZwU1WqGChBSrSZC5+zS/pWOlWA3S
         LnJA==
X-Gm-Message-State: AOAM531LeZNPZBALw9AxrNE/pYskt94rmXE6DABfzHWdndjvtevXYap1
        RRwQkqQVYjYZukyfMvuz5FCCXaVHUes=
X-Google-Smtp-Source: ABdhPJwZQHp6/LCb7JRKF73MDtamOQhS+xi4yu0wDZr8igOgLb/bdw/fJ59IdAG6TwwYVKj0BinaWQ==
X-Received: by 2002:aca:6c6:: with SMTP id 189mr1683171oig.134.1595461544710;
        Wed, 22 Jul 2020 16:45:44 -0700 (PDT)
Received: from posk-x1c.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id x9sm294804ota.9.2020.07.22.16.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 16:45:44 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, Andrei Vagin <avagin@google.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Aaron Lu <aaron.lwe@gmail.com>
Subject: [PATCH for 5.9 1/3] futex: introduce FUTEX_SWAP operation
Date:   Wed, 22 Jul 2020 16:45:36 -0700
Message-Id: <20200722234538.166697-2-posk@posk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722234538.166697-1-posk@posk.io>
References: <20200722234538.166697-1-posk@posk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

As Paul Turner presented at LPC in 2013 ...
- pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf
- video: https://www.youtube.com/watch?v=KXuZi9aeGTw

... Google has developed an M:N userspace threading subsystem backed
by Google-private SwitchTo Linux Kernel API (page 17 in the pdf referenced
above). This subsystem provides latency-sensitive services at Google with
fine-grained user-space control/scheduling over what is running when,
and this subsystem is used widely internally (called schedulers or fibers).

This patchset is the first step to open-source this work. As explained
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
 kernel/futex.c             | 90 +++++++++++++++++++++++++++++++-------
 2 files changed, 76 insertions(+), 16 deletions(-)

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
index 4616d4ad609d..f077168a4410 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1162,7 +1162,7 @@ static int handle_exit_race(u32 __user *uaddr, u32 uval,
 	 *  tsk->futex_state =               } else {
 	 *	FUTEX_STATE_DEAD;              if (tsk->futex_state !=
 	 *					  FUTEX_STATE_DEAD)
-	 *				         return -EAGAIN;
+	 *					 return -EAGAIN;
 	 *				       return -ESRCH; <--- FAIL
 	 *				     }
 	 *
@@ -1574,16 +1574,16 @@ double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
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
@@ -1611,14 +1611,28 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 			if (!(this->bitset & bitset))
 				continue;
 
-			mark_wake_futex(&wake_q, this);
+			mark_wake_futex(wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
 	}
 
 	spin_unlock(&hb->lock);
+	return ret;
+}
+
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
 	wake_up_q(&wake_q);
+
 	return ret;
 }
 
@@ -2557,9 +2571,12 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
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
@@ -2584,10 +2601,26 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
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
+		wake_up_process(next);
+		put_task_struct(next);
+	}
 }
 
 /**
@@ -2663,7 +2696,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 }
 
 static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
-		      ktime_t *abs_time, u32 bitset)
+		      ktime_t *abs_time, u32 bitset, struct task_struct *next)
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct restart_block *restart;
@@ -2687,7 +2720,8 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		goto out;
 
 	/* queue_me and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue_me(hb, &q, to, next);
+	next = NULL;
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret = 0;
@@ -2720,6 +2754,10 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	ret = -ERESTART_RESTARTBLOCK;
 
 out:
+	if (next) {
+		wake_up_process(next);
+		put_task_struct(next);
+	}
 	if (to) {
 		hrtimer_cancel(&to->timer);
 		destroy_hrtimer_on_stack(&to->timer);
@@ -2727,7 +2765,6 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	return ret;
 }
 
-
 static long futex_wait_restart(struct restart_block *restart)
 {
 	u32 __user *uaddr = restart->futex.uaddr;
@@ -2739,10 +2776,29 @@ static long futex_wait_restart(struct restart_block *restart)
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
+	if (ret < 0)
+		return ret;
+	if (!wake_q_empty(&wake_q)) {
+		/* At most one wakee can be present. Pull it out. */
+		next = container_of(wake_q.first, struct task_struct, wake_q);
+		next->wake_q.next = NULL;
+	}
+
+	return futex_wait(uaddr, flags, val, abs_time, bitset, next);
+}
 
 /*
  * Userspace tried a 0 -> TID atomic transition of the futex value
@@ -3221,7 +3277,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	}
 
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue_me(hb, &q, to, NULL);
 
 	spin_lock(&hb->lock);
 	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
@@ -3746,7 +3802,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		val3 = FUTEX_BITSET_MATCH_ANY;
 		/* fall through */
 	case FUTEX_WAIT_BITSET:
-		return futex_wait(uaddr, flags, val, timeout, val3);
+		return futex_wait(uaddr, flags, val, timeout, val3, NULL);
 	case FUTEX_WAKE:
 		val3 = FUTEX_BITSET_MATCH_ANY;
 		/* fall through */
@@ -3770,6 +3826,8 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 					     uaddr2);
 	case FUTEX_CMP_REQUEUE_PI:
 		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 1);
+	case FUTEX_SWAP:
+		return futex_swap(uaddr, flags, val, timeout, uaddr2);
 	}
 	return -ENOSYS;
 }
@@ -3786,7 +3844,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 
 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
 		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+		      cmd == FUTEX_WAIT_REQUEUE_PI || cmd == FUTEX_SWAP)) {
 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
 			return -EFAULT;
 		if (get_timespec64(&ts, utime))
@@ -3795,7 +3853,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 			return -EINVAL;
 
 		t = timespec64_to_ktime(ts);
-		if (cmd == FUTEX_WAIT)
+		if (cmd == FUTEX_WAIT || cmd == FUTEX_SWAP)
 			t = ktime_add_safe(ktime_get(), t);
 		tp = &t;
 	}
-- 
2.25.1

