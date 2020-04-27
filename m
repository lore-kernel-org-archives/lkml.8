Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E84FC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCD620775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZIJCLa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgD0SoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgD0SoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:44:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9327C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:44:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j14so21685913ybt.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tUPZR8jYBc9v0xao/MABE2wsoNahfX3099p1cY3Tx9I=;
        b=lZIJCLa+TvQTi89lCRezZep/+7/9ZWTuSARZ1PUJMboOoDXBMqWkSqvNkma50SOQV/
         DSvlOUH6OdjsjwrIf3+NroE6VDbQd0EBzWjoB9jv/ncM7JDj9zKofuW8Y4shDCUr/073
         JP//OKFXcbyTo6zqlt58oGm+VtKHwZxY/Fcad3Cv/ig+1crdCTroUUn6IWcut6gtOW8o
         2pKGYd9pd7B2+ApuCAFXVj1npCz4ulWWqbkzSCr4AYWCcHHhXofHbhXGp7yc9P1vmNdT
         R8hjKxMO6uPGW64bRBvfxWAT8tK4lYWmEyDmxSBfAoYhVPeJvNF7iiNdj1V90i6KprO2
         iCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tUPZR8jYBc9v0xao/MABE2wsoNahfX3099p1cY3Tx9I=;
        b=fWpi+zr2ToV3/j5W9QRLBL6EnSCBBnP7XUyx39FFObpdlYFx1+6XfXjSlD/8WsnbjX
         DNsyl5Fqu/kRhA1aGXmATj+muiPQmbp2xSV+9qcjLkRv6z9DRmm5nAfeZXijbuUBavIL
         O4cWAWxZyuCJchFsY9bYmj8OPbnu/B91oaM7Xfywt+wayfVi8h1+DNHm/M8GsYyQAy4x
         igijXpUBF9Kj8h7CAg9OrmbBi+Fq/49X6vwZcjssPi3md6DpzElHEkkW0KvvqCawTMw8
         XzQrTyx0GxEQe5IItSzDsyqNvE+1LAup+yWcxCKTkMoUpKV/4BfEZ+zznWeG40eGvLxC
         GI+A==
X-Gm-Message-State: AGi0PuZ0yHArRQbZmIktkrx9ft8w2rod5sB3EpUo5udJp+jD9PMKrdqR
        7CZHFeNt15PK88fh5CHA69S1aEilhOs=
X-Google-Smtp-Source: APiQypKo+1K46gA5Mu7rAXthGEDVu9OINkjfOa7QcJ7hbSFQOr/t9jxSe52Fx9HCXlqWkoQlGh73wu3Ihkg=
X-Received: by 2002:a25:3252:: with SMTP id y79mr38694008yby.274.1588013042905;
 Mon, 27 Apr 2020 11:44:02 -0700 (PDT)
Date:   Mon, 27 Apr 2020 11:43:58 -0700
Message-Id: <20200427184358.191624-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 1/1] kthread: break dependency between worker->lock and task_struct->pi_lock
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
at: https://lkml.org/lkml/2020/4/24/954
Break this lock dependency by moving task wakeup after worker->lock has
been released.

Reported-by: Ke Wang <ke.wang@unisoc.com>
Reported-by: Shakeel Butt <shakeelb@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/kthread.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..7a93654072bb 100644
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
+		kthread_insert_work(worker, &fwork.work, work->node.next,
+				    &wake_q);
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
2.26.2.303.gf8c07b1a785-goog

