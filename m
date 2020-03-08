Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0938C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA8820866
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgCHXYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:24:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57415 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgCHXYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:24:34 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5HF-0003K6-Cr; Mon, 09 Mar 2020 00:24:09 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2EAED1040C9;
        Mon,  9 Mar 2020 00:23:40 +0100 (CET)
Message-Id: <20200308231720.720215963@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 09 Mar 2020 00:14:33 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-III V2 23/23] x86/entry/32: Convert IRET exception to IDTENTRY_SW
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

Convert the IRET exception handler to IDTENTRY_SW. This is slightly
different than the conversions of hardware exceptions as the IRET exception
is invoked via an exception table when IRET faults. So it just uses the
IDTENTRY_SW mechanism for consistency. It does not emit ASM code as it does
not fit the other idtentry exceptions.

  - Implement the C entry point with DEFINE_IDTENTRY_SW() which maps to
    DEFINE_IDTENTRY()
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/entry/entry_32.S       |   12 ++++++------
 arch/x86/include/asm/idtentry.h |   10 ++++++++++
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/traps.c         |    6 +++---
 arch/x86/xen/xen-asm_32.S       |    2 +-
 5 files changed, 20 insertions(+), 13 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1156,9 +1156,9 @@ SYM_FUNC_START(entry_INT80_32)
 	jmp	.Lirq_return
 
 .section .fixup, "ax"
-SYM_CODE_START(iret_exc)
+SYM_CODE_START(asm_exc_iret_error)
 	pushl	$0				# no error code
-	pushl	$do_iret_error
+	pushl	$exc_iret_error
 
 #ifdef CONFIG_DEBUG_ENTRY
 	/*
@@ -1173,9 +1173,9 @@ SYM_CODE_START(iret_exc)
 #endif
 
 	jmp	common_exception
-SYM_CODE_END(iret_exc)
+SYM_CODE_END(asm_exc_iret_error)
 .previous
-	_ASM_EXTABLE(.Lirq_return, iret_exc)
+	_ASM_EXTABLE(.Lirq_return, asm_exc_iret_error)
 SYM_FUNC_END(entry_INT80_32)
 
 .macro FIXUP_ESPFIX_STACK
@@ -1302,7 +1302,7 @@ SYM_FUNC_END(name)
 #ifdef CONFIG_PARAVIRT
 SYM_CODE_START(native_iret)
 	iret
-	_ASM_EXTABLE(native_iret, iret_exc)
+	_ASM_EXTABLE(native_iret, asm_exc_iret_error)
 SYM_CODE_END(native_iret)
 #endif
 
@@ -1367,7 +1367,7 @@ SYM_FUNC_START(xen_failsafe_callback)
 	popl	%eax
 	lea	16(%esp), %esp
 	jz	5f
-	jmp	iret_exc
+	jmp	asm_exc_iret_error
 5:	pushl	$-1				/* orig_ax = -1 => not a system call */
 	SAVE_ALL
 	ENCODE_FRAME_POINTER
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -72,6 +72,10 @@ NOKPROBE_SYMBOL(func);							\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
 
+/* Special case for 32bit IRET 'trap' */
+#define DECLARE_IDTENTRY_SW	DECLARE_IDTENTRY
+#define DEFINE_IDTENTRY_SW	DEFINE_IDTENTRY
+
 /**
  * DECLARE_IDTENTRY_ERRORCODE - Declare functions for simple IDT entry points
  *				Error code pushed by hardware
@@ -125,6 +129,9 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
 	idtentry vector asm_##func func has_error_code=1
 
+/* Special case for 32bit IRET 'trap'. Do not emit ASM code */
+#define DECLARE_IDTENTRY_SW(vector, func)
+
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -147,6 +154,9 @@ DECLARE_IDTENTRY(X86_TRAP_SPURIOUS,	exc_
 DECLARE_IDTENTRY(X86_TRAP_MF,		exc_coprocessor_error);
 DECLARE_IDTENTRY(X86_TRAP_XF,		exc_simd_coprocessor_error);
 
+/* 32bit software IRET trap. Do not emit ASM code */
+DECLARE_IDTENTRY_SW(X86_TRAP_IRET,	exc_iret_error);
+
 /* Simple exception entries with error code pushed by hardware */
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_NP,	exc_segment_not_present);
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -41,9 +41,6 @@ dotraplinkage void do_int3(struct pt_reg
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-#ifdef CONFIG_X86_32
-dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
-#endif
 dotraplinkage void do_mce(struct pt_regs *regs, long error_code);
 
 #ifdef CONFIG_X86_64
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -966,14 +966,14 @@ DEFINE_IDTENTRY(exc_device_not_available
 }
 
 #ifdef CONFIG_X86_32
-dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_SW(exc_iret_error)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	local_irq_enable();
 
-	if (notify_die(DIE_TRAP, "iret exception", regs, error_code,
+	if (notify_die(DIE_TRAP, "iret exception", regs, 0,
 			X86_TRAP_IRET, SIGILL) != NOTIFY_STOP) {
-		do_trap(X86_TRAP_IRET, SIGILL, "iret exception", regs, error_code,
+		do_trap(X86_TRAP_IRET, SIGILL, "iret exception", regs, 0,
 			ILL_BADSTK, (void __user *)NULL);
 	}
 }
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -117,7 +117,7 @@ SYM_CODE_START(xen_iret)
 
 1:	iret
 xen_iret_end_crit:
-	_ASM_EXTABLE(1b, iret_exc)
+	_ASM_EXTABLE(1b, asm_exc_iret_error)
 
 hyper_iret:
 	/* put this out of line since its very rarely used */

