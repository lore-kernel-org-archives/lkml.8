Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9416BC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DC4206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgCMRrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:47:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47732 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMRrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:47:25 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jCoP3-00017r-WA; Fri, 13 Mar 2020 18:47:22 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 9/9] lockdep: Add posixtimer context tracing bits
Date:   Fri, 13 Mar 2020 18:47:01 +0100
Message-Id: <20200313174701.148376-10-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313174701.148376-1-bigeasy@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting run_posix_cpu_timers() into two parts is work in progress which
is stuck on other entry code related problems. The heavy lifting which
involves locking of sighand lock will be moved into task context so the
necessary execution time is burdened on the task and not on interrupt
context.

Until this work completes lockdep with the spinlock nesting rules enabled
would emit warnings for this known context.

Prevent it by setting "->irq_config =3D 1" for the invocation of
run_posix_cpu_timers() so lockdep does not complain when sighand lock is
acquried. This will be removed once the split is completed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irqflags.h       | 12 ++++++++++++
 kernel/time/posix-cpu-timers.c |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index f23f540e0ebba..a16adbb58f66a 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -69,6 +69,16 @@ do {						\
 			current->irq_config =3D 0;	\
 	  } while (0)
=20
+# define lockdep_posixtimer_enter()				\
+	  do {							\
+		  current->irq_config =3D 1;			\
+	  } while (0)
+
+# define lockdep_posixtimer_exit()				\
+	  do {							\
+		  current->irq_config =3D 0;			\
+	  } while (0)
+
 # define lockdep_irq_work_enter(__work)					\
 	  do {								\
 		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
@@ -94,6 +104,8 @@ do {						\
 # define lockdep_softirq_exit()		do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
 # define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
+# define lockdep_posixtimer_enter()		do { } while (0)
+# define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)
 # define lockdep_irq_work_exit(__work)		do { } while (0)
 #endif
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 8ff6da77a01fd..2c48a7233b196 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1126,8 +1126,11 @@ void run_posix_cpu_timers(void)
 	if (!fastpath_timer_check(tsk))
 		return;
=20
-	if (!lock_task_sighand(tsk, &flags))
+	lockdep_posixtimer_enter();
+	if (!lock_task_sighand(tsk, &flags)) {
+		lockdep_posixtimer_exit();
 		return;
+	}
 	/*
 	 * Here we take off tsk->signal->cpu_timers[N] and
 	 * tsk->cpu_timers[N] all the timers that are firing, and
@@ -1169,6 +1172,7 @@ void run_posix_cpu_timers(void)
 			cpu_timer_fire(timer);
 		spin_unlock(&timer->it_lock);
 	}
+	lockdep_posixtimer_exit();
 }
=20
 /*
--=20
2.25.1

