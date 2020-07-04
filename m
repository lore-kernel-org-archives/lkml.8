Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4D8C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4D42070B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PumsAjBR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yb2LA+YB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgGDRtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 13:49:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40548 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgGDRtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 13:49:13 -0400
Date:   Sat, 04 Jul 2020 17:49:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593884950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpLP0mh+Au9bFNc6nKf4AsXTb4Yu473K/TjbX/v+joM=;
        b=PumsAjBR+KBvLfpvTX4prg6D2YAwbZDt53dcN8cVasdwkzJ1sEKR1AVT2fdogrIddcy8YH
        +rDHI5MB0icbUW7dNgTcH4BMuimkXgshkJH4DD3Q3P7yYKmDbPKyo0Lgb1ZPHmtMW60z+6
        qiI/WB44rYLiDwTrWI15BaydnUPVDsGBnzHmq98Q+29mGhkW4CMHJndrYS5TcL1e6VVWmx
        qIRHseoNOIExe1DgYll605H/coTZSrQyL3AEO7pt5sgVEj+6Pq2i/JjJOKLHrnqRZ9mUrM
        OGWpJI3mWJEtmQBOsI25iQ80pGV/+o0s3ui8seCgHdgGGPZaEs6EV4BphVnFfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593884950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpLP0mh+Au9bFNc6nKf4AsXTb4Yu473K/TjbX/v+joM=;
        b=yb2LA+YBz5v0a+AGNqAo0+RWP1UE8ysH6G+FWH3kNSsXnXczWAPH2uvaI/r0NOn6InaSpq
        +/1SLZwKwczedhBA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/xen: Route #DB correctly on Xen PV
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4163e733cce0b41658e252c6c6b3464f33fdff17.1593795633.git.luto@kernel.org>
References: <4163e733cce0b41658e252c6c6b3464f33fdff17.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159388494977.4006.13168066916301921485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f41f0824224eb12ad84de8972962dd54be5abe3b
Gitweb:        https://git.kernel.org/tip/f41f0824224eb12ad84de8972962dd54be5abe3b
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 03 Jul 2020 10:02:55 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 04 Jul 2020 19:47:25 +02:00

x86/entry/xen: Route #DB correctly on Xen PV

On Xen PV, #DB doesn't use IST. It still needs to be correctly routed
depending on whether it came from user or kernel mode.

Get rid of DECLARE/DEFINE_IDTENTRY_XEN -- it was too hard to follow the
logic.  Instead, route #DB and NMI through DECLARE/DEFINE_IDTENTRY_RAW on
Xen, and do the right thing for #DB.  Also add more warnings to the
exc_debug* handlers to make this type of failure more obvious.

This fixes various forms of corruption that happen when usermode
triggers #DB on Xen PV.

Fixes: 4c0dcd8350a0 ("x86/entry: Implement user mode C entry points for #DB and #MCE")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/4163e733cce0b41658e252c6c6b3464f33fdff17.1593795633.git.luto@kernel.org

---
 arch/x86/include/asm/idtentry.h | 24 ++++++------------------
 arch/x86/kernel/traps.c         | 12 ++++++++++++
 arch/x86/xen/enlighten_pv.c     | 28 ++++++++++++++++++++++++----
 arch/x86/xen/xen-asm_64.S       |  5 ++---
 4 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index cf51c50..94333ac 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -398,18 +398,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG_USER	DEFINE_IDTENTRY_NOIST
 
-/**
- * DECLARE_IDTENTRY_XEN - Declare functions for XEN redirect IDT entry points
- * @vector:	Vector number (ignored for C)
- * @func:	Function name of the entry point
- *
- * Used for xennmi and xendebug redirections. No DEFINE as this is all ASM
- * indirection magic.
- */
-#define DECLARE_IDTENTRY_XEN(vector, func)				\
-	asmlinkage void xen_asm_exc_xen##func(void);			\
-	asmlinkage void asm_exc_xen##func(void)
-
 #else /* !__ASSEMBLY__ */
 
 /*
@@ -469,10 +457,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
 /* No ASM code emitted for NMI */
 #define DECLARE_IDTENTRY_NMI(vector, func)
 
