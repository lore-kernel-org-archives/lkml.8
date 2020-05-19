Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2860205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgESVrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgESVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:47:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DE4C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:47:19 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jbA4h-0002ll-Nr; Tue, 19 May 2020 23:46:59 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: [PATCH v1 14/25] sched: tasks: Use sequence counter with associated spinlock
Date:   Tue, 19 May 2020 23:45:36 +0200
Message-Id: <20200519214547.352050-15-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519214547.352050-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/sched.h | 2 +-
 init/init_task.c      | 3 ++-
 kernel/fork.c         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..a9ce6fbeb735 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1046,7 +1046,7 @@ struct task_struct {
 	/* Protected by ->alloc_lock: */
 	nodemask_t			mems_allowed;
 	/* Seqence number to catch updates: */
-	seqcount_t			mems_allowed_seq;
+	seqcount_spinlock_t		mems_allowed_seq;
 	int				cpuset_mem_spread_rotor;
 	int				cpuset_slab_spread_rotor;
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index bd403ed3e418..94bf4aea8293 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -142,7 +142,8 @@ struct task_struct init_task
 	.rcu_tasks_idle_cpu = -1,
 #endif
 #ifdef CONFIG_CPUSETS
-	.mems_allowed_seq = SEQCNT_ZERO(init_task.mems_allowed_seq),
+	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
+						 &init_task.alloc_lock),
 #endif
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
diff --git a/kernel/fork.c b/kernel/fork.c
index 8c700f881d92..a0fde1f17e0a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2019,7 +2019,7 @@ static __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_CPUSETS
 	p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
 	p->cpuset_slab_spread_rotor = NUMA_NO_NODE;
-	seqcount_init(&p->mems_allowed_seq);
+	seqcount_spinlock_init(&p->mems_allowed_seq, &p->alloc_lock);
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	p->irq_events = 0;
-- 
2.20.1

