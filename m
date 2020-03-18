Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E166C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCAF2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgCRU54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:57:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgCRU5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:57:53 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEfl8-0007O5-VD
        for linux-kernel@vger.kernel.org; Wed, 18 Mar 2020 21:57:51 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id DF3411040C5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 21:57:48 +0100 (CET)
Message-Id: <20200318204408.728747754@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 18 Mar 2020 21:43:15 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: [patch V2 13/15] lockdep: Add hrtimer context tracing bits
References: <20200318204302.693307984@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Set current->irq_config = 1 for hrtimers which are not marked to expire in
hard interrupt context during hrtimer_init(). These timers will expire in
softirq context on PREEMPT_RT.

Setting this allows lockdep to differentiate these timers. If a timer is
marked to expire in hard interrupt context then the timer callback is not
supposed to acquire a regular spinlock instead of a raw_spinlock in the
expiry callback.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/irqflags.h |   15 +++++++++++++++
 include/linux/sched.h    |    1 +
 kernel/locking/lockdep.c |    2 +-
 kernel/time/hrtimer.c    |    6 +++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -56,6 +56,19 @@ do {						\
 do {						\
 	current->softirq_context--;		\
 } while (0)
+
+# define lockdep_hrtimer_enter(__hrtimer)		\
+	  do {						\
+		  if (!__hrtimer->is_hard)		\
+			current->irq_config = 1;	\
+	  } while (0)
+
+# define lockdep_hrtimer_exit(__hrtimer)		\
+	  do {						\
+		  if (!__hrtimer->is_hard)		\
+			current->irq_config = 0;	\
+	  } while (0)
+
 #else
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
@@ -68,6 +81,8 @@ do {						\
 # define trace_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
 # define lockdep_softirq_exit()		do { } while (0)
+# define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
+# define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
 #endif
 
 #if defined(CONFIG_IRQSOFF_TRACER) || \
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -983,6 +983,7 @@ struct task_struct {
 	unsigned int			softirq_enable_event;
 	int				softirqs_enabled;
 	int				softirq_context;
+	int				irq_config;
 #endif
 
 #ifdef CONFIG_LOCKDEP
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3759,7 +3759,7 @@ static int check_wait_context(struct tas
 		/*
 		 * Check if force_irqthreads will run us threaded.
 		 */
-		if (curr->hardirq_threaded)
+		if (curr->hardirq_threaded || curr->irq_config)
 			curr_inner = LD_WAIT_CONFIG;
 		else
 			curr_inner = LD_WAIT_SPIN;
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1404,7 +1404,7 @@ static void __hrtimer_init(struct hrtime
 	base = softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	base += hrtimer_clockid_to_base(clock_id);
 	timer->is_soft = softtimer;
-	timer->is_hard = !softtimer;
+	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
 }
@@ -1514,7 +1514,11 @@ static void __run_hrtimer(struct hrtimer
 	 */
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	trace_hrtimer_expire_entry(timer, now);
+	lockdep_hrtimer_enter(timer);
+
 	restart = fn(timer);
+
+	lockdep_hrtimer_exit(timer);
 	trace_hrtimer_expire_exit(timer);
 	raw_spin_lock_irq(&cpu_base->lock);
 

