Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FA7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E1C2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Bygd4xf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgF3VdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgF3VdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:33:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8AEC03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so3690882pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SkFb2/HcrQjaRecGGa5omu8c1nJPy2DNxQ+MNigk0e0=;
        b=Bygd4xf8L8w8w+qmBMTwbD+Cv7F2eWMWJ6xT2i/eUusUG/fd+KLQQ5hbKgCua+PAr9
         J6FdQnqyf1eUNlbgiyiyf8/YmJt+1VigoSVN761R2Sfn12JFNujJz+hnMCGnAAaiZJ+e
         eK7okeTic+H4D5p/zCl4NgEqziDMnpGOD2fQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SkFb2/HcrQjaRecGGa5omu8c1nJPy2DNxQ+MNigk0e0=;
        b=bdFdtNkHCu43k7QPMVWm0JNtpHvvg0UPMZ44arMQsfH8VFXL8V9xfB3AhY5PzifkRJ
         NszcIMrzHbgpHlPTDlhPP8PFWUUzpTn4NcjLL2Kzv8ZBmIJdnGlcZNAYqgnWa2IDw1Gu
         K0x5r6UnJ1GBMMSKFTqAjcAEzNZCQVuiJL9BiX3/ZnyMH2xYQxzO8pKPenhmg/XR7LdY
         Rl448uJWMMYu4Jz44uuJh7EODIyH8e/2onTyAQcpgcb0FT6mAyMUFjGtSjwwL4nlxEtS
         lSi+Np/fxfP9Sxsv0a692CEowrojYFL8jHUE4HwFgegwgA8dOgTe+XxuCdGB7Tye8lCv
         jJBA==
X-Gm-Message-State: AOAM531wKQqpIfcGZ42LyNRhIVTQH+67CgLlZrf8BcYfBg9PD0rkGQyU
        lGfxrMgEI7mlgjUM+j8Ki7Cj1w==
X-Google-Smtp-Source: ABdhPJyXN3cDyb7biMSsc33Va2TZOvgy/+Da/YlTlQ9oPWNBFR67gnqPaK9fllqDrsG4cxcznp1WKw==
X-Received: by 2002:a63:2104:: with SMTP id h4mr17208969pgh.427.1593552782180;
        Tue, 30 Jun 2020 14:33:02 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id d6sm3418991pfn.47.2020.06.30.14.33.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:33:01 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 03/16] sched: Core-wide rq->lock
Date:   Tue, 30 Jun 2020 21:32:24 +0000
Message-Id: <6b1de626b6e37281c357cc7c54efb7da7dfd4910.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Introduce the basic infrastructure to have a core wide rq->lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
---
 kernel/Kconfig.preempt |  6 +++
 kernel/sched/core.c    | 91 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   | 31 ++++++++++++++
 3 files changed, 128 insertions(+)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..4488fbf4d3a8 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -80,3 +80,9 @@ config PREEMPT_COUNT
 config PREEMPTION
        bool
        select PREEMPT_COUNT
+
+config SCHED_CORE
+	bool "Core Scheduling for SMT"
+	default y
+	depends on SCHED_SMT
+
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ef594ace6ffd..4b81301e3f21 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -73,6 +73,70 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+#ifdef CONFIG_SCHED_CORE
+
+DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+/*
+ * The static-key + stop-machine variable are needed such that:
+ *
+ *	spin_lock(rq_lockp(rq));
+ *	...
+ *	spin_unlock(rq_lockp(rq));
+ *
+ * ends up locking and unlocking the _same_ lock, and all CPUs
+ * always agree on what rq has what lock.
+ *
+ * XXX entirely possible to selectively enable cores, don't bother for now.
+ */
+static int __sched_core_stopper(void *data)
+{
+	bool enabled = !!(unsigned long)data;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpu_rq(cpu)->core_enabled = enabled;
+
+	return 0;
+}
+
+static DEFINE_MUTEX(sched_core_mutex);
+static int sched_core_count;
+
+static void __sched_core_enable(void)
+{
+	// XXX verify there are no cookie tasks (yet)
+
+	static_branch_enable(&__sched_core_enabled);
+	stop_machine(__sched_core_stopper, (void *)true, NULL);
+}
+
+static void __sched_core_disable(void)
+{
+	// XXX verify there are no cookie tasks (left)
+
+	stop_machine(__sched_core_stopper, (void *)false, NULL);
+	static_branch_disable(&__sched_core_enabled);
+}
+
+void sched_core_get(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!sched_core_count++)
+		__sched_core_enable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+void sched_core_put(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!--sched_core_count)
+		__sched_core_disable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
@@ -6475,6 +6539,28 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
 int sched_cpu_starting(unsigned int cpu)
 {
+#ifdef CONFIG_SCHED_CORE
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	struct rq *rq, *core_rq = NULL;
+	int i;
+
+	for_each_cpu(i, smt_mask) {
+		rq = cpu_rq(i);
+		if (rq->core && rq->core == rq)
+			core_rq = rq;
+	}
+
+	if (!core_rq)
+		core_rq = cpu_rq(cpu);
+
+	for_each_cpu(i, smt_mask) {
+		rq = cpu_rq(i);
+
+		WARN_ON_ONCE(rq->core && rq->core != core_rq);
+		rq->core = core_rq;
+	}
+#endif /* CONFIG_SCHED_CORE */
+
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -6696,6 +6782,11 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+
+#ifdef CONFIG_SCHED_CORE
+		rq->core = NULL;
+		rq->core_enabled = 0;
+#endif
 	}
 
 	set_load_weight(&init_task, false);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a63c3115d212..66e586adee18 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1028,6 +1028,12 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#ifdef CONFIG_SCHED_CORE
+	/* per rq */
+	struct rq		*core;
+	unsigned int		core_enabled;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1055,11 +1061,36 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+#ifdef CONFIG_SCHED_CORE
+DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
+}
+
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	if (sched_core_enabled(rq))
+		return &rq->core->__lock;
+
+	return &rq->__lock;
+}
+
+#else /* !CONFIG_SCHED_CORE */
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return false;
+}
+
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	return &rq->__lock;
 }
 
+#endif /* CONFIG_SCHED_CORE */
+
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
 
-- 
2.17.1

