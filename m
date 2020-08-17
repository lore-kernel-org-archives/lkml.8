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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D38C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 04:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2B9206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 04:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRvg7VNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgHQEtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 00:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgHQEtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 00:49:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20831C061388
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 21:49:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i92so7407923pje.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 21:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YHQ+PZR0FEZKoPygfJ8Kul65FNrk987rMlVLSI+5xuU=;
        b=LRvg7VNy/yjOmJZk3pd4fCvHV/23o8JpOPLgs4zA46/4ibiI6SHRcH8OsnS0yHwtzJ
         Bwmykxyg4wQYJNR/F7jhTKSuZOHuk/TEzeI4CWHJog4PhpnCfTXxa1b/iaICdi0uEOEM
         xmTiJq1zp9BqHW5PvVrRk+EAAnKcTDHpFx11QZhMl8dB9xedXitm77T8xCxBNJddTIJp
         m6VTfOOWvBJDPX9ZmAi2D2mGtCcCaVaC2PYqadah3PIS4bRCYqz7dI9JGHpZ9/92bBDm
         rlQfmUA/a7D59m9bwXGTC9Lyhj/i05KR5FSZIt71932GW62FM4FDJCaq+uTqAA6/ddTQ
         eLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YHQ+PZR0FEZKoPygfJ8Kul65FNrk987rMlVLSI+5xuU=;
        b=aNZ31ORQaglsisG8rMSPC/kFQmL/53RfrKKY3DrL7RxSWZrIBOrTJi++fq6Fxby5p7
         VjK9aYAltQjhDCYhAMTsh03p3aMwO0akv2jBrL+BqDXptVAV2JlAz99I5eK2+n2s3fA0
         HSpS/goOtBOulWAi6bRo8K3Ozi2wUhEO9K1c+mrg0x9UDtBWaAM91JCfps7AjjFLDVLC
         hObzSaEOvfBbq6714zCgV5wh7fA6GySlWDpVTczjIkR+Y5iwzQMwkyOyOdUJ5d89jn/v
         yIQAVx+lL+84O5fGncVPU0Y3H44ig1spmO5Vd4AE9UOlHeAlANNrxrxHdMiqg7taaSD+
         rhEg==
X-Gm-Message-State: AOAM532XoIu1DJMLL0g6lc2mN2pmDR1CIBkyOvgq/hH3u3s13FXPNhP9
        tF+0EqrfJXXvmKSiAzIlBYDX/JdPQ+lVHg==
X-Google-Smtp-Source: ABdhPJxbVYilwsTPRbSaMsNQGwOKdEnx5IKx4Hu6u/sPRPiGDrhWosZvfPxckMaqOFUlJJZUYUe1XA==
X-Received: by 2002:a17:90a:f481:: with SMTP id bx1mr11054996pjb.172.1597639743597;
        Sun, 16 Aug 2020 21:49:03 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id z29sm17764307pfj.182.2020.08.16.21.49.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Aug 2020 21:49:03 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tglx@linutronix.de, axboe@kernel.dk, akpm@linux-foundation.org,
        Felix.Kuehling@amd.com
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH v4] kthread: Add debugobject support
Date:   Mon, 17 Aug 2020 12:48:56 +0800
Message-Id: <a14c878bc8a8f14d35e1b03b0c07220368e0114f.1597634369.git.zhaoqianli@xiaomi.com>
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
[30858.395788] WARNING: CPU: 2 PID: 387 at /home/work/data/codes/build_home/kernel/msm-4.19/lib/list_debug.c:56 __list_del_entry_valid+0xc8/0xd0
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
 kernel/kthread.c        | 135 ++++++++++++++++++++++++++++++++++++++++++++++--
 lib/Kconfig.debug       |  10 ++++
 4 files changed, 173 insertions(+), 6 deletions(-)

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
index 132f84a..ff73218 100644
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
@@ -697,6 +809,7 @@ int kthread_worker_fn(void *worker_ptr)
 	if (!list_empty(&worker->work_list)) {
 		work = list_first_entry(&worker->work_list,
 					struct kthread_work, node);
+		debug_kwork_deactivate(work);
 		list_del_init(&work->node);
 	}
 	worker->current_work = work;
@@ -833,6 +946,7 @@ static void kthread_insert_work(struct kthread_worker *worker,
 {
 	kthread_insert_work_sanity_check(worker, work);
 
+	debug_kwork_activate(work);
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
 	if (!worker->current_work && likely(worker->task))
@@ -857,6 +971,7 @@ bool kthread_queue_work(struct kthread_worker *worker,
 	bool ret = false;
 	unsigned long flags;
 
+	debug_kwork_assert_init(work);
 	raw_spin_lock_irqsave(&worker->lock, flags);
 	if (!queuing_blocked(worker, work)) {
 		kthread_insert_work(worker, work, &worker->work_list);
@@ -895,6 +1010,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 
 	/* Move the work from worker->delayed_work_list. */
 	WARN_ON_ONCE(list_empty(&work->node));
+	debug_kwork_deactivate(work);
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
 
@@ -925,6 +1041,7 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	/* Be paranoid and try to detect possible races already now. */
 	kthread_insert_work_sanity_check(worker, work);
 
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
@@ -987,16 +1105,17 @@ static void kthread_flush_work_fn(struct kthread_work *work)
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
@@ -1013,6 +1132,7 @@ void kthread_flush_work(struct kthread_work *work)
 
 	if (!noop)
 		wait_for_completion(&fwork.done);
+	destroy_kwork_on_stack(&fwork.work);
 }
 EXPORT_SYMBOL_GPL(kthread_flush_work);
 
@@ -1053,6 +1173,7 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
 	 * be from worker->work_list or from worker->delayed_work_list.
 	 */
 	if (!list_empty(&work->node)) {
+		debug_kwork_deactivate(work);
 		list_del_init(&work->node);
 		return true;
 	}
@@ -1091,6 +1212,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	int ret = false;
 
+	debug_kwork_assert_init(work);
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	/* Do not bother with canceling when never queued. */
@@ -1115,10 +1237,12 @@ EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
 
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
 
@@ -1194,12 +1318,13 @@ EXPORT_SYMBOL_GPL(kthread_cancel_delayed_work_sync);
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

