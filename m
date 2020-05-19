Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48442C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205D420849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgESUBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgEST6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29F0C08C5C0;
        Tue, 19 May 2020 12:58:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8No-0008LZ-Rh; Tue, 19 May 2020 21:58:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AE0E91C0837;
        Tue, 19 May 2020 21:58:30 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert Stack segment exception to IDTENTRY
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134905.539867572@linutronix.de>
References: <20200505134905.539867572@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831061.17951.221177603269494302.tip-bot2@tip-bot2>
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

Commit-ID:     24e4d217ea653837567c4763fa465d28d1422e63
Gitweb:        https://git.kernel.org/tip/24e4d217ea653837567c4763fa465d28d1422e63
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:01 +02:00

x86/entry: Convert Stack segment exception to IDTENTRY

Convert #SS to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134905.539867572@linutronix.de



---
 arch/x86/entry/entry_32.S       |  6 ------
 arch/x86/entry/entry_64.S       |  1 -
 arch/x86/include/asm/idtentry.h |  1 +
 arch/x86/include/asm/traps.h    |  3 ---
 arch/x86/kernel/idt.c           |  2 +-
 arch/x86/kernel/traps.c         | 12 ++++--------
 arch/x86/xen/enlighten_pv.c     |  2 +-
 arch/x86/xen/xen-asm_64.S       |  2 +-
 8 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index b01dbb3..ffe43d2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1318,12 +1318,6 @@ SYM_CODE_START(native_iret)
 SYM_CODE_END(native_iret)
 #endif
 
-SYM_CODE_START(stack_segment)
-	ASM_CLAC
-	pushl	$do_stack_segment
-	jmp	common_exception
-SYM_CODE_END(stack_segment)
-
 SYM_CODE_START(alignment_check)
 	ASM_CLAC
 	pushl	$do_alignment_check
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 367a207..c92592d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1073,7 +1073,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_SS		stack_segment		do_stack_segment		has_error_code=1
 idtentry	X86_TRAP_GP		general_protection	do_general_protection		has_error_code=1
 idtentry	X86_TRAP_SPURIOUS	spurious_interrupt_bug	do_spurious_interrupt_bug	has_error_code=0
 idtentry	X86_TRAP_MF		coprocessor_error	do_coprocessor_error		has_error_code=0
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index d517c09..4c0abd3 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -133,5 +133,6 @@ DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_coproc_segment_overrun);
 /* Simple exception entries with error code pushed by hardware */
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_NP,	exc_segment_not_present);
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
 
 #endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 970c888..5e580ff 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -17,7 +17,6 @@ asmlinkage void int3(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
-asmlinkage void stack_segment(void);
 asmlinkage void general_protection(void);
 asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
@@ -34,7 +33,6 @@ asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
 asmlinkage void xen_double_fault(void);
-asmlinkage void xen_stack_segment(void);
 asmlinkage void xen_general_protection(void);
 asmlinkage void xen_page_fault(void);
 asmlinkage void xen_spurious_interrupt_bug(void);
@@ -50,7 +48,6 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
-dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index b9acc7f..8d95cbf 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -81,7 +81,7 @@ static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_OLD_MF,		asm_exc_coproc_segment_overrun),
 	INTG(X86_TRAP_TS,		asm_exc_invalid_tss),
 	INTG(X86_TRAP_NP,		asm_exc_segment_not_present),
-	INTG(X86_TRAP_SS,		stack_segment),
+	INTG(X86_TRAP_SS,		asm_exc_stack_segment),
 	INTG(X86_TRAP_GP,		general_protection),
 	INTG(X86_TRAP_SPURIOUS,		spurious_interrupt_bug),
 	INTG(X86_TRAP_MF,		coprocessor_error),
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 88ba5f0..3dfdc4d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -264,16 +264,12 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
 		      SIGBUS, 0, NULL);
 }
 
-#define IP ((void __user *)uprobe_get_trap_addr(regs))
-#define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
-dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
-{									   \
-	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
+DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
+{
+	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
+		      0, NULL);
 }
 
-DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
-#undef IP
-
 dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
 {
 	char *str = "alignment check";
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5437e28..333222a 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -630,7 +630,7 @@ static struct trap_array_entry trap_array[] = {
 	TRAP_ENTRY(exc_coproc_segment_overrun,		false ),
 	TRAP_ENTRY(exc_invalid_tss,			false ),
 	TRAP_ENTRY(exc_segment_not_present,		false ),
-	{ stack_segment,               xen_stack_segment,               false },
+	TRAP_ENTRY(exc_stack_segment,			false ),
 	{ general_protection,          xen_general_protection,          false },
 	{ spurious_interrupt_bug,      xen_spurious_interrupt_bug,      false },
 	{ coprocessor_error,           xen_coprocessor_error,           false },
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index c8ce7ad..0ecc055 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -41,7 +41,7 @@ xen_pv_trap double_fault
 xen_pv_trap asm_exc_coproc_segment_overrun
 xen_pv_trap asm_exc_invalid_tss
 xen_pv_trap asm_exc_segment_not_present
-xen_pv_trap stack_segment
+xen_pv_trap asm_exc_stack_segment
 xen_pv_trap general_protection
 xen_pv_trap page_fault
 xen_pv_trap spurious_interrupt_bug