-/* XEN NMI and DB wrapper */
-#define DECLARE_IDTENTRY_XEN(vector, func)				\
-	idtentry vector asm_exc_xen##func exc_##func has_error_code=0
-
 /*
  * ASM code to emit the common vector entry stubs where each stub is
  * packed into 8 bytes.
@@ -570,11 +554,15 @@ DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
 
 /* NMI */
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
-DECLARE_IDTENTRY_XEN(X86_TRAP_NMI,	nmi);
+#ifdef CONFIG_XEN_PV
+DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);
+#endif
 
 /* #DB */
 DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
-DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug);
+#ifdef CONFIG_XEN_PV
+DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	xenpv_exc_debug);
+#endif
 
 /* #DF */
 DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f9727b9..c17f9b5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -866,6 +866,12 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	trace_hardirqs_off_finish();
 
 	/*
+	 * If something gets miswired and we end up here for a user mode
+	 * #DB, we will malfunction.
+	 */
+	WARN_ON_ONCE(user_mode(regs));
+
+	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
 	 * watchpoint at the same time then that will still be handled.
 	 */
@@ -883,6 +889,12 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 static __always_inline void exc_debug_user(struct pt_regs *regs,
 					   unsigned long dr6)
 {
+	/*
+	 * If something gets miswired and we end up here for a kernel mode
+	 * #DB, we will malfunction.
+	 */
+	WARN_ON_ONCE(!user_mode(regs));
+
 	idtentry_enter_user(regs);
 	instrumentation_begin();
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index acc49fa..0d68948 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -598,6 +598,26 @@ static void xen_write_ldt_entry(struct desc_struct *dt, int entrynum,
 }
 
 #ifdef CONFIG_X86_64
+void noist_exc_debug(struct pt_regs *regs);
+
+DEFINE_IDTENTRY_RAW(xenpv_exc_nmi)
+{
+	/* On Xen PV, NMI doesn't use IST.  The C part is the sane as native. */
+	exc_nmi(regs);
+}
+
+DEFINE_IDTENTRY_RAW(xenpv_exc_debug)
+{
+	/*
+	 * There's no IST on Xen PV, but we still need to dispatch
+	 * to the correct handler.
+	 */
+	if (user_mode(regs))
+		noist_exc_debug(regs);
+	else
+		exc_debug(regs);
+}
+
 struct trap_array_entry {
 	void (*orig)(void);
 	void (*xen)(void);
@@ -609,18 +629,18 @@ struct trap_array_entry {
 	.xen		= xen_asm_##func,		\
 	.ist_okay	= ist_ok }
 
-#define TRAP_ENTRY_REDIR(func, xenfunc, ist_ok) {	\
+#define TRAP_ENTRY_REDIR(func, ist_ok) {		\
 	.orig		= asm_##func,			\
-	.xen		= xen_asm_##xenfunc,		\
+	.xen		= xen_asm_xenpv_##func,		\
 	.ist_okay	= ist_ok }
 
 static struct trap_array_entry trap_array[] = {
-	TRAP_ENTRY_REDIR(exc_debug, exc_xendebug,	true  ),
+	TRAP_ENTRY_REDIR(exc_debug,			true  ),
 	TRAP_ENTRY(exc_double_fault,			true  ),
 #ifdef CONFIG_X86_MCE
 	TRAP_ENTRY(exc_machine_check,			true  ),
 #endif
-	TRAP_ENTRY_REDIR(exc_nmi, exc_xennmi,		true  ),
+	TRAP_ENTRY_REDIR(exc_nmi,			true  ),
 	TRAP_ENTRY(exc_int3,				false ),
 	TRAP_ENTRY(exc_overflow,			false ),
 #ifdef CONFIG_IA32_EMULATION
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index e1e1c7e..aab1d99 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -29,10 +29,9 @@ _ASM_NOKPROBE(xen_\name)
 .endm
 
 xen_pv_trap asm_exc_divide_error
-xen_pv_trap asm_exc_debug
-xen_pv_trap asm_exc_xendebug
+xen_pv_trap asm_xenpv_exc_debug
 xen_pv_trap asm_exc_int3
-xen_pv_trap asm_exc_xennmi
+xen_pv_trap asm_xenpv_exc_nmi
 xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds
 xen_pv_trap asm_exc_invalid_op
