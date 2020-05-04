Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FB2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FA521655
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FneXA0Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgEDSZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729963AbgEDSZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:25:47 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:25:47 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o19so200431qko.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Vr82xnSdttu/vwNeVjuXmdlyvgmTUqEl7LZO5k4HAlY=;
        b=FneXA0CsHKSgv1W+P2IQfI9C8e/ieyCjIGOOXkDQG9ARa3vmqWwtwcqWgVDtP17aic
         Pzx+bvvZY6ASVtBNbJWIZynhPwRhsJotgS/byYrrZzhCrNYBbtXtKFrcnLtZ93ppfgwO
         +VnD/trb8iv2yoaMr4+gdF8COIx/7mQI46SMzTrsA7K6R6YlqyFuhseKOjGveDP+b5tM
         jM5QQrTABZlrqJTT8FDWU1mtKkWua/8thCYnyRO6EZQl7Rzn3PqRW5Bt3w+4WEMsazVx
         lklDzpxo3EdbSSjxGpqM5iywPjMTuOnJBRXIxhAZZAiivAIzxuGhOId3CewyZhZ0Aztn
         TosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Vr82xnSdttu/vwNeVjuXmdlyvgmTUqEl7LZO5k4HAlY=;
        b=inFUvpoRNsCbC8TKf5ify0BZo+jfJTvfFHS66QWaqbzVEsTJbyZXEDZP6MuN8axCN9
         n1LkJhCCPz+LoywfrMGXteKaw0SExyrCnMQTXCsH+bE0SWvO3eeFxCxsfaPJzz7T1wze
         x57NRycvRUQflR4nyL/0Iv+If1vUf5dAA+5RHT4PD9vhIs800RKiO+57f7tMLIXrlQKR
         GIetqaprpwtvblc3igccs+SqVguNFAUZBbSrWQAIJuCQp9glZCnkdu9iphH0P5Gme8ij
         Y8RZFGhDqQmJ8EIkEezU+R388YduXSeCcHdVvOgWHvJOao+Xn1bqyhPzIX3V24iR1E+g
         hrVg==
X-Gm-Message-State: AGi0PuYCVxERIGwCA17pQODluXvK5g1Ad3FNXhJNoohiGeD1sixUPbHp
        WV2aeFUFaAM7Hlqwrz43Jco8k9U21hk=
X-Google-Smtp-Source: APiQypKpkGH3ku1eNF7NWCvz4QuH/NE1kfdyAmilguB2sknGZK+XaHTXQHMJRWari/NX/TZPKNA0sK4y/yQ=
X-Received: by 2002:a05:6214:8e9:: with SMTP id dr9mr460689qvb.84.1588616746138;
 Mon, 04 May 2020 11:25:46 -0700 (PDT)
Date:   Mon,  4 May 2020 11:25:40 -0700
Message-Id: <20200504182540.11124-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v2 1/1] kthread: break dependency between worker->lock and task_struct->pi_lock
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     peterz@infradead.org, mingo@redhat.com, hannes@cmpxchg.org,
        will@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
        ben.dooks@codethink.co.uk, cl@rock-chips.com, ke.wang@unisoc.com,
        shakeelb@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of kthread-related functions indirectly take task_struct->pi_lock
while holding worker->lock in the call chain like this:
    spin_lock(&worker->lock)
    kthread_insert_work
    wake_up_process
    try_to_wake_up
    raw_spin_lock_irqsave(&p->pi_lock, flags)

This lock dependency exists whenever kthread_insert_work is called either
directly or indirectly via __kthread_queue_delayed_work in the following
functions:
    kthread_queue_work
    kthread_delayed_work_timer_fn
    kthread_queue_delayed_work
    kthread_flush_work
    kthread_mod_delayed_work

This creates possibilities for circular dependencies like the one reported
at [1]. Break this lock dependency by moving task wakeup after worker->lock
has been released.

[1]: https://lore.kernel.org/lkml/CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com

Reported-by: Ke Wang <ke.wang@unisoc.com>
Reported-by: Shakeel Butt <shakeelb@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>

---
v2:
  * replace lkml link with lore.kernel.org one
  * change a line break to be more consistent with the rest of the code
---
 kernel/kthread.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..d37cd37d934c 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -9,6 +9,7 @@
 #include <uapi/linux/sched/types.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
