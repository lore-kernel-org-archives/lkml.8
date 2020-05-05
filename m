Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B64DC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42042207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgEEOPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729927AbgEEOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04750C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:44 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyM2-0001fW-11; Tue, 05 May 2020 16:15:26 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 8911EFFC8D;
        Tue,  5 May 2020 16:15:25 +0200 (CEST)
Message-Id: <20200505134906.021552202@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:22 +0200
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
Subject: [patch V4 part 3 28/29] x86/entry: Convert SIMD coprocessor error
 exception to IDTENTRY
References: <20200505134354.774943181@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Convert #XF to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Handle INVD_BUG in C
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes
  - Remove the RCU warning as the new entry macro ensures correctness

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Move the INVD bug handling to C (Brian)
---
 arch/x86/entry/entry_32.S       |   14 --------------
 arch/x86/entry/entry_64.S       |    1 -
 arch/x86/include/asm/idtentry.h |    1 +
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |   29 +++++++++++++++++------------
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 21 insertions(+), 33 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1290,20 +1290,6 @@ SYM_FUNC_END(name)
 /* The include is where all of the SMP etc. interrupts come from */
 #include <asm/entry_arch.h>
 
-SYM_CODE_START(simd_coprocessor_error)
-	ASM_CLAC
-	pushl	$0
-#ifdef CONFIG_X86_INVD_BUG
-	/* AMD 486 bug: invd from userspace calls exception 19 instead of #GP */
-	ALTERNATIVE "pushl	$exc_general_protection",	\
-		    "pushl	$do_simd_coprocessor_error",	\
-		    X86_FEATURE_XMM
-#else
-	pushl	$do_simd_coprocessor_error
-#endif
-	jmp	common_exception
-SYM_CODE_END(simd_coprocessor_error)
-
 #ifdef CONFIG_PARAVIRT
 SYM_CODE_START(native_iret)
 	iret
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1074,7 +1074,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_XF		simd_coprocessor_error	do_simd_coprocessor_error	has_error_code=0
 
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -131,6 +131,7 @@ DECLARE_IDTENTRY(X86_TRAP_NM,		exc_devic
 DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_coproc_segment_overrun);
 DECLARE_IDTENTRY(X86_TRAP_SPURIOUS,	exc_spurious_interrupt_bug);
 DECLARE_IDTENTRY(X86_TRAP_MF,		exc_coprocessor_error);
+DECLARE_IDTENTRY(X86_TRAP_XF,		exc_simd_coprocessor_error);
 
 /* Simple exception entries with error code pushed by hardware */
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -22,7 +22,6 @@ asmlinkage void async_page_fault(void);
 #ifdef CONFIG_X86_MCE
 asmlinkage void machine_check(void);
 #endif /* CONFIG_X86_MCE */
-asmlinkage void simd_coprocessor_error(void);
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
 asmlinkage void xen_xennmi(void);
@@ -33,7 +32,6 @@ asmlinkage void xen_page_fault(void);
 #ifdef CONFIG_X86_MCE
 asmlinkage void xen_machine_check(void);
 #endif /* CONFIG_X86_MCE */
-asmlinkage void xen_simd_coprocessor_error(void);
 #endif
 
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
@@ -43,7 +41,6 @@ dotraplinkage void do_int3(struct pt_reg
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
 #endif
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -83,7 +83,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_SPURIOUS,		asm_exc_spurious_interrupt_bug),
 	INTG(X86_TRAP_MF,		asm_exc_coprocessor_error),
 	INTG(X86_TRAP_AC,		asm_exc_alignment_check),
-	INTG(X86_TRAP_XF,		simd_coprocessor_error),
+	INTG(X86_TRAP_XF,		asm_exc_simd_coprocessor_error),
 
 #ifdef CONFIG_X86_32
 	TSKG(X86_TRAP_DF,		GDT_ENTRY_DOUBLEFAULT_TSS),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -802,7 +802,7 @@ NOKPROBE_SYMBOL(do_debug);
  * the correct behaviour even in the presence of the asynchronous
  * IRQ13 behaviour
  */
-static void math_error(struct pt_regs *regs, int error_code, int trapnr)
+static void math_error(struct pt_regs *regs, int trapnr)
 {
 	struct task_struct *task = current;
 	struct fpu *fpu = &task->thread.fpu;
@@ -813,15 +813,15 @@ static void math_error(struct pt_regs *r
 	cond_local_irq_enable(regs);
 
 	if (!user_mode(regs)) {
-		if (fixup_exception(regs, trapnr, error_code, 0))
+		if (fixup_exception(regs, trapnr, 0, 0))
 			goto exit;
 
-		task->thread.error_code = error_code;
+		task->thread.error_code = 0;
 		task->thread.trap_nr = trapnr;
 
-		if (notify_die(DIE_TRAP, str, regs, error_code,
-					trapnr, SIGFPE) != NOTIFY_STOP)
-			die(str, regs, error_code);
+		if (notify_die(DIE_TRAP, str, regs, 0, trapnr,
+			       SIGFPE) != NOTIFY_STOP)
+			die(str, regs, 0);
 		goto exit;
 	}
 
@@ -831,7 +831,7 @@ static void math_error(struct pt_regs *r
 	fpu__save(fpu);
 
 	task->thread.trap_nr	= trapnr;
-	task->thread.error_code = error_code;
+	task->thread.error_code = 0;
 
 	si_code = fpu__exception_code(fpu, trapnr);
 	/* Retry when we get spurious exceptions: */
@@ -846,14 +846,19 @@ static void math_error(struct pt_regs *r
 
 DEFINE_IDTENTRY(exc_coprocessor_error)
 {
-	math_error(regs, 0, X86_TRAP_MF);
+	math_error(regs, X86_TRAP_MF);
 }
 
-dotraplinkage void
-do_simd_coprocessor_error(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY(exc_simd_coprocessor_error)
 {
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
-	math_error(regs, error_code, X86_TRAP_XF);
+	if (IS_ENABLED(CONFIG_X86_INVD_BUG)) {
+		/* AMD 486 bug: INVD in CPL 0 raises #XF instead of #GP */
+		if (!static_cpu_has(X86_FEATURE_XMM)) {
+			__exc_general_protection(regs, 0);
+			return;
+		}
+	}
+	math_error(regs, X86_TRAP_XF);
 }
 
 DEFINE_IDTENTRY(exc_spurious_interrupt_bug)
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -635,7 +635,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_spurious_interrupt_bug,		false ),
 	TRAP_ENTRY(exc_coprocessor_error,		false ),
 	TRAP_ENTRY(exc_alignment_check,			false ),
-	{ simd_coprocessor_error,      xen_simd_coprocessor_error,      false },
+	TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
 };
 
 static bool __ref get_trap_addr(void **addr, unsigned int ist)
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -50,7 +50,7 @@ xen_pv_trap asm_exc_alignment_check
 #ifdef CONFIG_X86_MCE
 xen_pv_trap machine_check
 #endif /* CONFIG_X86_MCE */
-xen_pv_trap simd_coprocessor_error
+xen_pv_trap asm_exc_simd_coprocessor_error
 #ifdef CONFIG_IA32_EMULATION
 xen_pv_trap entry_INT80_compat
 #endif

