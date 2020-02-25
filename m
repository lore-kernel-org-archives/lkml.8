Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F35C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5F42468D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgBYX0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbgBYX0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:12 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaK-0004iz-N7; Wed, 26 Feb 2020 00:25:53 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9C707104094;
        Wed, 26 Feb 2020 00:25:38 +0100 (CET)
Message-Id: <20200225222649.153974461@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:16 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 10/24] x86/entry: Convert INT3 exception to IDTENTRY
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

Convert #BP to IDTENTRY:
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
 arch/x86/kernel/traps.c         |   11 +++++------
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 9 insertions(+), 20 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1698,13 +1698,6 @@ SYM_CODE_START(nmi)
 #endif
 SYM_CODE_END(nmi)
 
-SYM_CODE_START(int3)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_int3
-	jmp	common_exception
-SYM_CODE_END(int3)
-
 SYM_CODE_START(general_protection)
 	ASM_CLAC
 	pushl	$do_general_protection
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,7 +1061,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
 idtentry	X86_TRAP_BR		bounds			do_bounds			has_error_code=0
 idtentry	X86_TRAP_UD		invalid_op		do_invalid_op			has_error_code=0
 idtentry	X86_TRAP_NM		device_not_available	do_device_not_available		has_error_code=0
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -78,6 +78,7 @@ static __always_inline void __##func(str
 
 /* Simple exception entries: */
 DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
+DECLARE_IDTENTRY(X86_TRAP_BP,		exc_int3);
 DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overflow);
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -13,7 +13,6 @@
 
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
-asmlinkage void int3(void);
 asmlinkage void bounds(void);
 asmlinkage void invalid_op(void);
 asmlinkage void device_not_available(void);
@@ -38,7 +37,6 @@ asmlinkage void simd_coprocessor_error(v
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
-asmlinkage void xen_int3(void);
 asmlinkage void xen_bounds(void);
 asmlinkage void xen_invalid_op(void);
 asmlinkage void xen_device_not_available(void);
@@ -60,7 +58,6 @@ asmlinkage void xen_simd_coprocessor_err
 
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
-dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
 dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -57,7 +57,7 @@ struct idt_data {
  */
 static const __initconst struct idt_data early_idts[] = {
 	INTG(X86_TRAP_DB,		debug),
-	SYSG(X86_TRAP_BP,		int3),
+	SYSG(X86_TRAP_BP,		asm_exc_int3),
 #ifdef CONFIG_X86_32
 	INTG(X86_TRAP_PF,		page_fault),
 #endif
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -580,7 +580,7 @@ dotraplinkage void do_general_protection
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY(exc_int3)
 {
 	if (poke_int3_handler(regs))
 		return;
@@ -601,8 +601,8 @@ dotraplinkage void notrace do_int3(struc
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
-	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
-				SIGTRAP) == NOTIFY_STOP)
+	if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
+			 SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 #endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
 
@@ -611,12 +611,12 @@ dotraplinkage void notrace do_int3(struc
 		goto exit;
 #endif
 
-	if (notify_die(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
+	if (notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
 			SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
 	cond_local_irq_enable(regs);
-	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, error_code, 0, NULL);
+	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
 	cond_local_irq_disable(regs);
 
 exit:
@@ -625,7 +625,6 @@ dotraplinkage void notrace do_int3(struc
 		rcu_nmi_exit();
 	}
 }
-NOKPROBE_SYMBOL(do_int3);
 
 #ifdef CONFIG_X86_64
 /*
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -614,7 +614,7 @@ static struct trap_array_entry trap_arra
 	{ machine_check,               xen_machine_check,               true },
 #endif
 	{ nmi,                         xen_xennmi,                      true },
-	{ int3,                        xen_int3,                        false },
+	TRAP_ENTRY(exc_int3,				false ),
 	TRAP_ENTRY(exc_overflow,			false ),
 #ifdef CONFIG_IA32_EMULATION
 	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -31,7 +31,7 @@ SYM_CODE_END(xen_\name)
 xen_pv_trap asm_exc_divide_error
 xen_pv_trap debug
 xen_pv_trap xendebug
-xen_pv_trap int3
+xen_pv_trap asm_exc_int3
 xen_pv_trap xennmi
 xen_pv_trap asm_exc_overflow
 xen_pv_trap bounds

