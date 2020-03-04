Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6BAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C88A20658
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="cOPQ7r0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbgCDRAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:00:20 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34932 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388334AbgCDRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:11 -0500
Received: by mail-qv1-f68.google.com with SMTP id u10so1100126qvi.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7DtyWru90IJO468F3UYQ60d5th1CH01loonuxsZ5gtE=;
        b=cOPQ7r0f0F8CJHcPlul3QBRUt8E4bObmgeyI6Wh/cVXLKEzKXWArOCbVCYORmBpZGD
         AE/Vgl/8UsXpQom7DqxaZQF1XdAkUEwy/ZQBy9K8QvjzFPMYJjfWklLPNU5jxLWo42m4
         fs/EnZ+Dw16yvP6Nrw/Ou6rd7YvYsljiT07dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7DtyWru90IJO468F3UYQ60d5th1CH01loonuxsZ5gtE=;
        b=qtZhr7E83yG5+nt+zTvHT50nqDqDYh8rXM1zkhdM4dYgHont74Olpw/0ThxS5COE5K
         t3q+ITAMZ10Of4XNq5kenWnTTdC+Cy1woAKe7xONjUavaPGq8eqHi7UcwAhDzqNBr+QW
         5U5Bex6UgFkXDA+/hp9FU4sWbXkPAbn1FJnBgKUDPl+nvfWVfGUqt6WvXpbbxjEZk1cd
         IMiKhSeDqZHUnhjf2Gbz/ZXrRZJDf6TL8czRhOZE5G03BPjZ+o52Q3a1Zms5zSjsBsLt
         +xUguARvI6s66E5iqt4kAvwSINU3tt2DdLsgqnxekZLHHvdUf86jsDuxgpP2P/O+MzWx
         dMZQ==
X-Gm-Message-State: ANhLgQ13KSm2ANnKaLyRZy8rYjWbZwxVISEZp86Q83lKI03LRDmK1Q2L
        MS1hwx6STcy2WgyZNpT3bsvj1w==
X-Google-Smtp-Source: ADFU+vvvsqUvBKjMX34p40tBpgwy8jdhocLSTo64cm/m+cZe4/uGViTkXdfI20Xp3v1FOd2slZEXZg==
X-Received: by 2002:a0c:f985:: with SMTP id t5mr2905872qvn.127.1583341210149;
        Wed, 04 Mar 2020 09:00:10 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id u20sm5404885qkk.75.2020.03.04.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:09 -0800 (PST)
From:   vpillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 03/13] sched: Core-wide rq->lock
Date:   Wed,  4 Mar 2020 16:59:53 +0000
Message-Id: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
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
 kernel/Kconfig.preempt |   6 +++
 kernel/sched/core.c    | 113 ++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h   |  31 +++++++++++
 3 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..577c288e81e5 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -80,3 +80,9 @@ config PREEMPT_COUNT
 config PREEMPTION
        bool
        select PREEMPT_COUNT
+
+config SCHED_CORE
+	bool
+	default y
+	depends on SCHED_SMT
+
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 28ba9b56dd8a..ba17ff8a8663 100644
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
+	for_each_online_cpu(cpu)
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
@@ -6400,8 +6464,15 @@ int sched_cpu_activate(unsigned int cpu)
 	/*
 	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
 		static_branch_inc_cpuslocked(&sched_smt_present);
+#ifdef CONFIG_SCHED_CORE
+		if (static_branch_unlikely(&__sched_core_enabled)) {
+			rq->core_enabled = true;
+		}
+#endif
+	}
+
 #endif
 	set_cpu_active(cpu, true);
 
@@ -6447,8 +6518,16 @@ int sched_cpu_deactivate(unsigned int cpu)
 	/*
 	 * When going down, decrement the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
+#ifdef CONFIG_SCHED_CORE
+		struct rq *rq = cpu_rq(cpu);
+		if (static_branch_unlikely(&__sched_core_enabled)) {
+			rq->core_enabled = false;
+		}
+#endif
 		static_branch_dec_cpuslocked(&sched_smt_present);
+
+	}
 #endif
 
 	if (!sched_smp_initialized)
@@ -6473,6 +6552,28 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
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
@@ -6501,6 +6602,9 @@ int sched_cpu_dying(unsigned int cpu)
 	update_max_interval();
 	nohz_balance_exit_idle(rq);
 	hrtick_clear(rq);
+#ifdef CONFIG_SCHED_CORE
+	rq->core = NULL;
+#endif
 	return 0;
 }
 #endif
@@ -6695,6 +6799,11 @@ void __init sched_init(void)
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
index a8335e3078ab..a3941b2ee29e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -999,6 +999,12 @@ struct rq {
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
@@ -1026,11 +1032,36 @@ static inline int cpu_of(struct rq *rq)
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

