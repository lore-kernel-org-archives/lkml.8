Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085BBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DD1206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR1nN22y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMJz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:55:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207F8C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 02:55:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so2567333pgl.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QhQqGSG6azQ9d2GJ+2TCi8OhuKdXryXe8ria7u6IUMM=;
        b=WR1nN22yhW0HKSBplFc4JiwLMNReJ5kkFzcCviPa+U0TdVpe5n+Avv60gNa35WCfIv
         p8M54X0bmz+yQZVOrS0SHvNa1HhaQqDF0/RBgDTQ5GuO6zQGhpkhfvtwSHXHbOfLaOsB
         Hu4iD5KCbqcOF933YF+N2Q1IqyjqDG0kljE1MKLjgK2oPOr1xmCuoyd9CcDHN5y3ygfZ
         8KYGxJqPF42eUVhjVC/oX98jCzqgY/XfsERBcYDlBjB9SEN5hbRlx71jmGc9aRu3hCE4
         1qlxASsgDo9lf+q2rqcJBh4geCB6cZjYi1hsL/KH09bbFuooXeQyb39G47Vx8A93VDXa
         vIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QhQqGSG6azQ9d2GJ+2TCi8OhuKdXryXe8ria7u6IUMM=;
        b=S6HTc3T8COLPw9SwflVi+YYQDBbcn38mdwwzYy/gZwgDBKT/xX1s1+Ln132J2DrmRB
         rUXleA6sA/+STE2WsGLhY3deIZADLmokPA1xQUqKo3M8IJw0+ORjwUAww1GRD+3IyCwj
         2/CXUJOIzYReGwswSeex+rp/EAPKtrp5KFxHiei4IA1g/zKOSuJH3wsgFw5P6Givpmt7
         O7DpZNTwlAJl+liMJzb1M4pkru4qPqFW/aE13v4dPyEMteswYKbDWKUWgT7nvKFqv5mG
         QgI5T5OVkSpO8jFsI2+cyu8IiShI3DhOtGFfkgO8ddrnN9oqdH4y3udpD6by49yfTW5o
         cEBw==
X-Gm-Message-State: AOAM532GqKAyqfcsYVjnlBGAvwh3W2HgPelnvBrX0/+vPkd2SORLSIBx
        khaM1WgLW6vMysMCwrcGrug=
X-Google-Smtp-Source: ABdhPJwSs2a+HpHeIq+QCKzQsv20gsg/PTRnjN46+Oy/KDEYWHdpaQgf3/XF1FLT4RvORHAs44VTcA==
X-Received: by 2002:a63:2944:: with SMTP id p65mr3049343pgp.271.1597312524406;
        Thu, 13 Aug 2020 02:55:24 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id z3sm4742346pgk.49.2020.08.13.02.55.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 02:55:23 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tglx@linutronix.de, axboe@kernel.dk, akpm@linux-foundation.org,
        Felix.Kuehling@amd.com
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH v3] kthread: add objectdebug support
Date:   Thu, 13 Aug 2020 17:55:16 +0800
Message-Id: <08985916e4bfc3835207ff87634392ae2eac698e.1597307180.git.zhaoqianli@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

Add debugobject support to track the life time of kthread_work
which is used to detect reinitialization/free active object problems
Add kthread_init_work_onstack/kthread_init_delayed_work_onstack for
kthread onstack support

If we reinitialize a kthread_work that has been activated,
this will cause delayed_work_list/work_list corruption.
enable this config,there is an chance to fixup these errors
or WARNING the wrong use of kthread_work

[30858.395766] list_del corruption. next->prev should be ffffffe388ebbf88, but was ffffffe388ebb588
[30858.395788] WARNING: CPU: 2 PID: 387 at /home/work/data/codes/build_home/kernel/msm-4.19/lib/list_debug.c:56 __list_del_entry_valid+0xc8/0xd0
...
[30858.405951] list_add corruption. next->prev should be prev (ffffffe389392620), but was ffffffe388ebbf88. (next=ffffffe388ebbf88).
[30858.405977] WARNING: CPU: 0 PID: 7721 at /home/work/data/codes/build_home/kernel/msm-4.19/lib/list_debug.c:25 __list_add_valid+0x7c/0xc8

