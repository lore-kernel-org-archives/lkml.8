Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E57BC47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 539D620675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgEEOTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730115AbgEEOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B97C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:29 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMm-0002Aa-4d; Tue, 05 May 2020 16:16:12 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 82ABDFFC8D;
        Tue,  5 May 2020 16:16:11 +0200 (CEST)
Message-Id: <20200505135315.476734898@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 4 22/24] x86/mce: Address objtools noinstr complaints
References: <20200505134926.578885807@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the relevant functions noinstr, use the plain non-instrumented MSR
accessors. The only odd part is the instr_begin()/end() pair around the
indirect machine_check_vector() call as objtool can't figure that out. The
possible invoked functions are annotated correctly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/mce/core.c    |   20 +++++++++++++++-----
 arch/x86/kernel/cpu/mce/p5.c      |    4 +++-
 arch/x86/kernel/cpu/mce/winchip.c |    4 +++-
 kernel/time/timekeeping.c         |    2 +-
 4 files changed, 22 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -130,7 +130,7 @@ static void (*quirk_no_way_out)(int bank
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
+	instr_begin();
 	pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
 	       smp_processor_id());
+	instr_end();
 }
 
 /* Call the installed machine check handler for this CPU setup. */
@@ -1915,14 +1917,22 @@ static __always_inline void exc_machine_
 		return;
 
 	nmi_enter();
+	/*
+	 * The call targets are marked noinstr, but objtool can't figure
+	 * that out because it's an indirect call. Annotate it.
+	 */
+	instr_begin();
 	machine_check_vector(regs);
+	instr_end();
 	nmi_exit();
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
 	idtentry_enter(regs);
+	instr_begin();
 	machine_check_vector(regs);
+	instr_end();
 	idtentry_exit(regs);
 }
 
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -21,10 +21,11 @@
 int mce_p5_enabled __read_mostly;
 
 /* Machine check handler for Pentium class Intel CPUs: */
-static void pentium_machine_check(struct pt_regs *regs)
+static noinstr void pentium_machine_check(struct pt_regs *regs)
 {
 	u32 loaddr, hi, lotype;
 
+	instr_begin();
 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
 	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
 
@@ -37,6 +38,7 @@ static void pentium_machine_check(struct
 	}
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+	instr_end();
 }
 
 /* Set up machine check reporting for processors with Intel style MCE: */
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -17,10 +17,12 @@
 #include "internal.h"
 
 /* Machine check handler for WinChip C6: */
-static void winchip_machine_check(struct pt_regs *regs)
+static noinstr void winchip_machine_check(struct pt_regs *regs)
 {
+	instr_begin();
 	pr_emerg("CPU0: Machine Check Exception.\n");
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+	instr_end();
 }
 
 /* Set up machine check reporting on the Winchip C6 series */
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -953,7 +953,7 @@ EXPORT_SYMBOL_GPL(ktime_get_real_seconds
  * but without the sequence counter protect. This internal function
  * is called just when timekeeping lock is already held.
  */
-time64_t __ktime_get_real_seconds(void)
+noinstr time64_t __ktime_get_real_seconds(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 

