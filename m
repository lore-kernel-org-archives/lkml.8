Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997BCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DE120716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJMgrGf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgHQGhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 02:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgHQGhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 02:37:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1BEC061388
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 23:37:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 128so7647017pgd.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E/oT0ArAAh/xaPl+2YCG3g3qRrUwLsGwGnZkkylK7d0=;
        b=bJMgrGf5mVYSCkoP9MmStCLoyZQAIdVptpLqTI4KmatPcGW2a1rKXzn5Dpo8Am+xyd
         chUBTF44NVMjUyW/4Y2m+f4X8B4kFGBLP6pEZ19VF1/HXqkgGwFJjlsFDNe5g3zXyzSd
         xHW9IqLSn6kXa3MKatyr23JfhqiT8UfNh94+LkGJAd4zIwTsRpprd8u0r9QZxzWOEM6h
         xlMbgE4D8ZEZo9W41xjZZO4GFhrkzJlqd956jcWTSd2eUXRNvZ5lpjvDtsuK41eJjIGb
         qbQVXVCice7Oa7Rk+E/8SaeUAk+YXSdu3rUAr+xC365oUyXo+ALEcI8NSBkPzCwHVhM6
         3ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E/oT0ArAAh/xaPl+2YCG3g3qRrUwLsGwGnZkkylK7d0=;
        b=jrsCmOnwvICMCWfPMa4AK0HfIoTROTfrCRKWZUb3sqsU12+P6MQZBRWVJ+MryW8Vo3
         yUdDqT0WJNDoJ28L++yCFjjqaY0XBTCLOcFt+OeCkZcR0PwzK9IuASl3srQsuIQZ+f9d
         ahYMj5mZJ3Dc2hBxDDjMSqSM9whqjAZpZFZyKFChPC4Lmj32vBC4rWu//ppPyV8Tom+G
         JbxQGVYlhPMiCoD2GQqv//2GI+VBwRiCGx2s+LqhpjMkMXsea3rSMgoEBkCw1GjCCv/P
         AVYzvfawMf81+QB6ZuslkcwheoglV8FhxW/Rl4lWVtZ1wOJj6ZfFQNsEiq67+pXF6JN+
         C7IA==
X-Gm-Message-State: AOAM530T9mfpe+TgF6YUxBlchZXp+RylyJ7kftmY6HwQj5mMEYSCiUe6
        HQzwM+GKaLXdiO+57Y+M+jE=
X-Google-Smtp-Source: ABdhPJzbPskRRci/Jv3LOFJm/oFjtDOPkbjxp0ziB3XiZddCjjdBODyisbwbR4YHt4V/nWgmMQ9OGg==
X-Received: by 2002:aa7:96ef:: with SMTP id i15mr9655908pfq.231.1597646241381;
        Sun, 16 Aug 2020 23:37:21 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id l63sm15986902pgl.24.2020.08.16.23.37.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Aug 2020 23:37:20 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tglx@linutronix.de, axboe@kernel.dk, akpm@linux-foundation.org,
        Felix.Kuehling@amd.com, sboyd@kernel.org
Cc:     john.stultz@linaro.org, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH v5] kthread: Add debugobject support
Date:   Mon, 17 Aug 2020 14:37:13 +0800
Message-Id: <7a7af0e893e3ceb0d8d1f055bffca1d47025d7ba.1597645588.git.zhaoqianli@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

Add debugobject support to track the life time of kthread_work
which is used to detect reinitialization/free active object problems
Add kthread_init_work_onstack()/kthread_init_delayed_work_onstack() for
kthread onstack support

If we reinitialize a kthread_work that has been activated,
this will cause delayed_work_list/work_list corruption.
enable this config,there is an chance to fixup these errors
or WARNING the wrong use of kthread_work

[30858.395766] list_del corruption. next->prev should be ffffffe388ebbf88, but was ffffffe388ebb588
[30858.395788] WARNING: CPU: 2 PID: 387 at kernel/msm-4.19/lib/list_debug.c:56 __list_del_entry_valid+0xc8/0xd0
...
[30858.395906] Call trace:
[30858.395909]  __list_del_entry_valid+0xc8/0xd0
[30858.395912]  __kthread_cancel_work_sync+0x98/0x138
[30858.395915]  kthread_cancel_delayed_work_sync+0x10/0x20
[30858.395917]  sde_encoder_resource_control+0xe8/0x12c0
[30858.395920]  sde_encoder_prepare_for_kickoff+0x5dc/0x2008
[30858.395923]  sde_crtc_commit_kickoff+0x280/0x890
[30858.395925]  sde_kms_commit+0x16c/0x278
[30858.395928]  complete_commit+0x3c4/0x760
[30858.395931]  _msm_drm_commit_work_cb+0xec/0x1e0
[30858.395933]  kthread_worker_fn+0xf8/0x190
[30858.395935]  kthread+0x118/0x128
[30858.395938]  ret_from_fork+0x10/0x18

crash> struct kthread_worker.delayed_work_list 0xffffffe3893925f0
 [ffffffe389392620] delayed_work_list = {
    next = 0xffffffe388ebbf88,
    prev = 0xffffffe388ebb588
  }
