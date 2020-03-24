Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6A1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D18C20789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVMJqjGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgCXPUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:20:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57776 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727589AbgCXPUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585063250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PsOvQBlzuy3xnUZlgfJeTMdXK5YEHhrw4gbm6DAYH3A=;
        b=FVMJqjGchEpEl9Gy5oCDj1O/KkjFlyAiU2q6U9f5Ef92hYvah9wh8jKAGRKOvooDXHVCnB
        6AGwF3I4Tcd2WjiRI5LWKo5RIXb5SO50TQ7RDRdvMLx5UExXTFwCY/FYmSXJzgjKgevbAU
        LyuumphgxDayUnvTzEh9B18U4M7UwNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-1Ol68rMINbiaMZT6kIM8vQ-1; Tue, 24 Mar 2020 11:20:44 -0400
X-MC-Unique: 1Ol68rMINbiaMZT6kIM8vQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B07918CA244;
        Tue, 24 Mar 2020 15:20:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-9.gru2.redhat.com [10.97.116.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CCA61001938;
        Tue, 24 Mar 2020 15:20:42 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 773EF4198B3A; Tue, 24 Mar 2020 12:20:16 -0300 (-03)
Date:   Tue, 24 Mar 2020 12:20:16 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Chris Friesen <chris.friesen@windriver.com>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200324152016.GA25422@fuller.cnet>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imiuq0cg.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a kernel enhancement to configure the cpu affinity of kernel
threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>

When this option is specified, the cpumask is immediately applied upon
thread launch. This does not affect kernel threads that specify cpu
and node.

This allows CPU isolation (that is not allowing certain threads
to execute on certain CPUs) without using the isolcpus=domain parameter,
making it possible to enable load balancing on such CPUs
during runtime (see

Note-1: this is based off on Wind River's patch at
https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch

Difference being that this patch is limited to modifying
kernel thread cpumask: Behaviour of other threads can
be controlled via cgroups or sched_setaffinity.

Note-2: MontaVista's patch was based off Christoph Lameter's patch at
https://lwn.net/Articles/565932/ with the only difference being
the kernel parameter changed from kthread to kthread_cpus.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

v2: use isolcpus= subcommand (Thomas Gleixner)

 Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++
 include/linux/cpumask.h                         |    5 +++++
 include/linux/sched/isolation.h                 |    1 +
 init/main.c                                     |    1 +
 kernel/cpu.c                                    |   13 +++++++++++++
 kernel/kthread.c                                |    4 ++--
 kernel/sched/isolation.c                        |    6 ++++++
 7 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..7318e3057383 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1959,6 +1959,14 @@
 			  the CPU affinity syscalls or cpuset.
 			  <cpu number> begins at 0 and the maximum value is
 			  "number of CPUs in system - 1".
+			  When using cpusets, use the isolcpus option no_kthreads
+			  to avoid creation of kernel threads on isolated CPUs.
+
+			no_kthreads
+			  Adjust the CPU affinity mask of unbound kernel threads to
+			  not contain CPUs on the isolated list. This complements
+			  the isolation provided by the cpusets mechanism described
+			  above.
 
 			managed_irq
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index d5cc88514aee..a0dc4b12e048 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -55,6 +55,7 @@ extern unsigned int nr_cpu_ids;
  *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
  *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
  *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
+ *     cpu_kthread_mask - has bit 'cpu' set iff general kernel threads allowed
  *
  *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
  *
@@ -91,10 +92,12 @@ extern struct cpumask __cpu_possible_mask;
 extern struct cpumask __cpu_online_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
+extern struct cpumask __cpu_kthread_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
+#define cpu_kthread_mask  ((const struct cpumask *)&__cpu_kthread_mask)
 
 extern atomic_t __num_online_cpus;
 
@@ -145,6 +148,8 @@ static inline unsigned int cpumask_check(unsigned int cpu)
 	return cpu;
 }
 
+int __init init_kthread_cpumask(void);
+
 #if NR_CPUS == 1
 /* Uniprocessor.  Assume all masks are "1". */
 static inline unsigned int cpumask_first(const struct cpumask *srcp)
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 0fbcbacd1b29..d002332d00eb 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -14,6 +14,7 @@ enum hk_flags {
 	HK_FLAG_DOMAIN		= (1 << 5),
 	HK_FLAG_WQ		= (1 << 6),
 	HK_FLAG_MANAGED_IRQ	= (1 << 7),
+	HK_FLAG_NO_KTHREADS	= (1 << 8),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/init/main.c b/init/main.c
index ee4947af823f..69f528ddc477 100644
--- a/init/main.c
+++ b/init/main.c
@@ -618,6 +618,7 @@ noinline void __ref rest_init(void)
 	int pid;
 
 	rcu_scheduler_starting();
+	init_kthread_cpumask();
 	/*
 	 * We need to spawn init first so that it obtains pid 1, however
 	 * the init task will end up wanting to create kthreads, which, if
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c706af713fb..c549ad8e6596 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2311,9 +2311,22 @@ EXPORT_SYMBOL(__cpu_present_mask);
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
 
+struct cpumask __cpu_kthread_mask __read_mostly;
+EXPORT_SYMBOL(__cpu_kthread_mask);
+
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
 
+int __init init_kthread_cpumask(void)
+{
+	const struct cpumask *kthread_mask;
+
+	kthread_mask = housekeeping_cpumask(HK_FLAG_NO_KTHREADS);
+	cpumask_copy(&__cpu_kthread_mask, kthread_mask);
+
+	return 0;
+}
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index b262f47046ca..be9c8d53a986 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -347,7 +347,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		 * The kernel thread should not inherit these properties.
 		 */
 		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task, cpu_all_mask);
+		set_cpus_allowed_ptr(task, cpu_kthread_mask);
 	}
 	kfree(create);
 	return task;
@@ -572,7 +572,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, cpu_all_mask);
+	set_cpus_allowed_ptr(tsk, cpu_kthread_mask);
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 008d6ac2342b..e9d48729efd4 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -169,6 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "no_kthreads,", 12)) {
+			str += 12;
+			flags |= HK_FLAG_NO_KTHREADS;
+			continue;
+		}
+
 		pr_warn("isolcpus: Error, unknown flag\n");
 		return 0;
 	}