crash> struct kthread_worker.delayed_work_list 0xffffffe3893925f0
 [ffffffe389392620] delayed_work_list = {
    next = 0xffffffe388ebbf88,
    prev = 0xffffffe388ebb588
  }
crash> list 0xffffffe388ebbf88
ffffffe388ebbf88

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
Thanks for your suggestions,tglx,Stephen
please review this patchset

changes:
V3:
- changelog update
- add fixup_assert_init support
- move debug_kwork_activate/debug_kwork_deactivate before list operation
- name the kconfig CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
- use kthread_init_work_onstack/destroy_kwork_on_stack when kthread_work used on stack
- __init_kwork before clear kthread_work in kthread_init_work
---
 include/linux/kthread.h |  29 +++++++++-
 include/linux/poison.h  |   3 +
 kernel/kthread.c        | 142 +++++++++++++++++++++++++++++++++++++++++++++---
 lib/Kconfig.debug       |  10 ++++
 4 files changed, 176 insertions(+), 8 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 65b81e0..d3481a3 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -108,6 +108,16 @@ struct kthread_delayed_work {
 	struct timer_list timer;
 };
 
+#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
+extern void __init_kwork(struct kthread_work *kwork, int onstack);
+extern void destroy_kwork_on_stack(struct kthread_work *kwork);
+extern void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork);
+#else
+static inline void __init_kwork(struct kthread_work *kwork, int onstack) { }
+static inline void destroy_kwork_on_stack(struct kthread_work *kwork) { }
+static inline void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork) { }
+#endif
+
 #define KTHREAD_WORKER_INIT(worker)	{				\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
 	.work_list = LIST_HEAD_INIT((worker).work_list),		\
@@ -115,7 +125,7 @@ struct kthread_delayed_work {
 	}
 
 #define KTHREAD_WORK_INIT(work, fn)	{				\
-	.node = LIST_HEAD_INIT((work).node),				\
+	.node = { .next = KWORK_ENTRY_STATIC },				\
 	.func = (fn),							\
 	}
 
@@ -159,6 +169,15 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 
 #define kthread_init_work(work, fn)					\
 	do {								\
+		__init_kwork(work, 0);						\
+		memset((work), 0, sizeof(struct kthread_work));		\
+		INIT_LIST_HEAD(&(work)->node);				\
+		(work)->func = (fn);					\
+	} while (0)
+
+#define kthread_init_work_onstack(work, fn)					\
+	do {								\
+		__init_kwork(work, 1);						\
 		memset((work), 0, sizeof(struct kthread_work));		\
 		INIT_LIST_HEAD(&(work)->node);				\
 		(work)->func = (fn);					\
@@ -172,6 +191,14 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 			     TIMER_IRQSAFE);				\
 	} while (0)
 
+#define kthread_init_delayed_work_onstack(dwork, fn)				\
+	do {								\
+		kthread_init_work_onstack(&(dwork)->work, (fn));		\
+		__init_timer_on_stack(&(dwork)->timer,				\
+			     kthread_delayed_work_timer_fn,		\
+			     TIMER_IRQSAFE);				\
+	} while (0)
+
 int kthread_worker_fn(void *worker_ptr);
 
 __printf(2, 3)
diff --git a/include/linux/poison.h b/include/linux/poison.h
index df34330..2e6a370 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -86,4 +86,7 @@
 /********** security/ **********/
 #define KEY_DESTROY		0xbd
 
+/********** kernel/kthread **********/
+#define KWORK_ENTRY_STATIC	((void *) 0x600 + POISON_POINTER_DELTA)
+
 #endif
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 132f84a..68a16cc 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -67,6 +67,118 @@ enum KTHREAD_BITS {
 	KTHREAD_SHOULD_PARK,
 };
 
