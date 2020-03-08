Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE86C10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3A420863
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgCHXYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:24:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57403 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCHXY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:24:26 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gy-0003Bw-V4; Mon, 09 Mar 2020 00:23:54 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 52B4B1040A9;
        Mon,  9 Mar 2020 00:23:37 +0100 (CET)
Message-Id: <20200308231719.414154861@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 09 Mar 2020 00:14:20 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-III V2 10/23] x86/entry: Convert Bounds exception to IDTENTRY
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

Convert #BR to IDTENTRY:
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
 arch/x86/kernel/traps.c         |   10 +++++-----
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 9 insertions(+), 19 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1334,13 +1334,6 @@ SYM_CODE_START(native_iret)
 SYM_CODE_END(native_iret)
 #endif
 
-SYM_CODE_START(bounds)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_bounds
-	jmp	common_exception
-SYM_CODE_END(bounds)
-
 SYM_CODE_START(invalid_op)
 	ASM_CLAC
 	pushl	$0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1062,7 +1062,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_BR		bounds			do_bounds			has_error_code=0
 idtentry	X86_TRAP_UD		invalid_op		do_invalid_op			has_error_code=0
 idtentry	X86_TRAP_NM		device_not_available	do_device_not_available		has_error_code=0
 idtentry	X86_TRAP_OLD_MF		coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -94,5 +94,6 @@ static __always_inline void __##func(str
 /* Simple exception entry points. No hardware error code */
 DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
 DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overflow);
+DECLARE_IDTENTRY(X86_TRAP_BR,		exc_bounds);
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -14,7 +14,6 @@
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
 asmlinkage void int3(void);
-asmlinkage void bounds(void);
 asmlinkage void invalid_op(void);
 asmlinkage void device_not_available(void);
 #ifdef CONFIG_X86_64
@@ -39,7 +38,6 @@ asmlinkage void simd_coprocessor_error(v
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
-asmlinkage void xen_bounds(void);
 asmlinkage void xen_invalid_op(void);
 asmlinkage void xen_device_not_available(void);
 asmlinkage void xen_double_fault(void);
@@ -61,7 +59,6 @@ asmlinkage void xen_simd_coprocessor_err
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
-dotraplinkage void do_bounds(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
 dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -72,7 +72,7 @@ static const __initconst struct idt_data
 static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_DE,		asm_exc_divide_error),
 	INTG(X86_TRAP_NMI,		nmi),
-	INTG(X86_TRAP_BR,		bounds),
+	INTG(X86_TRAP_BR,		asm_exc_bounds),
 	INTG(X86_TRAP_UD,		invalid_op),
 	INTG(X86_TRAP_NM,		device_not_available),
 	INTG(X86_TRAP_OLD_MF,		coprocessor_segment_overrun),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -446,18 +446,18 @@ dotraplinkage void do_double_fault(struc
 }
 #endif
 
-dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY(exc_bounds)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
-	if (notify_die(DIE_TRAP, "bounds", regs, error_code,
-			X86_TRAP_BR, SIGSEGV) == NOTIFY_STOP)
+	if (notify_die(DIE_TRAP, "bounds", regs, 0,
+		       X86_TRAP_BR, SIGSEGV) == NOTIFY_STOP)
 		return;
 	cond_local_irq_enable(regs);
 
 	if (!user_mode(regs))
-		die("bounds", regs, error_code);
+		die("bounds", regs, 0);
 
-	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
+	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, 0, 0, NULL);
 }
 
 enum kernel_gp_hint {
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -621,7 +621,7 @@ static struct trap_array_entry trap_arra
 #endif
 	{ page_fault,                  xen_page_fault,                  false },
 	TRAP_ENTRY(exc_divide_error,			false ),
-	{ bounds,                      xen_bounds,                      false },
+	TRAP_ENTRY(exc_bounds,				false ),
 	{ invalid_op,                  xen_invalid_op,                  false },
 	{ device_not_available,        xen_device_not_available,        false },
 	{ coprocessor_segment_overrun, xen_coprocessor_segment_overrun, false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -34,7 +34,7 @@ xen_pv_trap xendebug
 xen_pv_trap int3
 xen_pv_trap xennmi
 xen_pv_trap asm_exc_overflow
-xen_pv_trap bounds
+xen_pv_trap asm_exc_bounds
 xen_pv_trap invalid_op
 xen_pv_trap device_not_available
 xen_pv_trap double_fault

