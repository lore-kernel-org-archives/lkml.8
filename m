Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8F120884
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgEST66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgEST6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6009C08C5C1;
        Tue, 19 May 2020 12:58:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nt-0008Oo-8l; Tue, 19 May 2020 21:58:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DB0DE1C06FE;
        Tue, 19 May 2020 21:58:33 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:33 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert Bounds exception to IDTENTRY
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134904.863001309@linutronix.de>
References: <20200505134904.863001309@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831377.17951.3400502875321725723.tip-bot2@tip-bot2>
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

Commit-ID:     e98b41399cb15d8e52e266b53e32f1362f541daf
Gitweb:        https://git.kernel.org/tip/e98b41399cb15d8e52e266b53e32f1362f541daf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:58 +02:00

x86/entry: Convert Bounds exception to IDTENTRY

Convert #BR to IDTENTRY:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototypes
  - Remove the RCU warning as the new entry macro ensures correctness

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134904.863001309@linutronix.de



---
 arch/x86/entry/entry_32.S       |  7 -------
 arch/x86/entry/entry_64.S       |  1 -
 arch/x86/include/asm/idtentry.h |  1 +
 arch/x86/include/asm/traps.h    |  3 ---
 arch/x86/kernel/idt.c           |  2 +-
 arch/x86/kernel/traps.c         |  9 ++++-----
 arch/x86/xen/enlighten_pv.c     |  2 +-
 arch/x86/xen/xen-asm_64.S       |  2 +-
 8 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index e5d57f6..31a64df 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1325,13 +1325,6 @@ SYM_CODE_START(native_iret)
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index eb503b0..a3e484d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1073,7 +1073,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_BR		bounds			do_bounds			has_error_code=0
 idtentry	X86_TRAP_UD		invalid_op		do_invalid_op			has_error_code=0
 idtentry	X86_TRAP_NM		device_not_available	do_device_not_available		has_error_code=0
 idtentry	X86_TRAP_OLD_MF		coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 54c41b3..d7c160b 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -79,5 +79,6 @@ static __always_inline void __##func(struct pt_regs *regs)
 /* Simple exception entry points. No hardware error code */
 DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
 DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overflow);
+DECLARE_IDTENTRY(X86_TRAP_BR,		exc_bounds);
 
 #endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 1b0452c..73fe4eb 100644
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
@@ -39,7 +38,6 @@ asmlinkage void simd_coprocessor_error(void);
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
-asmlinkage void xen_bounds(void);
 asmlinkage void xen_invalid_op(void);
 asmlinkage void xen_device_not_available(void);
 asmlinkage void xen_double_fault(void);
@@ -61,7 +59,6 @@ asmlinkage void xen_simd_coprocessor_error(void);
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
-dotraplinkage void do_bounds(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
 dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index f8d7962..87583b6 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -75,7 +75,7 @@ static const __initconst struct idt_data early_idts[] = {
 static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_DE,		asm_exc_divide_error),
 	INTG(X86_TRAP_NMI,		nmi),
-	INTG(X86_TRAP_BR,		bounds),
+	INTG(X86_TRAP_BR,		asm_exc_bounds),
 	INTG(X86_TRAP_UD,		invalid_op),
 	INTG(X86_TRAP_NM,		device_not_available),
 	INTG(X86_TRAP_OLD_MF,		coprocessor_segment_overrun),
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index b522e2a..7a9fb8b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -410,18 +410,17 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 	panic("Machine halted.");
 }
 
-dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY(exc_bounds)
 {
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
-	if (notify_die(DIE_TRAP, "bounds", regs, error_code,
+	if (notify_die(DIE_TRAP, "bounds", regs, 0,
 			X86_TRAP_BR, SIGSEGV) == NOTIFY_STOP)
 		return;
 	cond_local_irq_enable(regs);
 
 	if (!user_mode(regs))
-		die("bounds", regs, error_code);
+		die("bounds", regs, 0);
 
-	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
+	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, 0, 0, NULL);
 
 	cond_local_irq_disable(regs);
 }
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index f5487e5..dfb4baa 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -624,7 +624,7 @@ static struct trap_array_entry trap_array[] = {
 #endif
 	{ page_fault,                  xen_page_fault,                  false },
 	TRAP_ENTRY(exc_divide_error,			false ),
-	{ bounds,                      xen_bounds,                      false },
+	TRAP_ENTRY(exc_bounds,				false ),
 	{ invalid_op,                  xen_invalid_op,                  false },
 	{ device_not_available,        xen_device_not_available,        false },
 	{ coprocessor_segment_overrun, xen_coprocessor_segment_overrun, false },
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index c9c86a0..2cdbf6a 100644
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
