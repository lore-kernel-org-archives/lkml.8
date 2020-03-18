Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FD6C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F94621775
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgCRU6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:58:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58468 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgCRU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:57:55 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEfl8-0007O6-VR
        for linux-kernel@vger.kernel.org; Wed, 18 Mar 2020 21:57:51 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 23ACA1040C6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 21:57:49 +0100 (CET)
Message-Id: <20200318204408.836492988@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 18 Mar 2020 21:43:16 +0100
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
Subject: [patch V2 14/15] lockdep: Annotate irq_work
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

Mark irq_work items with IRQ_WORK_HARD_IRQ which should be invoked in
hardirq context even on PREEMPT_RT. IRQ_WORK without this flag will be
invoked in softirq context on PREEMPT_RT.

Set ->irq_config to 1 for the IRQ_WORK items which are invoked in softirq
context so lockdep knows that these can safely acquire a spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/irq_work.h |    2 ++
 include/linux/irqflags.h |   13 +++++++++++++
 kernel/irq_work.c        |    2 ++
 kernel/rcu/tree.c        |    1 +
 kernel/time/tick-sched.c |    1 +
 5 files changed, 19 insertions(+)

--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -18,6 +18,8 @@
 
 /* Doesn't want IPI, wait for tick: */
 #define IRQ_WORK_LAZY		BIT(2)
+/* Run hard IRQ context, even on RT */
+#define IRQ_WORK_HARD_IRQ	BIT(3)
 
 #define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
 
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -69,6 +69,17 @@ do {						\
 			current->irq_config = 0;	\
 	  } while (0)
 
+# define lockdep_irq_work_enter(__work)					\
+	  do {								\
+		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+			current->irq_config = 1;			\
+	  } while (0)
+# define lockdep_irq_work_exit(__work)					\
+	  do {								\
+		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+			current->irq_config = 0;			\
+	  } while (0)
+
 #else
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
@@ -83,6 +94,8 @@ do {						\
 # define lockdep_softirq_exit()		do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
 # define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
+# define lockdep_irq_work_enter(__work)		do { } while (0)
+# define lockdep_irq_work_exit(__work)		do { } while (0)
 #endif
 
 #if defined(CONFIG_IRQSOFF_TRACER) || \
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -153,7 +153,9 @@ static void irq_work_run_list(struct lli
 		 */
 		flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
 
+		lockdep_irq_work_enter(work);
 		work->func(work);
+		lockdep_irq_work_exit(work);
 		/*
 		 * Clear the BUSY bit and return to the free state if
 		 * no-one else claimed it meanwhile.
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1113,6 +1113,7 @@ static int rcu_implicit_dynticks_qs(stru
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
 			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
+			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -245,6 +245,7 @@ static void nohz_full_kick_func(struct i
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
 	.func = nohz_full_kick_func,
+	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
 };
 
 /*

