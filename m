Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9387EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AC020870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795799;
	bh=iEVSiueHx8hRTKGU2aYul8Ihtzr+i0DjLBeiRFigHCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ftrvsx8sUIUzMzVzRIroBtJXC2N6g+FLnn9Fex9K5awn8OR3v304JKLoxy2oKTf8O
	 Hb89oCrxYr1YSXUINNutbB+rf0y4KCn0ONnGh/XbK/BDbdgu7fscNNs+uV5KVO4ZmV
	 y76B3W/DbiokKvdmmSoLJtHroQ457bkqW9Lq24fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGCRDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgGCRDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:03:04 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97CF720B80;
        Fri,  3 Jul 2020 17:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795783;
        bh=iEVSiueHx8hRTKGU2aYul8Ihtzr+i0DjLBeiRFigHCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StLsy4QfTu4HJxEsGEa9Nfex0JwA/9oN2v8WdBL4mbex3ARyqWXh5yZP5q0IgaOvP
         pkbMjLonXyS369xQ77THjCO4RRDdA8oIY57Zr6clSgYWehNhtvVVdB1vrC574Oizz6
         XbGvRp+SWbj1RcHBD8LFg0Am9Jx7mzE6HatFzFiw=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH entry v2 3/6] x86/entry/xen: Route #DB correctly on Xen PV
Date:   Fri,  3 Jul 2020 10:02:55 -0700
Message-Id: <4163e733cce0b41658e252c6c6b3464f33fdff17.1593795633.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593795633.git.luto@kernel.org>
References: <cover.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Xen PV, #DB doesn't use IST.  We still need to correctly route it
depending on whether it came from user or kernel mode.

This patch gets rid of DECLARE/DEFINE_IDTENTRY_XEN -- it was too
hard to follow the logic.  Instead, route #DB and NMI through
DECLARE/DEFINE_IDTENTRY_RAW on Xen, and do the right thing for #DB.
Also add more warnings to the exc_debug* handlers to make this type
of failure more obvious.

This fixes various forms of corruption that happen when usermode
triggers #DB on Xen PV.

Fixes: 4c0dcd8350a0 ("x86/entry: Implement user mode C entry points for #DB and #MCE")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/idtentry.h | 24 ++++++------------------
 arch/x86/kernel/traps.c         | 12 ++++++++++++
 arch/x86/xen/enlighten_pv.c     | 28 ++++++++++++++++++++++++----
 arch/x86/xen/xen-asm_64.S       |  5 ++---
 4 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index cf51c50eb356..94333ac3092b 100644
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
index f9727b96961f..c17f9b57171f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -865,6 +865,12 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
 
+	/*
+	 * If something gets miswired and we end up here for a user mode
+	 * #DB, we will malfunction.
+	 */
+	WARN_ON_ONCE(user_mode(regs));
+
 	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
 	 * watchpoint at the same time then that will still be handled.
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
index acc49fa6a097..0d68948c82ad 100644
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
index e1e1c7eafa60..aab1d99b2b48 100644
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
-- 
2.25.4