crash> list 0xffffffe388ebbf88
ffffffe388ebbf88

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
V5:
- Fix format error checked by checkpatch.pl 

V4:
- Changelog update
- Add comment for KWORK_ENTRY_STATIC
- Code format modification 
- Check worker availability early in kthread_flush_work

V3:
- changelog update
- add fixup_assert_init support
- move debug_kwork_activate/debug_kwork_deactivate before list operation
- name the kconfig CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
- use kthread_init_work_onstack/destroy_kwork_on_stack when kthread_work used on stack
- __init_kwork before clear kthread_work in kthread_init_work
---
 include/linux/kthread.h |  30 ++++++++++-
 include/linux/poison.h  |   4 ++
 kernel/kthread.c        | 136 ++++++++++++++++++++++++++++++++++++++++++++++--
 lib/Kconfig.debug       |  10 ++++
 4 files changed, 174 insertions(+), 6 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 65b81e0..706302b 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -108,6 +108,17 @@ struct kthread_delayed_work {
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
+
 #define KTHREAD_WORKER_INIT(worker)	{				\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
 	.work_list = LIST_HEAD_INIT((worker).work_list),		\
@@ -115,7 +126,7 @@ struct kthread_delayed_work {
 	}
 
 #define KTHREAD_WORK_INIT(work, fn)	{				\
-	.node = LIST_HEAD_INIT((work).node),				\
+	.node = { .next = KWORK_ENTRY_STATIC },				\
 	.func = (fn),							\
 	}
 
@@ -159,6 +170,15 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 
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
@@ -172,6 +192,14 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
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
index df34330..d9095ca 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -86,4 +86,8 @@
 /********** security/ **********/
 #define KEY_DESTROY		0xbd
 
+/********** kernel/kthread **********/
+/*indicate a static kthread_work initializer for the object debugging code.*/
+#define KWORK_ENTRY_STATIC	((void *) 0x600 + POISON_POINTER_DELTA)
+
 #endif
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 132f84a..c283b24 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -67,6 +67,119 @@ enum KTHREAD_BITS {
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
+
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
+	.name			= "kthread_work",
+	.debug_hint		= kwork_debug_hint,
+	.is_static_object	= kwork_is_static_object,
+	.fixup_init		= kwork_fixup_init,
+	.fixup_free		= kwork_fixup_free,
+	.fixup_assert_init	= kwork_fixup_assert_init,
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
@@ -697,6 +810,7 @@ int kthread_worker_fn(void *worker_ptr)
 	if (!list_empty(&worker->work_list)) {
 		work = list_first_entry(&worker->work_list,
 					struct kthread_work, node);
+		debug_kwork_deactivate(work);
 		list_del_init(&work->node);
 	}
 	worker->current_work = work;
@@ -833,6 +947,7 @@ static void kthread_insert_work(struct kthread_worker *worker,
 {
 	kthread_insert_work_sanity_check(worker, work);
 
+	debug_kwork_activate(work);
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
 	if (!worker->current_work && likely(worker->task))
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
 
@@ -925,6 +1042,7 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	/* Be paranoid and try to detect possible races already now. */
 	kthread_insert_work_sanity_check(worker, work);
 
+	debug_kwork_activate(work);
 	list_add(&work->node, &worker->delayed_work_list);
 	work->worker = worker;
 	timer->expires = jiffies + delay;
@@ -954,6 +1072,7 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	bool ret = false;
 
+	debug_kwork_assert_init(work);
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	if (!queuing_blocked(worker, work)) {
@@ -987,16 +1106,17 @@ static void kthread_flush_work_fn(struct kthread_work *work)
 void kthread_flush_work(struct kthread_work *work)
 {
 	struct kthread_flush_work fwork = {
-		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
-		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
+		.done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),
 	};
 	struct kthread_worker *worker;
 	bool noop = false;
 
+	debug_kwork_assert_init(work);
 	worker = work->worker;
 	if (!worker)
 		return;
 
+	kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
 	raw_spin_lock_irq(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
@@ -1013,6 +1133,7 @@ void kthread_flush_work(struct kthread_work *work)
 
 	if (!noop)
 		wait_for_completion(&fwork.done);
+	destroy_kwork_on_stack(&fwork.work);
 }
 EXPORT_SYMBOL_GPL(kthread_flush_work);
 
@@ -1053,6 +1174,7 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
 	 * be from worker->work_list or from worker->delayed_work_list.
 	 */
 	if (!list_empty(&work->node)) {
+		debug_kwork_deactivate(work);
 		list_del_init(&work->node);
 		return true;
 	}
@@ -1091,6 +1213,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	int ret = false;
 
+	debug_kwork_assert_init(work);
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	/* Do not bother with canceling when never queued. */
@@ -1115,10 +1238,12 @@ EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
 
 static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 {
-	struct kthread_worker *worker = work->worker;
+	struct kthread_worker *worker;
 	unsigned long flags;
 	int ret = false;
 
+	debug_kwork_assert_init(work);
+	worker = work->worker;
 	if (!worker)
 		goto out;
 
@@ -1194,12 +1319,13 @@ EXPORT_SYMBOL_GPL(kthread_cancel_delayed_work_sync);
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

