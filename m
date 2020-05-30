Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C6C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2526B208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgE3J6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgE3J5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF60C03E969;
        Sat, 30 May 2020 02:57:22 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyEx-0002q9-FR; Sat, 30 May 2020 11:57:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 050501C032F;
        Sat, 30 May 2020 11:57:19 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:18 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Remove DBn stacks
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200529213321.303027161@infradead.org>
References: <20200529213321.303027161@infradead.org>
MIME-Version: 1.0
Message-ID: <159083263889.17951.9557256887639017668.tip-bot2@tip-bot2>
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

Commit-ID:     0f81407e6e4cf7e878f1e5d6423324dbd966acba
Gitweb:        https://git.kernel.org/tip/0f81407e6e4cf7e878f1e5d6423324dbd966acba
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 23:27:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:09 +02:00

x86/entry: Remove DBn stacks

Both #DB itself, as all other IST users (NMI, #MC) now clear DR7 on
entry. Combined with not allowing breakpoints on entry/noinstr/NOKPROBE
text and no single step (EFLAGS.TF) inside the #DB handler should guarantee
no nested #DB.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200529213321.303027161@infradead.org

---
 arch/x86/entry/entry_64.S             | 17 -----------------
 arch/x86/include/asm/cpu_entry_area.h | 12 +++---------
 arch/x86/kernel/asm-offsets_64.c      |  3 ---
 arch/x86/kernel/dumpstack_64.c        |  7 ++-----
 arch/x86/mm/cpu_entry_area.c          |  1 -
 5 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 265ff97..8ecaeee 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -396,11 +396,6 @@ SYM_CODE_END(\asmsym)
 	idtentry \vector asm_\cfunc \cfunc has_error_code=0
 .endm
 
-/*
- * MCE and DB exceptions
- */
-#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
-
 /**
  * idtentry_mce_db - Macro to generate entry stubs for #MC and #DB
  * @vector:		Vector number
@@ -416,10 +411,6 @@ SYM_CODE_END(\asmsym)
  * If hits in kernel mode then it needs to go through the paranoid
  * entry as the exception can hit any random state. No preemption
  * check on exit to keep the paranoid path simple.
- *
- * If the trap is #DB then the interrupt stack entry in the IST is
- * moved to the second stack, so a potential recursion will have a
- * fresh IST.
  */
 .macro idtentry_mce_db vector asmsym cfunc
 SYM_CODE_START(\asmsym)
@@ -445,16 +436,8 @@ SYM_CODE_START(\asmsym)
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
-	.if \vector == X86_TRAP_DB
-		subq	$DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
-	.endif
-
 	call	\cfunc
 
-	.if \vector == X86_TRAP_DB
-		addq	$DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
-	.endif
-
 	jmp	paranoid_exit
 
 	/* Switch to the regular task stack and use the noist entry point */
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 02c0078..8902fdb 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -11,15 +11,11 @@
 #ifdef CONFIG_X86_64
 
 /* Macro to enforce the same ordering and stack sizes */
-#define ESTACKS_MEMBERS(guardsize, db2_holesize)\
+#define ESTACKS_MEMBERS(guardsize)		\
 	char	DF_stack_guard[guardsize];	\
 	char	DF_stack[EXCEPTION_STKSZ];	\
 	char	NMI_stack_guard[guardsize];	\
 	char	NMI_stack[EXCEPTION_STKSZ];	\
-	char	DB2_stack_guard[guardsize];	\
-	char	DB2_stack[db2_holesize];	\
-	char	DB1_stack_guard[guardsize];	\
-	char	DB1_stack[EXCEPTION_STKSZ];	\
 	char	DB_stack_guard[guardsize];	\
 	char	DB_stack[EXCEPTION_STKSZ];	\
 	char	MCE_stack_guard[guardsize];	\
@@ -28,12 +24,12 @@
 
 /* The exception stacks' physical storage. No guard pages required */
 struct exception_stacks {
-	ESTACKS_MEMBERS(0, 0)
+	ESTACKS_MEMBERS(0)
 };
 
 /* The effective cpu entry area mapping with guard pages. */
 struct cea_exception_stacks {
-	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
+	ESTACKS_MEMBERS(PAGE_SIZE)
 };
 
 /*
@@ -42,8 +38,6 @@ struct cea_exception_stacks {
 enum exception_stack_ordering {
 	ESTACK_DF,
 	ESTACK_NMI,
-	ESTACK_DB2,
-	ESTACK_DB1,
 	ESTACK_DB,
 	ESTACK_MCE,
 	N_EXCEPTION_STACKS
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index c2a4701..828be79 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -57,9 +57,6 @@ int main(void)
 	BLANK();
 #undef ENTRY
 
-	OFFSET(TSS_ist, tss_struct, x86_tss.ist);
-	DEFINE(DB_STACK_OFFSET, offsetof(struct cea_exception_stacks, DB_stack) -
-	       offsetof(struct cea_exception_stacks, DB1_stack));
 	BLANK();
 
 #ifdef CONFIG_STACKPROTECTOR
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 460ae7f..4a94d38 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -22,15 +22,13 @@
 static const char * const exception_stack_names[] = {
 		[ ESTACK_DF	]	= "#DF",
 		[ ESTACK_NMI	]	= "NMI",
-		[ ESTACK_DB2	]	= "#DB2",
-		[ ESTACK_DB1	]	= "#DB1",
 		[ ESTACK_DB	]	= "#DB",
 		[ ESTACK_MCE	]	= "#MC",
 };
 
 const char *stack_type_name(enum stack_type type)
 {
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
 
 	if (type == STACK_TYPE_IRQ)
 		return "IRQ";
@@ -79,7 +77,6 @@ static const
 struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
 	EPAGERANGE(DF),
 	EPAGERANGE(NMI),
-	EPAGERANGE(DB1),
 	EPAGERANGE(DB),
 	EPAGERANGE(MCE),
 };
@@ -91,7 +88,7 @@ static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 	struct pt_regs *regs;
 	unsigned int k;
 
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
 
 	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
 	/*
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 5199d8a..060f083 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -107,7 +107,6 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 	 */
 	cea_map_stack(DF);
 	cea_map_stack(NMI);
-	cea_map_stack(DB1);
 	cea_map_stack(DB);
 	cea_map_stack(MCE);
 }
