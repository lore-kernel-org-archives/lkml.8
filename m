Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0628C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966E42075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgESTxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgESTws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C303C08C5C3;
        Tue, 19 May 2020 12:52:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8I0-0007rm-Au; Tue, 19 May 2020 21:52:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E04E21C047E;
        Tue, 19 May 2020 21:52:35 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] hardirq/nmi: Allow nested nmi_enter()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134100.864179229@linutronix.de>
References: <20200505134100.864179229@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795579.17951.3911373387673021445.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     69ea03b56ed2c7189ccd0b5910ad39f3cad1df21
Gitweb:        https://git.kernel.org/tip/69ea03b56ed2c7189ccd0b5910ad39f3cad1df21
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 19 Feb 2020 09:46:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:17 +02:00

hardirq/nmi: Allow nested nmi_enter()

Since there are already a number of sites (ARM64, PowerPC) that effectively
nest nmi_enter(), make the primitive support this before adding even more.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lkml.kernel.org/r/20200505134100.864179229@linutronix.de


---
 arch/arm64/kernel/sdei.c    | 14 ++------------
 arch/arm64/kernel/traps.c   |  8 ++------
 arch/powerpc/kernel/traps.c | 22 ++++++----------------
 include/linux/hardirq.h     |  5 ++++-
 include/linux/preempt.h     |  4 ++--
 5 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index d6259da..e396e69 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -251,22 +251,12 @@ asmlinkage __kprobes notrace unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
 	unsigned long ret;
-	bool do_nmi_exit = false;
 
-	/*
-	 * nmi_enter() deals with printk() re-entrance and use of RCU when
-	 * RCU believed this CPU was idle. Because critical events can
-	 * interrupt normal events, we may already be in_nmi().
-	 */
-	if (!in_nmi()) {
-		nmi_enter();
-		do_nmi_exit = true;
-	}
+	nmi_enter();
 
 	ret = _sdei_handler(regs, arg);
 
-	if (do_nmi_exit)
-		nmi_exit();
+	nmi_exit();
 
 	return ret;
 }
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be..c728f16 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -906,17 +906,13 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
 
 asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
 {
-	const bool was_in_nmi = in_nmi();
-
-	if (!was_in_nmi)
-		nmi_enter();
+	nmi_enter();
 
 	/* non-RAS errors are not containable */
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
 		arm64_serror_panic(regs, esr);
 
-	if (!was_in_nmi)
-		nmi_exit();
+	nmi_exit();
 }
 
 asmlinkage void enter_from_user_mode(void)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 3fca222..b44dd75 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -441,15 +441,9 @@ nonrecoverable:
 void system_reset_exception(struct pt_regs *regs)
 {
 	unsigned long hsrr0, hsrr1;
-	bool nested = in_nmi();
 	bool saved_hsrrs = false;
 
-	/*
-	 * Avoid crashes in case of nested NMI exceptions. Recoverability
-	 * is determined by RI and in_nmi
-	 */
-	if (!nested)
-		nmi_enter();
+	nmi_enter();
 
 	/*
 	 * System reset can interrupt code where HSRRs are live and MSR[RI]=1.
@@ -521,8 +515,7 @@ out:
 		mtspr(SPRN_HSRR1, hsrr1);
 	}
 
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 
 	/* What should we do here? We could issue a shutdown or hard reset. */
 }
@@ -823,9 +816,8 @@ int machine_check_generic(struct pt_regs *regs)
 void machine_check_exception(struct pt_regs *regs)
 {
 	int recover = 0;
-	bool nested = in_nmi();
-	if (!nested)
-		nmi_enter();
+
+	nmi_enter();
 
 	__this_cpu_inc(irq_stat.mce_exceptions);
 
@@ -851,8 +843,7 @@ void machine_check_exception(struct pt_regs *regs)
 	if (check_io_access(regs))
 		goto bail;
 
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 
 	die("Machine check", regs, SIGBUS);
 
@@ -863,8 +854,7 @@ void machine_check_exception(struct pt_regs *regs)
 	return;
 
 bail:
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 }
 
 void SMIException(struct pt_regs *regs)
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 7c8b82f..a043ad8 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -65,13 +65,16 @@ extern void irq_exit(void);
 #define arch_nmi_exit()		do { } while (0)
 #endif
 
+/*
+ * nmi_enter() can nest up to 15 times; see NMI_BITS.
+ */
 #define nmi_enter()						\
 	do {							\
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
-		BUG_ON(in_nmi());				\
+		BUG_ON(in_nmi() == NMI_MASK);			\
 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
 		lockdep_hardirq_enter();			\
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index bc3f1ae..7d9c1c0 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -26,13 +26,13 @@
  *         PREEMPT_MASK:	0x000000ff
  *         SOFTIRQ_MASK:	0x0000ff00
  *         HARDIRQ_MASK:	0x000f0000
- *             NMI_MASK:	0x00100000
+ *             NMI_MASK:	0x00f00000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	1
+#define NMI_BITS	4
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
