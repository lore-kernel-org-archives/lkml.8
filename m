Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33197C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192CD206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgEEOT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730034AbgEEOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2955FC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:12 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMW-0001wv-2P; Tue, 05 May 2020 16:15:56 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 654B9FFC8D;
        Tue,  5 May 2020 16:15:55 +0200 (CEST)
Message-Id: <20200505135314.243936614@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:35 +0200
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
Subject: [patch V4 part 4 09/24] x86/mce: Move nmi_enter/exit() into the entry point
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

There is no reason to have nmi_enter/exit() in the actual MCE
handlers. Move it to the entry point. This also covers the until now
uncovered initial handler which only prints.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/mce/core.c    |   26 +++++++++++++-------------
 arch/x86/kernel/cpu/mce/p5.c      |    4 ----
 arch/x86/kernel/cpu/mce/winchip.c |    4 ----
 3 files changed, 13 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1100,8 +1100,10 @@ static void mce_clear_state(unsigned lon
  * kdump kernel establishing a new #MC handler where a broadcasted MCE
  * might not get handled properly.
  */
-static bool __mc_check_crashing_cpu(int cpu)
+static noinstr bool mce_check_crashing_cpu(void)
 {
+	unsigned int cpu = smp_processor_id();
+
 	if (cpu_is_offline(cpu) ||
 	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
@@ -1235,7 +1237,6 @@ void noinstr do_machine_check(struct pt_
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
 	struct mca_config *cfg = &mca_cfg;
-	int cpu = smp_processor_id();
 	struct mce m, *final;
 	char *msg = NULL;
 	int worst = 0;
@@ -1264,11 +1265,6 @@ void noinstr do_machine_check(struct pt_
 	 */
 	int lmce = 1;
 
-	if (__mc_check_crashing_cpu(cpu))
-		return;
-
-	nmi_enter();
-
 	this_cpu_inc(mce_exception_count);
 
 	mce_gather_info(&m, regs);
@@ -1356,7 +1352,7 @@ void noinstr do_machine_check(struct pt_
 	sync_core();
 
 	if (worst != MCE_AR_SEVERITY && !kill_it)
-		goto out_ist;
+		return;
 
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
@@ -1373,9 +1369,6 @@ void noinstr do_machine_check(struct pt_
 		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
 			mce_panic("Failed kernel mode recovery", &m, msg);
 	}
-
-out_ist:
-	nmi_exit();
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
 
@@ -1912,11 +1905,18 @@ static void unexpected_machine_check(str
 void (*machine_check_vector)(struct pt_regs *, long error_code) =
 						unexpected_machine_check;
 
-dotraplinkage notrace void do_mce(struct pt_regs *regs, long error_code)
+dotraplinkage noinstr void do_mce(struct pt_regs *regs, long error_code)
 {
+	if (machine_check_vector == do_machine_check &&
+	    mce_check_crashing_cpu())
+		return;
+
+	nmi_enter();
+
 	machine_check_vector(regs, error_code);
+
+	nmi_exit();
 }
-NOKPROBE_SYMBOL(do_mce);
 
 /*
  * Called for each booted CPU to set up machine checks.
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -25,8 +25,6 @@ static void pentium_machine_check(struct
 {
 	u32 loaddr, hi, lotype;
 
-	nmi_enter();
-
 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
 	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
 
@@ -39,8 +37,6 @@ static void pentium_machine_check(struct
 	}
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
-
-	nmi_exit();
 }
 
 /* Set up machine check reporting for processors with Intel style MCE: */
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -19,12 +19,8 @@
 /* Machine check handler for WinChip C6: */
 static void winchip_machine_check(struct pt_regs *regs, long error_code)
 {
-	nmi_enter();
-
 	pr_emerg("CPU0: Machine Check Exception.\n");
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
-
-	nmi_exit();
 }
 
 /* Set up machine check reporting on the Winchip C6 series */

