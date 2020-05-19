Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C732C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4332075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgEST6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgEST6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FA3C08C5C2;
        Tue, 19 May 2020 12:58:24 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8NW-00088L-OW; Tue, 19 May 2020 21:58:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5F0B11C0178;
        Tue, 19 May 2020 21:58:18 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:18 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/mce: Address objtools noinstr complaints
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135315.476734898@linutronix.de>
References: <20200505135315.476734898@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991829826.17951.7641601849300262770.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     260ba6c939f6ac42c8a96d2b50750b18706f1663
Gitweb:        https://git.kernel.org/tip/260ba6c939f6ac42c8a96d2b50750b18706f1663
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 21:22:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:14 +02:00

x86/mce: Address objtools noinstr complaints

Mark the relevant functions noinstr, use the plain non-instrumented MSR
accessors. The only odd part is the instrumentation_begin()/end() pair around the
indirect machine_check_vector() call as objtool can't figure that out. The
possible invoked functions are annotated correctly.

Also use notrace variant of nmi_enter/exit(). If MCEs happen then hardware
latency tracing is the least of the worries.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135315.476734898@linutronix.de


---
 arch/x86/kernel/cpu/mce/core.c    | 20 +++++++++++++++-----
 arch/x86/kernel/cpu/mce/p5.c      |  4 +++-
 arch/x86/kernel/cpu/mce/winchip.c |  4 +++-
 kernel/time/timekeeping.c         |  2 +-
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a72c013..a32a7e2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -130,7 +130,7 @@ static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
 /* Do initial initialization of a struct mce */
-void mce_setup(struct mce *m)
+noinstr void mce_setup(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
 	m->cpu = m->extcpu = smp_processor_id();
@@ -140,12 +140,12 @@ void mce_setup(struct mce *m)
 	m->cpuid = cpuid_eax(1);
 	m->socketid = cpu_data(m->extcpu).phys_proc_id;
 	m->apicid = cpu_data(m->extcpu).initial_apicid;
-	rdmsrl(MSR_IA32_MCG_CAP, m->mcgcap);
+	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
 
 	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
-		rdmsrl(MSR_PPIN, m->ppin);
+		m->ppin = __rdmsr(MSR_PPIN);
 	else if (this_cpu_has(X86_FEATURE_AMD_PPIN))
-		rdmsrl(MSR_AMD_PPIN, m->ppin);
+		m->ppin = __rdmsr(MSR_AMD_PPIN);
 
 	m->microcode = boot_cpu_data.microcode;
 }
@@ -1895,10 +1895,12 @@ bool filter_mce(struct mce *m)
 }
 
 /* Handle unconfigured int18 (should never happen) */
-static void unexpected_machine_check(struct pt_regs *regs)
+static noinstr void unexpected_machine_check(struct pt_regs *regs)
 {
+	instrumentation_begin();
 	pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
 	       smp_processor_id());
+	instrumentation_end();
 }
 
 /* Call the installed machine check handler for this CPU setup. */
@@ -1915,14 +1917,22 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 		return;
 
 	nmi_enter();
+	/*
+	 * The call targets are marked noinstr, but objtool can't figure
+	 * that out because it's an indirect call. Annotate it.
+	 */
+	instrumentation_begin();
 	machine_check_vector(regs);
+	instrumentation_end();
 	nmi_exit();
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
 	idtentry_enter(regs);
+	instrumentation_begin();
 	machine_check_vector(regs);
+	instrumentation_end();
 	idtentry_exit(regs);
 }
 
diff --git a/arch/x86/kernel/cpu/mce/p5.c b/arch/x86/kernel/cpu/mce/p5.c
index eaebc4c..19e90ca 100644
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -21,10 +21,11 @@
 int mce_p5_enabled __read_mostly;
 
 /* Machine check handler for Pentium class Intel CPUs: */
-static void pentium_machine_check(struct pt_regs *regs)
+static noinstr void pentium_machine_check(struct pt_regs *regs)
 {
 	u32 loaddr, hi, lotype;
 
+	instrumentation_begin();
 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
 	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
 
@@ -37,6 +38,7 @@ static void pentium_machine_check(struct pt_regs *regs)
 	}
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+	instrumentation_end();
 }
 
 /* Set up machine check reporting for processors with Intel style MCE: */
diff --git a/arch/x86/kernel/cpu/mce/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
index 90e3d60..9c9f0ab 100644
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -17,10 +17,12 @@
 #include "internal.h"
 
 /* Machine check handler for WinChip C6: */
-static void winchip_machine_check(struct pt_regs *regs)
+static noinstr void winchip_machine_check(struct pt_regs *regs)
 {
+	instrumentation_begin();
 	pr_emerg("CPU0: Machine Check Exception.\n");
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+	instrumentation_end();
 }
 
 /* Set up machine check reporting on the Winchip C6 series */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 9ebaab1..d20d489 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -953,7 +953,7 @@ EXPORT_SYMBOL_GPL(ktime_get_real_seconds);
  * but without the sequence counter protect. This internal function
  * is called just when timekeeping lock is already held.
  */
-time64_t __ktime_get_real_seconds(void)
+noinstr time64_t __ktime_get_real_seconds(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 
