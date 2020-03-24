Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5DCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA54C21473
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PEc2stQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgCXQMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:12:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36930 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgCXQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pSGP6r2NLE6dzWu1sb8wNttMOQP+/GZ86JZyVLYhiRo=; b=PEc2stQ8jB0ujDASoy8qNKNtVX
        HZzWZJkfqdJ5K94nUKqqeRA1ESXJI1UtZI2lhRPnDRjE7XiKygCqwYgCLI9pkunVfUPy3GBbqvBSL
        gX9LpS4cs1c6RqFtmF7JL0ypxG7uBnNLHnE9PHlIgzWhGGq/cJJXkYm2ZLaSZFKFBENnxBB8qxKzO
        u3xRshEcchDxiN83PXgxUiemEGl78WnyXvmbEvTnvtYbpGTDZbydtLm5AfZkBdPOc9CM0EZoMdt4k
        a/Isl/M4dF7q4ByN2MZBMQhgSFt7aXiSaFhzM1Qp488UivTw5TBQ+PzhdjcjXKzhahC4iqK/FbEBI
        O4Kjs/9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9L-0006bT-6i; Tue, 24 Mar 2020 16:11:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 448E4306118;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 271E729A490F6; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.202621656@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 05/26] x86/kexec: Make relocate_kernel_64.S objtool clean
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having fixed the biggest objtool issue in this file; fix up the rest
and remove the exception.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/Makefile             |    1 -
 arch/x86/kernel/relocate_kernel_64.S |    7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -32,7 +32,6 @@ KASAN_SANITIZE_paravirt.o				:= n
 # by several compilation units. To be safe, disable all instrumentation.
 KCSAN_SANITIZE := n
 
-OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o	:= y
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 OBJECT_FILES_NON_STANDARD_paravirt_patch.o		:= y
 
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -9,6 +9,8 @@
 #include <asm/kexec.h>
 #include <asm/processor-flags.h>
 #include <asm/pgtable_types.h>
+#include <asm/nospec-branch.h>
+#include <asm/unwind_hints.h>
 
 /*
  * Must be relocatable PIC code callable as a C function
@@ -39,6 +41,7 @@
 	.align PAGE_SIZE
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
+	UNWIND_HINT_EMPTY
 	/*
 	 * %rdi indirection_page
 	 * %rsi page_list
@@ -105,6 +108,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
+	UNWIND_HINT_EMPTY
 	/* set return address to 0 if not preserving context */
 	pushq	$0
 	/* store the start address on the stack */
@@ -192,6 +196,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_ma
 1:
 	popq	%rdx
 	leaq	PAGE_SIZE(%r10), %rsp
+	ANNOTATE_RETPOLINE_SAFE
 	call	*%rdx
 
 	/* get the re-entry point of the peer system */
@@ -209,6 +214,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_ma
 SYM_CODE_END(identity_mapped)
 
 SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
+	UNWIND_HINT_EMPTY
 	movq	RSP(%r8), %rsp
 	movq	CR4(%r8), %rax
 	movq	%rax, %cr4
@@ -230,6 +236,7 @@ SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
 SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
+	UNWIND_HINT_EMPTY
 	movq	%rdi, %rcx 	/* Put the page_list in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi


