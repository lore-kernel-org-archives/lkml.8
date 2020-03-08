Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D8FC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731A420863
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCHXZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:25:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57381 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCHXYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:24:22 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5H3-0003EN-Vp; Mon, 09 Mar 2020 00:23:58 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 6B4A21040C0;
        Mon,  9 Mar 2020 00:23:38 +0100 (CET)
Message-Id: <20200308231719.918945605@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 09 Mar 2020 00:14:25 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-III V2 15/23] x86/entry: Convert Invalid TSS exception to IDTENTRY
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

Convert #TS to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/entry/entry_32.S       |    6 ------
 arch/x86/entry/entry_64.S       |    1 -
 arch/x86/include/asm/idtentry.h |    3 +++
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |    7 ++++++-
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 12 insertions(+), 14 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1327,12 +1327,6 @@ SYM_CODE_START(native_iret)
 SYM_CODE_END(native_iret)
 #endif
 
-SYM_CODE_START(invalid_TSS)
-	ASM_CLAC
-	pushl	$do_invalid_TSS
-	jmp	common_exception
-SYM_CODE_END(invalid_TSS)
-
 SYM_CODE_START(segment_not_present)
 	ASM_CLAC
 	pushl	$do_segment_not_present
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1062,7 +1062,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_TS		invalid_TSS		do_invalid_TSS			has_error_code=1
 idtentry	X86_TRAP_NP		segment_not_present	do_segment_not_present		has_error_code=1
 idtentry	X86_TRAP_SS		stack_segment		do_stack_segment		has_error_code=1
 idtentry	X86_TRAP_GP		general_protection	do_general_protection		has_error_code=1
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -144,4 +144,7 @@ DECLARE_IDTENTRY(X86_TRAP_UD,		exc_inval
 DECLARE_IDTENTRY(X86_TRAP_NM,		exc_device_not_available);
 DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_coproc_segment_overrun);
 
+/* Simple exception entries with error code pushed by hardware */
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
+
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -17,7 +17,6 @@ asmlinkage void int3(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
-asmlinkage void invalid_TSS(void);
 asmlinkage void segment_not_present(void);
 asmlinkage void stack_segment(void);
 asmlinkage void general_protection(void);
@@ -36,7 +35,6 @@ asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
 asmlinkage void xen_double_fault(void);
-asmlinkage void xen_invalid_TSS(void);
 asmlinkage void xen_segment_not_present(void);
 asmlinkage void xen_stack_segment(void);
 asmlinkage void xen_general_protection(void);
@@ -56,7 +54,6 @@ dotraplinkage void do_int3(struct pt_reg
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
-dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
 dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
 dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -76,7 +76,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
 	INTG(X86_TRAP_NM,		asm_exc_device_not_available),
 	INTG(X86_TRAP_OLD_MF,		asm_exc_coproc_segment_overrun),
-	INTG(X86_TRAP_TS,		invalid_TSS),
+	INTG(X86_TRAP_TS,		asm_exc_invalid_tss),
 	INTG(X86_TRAP_NP,		segment_not_present),
 	INTG(X86_TRAP_SS,		stack_segment),
 	INTG(X86_TRAP_GP,		general_protection),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -311,6 +311,12 @@ DEFINE_IDTENTRY(exc_coproc_segment_overr
 		      X86_TRAP_OLD_MF, SIGFPE, 0, NULL);
 }
 
+DEFINE_IDTENTRY_ERRORCODE(exc_invalid_tss)
+{
+	do_error_trap(regs, error_code, "invalid TSS", X86_TRAP_TS, SIGSEGV,
+		      0, NULL);
+}
+
 #define IP ((void __user *)uprobe_get_trap_addr(regs))
 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
 dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
@@ -318,7 +324,6 @@ dotraplinkage void do_##name(struct pt_r
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
 
-DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
 DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -625,7 +625,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_invalid_op,			false ),
 	TRAP_ENTRY(exc_device_not_available,		false ),
 	TRAP_ENTRY(exc_coproc_segment_overrun,		false ),
-	{ invalid_TSS,                 xen_invalid_TSS,                 false },
+	TRAP_ENTRY(exc_invalid_tss,			false ),
 	{ segment_not_present,         xen_segment_not_present,         false },
 	{ stack_segment,               xen_stack_segment,               false },
 	{ general_protection,          xen_general_protection,          false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -39,7 +39,7 @@ xen_pv_trap asm_exc_invalid_op
 xen_pv_trap asm_exc_device_not_available
 xen_pv_trap double_fault
 xen_pv_trap asm_exc_coproc_segment_overrun
-xen_pv_trap invalid_TSS
+xen_pv_trap asm_exc_invalid_tss
 xen_pv_trap segment_not_present
 xen_pv_trap stack_segment
 xen_pv_trap general_protection

