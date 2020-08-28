Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B063C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC0820897
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Y7Tu9q4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgH1TyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgH1TxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:53:05 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FE1C061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:53:04 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id d30so194902qvc.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kbo7U0PEYUU1ZVhELvLuoIBCLuc5axiCLP3YPvEd+w0=;
        b=Y7Tu9q4MoE9k9F0MQEgkXzA6+X+sxXyiu1mLTNJHtm3TliTlBYJ/onNU+QLW5x98ts
         CBEFpUQdfXWuKqskJYfQgiORLJhBXNRGsigcTh8DxJlIKkK0HAxqaShZlIPOoqX0mLEs
         eGmfaCRzabAJuqWGiJRsXPj4CsBAZX58P1DYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kbo7U0PEYUU1ZVhELvLuoIBCLuc5axiCLP3YPvEd+w0=;
        b=hJ85PH2WZS1sXQ0FnYpc1ITJlQysbwHiuWb9GBscFCjlRHbnpIcel3kUMdwuuGCli/
         2cyvrtoqj2CDwOuLEDo2c3DaOeN+9Tido2f6thOCkGEfrWEzLh8grvYWQlDxiJkdgVuZ
         J9cjU99iZiWEDe5OnfEE0MCTTISVQlKDq6hm+0JZhX6NpcFLsNdvVToY8I8wrQCNSZqn
         yOh/QE2qpvkWMEg7s1tqrMs7U6DgDfbG7ghpYo4/OqViY/eRMeGnd4R0vYHz2c/qA3QQ
         A2gd5eUq0NWYrSVjAZKjItye+SpyArUc0czvdDXuaunoccjC3i6lH7p9OXmYc/3Dh6Si
         H+HQ==
X-Gm-Message-State: AOAM5318lGUs46mqr7tfZwnmfrb/v9Ah05POhyoRG7d7ivThDUWZWYmQ
        IDNT/JR8ABN65pRZSpyg/pRPPQ==
X-Google-Smtp-Source: ABdhPJyHDvOokqdfSSmpGL+b5AN45YnQoAEz400JPyodFeA6YezI8hs7QAw/u0gOV39fiyNaJH0XLA==
X-Received: by 2002:ad4:41c9:: with SMTP id a9mr141310qvq.171.1598644383400;
        Fri, 28 Aug 2020 12:53:03 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:53:02 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 20/23] sched/coresched: config option for kernel protection
Date:   Fri, 28 Aug 2020 15:51:21 -0400
Message-Id: <9cd9abad06ad8c3f35228afd07c74c7d9533c412.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

There are use cases where the kernel protection is not needed. One
example could be about using core scheduling for non-security related
use cases - isolate core for a particular process dynamically. Also,
to test/benchmark the overhead of kernel protection.

Have a compile time and boot time option to disable the feature.
CONFIG_SCHED_CORE_KERNEL_PROTECTION will enable this feature at
compile time and is enabled by default is CONFIG_SCHED_CORE=y.
sched_core_kernel_protection= boot time option to control this. Value
0 will disable the feature.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++++
 include/linux/sched.h                         |  2 +-
 kernel/Kconfig.preempt                        | 13 +++++++
 kernel/sched/core.c                           | 39 ++++++++++++++++++-
 kernel/sched/sched.h                          |  2 +
 5 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1068742a6df..01e442388e4a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4611,6 +4611,15 @@
 
 	sbni=		[NET] Granch SBNI12 leased line adapter
 
+	sched_core_kernel_protection=
+			[SCHED_CORE, SCHED_CORE_IRQ_PAUSE] Pause SMT siblings
+			of a core runninig in user mode if atleast one of the
+			siblings of the core is running in kernel. This is to
+			guarantee that kernel data is not leaked to tasks which
+			are not trusted by the kernel.
+			This feature is valid only when Core scheduling is
+			enabled(CONFIG_SCHED_CORE).
+
 	sched_debug	[KNL] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1e04ffe689cb..4d9ae6b4dcc9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2055,7 +2055,7 @@ int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
-#ifdef CONFIG_SCHED_CORE
+#ifdef CONFIG_SCHED_CORE_KERNEL_PROTECTION
 void sched_core_unsafe_enter(void);
 void sched_core_unsafe_exit(void);
 void sched_core_unsafe_exit_wait(unsigned long ti_check);
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 4488fbf4d3a8..52f86739f910 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -86,3 +86,16 @@ config SCHED_CORE
 	default y
 	depends on SCHED_SMT
 
