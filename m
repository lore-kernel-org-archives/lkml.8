Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C24DC2BA17
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290BE206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 13:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDENnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 09:43:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgDENnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 09:43:14 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jL5YK-00042H-2g; Sun, 05 Apr 2020 15:43:08 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2F2AE1001FC;
        Sun,  5 Apr 2020 15:43:07 +0200 (CEST)
Date:   Sun, 05 Apr 2020 13:41:52 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.7-rc1
References: <158609410988.4266.5816311298811487752.tglx@nanos.tec.linutronix.de>
Message-ID: <158609411231.4266.16619269103115870160.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-04-05

up to:  760a53768610: clocksource/drivers/timer-vf-pit: Add missing parenthesis


Two timer subsystem fixes:

    - Prevent a use after free in the new lockdep state tracking for hrtimers

    - Add missing parenthesis in the VF pit timer driver

Thanks,

	tglx

------------------>
Sebastian Andrzej Siewior (1):
      hrtimer: Don't dereference the hrtimer pointer after the callback

afzal mohammed (1):
      clocksource/drivers/timer-vf-pit: Add missing parenthesis


 drivers/clocksource/timer-vf-pit.c |  2 +-
 include/linux/irqflags.h           | 27 ++++++++++++++++-----------
 kernel/time/hrtimer.c              |  5 +++--
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 7ad4a8b008c2..1a86a4e7e344 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -129,7 +129,7 @@ static int __init pit_clockevent_init(unsigned long rate, int irq)
 	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
 
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   "VF pit timer", &clockevent_pit);
+			   "VF pit timer", &clockevent_pit));
 
 	clockevent_pit.cpumask = cpumask_of(0);
 	clockevent_pit.irq = irq;
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index ceca42de4438..61a9ced3aa50 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -58,16 +58,21 @@ do {						\
 } while (0)
 
 # define lockdep_hrtimer_enter(__hrtimer)		\
-	  do {						\
-		  if (!__hrtimer->is_hard)		\
-			current->irq_config = 1;	\
-	  } while (0)
-
-# define lockdep_hrtimer_exit(__hrtimer)		\
-	  do {						\
-		  if (!__hrtimer->is_hard)		\
+({							\
+	bool __expires_hardirq = true;			\
+							\
+	if (!__hrtimer->is_hard) {			\
+		current->irq_config = 1;		\
+		__expires_hardirq = false;		\
+	}						\
+	__expires_hardirq;				\
+})
+
+# define lockdep_hrtimer_exit(__expires_hardirq)	\
+	do {						\
+		if (!__expires_hardirq)			\
 			current->irq_config = 0;	\
-	  } while (0)
+	} while (0)
 
 # define lockdep_posixtimer_enter()				\
 	  do {							\
@@ -102,8 +107,8 @@ do {						\
 # define lockdep_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
 # define lockdep_softirq_exit()		do { } while (0)
-# define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
-# define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
+# define lockdep_hrtimer_enter(__hrtimer)	false
+# define lockdep_hrtimer_exit(__context)	do { } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
 # define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d0a5ba37aff4..d89da1c7e005 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1480,6 +1480,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 			  unsigned long flags) __must_hold(&cpu_base->lock)
 {
 	enum hrtimer_restart (*fn)(struct hrtimer *);
+	bool expires_in_hardirq;
 	int restart;
 
 	lockdep_assert_held(&cpu_base->lock);
@@ -1514,11 +1515,11 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	 */
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	trace_hrtimer_expire_entry(timer, now);
-	lockdep_hrtimer_enter(timer);
+	expires_in_hardirq = lockdep_hrtimer_enter(timer);
 
 	restart = fn(timer);
 
-	lockdep_hrtimer_exit(timer);
+	lockdep_hrtimer_exit(expires_in_hardirq);
 	trace_hrtimer_expire_exit(timer);
 	raw_spin_lock_irq(&cpu_base->lock);
 