+#include <linux/sched/wake_q.h>
 #include <linux/kthread.h>
 #include <linux/completion.h>
 #include <linux/err.h>
@@ -806,14 +807,15 @@ static void kthread_insert_work_sanity_check(struct kthread_worker *worker,
 /* insert @work before @pos in @worker */
 static void kthread_insert_work(struct kthread_worker *worker,
 				struct kthread_work *work,
-				struct list_head *pos)
+				struct list_head *pos,
+				struct wake_q_head *wake_q)
 {
 	kthread_insert_work_sanity_check(worker, work);
 
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
 	if (!worker->current_work && likely(worker->task))
-		wake_up_process(worker->task);
+		wake_q_add(wake_q, worker->task);
 }
 
 /**
@@ -831,15 +833,19 @@ static void kthread_insert_work(struct kthread_worker *worker,
 bool kthread_queue_work(struct kthread_worker *worker,
 			struct kthread_work *work)
 {
-	bool ret = false;
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
+	bool ret = false;
 
 	raw_spin_lock_irqsave(&worker->lock, flags);
 	if (!queuing_blocked(worker, work)) {
-		kthread_insert_work(worker, work, &worker->work_list);
+		kthread_insert_work(worker, work, &worker->work_list, &wake_q);
 		ret = true;
 	}
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
+
+	wake_up_q(&wake_q);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_work);
@@ -857,6 +863,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	struct kthread_delayed_work *dwork = from_timer(dwork, t, timer);
 	struct kthread_work *work = &dwork->work;
 	struct kthread_worker *worker = work->worker;
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 
 	/*
@@ -873,15 +880,18 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	/* Move the work from worker->delayed_work_list. */
 	WARN_ON_ONCE(list_empty(&work->node));
 	list_del_init(&work->node);
-	kthread_insert_work(worker, work, &worker->work_list);
+	kthread_insert_work(worker, work, &worker->work_list, &wake_q);
 
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
+
+	wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
 
 static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 					 struct kthread_delayed_work *dwork,
-					 unsigned long delay)
+					 unsigned long delay,
+					 struct wake_q_head *wake_q)
 {
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
@@ -895,7 +905,7 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	 * on that there's no such delay when @delay is 0.
 	 */
 	if (!delay) {
-		kthread_insert_work(worker, work, &worker->work_list);
+		kthread_insert_work(worker, work, &worker->work_list, wake_q);
 		return;
 	}
 
@@ -928,17 +938,21 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
 				unsigned long delay)
 {
 	struct kthread_work *work = &dwork->work;
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 	bool ret = false;
 
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	if (!queuing_blocked(worker, work)) {
-		__kthread_queue_delayed_work(worker, dwork, delay);
+		__kthread_queue_delayed_work(worker, dwork, delay, &wake_q);
 		ret = true;
 	}
 
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
+
+	wake_up_q(&wake_q);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
@@ -967,6 +981,7 @@ void kthread_flush_work(struct kthread_work *work)
 		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
 		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
 	};
+	DEFINE_WAKE_Q(wake_q);
 	struct kthread_worker *worker;
 	bool noop = false;
 
@@ -979,15 +994,18 @@ void kthread_flush_work(struct kthread_work *work)
 	WARN_ON_ONCE(work->worker != worker);
 
 	if (!list_empty(&work->node))
-		kthread_insert_work(worker, &fwork.work, work->node.next);
+		kthread_insert_work(worker, &fwork.work,
+				    work->node.next, &wake_q);
 	else if (worker->current_work == work)
 		kthread_insert_work(worker, &fwork.work,
-				    worker->work_list.next);
+				    worker->work_list.next, &wake_q);
 	else
 		noop = true;
 
 	raw_spin_unlock_irq(&worker->lock);
 
+	wake_up_q(&wake_q);
+
 	if (!noop)
 		wait_for_completion(&fwork.done);
 }
@@ -1065,6 +1083,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 			      unsigned long delay)
 {
 	struct kthread_work *work = &dwork->work;
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 	int ret = false;
 
@@ -1083,9 +1102,12 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 
 	ret = __kthread_cancel_work(work, true, &flags);
 fast_queue:
-	__kthread_queue_delayed_work(worker, dwork, delay);
+	__kthread_queue_delayed_work(worker, dwork, delay, &wake_q);
 out:
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
+
+	wake_up_q(&wake_q);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
-- 
2.26.2.526.g744177e7f7-goog

