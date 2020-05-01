Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18D6C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5FDC21924
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgEASWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730583AbgEASWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B85C061A0C;
        Fri,  1 May 2020 11:22:18 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIa-0003XB-HQ; Fri, 01 May 2020 20:22:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 19D971C0330;
        Fri,  1 May 2020 20:22:08 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:08 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Fix illegal RCU from offline CPUs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qian Cai <cai@lca.pw>, Michael Ellerman <mpe@ellerman.id.au>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401214033.8448-1-cai@lca.pw>
References: <20200401214033.8448-1-cai@lca.pw>
MIME-Version: 1.0
Message-ID: <158835732806.8414.13635392824259089476.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bf2c59fce4074e55d622089b34be3a6bc95484fb
Gitweb:        https://git.kernel.org/tip/bf2c59fce4074e55d622089b34be3a6bc95484fb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 01 Apr 2020 17:40:33 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:41 +02:00

sched/core: Fix illegal RCU from offline CPUs

In the CPU-offline process, it calls mmdrop() after idle entry and the
subsequent call to cpuhp_report_idle_dead(). Once execution passes the
call to rcu_report_dead(), RCU is ignoring the CPU, which results in
lockdep complaining when mmdrop() uses RCU from either memcg or
debugobjects below.

Fix it by cleaning up the active_mm state from BP instead. Every arch
which has CONFIG_HOTPLUG_CPU should have already called idle_task_exit()
from AP. The only exception is parisc because it switches them to
&init_mm unconditionally (see smp_boot_one_cpu() and smp_cpu_init()),
but the patch will still work there because it calls mmgrab(&init_mm) in
smp_cpu_init() and then should call mmdrop(&init_mm) in finish_cpu().

  WARNING: suspicious RCU usage
  -----------------------------
  kernel/workqueue.c:710 RCU or wq_pool_mutex should be held!

  other info that might help us debug this:

  RCU used illegally from offline CPU!
  Call Trace:
   dump_stack+0xf4/0x164 (unreliable)
   lockdep_rcu_suspicious+0x140/0x164
   get_work_pool+0x110/0x150
   __queue_work+0x1bc/0xca0
   queue_work_on+0x114/0x120
   css_release+0x9c/0xc0
   percpu_ref_put_many+0x204/0x230
   free_pcp_prepare+0x264/0x570
   free_unref_page+0x38/0xf0
   __mmdrop+0x21c/0x2c0
   idle_task_exit+0x170/0x1b0
   pnv_smp_cpu_kill_self+0x38/0x2e0
   cpu_die+0x48/0x64
   arch_cpu_idle_dead+0x30/0x50
   do_idle+0x2f4/0x470
   cpu_startup_entry+0x38/0x40
   start_secondary+0x7a8/0xa80
   start_secondary_resume+0x10/0x14

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Link: https://lkml.kernel.org/r/20200401214033.8448-1-cai@lca.pw
---
 arch/powerpc/platforms/powernv/smp.c |  1 -
 include/linux/sched/mm.h             |  2 ++
 kernel/cpu.c                         | 18 +++++++++++++++++-
 kernel/sched/core.c                  |  5 +++--
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 13e2516..b2ba3e9 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -167,7 +167,6 @@ static void pnv_smp_cpu_kill_self(void)
 	/* Standard hot unplug procedure */
 
 	idle_task_exit();
-	current->active_mm = NULL; /* for sanity */
 	cpu = smp_processor_id();
 	DBG("CPU%d offline\n", cpu);
 	generic_set_cpu_dead(cpu);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c49257a..a132d87 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,6 +49,8 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
 
+void mmdrop(struct mm_struct *mm);
+
 /*
  * This has to be called after a get_task_mm()/mmget_not_zero()
  * followed by taking the mmap_sem for writing before modifying the
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2371292..244d305 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3,6 +3,7 @@
  *
  * This code is licenced under the GPL.
  */
+#include <linux/sched/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/smp.h>
 #include <linux/init.h>
@@ -564,6 +565,21 @@ static int bringup_cpu(unsigned int cpu)
 	return bringup_wait_for_ap(cpu);
 }
 
+static int finish_cpu(unsigned int cpu)
+{
+	struct task_struct *idle = idle_thread_get(cpu);
+	struct mm_struct *mm = idle->active_mm;
+
+	/*
+	 * idle_task_exit() will have switched to &init_mm, now
+	 * clean up any remaining active_mm state.
+	 */
+	if (mm != &init_mm)
+		idle->active_mm = &init_mm;
+	mmdrop(mm);
+	return 0;
+}
+
 /*
  * Hotplug state machine related functions
  */
@@ -1549,7 +1565,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_BRINGUP_CPU] = {
 		.name			= "cpu:bringup",
 		.startup.single		= bringup_cpu,
-		.teardown.single	= NULL,
+		.teardown.single	= finish_cpu,
 		.cant_stop		= true,
 	},
 	/* Final state before CPU kills itself */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e6ba9e..f6ae262 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6197,13 +6197,14 @@ void idle_task_exit(void)
 	struct mm_struct *mm = current->active_mm;
 
 	BUG_ON(cpu_online(smp_processor_id()));
+	BUG_ON(current != this_rq()->idle);
 
 	if (mm != &init_mm) {
 		switch_mm(mm, &init_mm, current);
-		current->active_mm = &init_mm;
 		finish_arch_post_lock_switch();
 	}
-	mmdrop(mm);
+
+	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
 /*
