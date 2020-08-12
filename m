Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 05:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5030020768
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 05:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD0G3wyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHLFOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 01:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgHLFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 01:14:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117FAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 22:14:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e4so545235pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 22:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yqN/6PSKloXFvVVZs+NSVTFvKWCYyMKFMfiTSTyCzNY=;
        b=dD0G3wyuEIpsh9NKhHAO9Z7jq1afFRQMImNsdJWhy/zG4rq7TaUKanptItHNKMEDju
         +i85LkeBhfHswhorOPlfwSPCL5I2SkvdRrYcL8RaBPgMUDfHXhPvjZH3/Gc6SG/irSjV
         6Uqntam6exSqTWaudiV0zzEjAJHLirwjZwZ8FpP1KyCJLg+IwQDFlwNJnL5TX0LER8lE
         b1qJTxNdwYWyfZ02yocTwbPCnIgllJu7T4khwvFldhuug0lB0HlshJWeERDDQS4Z7u/9
         icPg+RO4iC95jrjUNfb/ND7cdpuB+qapIzQEySwBUYhuwnDU8go2vVQ9y4WYYfDAOAx1
         SwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yqN/6PSKloXFvVVZs+NSVTFvKWCYyMKFMfiTSTyCzNY=;
        b=PQnHFhfoUkcqc+Ju3cy/ptEE70ATra4+Ex0BBBaH2oxp7wtH/1USemWeXDo/lzgDCh
         8R6xQlTB5vOMaM3Dtr+NiZMCPY3PQD+OOhE6vGeElA/POdYqW5MQA791GqJCVk/vCWhi
         IH7Qk3n7BPQwzvPdIyPhCg2o2tmA4sl6CbXRBOwAZ0eRp4KtVTfEzmP+bj6ArVUfDlr5
         X2gTmn3raqSDYyZecCcjhp9acZIFfYPvcezN0mtoQ8qXDKLBKbMF3fat76bAdoScu51q
         qWhsK9m4rOgCdDwtThFVvMxNVK2R/FTWlAknykiINYiwU4oF2o+ArFF8HoFqgiLDhH9e
         DRHA==
X-Gm-Message-State: AOAM532FKUqpL76ttiSHKc04eM3VGBv1/YTtJomtMS8tX8rlDl6uGX/4
        zXeztREIdxdrS3ZHtrPq6i4=
X-Google-Smtp-Source: ABdhPJzAZhRtVwua/JRMRHzPojWjIEmywpvZIbtvMFbbDm8M7dic+xkimpUBAkJvql/TXFbwSPxg9A==
X-Received: by 2002:a17:902:7004:: with SMTP id y4mr3767164plk.52.1597209262419;
        Tue, 11 Aug 2020 22:14:22 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id n3sm825813pfq.131.2020.08.11.22.14.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 22:14:22 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tglx@linutronix.de, axboe@kernel.dk, akpm@linux-foundation.org,
        Felix.Kuehling@amd.com
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [RFC V2] kthread: add object debug support
Date:   Wed, 12 Aug 2020 13:14:14 +0800
Message-Id: <311159bc826dcca2848344fc277c0069cff0a164.1597207603.git.zhaoqianli@xiaomi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
I got an crash issue since kthread_delayed_work reinitialization,crash log show us that is a timer NULL pointer exception
[16238.089921] Unable to handle kernel paging request at virtual address dead000000000208
[16238.090298] Call trace:
[16238.090307]  run_timer_softirq+0x2d0/0xa30
[16238.090318]  __do_softirq+0x1dc/0x384
[16238.090328]  irq_exit+0xb4/0xb8
[16238.090338]  __handle_domain_irq+0x84/0xc0
[16238.090345]  gic_handle_irq+0x138/0x1bc
[16238.090353]  el1_irq+0xb0/0x128
[16238.090362]  queue_work_on+0x54/0x60
[16238.090374]  _process_event_group+0x190/0x230
[16238.090382]  kgsl_process_event_groups+0x44/0x70
[16238.090391]  adreno_dispatcher_work+0x1e4/0xae8
[16238.090400]  kthread_worker_fn+0xec/0x180
[16238.090407]  kthread+0x118/0x128
[16238.090415]  ret_from_fork+0x10/0x18

It turns out that the problem is caused by the timer reinitialization,after enable CONFIG_DEBUG_OBJECTS_TIMERS,the reason for the problem is obvious.

This timer belongs to kthread_delayed_work,from kernel log we also see list corruption WARNING:
[30858.395766] list_del corruption. next->prev should be ffffffe388ebbf88, but was ffffffe388ebb588
[30858.395788] WARNING: CPU: 2 PID: 387 at /home/work/data/miui_codes/build_home/kernel/msm-4.19/lib/list_debug.c:56 __list_del_entry_valid+0xc8/0xd0
...
[30858.405951] list_add corruption. next->prev should be prev (ffffffe389392620), but was ffffffe388ebbf88. (next=ffffffe388ebbf88).
[30858.405977] WARNING: CPU: 0 PID: 7721 at /home/work/data/miui_codes/build_home/kernel/msm-4.19/lib/list_debug.c:25 __list_add_valid+0x7c/0xc8

crash> struct kthread_worker.delayed_work_list 0xffffffe3893925f0
 [ffffffe389392620] delayed_work_list = {
    next = 0xffffffe388ebbf88, 
    prev = 0xffffffe388ebb588
  }
crash> list 0xffffffe388ebbf88
ffffffe388ebbf88

delayed_work_list is corruption,this work is reinitialized.if kthread_work reinitialized after move to work_list,this work will be carried out forever in kthread_worker_fn.

Timer and workqueue both provide debugobject support，kthread_work similar with workqueue,so i think it is necessary to support objectdebug in kthread_work.

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

