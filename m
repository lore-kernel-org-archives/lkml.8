Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF90C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152E820826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgESUB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgEST6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582FFC08C5C1;
        Tue, 19 May 2020 12:58:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8No-0008I8-Ir; Tue, 19 May 2020 21:58:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 06D5A1C06DA;
        Tue, 19 May 2020 21:58:28 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:27 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Convert IRET exception to IDTENTRY_SW
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134906.128769226@linutronix.de>
References: <20200505134906.128769226@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830791.17951.9234236070392744978.tip-bot2@tip-bot2>
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

Commit-ID:     db300565d865092ee8a372a6bd15eb2764ec85ab
Gitweb:        https://git.kernel.org/tip/db300565d865092ee8a372a6bd15eb2764ec85ab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:04 +02:00

x86/entry/32: Convert IRET exception to IDTENTRY_SW

Convert the IRET exception handler to IDTENTRY_SW. This is slightly
different than the conversions of hardware exceptions as the IRET exception
is invoked via an exception table when IRET faults. So it just uses the
IDTENTRY_SW mechanism for consistency. It does not emit ASM code as it does
not fit the other idtentry exceptions.

  - Implement the C entry point with DEFINE_IDTENTRY_SW() which maps to
    DEFINE_IDTENTRY()
  - Fixup the XEN/PV code
  - Remove the old prototypes
  - Remove the RCU warning as the new entry macro ensures correctness

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134906.128769226@linutronix.de


---
 arch/x86/entry/entry_32.S       | 14 +++++++-------
 arch/x86/include/asm/idtentry.h | 10 ++++++++++
 arch/x86/include/asm/traps.h    |  3 ---
 arch/x86/kernel/traps.c         |  8 +++-----
 arch/x86/xen/xen-asm_32.S       |  2 +-
 5 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index c93fb73..f7a5f1c 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1147,9 +1147,9 @@ restore_all_kernel:
 	jmp	.Lirq_return
 
 .section .fixup, "ax"
-SYM_CODE_START(iret_exc)
+SYM_CODE_START(asm_iret_error)
 	pushl	$0				# no error code
-	pushl	$do_iret_error
+	pushl	$iret_error
 
 #ifdef CONFIG_DEBUG_ENTRY
 	/*
@@ -1163,10 +1163,10 @@ SYM_CODE_START(iret_exc)
 	popl	%eax
 #endif
 
-	jmp	common_exception
-SYM_CODE_END(iret_exc)
+	jmp	handle_exception
+SYM_CODE_END(asm_iret_error)
 .previous
-	_ASM_EXTABLE(.Lirq_return, iret_exc)
+	_ASM_EXTABLE(.Lirq_return, asm_iret_error)
 SYM_FUNC_END(entry_INT80_32)
 
 .macro FIXUP_ESPFIX_STACK
@@ -1293,7 +1293,7 @@ SYM_FUNC_END(name)
 #ifdef CONFIG_PARAVIRT
 SYM_CODE_START(native_iret)
 	iret
-	_ASM_EXTABLE(native_iret, iret_exc)
+	_ASM_EXTABLE(native_iret, asm_iret_error)
 SYM_CODE_END(native_iret)
 #endif
 
@@ -1358,7 +1358,7 @@ SYM_FUNC_START(xen_failsafe_callback)
 	popl	%eax
 	lea	16(%esp), %esp
 	jz	5f
-	jmp	iret_exc
+	jmp	asm_iret_error
 5:	pushl	$-1				/* orig_ax = -1 => not a system call */
 	SAVE_ALL
 	ENCODE_FRAME_POINTER
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 99d4759..ee6ebfe 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -57,6 +57,10 @@ __visible noinstr void func(struct pt_regs *regs)			\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
 
+/* Special case for 32bit IRET 'trap' */
+#define DECLARE_IDTENTRY_SW	DECLARE_IDTENTRY
+#define DEFINE_IDTENTRY_SW	DEFINE_IDTENTRY
+
 /**
  * DECLARE_IDTENTRY_ERRORCODE - Declare functions for simple IDT entry points
  *				Error code pushed by hardware
@@ -111,6 +115,9 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
 	idtentry vector asm_##func func has_error_code=1 sane=1
 
+/* Special case for 32bit IRET 'trap'. Do not emit ASM code */
+#define DECLARE_IDTENTRY_SW(vector, func)
+
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -133,6 +140,9 @@ DECLARE_IDTENTRY(X86_TRAP_SPURIOUS,	exc_spurious_interrupt_bug);
 DECLARE_IDTENTRY(X86_TRAP_MF,		exc_coprocessor_error);
 DECLARE_IDTENTRY(X86_TRAP_XF,		exc_simd_coprocessor_error);
 
+/* 32bit software IRET trap. Do not emit ASM code */
+DECLARE_IDTENTRY_SW(X86_TRAP_IRET,	iret_error);
+
 /* Simple exception entries with error code pushed by hardware */
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_NP,	exc_segment_not_present);
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index e7eb753..5774d0b 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -39,9 +39,6 @@ dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-#ifdef CONFIG_X86_32
-dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
-#endif
 dotraplinkage void do_mce(struct pt_regs *regs, long error_code);
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1702922..b28a64d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -925,14 +925,12 @@ DEFINE_IDTENTRY(exc_device_not_available)
 }
 
 #ifdef CONFIG_X86_32
-dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_SW(iret_error)
 {
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	local_irq_enable();
-
-	if (notify_die(DIE_TRAP, "iret exception", regs, error_code,
+	if (notify_die(DIE_TRAP, "iret exception", regs, 0,
 			X86_TRAP_IRET, SIGILL) != NOTIFY_STOP) {
-		do_trap(X86_TRAP_IRET, SIGILL, "iret exception", regs, error_code,
+		do_trap(X86_TRAP_IRET, SIGILL, "iret exception", regs, 0,
 			ILL_BADSTK, (void __user *)NULL);
 	}
 	local_irq_disable();
diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
index 2712e91..812ff01 100644
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -117,7 +117,7 @@ iret_restore_end:
 
 1:	iret
 xen_iret_end_crit:
-	_ASM_EXTABLE(1b, iret_exc)
+	_ASM_EXTABLE(1b, asm_iret_error)
 
 hyper_iret:
 	/* put this out of line since its very rarely used */
