Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52460C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B1C214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgFPMWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgFPMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07625C08C5C4;
        Tue, 16 Jun 2020 05:22:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbN-0004i4-RM; Tue, 16 Jun 2020 14:22:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BEAAE1C0845;
        Tue, 16 Jun 2020 14:21:53 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:53 -0000
From:   "tip-bot2 for Marcelo Tosatti" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] isolcpus: Affine unbound kernel threads to
 housekeeping cpus
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527142909.23372-3-frederic@kernel.org>
References: <20200527142909.23372-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159231011359.16989.9937469140076463872.tip-bot2@tip-bot2>
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

Commit-ID:     9cc5b8656892a72438ee7deb5e80f5be47643b8b
Gitweb:        https://git.kernel.org/tip/9cc5b8656892a72438ee7deb5e80f5be47643b8b
Author:        Marcelo Tosatti <mtosatti@redhat.com>
AuthorDate:    Wed, 27 May 2020 16:29:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:03 +02:00

isolcpus: Affine unbound kernel threads to housekeeping cpus

This is a kernel enhancement that configures the cpu affinity of kernel
threads via kernel boot option nohz_full=.

When this option is specified, the cpumask is immediately applied upon
kthread launch. This does not affect kernel threads that specify cpu
and node.

This allows CPU isolation (that is not allowing certain threads
to execute on certain CPUs) without using the isolcpus=domain parameter,
making it possible to enable load balancing on such CPUs
during runtime (see kernel-parameters.txt).

Note-1: this is based off on Wind River's patch at
https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch

Difference being that this patch is limited to modifying kernel thread
cpumask. Behaviour of other threads can be controlled via cgroups or
sched_setaffinity.

Note-2: Wind River's patch was based off Christoph Lameter's patch at
https://lwn.net/Articles/565932/ with the only difference being
the kernel parameter changed from kthread to kthread_cpus.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200527142909.23372-3-frederic@kernel.org
---
 include/linux/sched/isolation.h | 1 +
 kernel/kthread.c                | 6 ++++--
 kernel/sched/isolation.c        | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 0fbcbac..cc9f393 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -14,6 +14,7 @@ enum hk_flags {
 	HK_FLAG_DOMAIN		= (1 << 5),
 	HK_FLAG_WQ		= (1 << 6),
 	HK_FLAG_MANAGED_IRQ	= (1 << 7),
+	HK_FLAG_KTHREAD		= (1 << 8),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/kernel/kthread.c b/kernel/kthread.c
index b86d37c..032b610 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -27,6 +27,7 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
 #include <linux/numa.h>
+#include <linux/sched/isolation.h>
 #include <trace/events/sched.h>
 
 
@@ -383,7 +384,8 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		 * The kernel thread should not inherit these properties.
 		 */
 		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task, cpu_possible_mask);
+		set_cpus_allowed_ptr(task,
+				     housekeeping_cpumask(HK_FLAG_KTHREAD));
 	}
 	kfree(create);
 	return task;
@@ -608,7 +610,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, cpu_possible_mask);
+	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_FLAG_KTHREAD));
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 808244f..5a6ea03 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -140,7 +140,8 @@ static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned int flags;
 
-	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC;
+	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
+		HK_FLAG_MISC | HK_FLAG_KTHREAD;
 
 	return housekeeping_setup(str, flags);
 }
