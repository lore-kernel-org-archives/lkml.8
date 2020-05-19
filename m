Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5639BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3006020826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgESUCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgEST6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3303C08C5C1;
        Tue, 19 May 2020 12:58:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Ni-0008En-Q8; Tue, 19 May 2020 21:58:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 422E71C04D1;
        Tue, 19 May 2020 21:58:25 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:25 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert INT3 exception to IDTENTRY_RAW
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135313.938474960@linutronix.de>
References: <20200505135313.938474960@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830515.17951.16465298132644603014.tip-bot2@tip-bot2>
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

Commit-ID:     3512eab9b00ac8bd3930222233847677dc3b7592
Gitweb:        https://git.kernel.org/tip/3512eab9b00ac8bd3930222233847677dc3b7592
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:06 +02:00

x86/entry: Convert INT3 exception to IDTENTRY_RAW

Convert #BP to IDTENTRY_RAW:
  - Implement the C entry point with DEFINE_IDTENTRY_RAW
  - Invoke idtentry_enter/exit() from the function body
  - Emit the ASM stub with DECLARE_IDTENTRY_RAW
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototypes

No functional change.

This could be a plain IDTENTRY, but as Peter pointed out INT3 is broken
vs. the static key in the context tracking code as this static key might be
in the state of being patched and has an int3 which would recurse forever.
IDTENTRY_RAW is therefore chosen to allow addressing this issue without
lots of code churn.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135313.938474960@linutronix.de



---
 arch/x86/entry/entry_32.S       |  7 -------
 arch/x86/entry/entry_64.S       |  2 --
 arch/x86/include/asm/idtentry.h |  3 +++
 arch/x86/include/asm/traps.h    |  3 ---
 arch/x86/kernel/idt.c           |  2 +-
 arch/x86/kernel/traps.c         | 28 +++++++++++++++++-----------
 arch/x86/xen/enlighten_pv.c     |  2 +-
 arch/x86/xen/xen-asm_64.S       |  2 +-
 8 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index f7a5f1c..b9b0ddb 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1649,13 +1649,6 @@ SYM_CODE_START(nmi)
 #endif
 SYM_CODE_END(nmi)
 
-SYM_CODE_START(int3)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_int3
-	jmp	common_exception
-SYM_CODE_END(int3)
-
 .pushsection .text, "ax"
 SYM_CODE_START(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1bada7b..69ddd05 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1072,8 +1072,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
 #ifdef CONFIG_X86_MCE
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 2f31d03..3dc4d5b 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -181,4 +181,7 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 
+/* Raw exception entries which need extra work */
+DECLARE_IDTENTRY_RAW(X86_TRAP_BP,	exc_int3);
+
 #endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 5774d0b..698285a 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -13,7 +13,6 @@
 
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
-asmlinkage void int3(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
@@ -26,7 +25,6 @@ asmlinkage void machine_check(void);
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
-asmlinkage void xen_int3(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
 #ifdef CONFIG_X86_MCE
@@ -36,7 +34,6 @@ asmlinkage void xen_machine_check(void);
 
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
-dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_mce(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 38b565b..9ca8af6 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -60,7 +60,7 @@ static bool idt_setup_done __initdata;
  */
 static const __initconst struct idt_data early_idts[] = {
 	INTG(X86_TRAP_DB,		debug),
-	SYSG(X86_TRAP_BP,		int3),
+	SYSG(X86_TRAP_BP,		asm_exc_int3),
 #ifdef CONFIG_X86_32
 	INTG(X86_TRAP_PF,		page_fault),
 #endif
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 280c290..0ad12df 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -568,7 +568,7 @@ exit:
 	cond_local_irq_disable(regs);
 }
 
-dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_RAW(exc_int3)
 {
 	/*
 	 * poke_int3_handler() is completely self contained code; it does (and
@@ -579,16 +579,20 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 		return;
 
 	/*
-	 * Unlike any other non-IST entry, we can be called from pretty much
-	 * any location in the kernel through kprobes -- text_poke() will most
-	 * likely be handled by poke_int3_handler() above. This means this
-	 * handler is effectively NMI-like.
+	 * idtentry_enter() uses static_branch_{,un}likely() and therefore
+	 * can trigger INT3, hence poke_int3_handler() must be done
+	 * before. If the entry came from kernel mode, then use nmi_enter()
+	 * because the INT3 could have been hit in any context including
+	 * NMI.
 	 */
-	if (!user_mode(regs))
+	if (user_mode(regs))
+		idtentry_enter(regs);
+	else
 		nmi_enter();
 
+	instrumentation_begin();
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
-	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
+	if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
 				SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 #endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
@@ -598,19 +602,21 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
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
-	if (!user_mode(regs))
+	instrumentation_end();
+	if (user_mode(regs))
+		idtentry_exit(regs);
+	else
 		nmi_exit();
 }
-NOKPROBE_SYMBOL(do_int3);
 
 #ifdef CONFIG_X86_64
 /*
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c41152b..725d550 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -617,7 +617,7 @@ static struct trap_array_entry trap_array[] = {
 	{ machine_check,               xen_machine_check,               true },
 #endif
 	{ nmi,                         xen_xennmi,                      true },
-	{ int3,                        xen_int3,                        false },
+	TRAP_ENTRY(exc_int3,				false ),
 	TRAP_ENTRY(exc_overflow,			false ),
 #ifdef CONFIG_IA32_EMULATION
 	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 6a91157..44f5556 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -31,7 +31,7 @@ _ASM_NOKPROBE(xen_\name)
 xen_pv_trap asm_exc_divide_error
 xen_pv_trap debug
 xen_pv_trap xendebug
-xen_pv_trap int3
+xen_pv_trap asm_exc_int3
 xen_pv_trap xennmi
 xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds
