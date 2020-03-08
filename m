Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14507C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B252087F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCHXYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:24:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57325 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgCHXYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:24:10 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gx-0003Bv-MV; Mon, 09 Mar 2020 00:23:53 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 1C11F1040B9;
        Mon,  9 Mar 2020 00:23:37 +0100 (CET)
Message-Id: <20200308231719.320758478@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 09 Mar 2020 00:14:19 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-III V2 09/23] x86/entry: Convert Overflow exception to IDTENTRY
References: <20200308231410.905396057@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Convert #OF to IDTENTRY:
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
 arch/x86/kernel/traps.c         |    6 +++++-
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 9 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1334,13 +1334,6 @@ SYM_CODE_START(native_iret)
 SYM_CODE_END(native_iret)
 #endif
 
-SYM_CODE_START(overflow)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_overflow
-	jmp	common_exception
-SYM_CODE_END(overflow)
-
 SYM_CODE_START(bounds)
 	ASM_CLAC
 	pushl	$0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,7 +1061,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_OF		overflow		do_overflow			has_error_code=0
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
 idtentry	X86_TRAP_BR		bounds			do_bounds			has_error_code=0
 idtentry	X86_TRAP_UD		invalid_op		do_invalid_op			has_error_code=0
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -93,5 +93,6 @@ static __always_inline void __##func(str
 
 /* Simple exception entry points. No hardware error code */
 DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
+DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overflow);
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -14,7 +14,6 @@
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
 asmlinkage void int3(void);
-asmlinkage void overflow(void);
 asmlinkage void bounds(void);
 asmlinkage void invalid_op(void);
 asmlinkage void device_not_available(void);
@@ -40,7 +39,6 @@ asmlinkage void simd_coprocessor_error(v
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
-asmlinkage void xen_overflow(void);
 asmlinkage void xen_bounds(void);
 asmlinkage void xen_invalid_op(void);
 asmlinkage void xen_device_not_available(void);
@@ -63,7 +61,6 @@ asmlinkage void xen_simd_coprocessor_err
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
-dotraplinkage void do_overflow(struct pt_regs *regs, long error_code);
 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
 dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -96,7 +96,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_MC,		&machine_check),
 #endif
 
-	SYSG(X86_TRAP_OF,		overflow),
+	SYSG(X86_TRAP_OF,		asm_exc_overflow),
 #if defined(CONFIG_IA32_EMULATION)
 	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_compat),
 #elif defined(CONFIG_X86_32)
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -285,6 +285,11 @@ DEFINE_IDTENTRY(exc_divide_error)
 		      FPE_INTDIV, error_get_trap_addr(regs));
 }
 
+DEFINE_IDTENTRY(exc_overflow)
+{
+	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
+}
+
 #define IP ((void __user *)uprobe_get_trap_addr(regs))
 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
 dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
@@ -292,7 +297,6 @@ dotraplinkage void do_##name(struct pt_r
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
 
-DO_ERROR(X86_TRAP_OF,     SIGSEGV,          0, NULL, "overflow",            overflow)
 DO_ERROR(X86_TRAP_UD,     SIGILL,  ILL_ILLOPN,   IP, "invalid opcode",      invalid_op)
 DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overrun", coprocessor_segment_overrun)
 DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -615,7 +615,7 @@ static struct trap_array_entry trap_arra
 #endif
 	{ nmi,                         xen_xennmi,                      true },
 	{ int3,                        xen_int3,                        false },
-	{ overflow,                    xen_overflow,                    false },
+	TRAP_ENTRY(exc_overflow,			false ),
 #ifdef CONFIG_IA32_EMULATION
 	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
 #endif
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -33,7 +33,7 @@ xen_pv_trap debug
 xen_pv_trap xendebug
 xen_pv_trap int3
 xen_pv_trap xennmi
-xen_pv_trap overflow
+xen_pv_trap asm_exc_overflow
 xen_pv_trap bounds
 xen_pv_trap invalid_op
 xen_pv_trap device_not_available

