Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA59AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C0C20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="bAt/OYJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgHCWPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgHCWPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:15:18 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A6CC061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 15:15:18 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b22so8710854oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 15:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RP1mmSJLoGcdLaNUgBjjlLBGhBh4QSZTvBeWGKSKCzQ=;
        b=bAt/OYJiFvX7yQzDRnylov4wFiFHAjF1ELEXlddyyzw6tmW/6+V5WvIr5OkbCFk+CS
         5TRFlA17aEoKQrOfWonHRhxqZv7HH3NpVnwxGNSn1Dw88MkTpfJQCG0jj6ik4wcqRd0x
         nr2dYEHHLPrJeCPqGScP/lBVacUMZJwtppuO0GchcyZktL+XjFD/atYUNfEFM0TCoWvh
         A3KaaC8g7ABqBRwVpnO64bBAZ5bDhnwDfESHMptvjFZqdFRpOIyRQ8BBjALXQv71VmQ6
         lpWGG+ZGpNS/cWEXJ93LxWOHoTvXISbtSsQRXQp1oEu1pcxOx/BpfKIVrESGKkNYlZiy
         YTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RP1mmSJLoGcdLaNUgBjjlLBGhBh4QSZTvBeWGKSKCzQ=;
        b=h3MwVtRJnbBTqGc3sMv/6rV6301kJlH+8uI/suoG4h8WKoQzkwpySkB3I921HBRRM0
         Ijh4qsEcZevGn1s6kJlhjr7yrabttKVOne9kRlM3moodD4H7YixSxm3nVUWIDaLie2Ca
         4VwFXwv4n3XcZE9Lyvc5tL1XVi5B6SE6qsk0NntvtEUPzMRaGUlVhe22H7teZD83QoDk
         wVM1Owc6cEp/JlTVgNNCoBsijp28RS6sHQcFkgCKiWMYLEUF4fH45p2jV1Y1d4lmnnzu
         0ZhHEeBfBqr18xfYAeoH94UxK+D7fYublresctkAc2j5JLT66iTWDF0fmEo+hV/KSJEv
         umTg==
X-Gm-Message-State: AOAM532kUA0v8hb8FcYWG3s+Qje3q0lhBSJTk6MtI+Vg+HYlSQODCQFy
        urfVMTKVeJJthJWXsIiTYH8jGo/E5sE=
X-Google-Smtp-Source: ABdhPJzWTLv9/Vxyh65yQBN1UAlV0Yi+3uxFrxakSCvLFfzMIBf9Nhv0tVTnkCbJgO9PQAzYMLKZoA==
X-Received: by 2002:a05:6808:2d4:: with SMTP id a20mr1100894oid.151.1596492917635;
        Mon, 03 Aug 2020 15:15:17 -0700 (PDT)
Received: from posk-x1c.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id m8sm3026624ote.55.2020.08.03.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 15:15:17 -0700 (PDT)
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
Subject: [PATCH for 5.9 v2 2/4] futex: implement FUTEX_SWAP as wake+wait.
Date:   Mon,  3 Aug 2020 15:15:08 -0700
Message-Id: <20200803221510.170674-3-posk@posk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803221510.170674-1-posk@posk.io>
References: <20200803221510.170674-1-posk@posk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

See the previous patch in the patchset, which introduced
FUTEX_SWAP op in futex.h, for a detailed description of
the use cases and future directions.

This patch implements FUTEX_SWAP as a simple wake+wait.
The next patch will improve this by migrating the wakee
to the waker's (= waiter's) CPU.

Tested: see patch 4 in this patchset.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 kernel/futex.c | 87 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 15 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 4616d4ad609d..a81d62a16e72 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1574,16 +1574,16 @@ double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 }
 
 /*
- * Wake up waiters matching bitset queued on this futex (uaddr).
+ * Prepare wake queue matching bitset queued on this futex (uaddr).
  */
 static int
-futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
+prepare_wake_q(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset,
+		struct wake_q_head *wake_q)
 {
 	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
 	union futex_key key = FUTEX_KEY_INIT;
 	int ret;
-	DEFINE_WAKE_Q(wake_q);
 
 	if (!bitset)
 		return -EINVAL;
@@ -1611,13 +1611,26 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
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
 	return ret;
 }
@@ -2557,9 +2570,12 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
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
@@ -2584,10 +2600,26 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 		 * flagged for rescheduling. Only call schedule if there
 		 * is no timeout, or if it has yet to expire.
 		 */
-		if (!timeout || timeout->task)
+		if (!timeout || timeout->task) {
+			if (next) {
+				/*
+				 * wake_up_process() below will be
+				 * replaced in the next patch with
+				 * wake_up_swap().
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
@@ -2663,7 +2695,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 }
 
 static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
-		      ktime_t *abs_time, u32 bitset)
+		      ktime_t *abs_time, u32 bitset, struct task_struct *next)
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct restart_block *restart;
@@ -2687,7 +2719,8 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		goto out;
 
 	/* queue_me and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue_me(hb, &q, to, next);
+	next = NULL;
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret = 0;
@@ -2720,6 +2753,10 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	ret = -ERESTART_RESTARTBLOCK;
 
 out:
+	if (next) {
+		wake_up_process(next);
+		put_task_struct(next);
+	}
 	if (to) {
 		hrtimer_cancel(&to->timer);
 		destroy_hrtimer_on_stack(&to->timer);
@@ -2727,7 +2764,6 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	return ret;
 }
 
-
 static long futex_wait_restart(struct restart_block *restart)
 {
 	u32 __user *uaddr = restart->futex.uaddr;
@@ -2739,10 +2775,29 @@ static long futex_wait_restart(struct restart_block *restart)
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
@@ -3221,7 +3276,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	}
 
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue_me(hb, &q, to, NULL);
 
 	spin_lock(&hb->lock);
 	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
@@ -3746,7 +3801,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		val3 = FUTEX_BITSET_MATCH_ANY;
 		/* fall through */
 	case FUTEX_WAIT_BITSET:
-		return futex_wait(uaddr, flags, val, timeout, val3);
+		return futex_wait(uaddr, flags, val, timeout, val3, NULL);
 	case FUTEX_WAKE:
 		val3 = FUTEX_BITSET_MATCH_ANY;
 		/* fall through */
@@ -3770,6 +3825,8 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 					     uaddr2);
 	case FUTEX_CMP_REQUEUE_PI:
 		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 1);
+	case FUTEX_SWAP:
+		return futex_swap(uaddr, flags, val, timeout, uaddr2);
 	}
 	return -ENOSYS;
 }
@@ -3786,7 +3843,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 
 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
 		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+		      cmd == FUTEX_WAIT_REQUEUE_PI || cmd == FUTEX_SWAP)) {
 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
 			return -EFAULT;
 		if (get_timespec64(&ts, utime))
@@ -3795,7 +3852,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 			return -EINVAL;
 
 		t = timespec64_to_ktime(ts);
-		if (cmd == FUTEX_WAIT)
+		if (cmd == FUTEX_WAIT || cmd == FUTEX_SWAP)
 			t = ktime_add_safe(ktime_get(), t);
 		tp = &t;
 	}
-- 
2.25.1

