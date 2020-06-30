Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE82CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D01C2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="QmRGXtYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgF3Vdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgF3Vds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:33:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9353EC03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 67so5914057pfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TA6J+Zp+sZLd2wte9i4PUROkfS0NEOAhM4Mz1O6uEMc=;
        b=QmRGXtYbIH0jqZCsq22EXH+VIEBuU0xdG0l5UZDk2K6jtmPmp28003l3TVqY/w0p/1
         Xp/5wGc1zwpEALRy2Cng58Eerh4felbmpy1PczfvEqFfZ6bSpCu3mTZ7slim29zldEgK
         9jG1BtfLQ/buXBD0dniLeXRnqiQh/VZXC46Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TA6J+Zp+sZLd2wte9i4PUROkfS0NEOAhM4Mz1O6uEMc=;
        b=Fs2dE2yK9FurSr5gze8HrevnDqIR1h3lnvRdbeTW3GWaJLvYa7oXmBdpLpABwO9kE0
         +TMJqRj6Vts/R9Ub7ObPzWFfht2tE1NBq3SNOeNkPb7IRRe6uL2zbEnjsJOUTXc8dKK9
         FEJI/OQa+4TmAWc2AN7VHGHhauUMZU7dnCQN62atnQ/FcxQBTcf5YM9wa1J9MYOKUrpp
         IPjwVayPjPZu/M3Xfhq+qw9A4wKnfbqDuqCX+sSUYUTZ1+lXBTNS7P/ZHl0Nelo22Cks
         7wcKqbb3YXU6C0XlTuDlv09bm4ZQQdEFJ5wKaTypKSiiokEMRaEelNCA540Lbwu8tm6V
         EOMg==
X-Gm-Message-State: AOAM532NHx6+OlhczkwiPzJPS1hZ56v5n5aGu14AoI8w5YawXLZOhcDz
        uya60k7fds61F/FcKBoQG//oYQ==
X-Google-Smtp-Source: ABdhPJzM+Yca5KzaWCHqf861dEfD54s+B5l8ldZ5fZmelQD7KCnrVzJXvZPoXyMkvxOyXDBCle2lLw==
X-Received: by 2002:aa7:859a:: with SMTP id w26mr19600761pfn.10.1593552827971;
        Tue, 30 Jun 2020 14:33:47 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id c139sm3570761pfb.189.2020.06.30.14.33.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:33:47 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        subhra.mazumdar@oracle.com, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 13/16] sched: Fix pick_next_task() race condition in core scheduling
Date:   Tue, 30 Jun 2020 21:32:34 +0000
Message-Id: <907055bc2fa4b21e2b6675268903ca2c89285e34.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

As Peter mentioned that Commit 6e2df0581f56 ("sched: Fix pick_next_task()
vs 'change' pattern race") has fixed a race condition due to rq->lock
improperly released after put_prev_task(), backport this fix to core
scheduling's pick_next_task() as well.

Without this fix, Aubrey, Long and I found an NULL exception point
triggered within one hour when running RDT MBA(Intel Resource Directory
Technolodge Memory Bandwidth Allocation) benchmarks on a 36 Core(72 HTs)
platform, which tries to dereference a NULL sched_entity:

[ 3618.429053] BUG: kernel NULL pointer dereference, address: 0000000000000160
[ 3618.429039] RIP: 0010:pick_task_fair+0x2e/0xa0
[ 3618.429042] RSP: 0018:ffffc90000317da8 EFLAGS: 00010046
[ 3618.429044] RAX: 0000000000000000 RBX: ffff88afdf4ad100 RCX: 0000000000000001
[ 3618.429045] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88afdf4ad100
[ 3618.429045] RBP: ffffc90000317dc0 R08: 0000000000000048 R09: 0100000000100000
[ 3618.429046] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[ 3618.429047] R13: 000000000002d080 R14: ffff88afdf4ad080 R15: 0000000000000014
[ 3618.429048]  ? pick_task_fair+0x48/0xa0
[ 3618.429048]  pick_next_task+0x34c/0x7e0
[ 3618.429049]  ? tick_program_event+0x44/0x70
[ 3618.429049]  __schedule+0xee/0x5d0
[ 3618.429050]  schedule_idle+0x2c/0x40
[ 3618.429051]  do_idle+0x175/0x280
[ 3618.429051]  cpu_startup_entry+0x1d/0x30
[ 3618.429052]  start_secondary+0x169/0x1c0
[ 3618.429052]  secondary_startup_64+0xa4/0xb0

While with this patch applied, no NULL pointer exception was found within
14 hours for now. Although there's no direct evidence this fix would solve
the issue, it does fix a potential race condition.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
---
 kernel/sched/core.c  | 44 +++++++++++++++++++++++++-------------------
 kernel/sched/fair.c  |  9 ++++++---
 kernel/sched/sched.h |  7 -------
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c84f209b8591..ede86fb37b4e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4169,6 +4169,29 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 	schedstat_inc(this_rq()->sched_count);
 }
 
