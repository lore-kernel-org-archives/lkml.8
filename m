Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B45C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061CA206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFJPPwtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgHKIX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgHKIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:23:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CAAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 01:23:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k13so6437587plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v3miegfoyhNycCuQvQV9EUUiGbsFBTX4cclB0GQdq4w=;
        b=tFJPPwtt6mZifzYEt8SaiuV6klKGvNJwvUDk7Q/3TzwW3bfCmedQv1oVecjWtOw/Zp
         2+mkkjZEzDxm8xwquo66ZD8X6vnPDyvUeAT9A/zNGPJflqtRtWUc8WE/pMdVs2Y1k3LH
         6ooff0N6dHRKq///clgD85IFCIDl0viawsl2zYwIkBObwv4XnS/CZBYUMpTQw99tYHPj
         9dlR5mUe9QQgsUqhbQotGJ+ulS2QZvkeRbZ/PQYF86UxzcfGrs9imjTcTZHaPC6a3yIn
         2MJCoqiPpyT06V6L/IwTBWaqXtt3mHHpdS+sNx1OxWH7bwS3q99uN12EJfOuK5PRAw9J
         rl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v3miegfoyhNycCuQvQV9EUUiGbsFBTX4cclB0GQdq4w=;
        b=kPS/iffYe4beB8NPE7FB//Nbg9NGEBWtzMO4E3tcC26cdGveTOIy14vmom5pxw7AKV
         1UKhLn2wo9lSpvI+xDX9vhg8vhnJTSvjuCU+Z5zSVe9zA8GdtMTdZcOClNymdShQHI8Y
         RfcDfW/WJbZ7QPnLtU1W3kaPIWmNlC5OyvUJJLkxN36a1toIhnV1ZL/9Mt8DcrwuphNK
         i9SYscoYzeJYg/53ZzXoOtJwOWqzwVRq3IP6ElNI8d+YojPwlFqnqrUrgnndP/fOfMOy
         LaYCo+V77Arc6YrylZjfR3sy2yFjUgEEqCC4E8IAMuOBYwEOicLV962XASCkAdoHcy/K
         GPFg==
X-Gm-Message-State: AOAM533YuK6k8CBJJ/8uHMwduslkknY5SPR2U2A6eqVIkRUAuITj/Fhi
        pQdtXbkNhCjxP5G7K84r6MM=
X-Google-Smtp-Source: ABdhPJyrgS4nZKMdW+IUbmwugtAFYRnw/kgESNW8QAvvZmGIQCcRwyrfM8S9Rc9DQHT/qtwhb1iWUA==
X-Received: by 2002:a17:90a:fe83:: with SMTP id co3mr15188pjb.64.1597134236978;
        Tue, 11 Aug 2020 01:23:56 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id b6sm1515125pgt.17.2020.08.11.01.23.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 01:23:56 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tglx@linutronix.de, axboe@kernel.dk, akpm@linux-foundation.org,
        Felix.Kuehling@amd.com
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [RFC] kthread: add object debug support
Date:   Tue, 11 Aug 2020 16:23:46 +0800
Message-Id: <1597134226-14835-1-git-send-email-zhaoqianligood@gmail.com>
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

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
 include/linux/kthread.h | 29 ++++++++++++++-
 include/linux/poison.h  |  3 ++
 kernel/kthread.c        | 95 ++++++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug       | 10 ++++++
 4 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 65b81e0..1530953 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -108,6 +108,16 @@ struct kthread_delayed_work {
 	struct timer_list timer;
 };
 
+#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD
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
 
@@ -160,6 +170,15 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 #define kthread_init_work(work, fn)					\
 	do {								\
 		memset((work), 0, sizeof(struct kthread_work));		\
+		__init_kwork(work, 0);						\
+		INIT_LIST_HEAD(&(work)->node);				\
+		(work)->func = (fn);					\
+	} while (0)
+
+#define kthread_init_work_onstack(work, fn)					\
+	do {								\
+		memset((work), 0, sizeof(struct kthread_work));		\
+		__init_kwork(work, 1);						\
 		INIT_LIST_HEAD(&(work)->node);				\
 		(work)->func = (fn);					\
 	} while (0)
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
index 132f84a..ca00bd2 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -67,6 +67,94 @@ enum KTHREAD_BITS {
 	KTHREAD_SHOULD_PARK,
 };
 
+#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD
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
+static struct debug_obj_descr kwork_debug_descr = {
+	.name		= "kthread_work",
+	.debug_hint	= kwork_debug_hint,
+	.is_static_object = kwork_is_static_object,
+	.fixup_init	= kwork_fixup_init,
+	.fixup_free	= kwork_fixup_free,
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
+#endif
+
 static inline void set_kthread_struct(void *kthread)
 {
 	/*
@@ -698,6 +786,7 @@ int kthread_worker_fn(void *worker_ptr)
 		work = list_first_entry(&worker->work_list,
 					struct kthread_work, node);
 		list_del_init(&work->node);
+		debug_kwork_deactivate(work);
 	}
 	worker->current_work = work;
 	raw_spin_unlock_irq(&worker->lock);
@@ -835,8 +924,11 @@ static void kthread_insert_work(struct kthread_worker *worker,
 
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
-	if (!worker->current_work && likely(worker->task))
+
+	if (!worker->current_work && likely(worker->task)) {
+		debug_kwork_activate(work);
 		wake_up_process(worker->task);
+	}
 }
 
 /**
@@ -1054,6 +1146,7 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
 	 */
 	if (!list_empty(&work->node)) {
 		list_del_init(&work->node);
+		debug_kwork_deactivate(work);
 		return true;
 	}
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210..8355984 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -540,6 +540,16 @@ config DEBUG_OBJECTS_WORK
 	  work queue routines to track the life time of work objects and
 	  validate the work operations.
 
+config DEBUG_OBJECTS_KTHREAD
+	bool "Debug kthread work objects"
+	depends on DEBUG_OBJECTS
+	help
+	  If you say Y here, additional code will be inserted into the
+	  kthread routines to track the life time of kthread objects and
+	  validate the kthread operations.
+
+	  If unsure, say N.
+
 config DEBUG_OBJECTS_RCU_HEAD
 	bool "Debug RCU callbacks objects"
 	depends on DEBUG_OBJECTS
-- 
2.7.4

