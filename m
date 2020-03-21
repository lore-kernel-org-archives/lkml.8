Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE849C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DFA2078C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCUPxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:53:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39000 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgCUPxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:53:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRV-0005Pu-Ds; Sat, 21 Mar 2020 16:53:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EE3921C22EE;
        Sat, 21 Mar 2020 16:53:44 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:44 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Add posixtimer context tracing bits
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113242.751182723@linutronix.de>
References: <20200321113242.751182723@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480602457.28353.11066346230705460485.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d53f2b62fcb63f6547c10d8c62bca19e957b0eef
Gitweb:        https://git.kernel.org/tip/d53f2b62fcb63f6547c10d8c62bca19e957b0eef
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 21 Mar 2020 12:26:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:25 +01:00

lockdep: Add posixtimer context tracing bits

Splitting run_posix_cpu_timers() into two parts is work in progress which
is stuck on other entry code related problems. The heavy lifting which
involves locking of sighand lock will be moved into task context so the
necessary execution time is burdened on the task and not on interrupt
context.

Until this work completes lockdep with the spinlock nesting rules enabled
would emit warnings for this known context.

Prevent it by setting "->irq_config = 1" for the invocation of
run_posix_cpu_timers() so lockdep does not complain when sighand lock is
acquried. This will be removed once the split is completed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200321113242.751182723@linutronix.de
---
 include/linux/irqflags.h       | 12 ++++++++++++
 kernel/time/posix-cpu-timers.c |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index f23f540..a16adbb 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -69,6 +69,16 @@ do {						\
 			current->irq_config = 0;	\
 	  } while (0)
 
+# define lockdep_posixtimer_enter()				\
+	  do {							\
+		  current->irq_config = 1;			\
+	  } while (0)
+
+# define lockdep_posixtimer_exit()				\
+	  do {							\
+		  current->irq_config = 0;			\
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
index 8ff6da7..2c48a72 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1126,8 +1126,11 @@ void run_posix_cpu_timers(void)
 	if (!fastpath_timer_check(tsk))
 		return;
 
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
 
 /*