+#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
+static struct debug_obj_descr kwork_debug_descr;
+
+static void *kwork_debug_hint(void *addr)
+{
+	return ((struct kthread_work *) addr)->func;
+}
+
+static bool kwork_is_static_object(void *addr)
+{
+	struct kthread_work *kwork = addr;
+
+	return (kwork->node.prev == NULL &&
+		kwork->node.next == KWORK_ENTRY_STATIC);
+}
+
+static bool kwork_fixup_init(void *addr, enum debug_obj_state state)
+{
+	struct kthread_work *kwork = addr;
+
+	switch (state) {
+	case ODEBUG_STATE_ACTIVE:
+		kthread_cancel_work_sync(kwork);
+		debug_object_init(kwork, &kwork_debug_descr);
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool kwork_fixup_free(void *addr, enum debug_obj_state state)
+{
+	struct kthread_work *kwork = addr;
+
+	switch (state) {
+	case ODEBUG_STATE_ACTIVE:
+		kthread_cancel_work_sync(kwork);
+		debug_object_free(kwork, &kwork_debug_descr);
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void stub_kthread_work(struct kthread_work *unuse)
+{
+	WARN_ON(1);
+}
+
+static bool kwork_fixup_assert_init(void *addr, enum debug_obj_state state)
+{
+	struct kthread_work *kwork = addr;
+	switch (state) {
+	case ODEBUG_STATE_NOTAVAILABLE:
+		kthread_init_work(kwork, stub_kthread_work);
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct debug_obj_descr kwork_debug_descr = {
+		.name		= "kthread_work",
+		.debug_hint	= kwork_debug_hint,
+		.is_static_object = kwork_is_static_object,
+		.fixup_init	= kwork_fixup_init,
+		.fixup_free	= kwork_fixup_free,
+		.fixup_assert_init = kwork_fixup_assert_init,
+};
+
+static inline void debug_kwork_activate(struct kthread_work *kwork)
+{
+	debug_object_activate(kwork, &kwork_debug_descr);
+}
+
+static inline void debug_kwork_deactivate(struct kthread_work *kwork)
+{
+	debug_object_deactivate(kwork, &kwork_debug_descr);
+}
+
+static inline void debug_kwork_assert_init(struct kthread_work *kwork)
+{
+	debug_object_assert_init(kwork, &kwork_debug_descr);
+}
+
+void __init_kwork(struct kthread_work *kwork, int onstack)
+{
+	if (onstack)
+		debug_object_init_on_stack(kwork, &kwork_debug_descr);
+	else
+		debug_object_init(kwork, &kwork_debug_descr);
+}
+EXPORT_SYMBOL_GPL(__init_kwork);
+
+void destroy_kwork_on_stack(struct kthread_work *kwork)
+{
+	debug_object_free(kwork, &kwork_debug_descr);
+}
+EXPORT_SYMBOL_GPL(destroy_kwork_on_stack);
+
+void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork)
+{
+	destroy_timer_on_stack(&kdwork->timer);
+	debug_object_free(&kdwork->work, &kwork_debug_descr);
+}
+EXPORT_SYMBOL_GPL(destroy_delayed_kwork_on_stack);
+#else
+static inline void debug_kwork_activate(struct kthread_work *kwork) { }
+static inline void debug_kwork_deactivate(struct kthread_work *kwork) { }
+static inline void debug_kwork_assert_init(struct kthread_work *kwork) { }
+#endif
+
 static inline void set_kthread_struct(void *kthread)
 {
 	/*
@@ -697,6 +809,7 @@ int kthread_worker_fn(void *worker_ptr)
 	if (!list_empty(&worker->work_list)) {
 		work = list_first_entry(&worker->work_list,
 					struct kthread_work, node);
+		debug_kwork_deactivate(work);
 		list_del_init(&work->node);
 	}
 	worker->current_work = work;
@@ -833,8 +946,10 @@ static void kthread_insert_work(struct kthread_worker *worker,
 {
 	kthread_insert_work_sanity_check(worker, work);
 
+	debug_kwork_activate(work);
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
+
 	if (!worker->current_work && likely(worker->task))
 		wake_up_process(worker->task);
 }
@@ -857,6 +972,7 @@ bool kthread_queue_work(struct kthread_worker *worker,
 	bool ret = false;
 	unsigned long flags;
 
+	debug_kwork_assert_init(work);
 	raw_spin_lock_irqsave(&worker->lock, flags);
 	if (!queuing_blocked(worker, work)) {
 		kthread_insert_work(worker, work, &worker->work_list);
@@ -895,6 +1011,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 
 	/* Move the work from worker->delayed_work_list. */
 	WARN_ON_ONCE(list_empty(&work->node));
+	debug_kwork_deactivate(work);
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
 
@@ -924,7 +1041,7 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 
 	/* Be paranoid and try to detect possible races already now. */
 	kthread_insert_work_sanity_check(worker, work);
-
+	debug_kwork_activate(work);
 	list_add(&work->node, &worker->delayed_work_list);
 	work->worker = worker;
 	timer->expires = jiffies + delay;
@@ -954,6 +1071,7 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	bool ret = false;
 
+	debug_kwork_assert_init(work);
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	if (!queuing_blocked(worker, work)) {
@@ -987,15 +1105,16 @@ static void kthread_flush_work_fn(struct kthread_work *work)
 void kthread_flush_work(struct kthread_work *work)
 {
 	struct kthread_flush_work fwork = {
-		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
-		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
+		.done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),
 	};
 	struct kthread_worker *worker;
 	bool noop = false;
 
+	kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
+	debug_kwork_assert_init(work);
 	worker = work->worker;
 	if (!worker)
-		return;
+		goto out;
 
 	raw_spin_lock_irq(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
@@ -1013,6 +1132,9 @@ void kthread_flush_work(struct kthread_work *work)
 
 	if (!noop)
 		wait_for_completion(&fwork.done);
+
+out:
+	destroy_kwork_on_stack(&fwork.work);
 }
 EXPORT_SYMBOL_GPL(kthread_flush_work);
 
@@ -1053,6 +1175,7 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
 	 * be from worker->work_list or from worker->delayed_work_list.
 	 */
 	if (!list_empty(&work->node)) {
+		debug_kwork_deactivate(work);
 		list_del_init(&work->node);
 		return true;
 	}
@@ -1091,6 +1214,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	int ret = false;
 
+	debug_kwork_assert_init(work);
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	/* Do not bother with canceling when never queued. */
@@ -1115,10 +1239,13 @@ EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
 
 static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 {
-	struct kthread_worker *worker = work->worker;
+	struct kthread_worker *worker;
 	unsigned long flags;
 	int ret = false;
 
+	debug_kwork_assert_init(work);
+
+	worker = work->worker;
 	if (!worker)
 		goto out;
 
@@ -1194,12 +1321,13 @@ EXPORT_SYMBOL_GPL(kthread_cancel_delayed_work_sync);
 void kthread_flush_worker(struct kthread_worker *worker)
 {
 	struct kthread_flush_work fwork = {
-		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
-		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
+		.done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),
 	};
 
+	kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
 	kthread_queue_work(worker, &fwork.work);
 	wait_for_completion(&fwork.done);
+	destroy_kwork_on_stack(&fwork.work);
 }
 EXPORT_SYMBOL_GPL(kthread_flush_worker);
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210..71d6696 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -540,6 +540,16 @@ config DEBUG_OBJECTS_WORK
 	  work queue routines to track the life time of work objects and
 	  validate the work operations.
 
+config DEBUG_OBJECTS_KTHREAD_WORK
+	bool "Debug kthread work objects"
+	depends on DEBUG_OBJECTS
+	help
+	  If you say Y here, additional code will be inserted into the
+	  kthread routines to track the life time of kthread_work objects
+	  and validate the kthread_work operations.
+
+	  If unsure, say N.
+
 config DEBUG_OBJECTS_RCU_HEAD
 	bool "Debug RCU callbacks objects"
 	depends on DEBUG_OBJECTS
-- 
2.7.4

