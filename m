Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BBBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21DE20849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgESUBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgEST6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C577C08C5C0;
        Tue, 19 May 2020 12:58:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Np-0008Ml-80; Tue, 19 May 2020 21:58:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B4EF71C047E;
        Tue, 19 May 2020 21:58:31 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:31 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert Invalid TSS exception to IDTENTRY
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134905.350676449@linutronix.de>
References: <20200505134905.350676449@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831154.17951.4743024430282923932.tip-bot2@tip-bot2>
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

Commit-ID:     87a9c4feaa8a5e219462c3e54fa6b39d9ccc03db
Gitweb:        https://git.kernel.org/tip/87a9c4feaa8a5e219462c3e54fa6b39d9ccc03db
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:00 +02:00

x86/entry: Convert Invalid TSS exception to IDTENTRY

Convert #TS to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134905.350676449@linutronix.de



---
 arch/x86/entry/entry_32.S       | 6 ------
 arch/x86/entry/entry_64.S       | 1 -
 arch/x86/include/asm/idtentry.h | 3 +++
 arch/x86/include/asm/traps.h    | 3 ---
 arch/x86/kernel/idt.c           | 2 +-
 arch/x86/kernel/traps.c         | 7 ++++++-
 arch/x86/xen/enlighten_pv.c     | 2 +-
 arch/x86/xen/xen-asm_64.S       | 2 +-
 8 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 916ce82..2143a62 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1318,12 +1318,6 @@ SYM_CODE_START(native_iret)
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 423c3a9..07307cf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1073,7 +1073,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_TS		invalid_TSS		do_invalid_TSS			has_error_code=1
 idtentry	X86_TRAP_NP		segment_not_present	do_segment_not_present		has_error_code=1
 idtentry	X86_TRAP_SS		stack_segment		do_stack_segment		has_error_code=1
 idtentry	X86_TRAP_GP		general_protection	do_general_protection		has_error_code=1
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f35d5c9..aa0d465 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -130,4 +130,7 @@ DECLARE_IDTENTRY(X86_TRAP_UD,		exc_invalid_op);
 DECLARE_IDTENTRY(X86_TRAP_NM,		exc_device_not_available);
 DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_coproc_segment_overrun);
 
+/* Simple exception entries with error code pushed by hardware */
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
+
 #endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 5e9d402..30bc589 100644
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
@@ -54,7 +52,6 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
-dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
 dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
 dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 758d325..caa740d 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -79,7 +79,7 @@ static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
 	INTG(X86_TRAP_NM,		asm_exc_device_not_available),
 	INTG(X86_TRAP_OLD_MF,		asm_exc_coproc_segment_overrun),
-	INTG(X86_TRAP_TS,		invalid_TSS),
+	INTG(X86_TRAP_TS,		asm_exc_invalid_tss),
 	INTG(X86_TRAP_NP,		segment_not_present),
 	INTG(X86_TRAP_SS,		stack_segment),
 	INTG(X86_TRAP_GP,		general_protection),
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3ce1f66..10ab083 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -252,6 +252,12 @@ DEFINE_IDTENTRY(exc_coproc_segment_overrun)
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
@@ -259,7 +265,6 @@ dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
 
-DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
 #undef IP
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index a3bfc1f..2ed7d2f 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -628,7 +628,7 @@ static struct trap_array_entry trap_array[] = {
 	TRAP_ENTRY(exc_invalid_op,			false ),
 	TRAP_ENTRY(exc_device_not_available,		false ),
 	TRAP_ENTRY(exc_coproc_segment_overrun,		false ),
-	{ invalid_TSS,                 xen_invalid_TSS,                 false },
+	TRAP_ENTRY(exc_invalid_tss,			false ),
 	{ segment_not_present,         xen_segment_not_present,         false },
 	{ stack_segment,               xen_stack_segment,               false },
 	{ general_protection,          xen_general_protection,          false },
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 7ac9c26..f7a890c 100644
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
