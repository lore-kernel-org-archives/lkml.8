Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C58C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1706724696
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgBYX01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbgBYX0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:21 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaL-0004j0-EG; Wed, 26 Feb 2020 00:25:54 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 11E8610409C;
        Wed, 26 Feb 2020 00:25:39 +0100 (CET)
Message-Id: <20200225222649.353236304@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:18 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 12/24] x86/entry: Convert Invalid Opcode exception to IDTENTRY
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

Convert #UD to IDTENTRY:
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
 arch/x86/kernel/traps.c         |    7 ++++++-
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 10 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1334,13 +1334,6 @@ SYM_CODE_START(native_iret)
 SYM_CODE_END(native_iret)
 #endif
 
-SYM_CODE_START(invalid_op)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_invalid_op
-	jmp	common_exception
-SYM_CODE_END(invalid_op)
-
 SYM_CODE_START(coprocessor_segment_overrun)
 	ASM_CLAC
 	pushl	$0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,7 +1061,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_UD		invalid_op		do_invalid_op			has_error_code=0
 idtentry	X86_TRAP_NM		device_not_available	do_device_not_available		has_error_code=0
 idtentry	X86_TRAP_OLD_MF		coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
 idtentry	X86_TRAP_TS		invalid_TSS		do_invalid_TSS			has_error_code=1
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -81,5 +81,6 @@ DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divid
 DECLARE_IDTENTRY(X86_TRAP_BP,		exc_int3);
 DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overflow);
 DECLARE_IDTENTRY(X86_TRAP_BR,		exc_bounds);
+DECLARE_IDTENTRY(X86_TRAP_UD,		exc_invalid_op);
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -13,7 +13,6 @@
 
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
-asmlinkage void invalid_op(void);
 asmlinkage void device_not_available(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
@@ -36,7 +35,6 @@ asmlinkage void simd_coprocessor_error(v
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
-asmlinkage void xen_invalid_op(void);
 asmlinkage void xen_device_not_available(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_coprocessor_segment_overrun(void);
@@ -56,7 +54,6 @@ asmlinkage void xen_simd_coprocessor_err
 
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
-dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
 dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -73,7 +73,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_DE,		asm_exc_divide_error),
 	INTG(X86_TRAP_NMI,		nmi),
 	INTG(X86_TRAP_BR,		asm_exc_bounds),
-	INTG(X86_TRAP_UD,		invalid_op),
+	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
 	INTG(X86_TRAP_NM,		device_not_available),
 	INTG(X86_TRAP_OLD_MF,		coprocessor_segment_overrun),
 	INTG(X86_TRAP_TS,		invalid_TSS),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -290,6 +290,12 @@ DEFINE_IDTENTRY(exc_overflow)
 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
 }
 
+DEFINE_IDTENTRY(exc_invalid_op)
+{
+	do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
+		      ILL_ILLOPN, error_get_trap_addr(regs));
+}
+
 #define IP ((void __user *)uprobe_get_trap_addr(regs))
 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
 dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
@@ -297,7 +303,6 @@ dotraplinkage void do_##name(struct pt_r
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
 
-DO_ERROR(X86_TRAP_UD,     SIGILL,  ILL_ILLOPN,   IP, "invalid opcode",      invalid_op)
 DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overrun", coprocessor_segment_overrun)
 DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -622,7 +622,7 @@ static struct trap_array_entry trap_arra
 	{ page_fault,                  xen_page_fault,                  false },
 	TRAP_ENTRY(exc_divide_error,			false ),
 	TRAP_ENTRY(exc_bounds,				false ),
-	{ invalid_op,                  xen_invalid_op,                  false },
+	TRAP_ENTRY(exc_invalid_op,			false ),
 	{ device_not_available,        xen_device_not_available,        false },
 	{ coprocessor_segment_overrun, xen_coprocessor_segment_overrun, false },
 	{ invalid_TSS,                 xen_invalid_TSS,                 false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -35,7 +35,7 @@ xen_pv_trap asm_exc_int3
 xen_pv_trap xennmi
 xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds
-xen_pv_trap invalid_op
+xen_pv_trap asm_exc_invalid_op
 xen_pv_trap device_not_available
 xen_pv_trap double_fault
 xen_pv_trap coprocessor_segment_overrun