+config SCHED_CORE_KERNEL_PROTECTION
+	bool "Core Scheduling for SMT"
+	default y
+	depends on SCHED_CORE
+	help
+	  This option enables pausing all SMT siblings of a core running in
+	  user mode when atleast one of the siblings in the core is in kernel.
+	  This is to enforce security such that information from kernel is not
+	  leaked to non-trusted tasks running on siblings. This option is valid
+	  only if Core Scheduling(CONFIG_SCHED_CORE) is enabled.
+
+	  If in doubt, select 'Y' when CONFIG_SCHED_CORE=y
+
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0dc9172be04d..34238fd67f31 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -75,6 +75,24 @@ __read_mostly int scheduler_running;
 
 #ifdef CONFIG_SCHED_CORE
 
+#ifdef CONFIG_SCHED_CORE_KERNEL_PROTECTION
+
+DEFINE_STATIC_KEY_TRUE(sched_core_kernel_protection);
+static int __init set_sched_core_kernel_protection(char *str)
+{
+	unsigned long val = 0;
+
+	if (!str)
+		return 0;
+
+	if (!kstrtoul(str, 0, &val) && !val)
+		static_branch_disable(&sched_core_kernel_protection);
+
+	return 1;
+}
+__setup("sched_core_kernel_protection=", set_sched_core_kernel_protection);
+#endif
+
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
 
 /* kernel prio, less is more */
@@ -4600,6 +4618,8 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
+#ifdef CONFIG_SCHED_CORE_KERNEL_PROTECTION
+
 /*
  * Handler to attempt to enter kernel. It does nothing because the exit to
  * usermode or guest mode will do the actual work (of waiting if needed).
@@ -4609,6 +4629,11 @@ static void sched_core_irq_work(struct irq_work *work)
 	return;
 }
 
+static inline void init_sched_core_irq_work(struct rq *rq)
+{
+	init_irq_work(&rq->core_irq_work, sched_core_irq_work);
+}
+
 /*
  * sched_core_wait_till_safe - Pause the caller's hyperthread until the core
  * exits the core-wide unsafe state. Obviously the CPU calling this function
@@ -4684,6 +4709,9 @@ void sched_core_unsafe_enter(void)
 	struct rq *rq;
 	int i, cpu;
 
+	if (!static_branch_likely(&sched_core_kernel_protection))
+		return;
+
 	/* Ensure that on return to user/guest, we check whether to wait. */
 	if (current->core_cookie)
 		set_tsk_thread_flag(current, TIF_UNSAFE_RET);
@@ -4769,6 +4797,9 @@ void sched_core_unsafe_exit(void)
 	struct rq *rq;
 	int cpu;
 
+	if (!static_branch_likely(&sched_core_kernel_protection))
+		return;
+
 	local_irq_save(flags);
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
@@ -4807,9 +4838,15 @@ void sched_core_unsafe_exit(void)
 
 void sched_core_unsafe_exit_wait(unsigned long ti_check)
 {
+	if (!static_branch_likely(&sched_core_kernel_protection))
+		return;
+
 	sched_core_unsafe_exit();
 	sched_core_wait_till_safe(ti_check);
 }
+#else
+static inline void init_sched_core_irq_work(struct rq *rq) {}
+#endif /* CONFIG_SCHED_CORE_KERNEL_PROTECTION */
 
 // XXX fairness/fwd progress conditions
 /*
@@ -7795,7 +7832,7 @@ int sched_cpu_starting(unsigned int cpu)
 			rq = cpu_rq(i);
 			if (rq->core && rq->core == rq)
 				core_rq = rq;
-			init_irq_work(&rq->core_irq_work, sched_core_irq_work);
+			init_sched_core_irq_work(rq);
 		}
 
 		if (!core_rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index dbd8416ddaba..676818bdb9df 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1058,8 +1058,10 @@ struct rq {
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
 	unsigned char		core_forceidle;
+#ifdef CONFIG_SCHED_CORE_KERNEL_PROTECTION
 	struct irq_work		core_irq_work; /* To force HT into kernel */
 	unsigned int		core_this_unsafe_nest;
+#endif
 
 	/* shared state */
 	unsigned int		core_task_seq;
-- 
2.17.1

