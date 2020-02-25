Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29673C4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D182469F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgBYX0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55782 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgBYX0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:23 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaW-0004o0-A9; Wed, 26 Feb 2020 00:26:05 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 0B5DD1040A3;
        Wed, 26 Feb 2020 00:25:41 +0100 (CET)
Message-Id: <20200225222650.248245191@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:27 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 21/24] x86/entry: Convert Coprocessor error exception to IDTENTRY
References: <20200225221606.511535280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert #MF to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    7 -------
 arch/x86/entry/entry_64.S       |    1 -
 arch/x86/include/asm/idtentry.h |    1 +
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |    4 ++--
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 6 insertions(+), 16 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1299,13 +1299,6 @@ SYM_FUNC_END(name)
 /* The include is where all of the SMP etc. interrupts come from */
 #include <asm/entry_arch.h>
 
-SYM_CODE_START(coprocessor_error)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_coprocessor_error
-	jmp	common_exception
-SYM_CODE_END(coprocessor_error)
-
 SYM_CODE_START(simd_coprocessor_error)
 	ASM_CLAC
 	pushl	$0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,7 +1061,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_MF		coprocessor_error	do_coprocessor_error		has_error_code=0
 idtentry	X86_TRAP_AC		alignment_check		do_alignment_check		has_error_code=1
 idtentry	X86_TRAP_XF		simd_coprocessor_error	do_simd_coprocessor_error	has_error_code=0
 
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -128,6 +128,7 @@ DECLARE_IDTENTRY(X86_TRAP_UD,		exc_inval
 DECLARE_IDTENTRY(X86_TRAP_NM,		exc_device_not_available);
 DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_coproc_segment_overrun);
 DECLARE_IDTENTRY(X86_TRAP_SPURIOUS,	exc_spurious_interrupt_bug);
+DECLARE_IDTENTRY(X86_TRAP_MF,		exc_coprocessor_error);
 
 /* Simple exception entries with error code pushed by hardware */
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -18,7 +18,6 @@ asmlinkage void double_fault(void);
 #endif
 asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
-asmlinkage void coprocessor_error(void);
 asmlinkage void alignment_check(void);
 #ifdef CONFIG_X86_MCE
 asmlinkage void machine_check(void);
@@ -30,7 +29,6 @@ asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
-asmlinkage void xen_coprocessor_error(void);
 asmlinkage void xen_alignment_check(void);
 #ifdef CONFIG_X86_MCE
 asmlinkage void xen_machine_check(void);
@@ -44,7 +42,6 @@ dotraplinkage void do_nmi(struct pt_regs
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
 dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_32
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -81,7 +81,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_SS,		asm_exc_stack_segment),
 	INTG(X86_TRAP_GP,		asm_exc_general_protection),
 	INTG(X86_TRAP_SPURIOUS,		asm_exc_spurious_interrupt_bug),
-	INTG(X86_TRAP_MF,		coprocessor_error),
+	INTG(X86_TRAP_MF,		asm_exc_coprocessor_error),
 	INTG(X86_TRAP_AC,		alignment_check),
 	INTG(X86_TRAP_XF,		simd_coprocessor_error),
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -892,10 +892,10 @@ static void math_error(struct pt_regs *r
 			(void __user *)uprobe_get_trap_addr(regs));
 }
 
-dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY(exc_coprocessor_error)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
-	math_error(regs, error_code, X86_TRAP_MF);
+	math_error(regs, 0, X86_TRAP_MF);
 }
 
 dotraplinkage void
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -630,7 +630,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_stack_segment,			false ),
 	TRAP_ENTRY(exc_general_protection,		false ),
 	TRAP_ENTRY(exc_spurious_interrupt_bug,		false ),
-	{ coprocessor_error,           xen_coprocessor_error,           false },
+	TRAP_ENTRY(exc_coprocessor_error,		false ),
 	{ alignment_check,             xen_alignment_check,             false },
 	{ simd_coprocessor_error,      xen_simd_coprocessor_error,      false },
 };
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -45,7 +45,7 @@ xen_pv_trap asm_exc_stack_segment
 xen_pv_trap asm_exc_general_protection
 xen_pv_trap page_fault
 xen_pv_trap asm_exc_spurious_interrupt_bug
-xen_pv_trap coprocessor_error
+xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap alignment_check
 #ifdef CONFIG_X86_MCE
 xen_pv_trap machine_check

