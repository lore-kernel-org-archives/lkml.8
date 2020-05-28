Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945C9207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lWg1JeIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407105AbgE1UYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407021AbgE1UYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:24:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E77C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6c1l8mv8BHX+LPR3tE4uLKCg0tOvdVhpWAI761gXwMc=; b=lWg1JeIXMFh7DksQ9qUBq/wXK+
        Zd9gDLZ5VWM154XrVUmXObfDi+EdbsrNEPdyqCOatMc97HTTWpW75xupmVhJZl6W5AmOMhXNsyiv+
        hfAUL/8Ite10nya3b9etDoB2jw3Ieir8+MPADyADw4NMka8Jw17i1wKX8LZNVIZ7N7gWWixLwt9+I
        TL5XdxA68uxBK79S6u+qsvAgXpI9bDVbQnokcUbaQHarGfLL1EKxhUAwCE+fTi5CPwnHs9oNdZRQk
        Q0wv3ThqRLKhs31RDqP7A0ncI0vGipQ1DKAZ84rLMX90qIcTaUS2TKnVZn+afrHlViIBg8SuH+fpJ
        VqFvkhog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeP4j-0005Zp-6V; Thu, 28 May 2020 20:24:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3237030704D;
        Thu, 28 May 2020 22:24:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DF3B12BA01B1A; Thu, 28 May 2020 22:24:22 +0200 (CEST)
Message-ID: <20200528202328.708732152@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 28 May 2020 22:19:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org
Subject: [RFC][PATCH 6/6] x86/entry: Remove DBn stacks
References: <20200528201937.038455891@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both #DB itself, as all other IST users (NMI, #MC) now clear DR7 on
entry. Combined with not allowing breakpoints on entry/noinstr/NOKPROBE
text and no single step (EFLAGS.TF) inside the #DB handler should
guarantee us no nested #DB.

XXX depends on KGDB breakpoints not being stupid

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S             |   13 -------------
 arch/x86/include/asm/cpu_entry_area.h |    6 ------
 arch/x86/kernel/asm-offsets_64.c      |    3 ---
 arch/x86/kernel/dumpstack_64.c        |    3 ---
 arch/x86/mm/cpu_entry_area.c          |    1 -
 5 files changed, 26 deletions(-)

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
@@ -445,16 +440,8 @@ SYM_CODE_START(\asmsym)
 
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
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -16,10 +16,6 @@
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
@@ -42,8 +38,6 @@ struct cea_exception_stacks {
 enum exception_stack_ordering {
 	ESTACK_DF,
 	ESTACK_NMI,
-	ESTACK_DB2,
-	ESTACK_DB1,
 	ESTACK_DB,
 	ESTACK_MCE,
 	N_EXCEPTION_STACKS
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
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -22,8 +22,6 @@
 static const char * const exception_stack_names[] = {
 		[ ESTACK_DF	]	= "#DF",
 		[ ESTACK_NMI	]	= "NMI",
-		[ ESTACK_DB2	]	= "#DB2",
-		[ ESTACK_DB1	]	= "#DB1",
 		[ ESTACK_DB	]	= "#DB",
 		[ ESTACK_MCE	]	= "#MC",
 };
@@ -79,7 +77,6 @@ static const
 struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
 	EPAGERANGE(DF),
 	EPAGERANGE(NMI),
-	EPAGERANGE(DB1),
 	EPAGERANGE(DB),
 	EPAGERANGE(MCE),
 };
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -107,7 +107,6 @@ static void __init percpu_setup_exceptio
 	 */
 	cea_map_stack(DF);
 	cea_map_stack(NMI);
-	cea_map_stack(DB1);
 	cea_map_stack(DB);
 	cea_map_stack(MCE);
 }


