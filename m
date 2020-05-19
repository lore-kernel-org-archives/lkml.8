Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA018C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C035520826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgESUCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgEST6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C038C08C5C4;
        Tue, 19 May 2020 12:58:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nk-0008IM-2K; Tue, 19 May 2020 21:58:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7C5071C0480;
        Tue, 19 May 2020 21:58:28 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:28 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert SIMD coprocessor error exception
 to IDTENTRY
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134906.021552202@linutronix.de>
References: <20200505134906.021552202@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830840.17951.9590853474984202597.tip-bot2@tip-bot2>
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

Commit-ID:     03852142b159a78c77aa795ba6c6bd1f6273eab8
Gitweb:        https://git.kernel.org/tip/03852142b159a78c77aa795ba6c6bd1f6273eab8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:03 +02:00

x86/entry: Convert SIMD coprocessor error exception to IDTENTRY

Convert #XF to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Handle INVD_BUG in C
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototypes
  - Remove the RCU warning as the new entry macro ensures correctness

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134906.021552202@linutronix.de


---
 arch/x86/entry/entry_32.S       | 14 --------------
 arch/x86/entry/entry_64.S       |  1 -
 arch/x86/include/asm/idtentry.h |  1 +
 arch/x86/include/asm/traps.h    |  3 ---
 arch/x86/kernel/idt.c           |  2 +-
 arch/x86/kernel/traps.c         | 29 +++++++++++++++++------------
 arch/x86/xen/enlighten_pv.c     |  2 +-
 arch/x86/xen/xen-asm_64.S       |  2 +-
 8 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 7402890..c93fb73 100644
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3c95a63..1bada7b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1073,7 +1073,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_XF		simd_coprocessor_error	do_simd_coprocessor_error	has_error_code=0
 
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 531dbc0..99d4759 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -131,6 +131,7 @@ DECLARE_IDTENTRY(X86_TRAP_NM,		exc_device_not_available);
 DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_coproc_segment_overrun);
 DECLARE_IDTENTRY(X86_TRAP_SPURIOUS,	exc_spurious_interrupt_bug);
 DECLARE_IDTENTRY(X86_TRAP_MF,		exc_coprocessor_error);
+DECLARE_IDTENTRY(X86_TRAP_XF,		exc_simd_coprocessor_error);
 
 /* Simple exception entries with error code pushed by hardware */
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 0f755e1..e7eb753 100644
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
@@ -41,7 +39,6 @@ dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
 #endif
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index af48196..38b565b 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -86,7 +86,7 @@ static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_SPURIOUS,		asm_exc_spurious_interrupt_bug),
 	INTG(X86_TRAP_MF,		asm_exc_coprocessor_error),
 	INTG(X86_TRAP_AC,		asm_exc_alignment_check),
-	INTG(X86_TRAP_XF,		simd_coprocessor_error),
+	INTG(X86_TRAP_XF,		asm_exc_simd_coprocessor_error),
 
 #ifdef CONFIG_X86_32
 	TSKG(X86_TRAP_DF,		GDT_ENTRY_DOUBLEFAULT_TSS),
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9f156c8..1702922 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -810,7 +810,7 @@ NOKPROBE_SYMBOL(do_debug);
  * the correct behaviour even in the presence of the asynchronous
  * IRQ13 behaviour
  */
-static void math_error(struct pt_regs *regs, int error_code, int trapnr)
+static void math_error(struct pt_regs *regs, int trapnr)
 {
 	struct task_struct *task = current;
 	struct fpu *fpu = &task->thread.fpu;
@@ -821,15 +821,15 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
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
 
@@ -839,7 +839,7 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 	fpu__save(fpu);
 
 	task->thread.trap_nr	= trapnr;
-	task->thread.error_code = error_code;
+	task->thread.error_code = 0;
 
 	si_code = fpu__exception_code(fpu, trapnr);
 	/* Retry when we get spurious exceptions: */
@@ -854,14 +854,19 @@ exit:
 
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
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index afe12d9..c41152b 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -635,7 +635,7 @@ static struct trap_array_entry trap_array[] = {
 	TRAP_ENTRY(exc_spurious_interrupt_bug,		false ),
 	TRAP_ENTRY(exc_coprocessor_error,		false ),
 	TRAP_ENTRY(exc_alignment_check,			false ),
-	{ simd_coprocessor_error,      xen_simd_coprocessor_error,      false },
+	TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
 };
 
 static bool __ref get_trap_addr(void **addr, unsigned int ist)
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index a591bec..6a91157 100644
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
