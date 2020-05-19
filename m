Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B5B208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgEST7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgEST6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A625C08C5C0;
        Tue, 19 May 2020 12:58:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Ny-0008QN-Mg; Tue, 19 May 2020 21:58:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D949B1C081A;
        Tue, 19 May 2020 21:58:34 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:34 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert Divide Error to IDTENTRY
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134904.663914713@linutronix.de>
References: <20200505134904.663914713@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831479.17951.17390452716048622271.tip-bot2@tip-bot2>
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

Commit-ID:     4b1250ee34e648302449214eb86235ce1d94ea17
Gitweb:        https://git.kernel.org/tip/4b1250ee34e648302449214eb86235ce1d94ea17
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:57 +02:00

x86/entry: Convert Divide Error to IDTENTRY

Convert #DE to IDTENTRY:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134904.663914713@linutronix.de


---
 arch/x86/entry/entry_32.S       |  7 -------
 arch/x86/entry/entry_64.S       |  1 -
 arch/x86/include/asm/idtentry.h | 12 ++++++++++++
 arch/x86/include/asm/traps.h    |  3 ---
 arch/x86/kernel/idt.c           |  2 +-
 arch/x86/kernel/traps.c         |  7 ++++++-
 arch/x86/xen/enlighten_pv.c     |  7 ++++++-
 arch/x86/xen/xen-asm_64.S       |  2 +-
 8 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 8c0e07e..398fd3c 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1377,13 +1377,6 @@ SYM_CODE_START(alignment_check)
 	jmp	common_exception
 SYM_CODE_END(alignment_check)
 
-SYM_CODE_START(divide_error)
-	ASM_CLAC
-	pushl	$0				# no error code
-	pushl	$do_divide_error
-	jmp	common_exception
-SYM_CODE_END(divide_error)
-
 #ifdef CONFIG_X86_MCE
 SYM_CODE_START(machine_check)
 	ASM_CLAC
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ee07162..e18594d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1072,7 +1072,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_DE		divide_error		do_divide_error			has_error_code=0
 idtentry	X86_TRAP_OF		overflow		do_overflow			has_error_code=0
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
 idtentry	X86_TRAP_BR		bounds			do_bounds			has_error_code=0
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 2adfd80..e6f6e29 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -67,4 +67,16 @@ static __always_inline void __##func(struct pt_regs *regs)
 
 #endif /* __ASSEMBLY__ */
 
+/*
+ * The actual entry points. Note that DECLARE_IDTENTRY*() serves two
+ * purposes:
+ *  - provide the function declarations when included from C-Code
+ *  - emit the ASM stubs when included from entry_32/64.S
+ *
+ * This avoids duplicate defines and ensures that everything is consistent.
+ */
+
+/* Simple exception entry points. No hardware error code */
+DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
+
 #endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 814273f..e68cbf8 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -11,7 +11,6 @@
 
 #define dotraplinkage __visible
 
-asmlinkage void divide_error(void);
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
 asmlinkage void int3(void);
@@ -38,7 +37,6 @@ asmlinkage void machine_check(void);
 asmlinkage void simd_coprocessor_error(void);
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
-asmlinkage void xen_divide_error(void);
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
@@ -62,7 +60,6 @@ asmlinkage void xen_machine_check(void);
 asmlinkage void xen_simd_coprocessor_error(void);
 #endif
 
-dotraplinkage void do_divide_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 95609ee..f2a751b 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -73,7 +73,7 @@ static const __initconst struct idt_data early_idts[] = {
  * set up TSS.
  */
 static const __initconst struct idt_data def_idts[] = {
-	INTG(X86_TRAP_DE,		divide_error),
+	INTG(X86_TRAP_DE,		asm_exc_divide_error),
 	INTG(X86_TRAP_NMI,		nmi),
 	INTG(X86_TRAP_BR,		bounds),
 	INTG(X86_TRAP_UD,		invalid_op),
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3857c0f..37092f7 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -220,6 +220,12 @@ static __always_inline void __user *error_get_trap_addr(struct pt_regs *regs)
 	return (void __user *)uprobe_get_trap_addr(regs);
 }
 
+DEFINE_IDTENTRY(exc_divide_error)
+{
+	do_error_trap(regs, 0, "divide_error", X86_TRAP_DE, SIGFPE,
+		      FPE_INTDIV, error_get_trap_addr(regs));
+}
+
 #define IP ((void __user *)uprobe_get_trap_addr(regs))
 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
 dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
@@ -227,7 +233,6 @@ dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
 
-DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
 DO_ERROR(X86_TRAP_OF,     SIGSEGV,          0, NULL, "overflow",            overflow)
 DO_ERROR(X86_TRAP_UD,     SIGILL,  ILL_ILLOPN,   IP, "invalid opcode",      invalid_op)
 DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overrun", coprocessor_segment_overrun)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 507f4fb..c2fe7b6 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -605,6 +605,11 @@ struct trap_array_entry {
 	bool ist_okay;
 };
 
+#define TRAP_ENTRY(func, ist_ok) {			\
+	.orig		= asm_##func,			\
+	.xen		= xen_asm_##func,		\
+	.ist_okay	= ist_ok }
+
 static struct trap_array_entry trap_array[] = {
 	{ debug,                       xen_xendebug,                    true },
 	{ double_fault,                xen_double_fault,                true },
@@ -618,7 +623,7 @@ static struct trap_array_entry trap_array[] = {
 	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
 #endif
 	{ page_fault,                  xen_page_fault,                  false },
-	{ divide_error,                xen_divide_error,                false },
+	TRAP_ENTRY(exc_divide_error,			false ),
 	{ bounds,                      xen_bounds,                      false },
 	{ invalid_op,                  xen_invalid_op,                  false },
 	{ device_not_available,        xen_device_not_available,        false },
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 0a0fd16..48ac67e 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -28,7 +28,7 @@ SYM_CODE_END(xen_\name)
 _ASM_NOKPROBE(xen_\name)
 .endm
 
-xen_pv_trap divide_error
+xen_pv_trap asm_exc_divide_error
 xen_pv_trap debug
 xen_pv_trap xendebug
 xen_pv_trap int3
