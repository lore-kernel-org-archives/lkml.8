Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D30AC4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C45C24681
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbgBYX2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:28:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55846 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbgBYX0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:30 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaV-0004nY-0W; Wed, 26 Feb 2020 00:26:03 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CAA621040A2;
        Wed, 26 Feb 2020 00:25:40 +0100 (CET)
Message-Id: <20200225222650.143873589@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:26 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 20/24] x86/entry: Convert Spurious interrupt bug exception to IDTENTRY
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

Convert #SPURIOUS to IDTENTRY_ERRORCODE:
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
 arch/x86/kernel/traps.c         |    3 +--
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 5 insertions(+), 16 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1342,13 +1342,6 @@ SYM_CODE_START(machine_check)
 SYM_CODE_END(machine_check)
 #endif
 
-SYM_CODE_START(spurious_interrupt_bug)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_spurious_interrupt_bug
-	jmp	common_exception
-SYM_CODE_END(spurious_interrupt_bug)
-
 #ifdef CONFIG_XEN_PV
 SYM_FUNC_START(xen_hypervisor_callback)
 	/*
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,7 +1061,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_SPURIOUS	spurious_interrupt_bug	do_spurious_interrupt_bug	has_error_code=0
 idtentry	X86_TRAP_MF		coprocessor_error	do_coprocessor_error		has_error_code=0
 idtentry	X86_TRAP_AC		alignment_check		do_alignment_check		has_error_code=1
 idtentry	X86_TRAP_XF		simd_coprocessor_error	do_simd_coprocessor_error	has_error_code=0
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -127,6 +127,7 @@ DECLARE_IDTENTRY(X86_TRAP_BR,		exc_bound
 DECLARE_IDTENTRY(X86_TRAP_UD,		exc_invalid_op);
 DECLARE_IDTENTRY(X86_TRAP_NM,		exc_device_not_available);
 DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_coproc_segment_overrun);
+DECLARE_IDTENTRY(X86_TRAP_SPURIOUS,	exc_spurious_interrupt_bug);
 
 /* Simple exception entries with error code pushed by hardware */
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -18,7 +18,6 @@ asmlinkage void double_fault(void);
 #endif
 asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
-asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void coprocessor_error(void);
 asmlinkage void alignment_check(void);
 #ifdef CONFIG_X86_MCE
@@ -31,7 +30,6 @@ asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
-asmlinkage void xen_spurious_interrupt_bug(void);
 asmlinkage void xen_coprocessor_error(void);
 asmlinkage void xen_alignment_check(void);
 #ifdef CONFIG_X86_MCE
@@ -46,7 +44,6 @@ dotraplinkage void do_nmi(struct pt_regs
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
 dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -80,7 +80,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_NP,		asm_exc_segment_not_present),
 	INTG(X86_TRAP_SS,		asm_exc_stack_segment),
 	INTG(X86_TRAP_GP,		asm_exc_general_protection),
-	INTG(X86_TRAP_SPURIOUS,		spurious_interrupt_bug),
+	INTG(X86_TRAP_SPURIOUS,		asm_exc_spurious_interrupt_bug),
 	INTG(X86_TRAP_MF,		coprocessor_error),
 	INTG(X86_TRAP_AC,		alignment_check),
 	INTG(X86_TRAP_XF,		simd_coprocessor_error),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -905,8 +905,7 @@ do_simd_coprocessor_error(struct pt_regs
 	math_error(regs, error_code, X86_TRAP_XF);
 }
 
-dotraplinkage void
-do_spurious_interrupt_bug(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY(exc_spurious_interrupt_bug)
 {
 	/*
 	 * This addresses a Pentium Pro Erratum:
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -629,7 +629,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_segment_not_present,		false ),
 	TRAP_ENTRY(exc_stack_segment,			false ),
 	TRAP_ENTRY(exc_general_protection,		false ),
-	{ spurious_interrupt_bug,      xen_spurious_interrupt_bug,      false },
+	TRAP_ENTRY(exc_spurious_interrupt_bug,		false ),
 	{ coprocessor_error,           xen_coprocessor_error,           false },
 	{ alignment_check,             xen_alignment_check,             false },
 	{ simd_coprocessor_error,      xen_simd_coprocessor_error,      false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -44,7 +44,7 @@ xen_pv_trap asm_exc_segment_not_present
 xen_pv_trap asm_exc_stack_segment
 xen_pv_trap asm_exc_general_protection
 xen_pv_trap page_fault
-xen_pv_trap spurious_interrupt_bug
+xen_pv_trap asm_exc_spurious_interrupt_bug
 xen_pv_trap coprocessor_error
 xen_pv_trap alignment_check
 #ifdef CONFIG_X86_MCE