+static inline void
+finish_prev_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+#ifdef CONFIG_SMP
+	const struct sched_class *class;
+
+	/*
+	 * We must do the balancing pass before put_next_task(), such
+	 * that when we release the rq->lock the task is in the same
+	 * state as before we took rq->lock.
+	 *
+	 * We can terminate the balance pass as soon as we know there is
+	 * a runnable task of @class priority or higher.
+	 */
+	for_class_range(class, prev->sched_class, &idle_sched_class) {
+		if (class->balance(rq, prev, rf))
+			break;
+	}
+#endif
+
+	put_prev_task(rq, prev);
+}
+
 /*
  * Pick up the highest-prio task:
  */
@@ -4202,22 +4225,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 restart:
-#ifdef CONFIG_SMP
-	/*
-	 * We must do the balancing pass before put_next_task(), such
-	 * that when we release the rq->lock the task is in the same
-	 * state as before we took rq->lock.
-	 *
-	 * We can terminate the balance pass as soon as we know there is
-	 * a runnable task of @class priority or higher.
-	 */
-	for_class_range(class, prev->sched_class, &idle_sched_class) {
-		if (class->balance(rq, prev, rf))
-			break;
-	}
-#endif
-
-	put_prev_task(rq, prev);
+	finish_prev_task(rq, prev, rf);
 
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
@@ -4323,9 +4331,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		return next;
 	}
 
-	prev->sched_class->put_prev_task(rq, prev);
-	if (!rq->nr_running)
-		newidle_balance(rq, rf);
+	finish_prev_task(rq, prev, rf);
 
 	cpu = cpu_of(rq);
 	smt_mask = cpu_smt_mask(cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33dc4bf01817..435b460d3c3f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -115,6 +115,7 @@ int __weak arch_asym_cpu_priority(int cpu)
  */
 #define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
 
+static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -7116,9 +7117,11 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *se;
 	struct task_struct *p;
+#ifdef CONFIG_SMP
 	int new_tasks;
 
 again:
+#endif
 	if (!sched_fair_runnable(rq))
 		goto idle;
 
@@ -7232,6 +7235,7 @@ done: __maybe_unused;
 	if (!rf)
 		return NULL;
 
+#ifdef CONFIG_SMP
 	new_tasks = newidle_balance(rq, rf);
 
 	/*
@@ -7244,6 +7248,7 @@ done: __maybe_unused;
 
 	if (new_tasks > 0)
 		goto again;
+#endif
 
 	/*
 	 * rq is about to be idle, check if we need to update the
@@ -8750,10 +8755,8 @@ static int idle_cpu_without(int cpu, struct task_struct *p)
 	 * be computed and tested before calling idle_cpu_without().
 	 */
 
-#ifdef CONFIG_SMP
 	if (!llist_empty(&rq->wake_list))
 		return 0;
-#endif
 
 	return 1;
 }
@@ -10636,7 +10639,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  *     0 - failed, no new tasks
  *   > 0 - success, new (fair) tasks present
  */
-int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
+static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c4b4640fcdc8..a5450886c4e4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1640,15 +1640,8 @@ static inline void unregister_sched_domain_sysctl(void)
 {
 }
 #endif
-
-extern int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
-
 #else
-
 static inline void sched_ttwu_pending(void) { }
-
-static inline int newidle_balance(struct rq *this_rq, struct rq_flags *rf) { return 0; }
-
 #endif /* CONFIG_SMP */
 
 #include "stats.h"
-- 
2.17.1

