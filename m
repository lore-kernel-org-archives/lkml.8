Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF0E2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590589764;
	bh=UOSoPdNMbA62JAx1FmnB3icHVLAVTB9mVXGrph7UeR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=anh/6bQeP0ip1z+JGqzPO4WagzqbT0GsflWzLD1CTJyGczjTpTpoOVmvkCBDXu8a9
	 5oqhqXvUEPw7CeWYHpbh8scda9jrUKEChYWBd01CpCUNyGhhX2hdR6/WUnh2FYOJgx
	 CpO1goEkJCfYUBc2xtTeZJVo2ZcqbW1qSq4d7kug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389249AbgE0O3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389185AbgE0O3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:29:20 -0400
Received: from lenoir.home (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3729720B80;
        Wed, 27 May 2020 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590589760;
        bh=UOSoPdNMbA62JAx1FmnB3icHVLAVTB9mVXGrph7UeR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Te1+1jmw4UDuULo2cjfBzukgtKuyBB+IMFLOiF5UBN3bIAsWn9aY2djVGpNYQw1Gh
         qRQ2n+4PTkCs0rlDycwcTyDrxVPhKo7CDmXZLEw1vZbZQHk2PLIeYYUlofoqVf4vMH
         96z+lZGMSXImlrs4C1DT9Iz55GhlQJYWD9+h4KFU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Jim Somerville <Jim.Somerville@windriver.com>
Subject: [PATCH 2/2] isolcpus: Affine unbound kernel threads to housekeeping cpus
Date:   Wed, 27 May 2020 16:29:09 +0200
Message-Id: <20200527142909.23372-3-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527142909.23372-1-frederic@kernel.org>
References: <20200527142909.23372-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Tosatti <mtosatti@redhat.com>

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

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Chris Friesen <chris.friesen@windriver.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jim Somerville <Jim.Somerville@windriver.com>
Cc: Christoph Lameter <cl@linux.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched/isolation.h | 1 +
 kernel/kthread.c                | 6 ++++--
 kernel/sched/isolation.c        | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 0fbcbacd1b29..cc9f393e2a70 100644
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
index 788bec94aca7..eaeadefc0f8f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -23,6 +23,7 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
 #include <linux/numa.h>
+#include <linux/sched/isolation.h>
 #include <trace/events/sched.h>
 
 static DEFINE_SPINLOCK(kthread_create_lock);
@@ -360,7 +361,8 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		 * The kernel thread should not inherit these properties.
 		 */
 		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task, cpu_possible_mask);
+		set_cpus_allowed_ptr(task,
+				     housekeeping_cpumask(HK_FLAG_KTHREAD));
 	}
 	kfree(create);
 	return task;
@@ -585,7 +587,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, cpu_possible_mask);
+	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_FLAG_KTHREAD));
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 808244f3ddd9..5a6ea03f9882 100644
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
-- 
2.26.2

