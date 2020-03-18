Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BACC4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128A121473
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgCRU57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:57:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58467 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgCRU5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:57:53 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEfl9-0007O9-Ag
        for linux-kernel@vger.kernel.org; Wed, 18 Mar 2020 21:57:51 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 592B71040C7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 21:57:49 +0100 (CET)
Message-Id: <20200318204408.946175347@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 18 Mar 2020 21:43:17 +0100
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
Subject: [patch V2 15/15] lockdep: Add posixtimer context tracing bits
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

---
 include/linux/irqflags.h       | 12 ++++++++++++
 kernel/time/posix-cpu-timers.c |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index f23f540e0ebba..a16adbb58f66a 100644
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
index 8ff6da77a01fd..2c48a7233b196 100644
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
-- 
2.25.1


