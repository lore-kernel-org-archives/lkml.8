Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C7C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA53F20775
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgCZKIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:08:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50240 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgCZKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRL-00048e-7F; Thu, 26 Mar 2020 11:08:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CE4461C0478;
        Thu, 26 Mar 2020 11:08:37 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:37 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] x86/kexec: Make relocate_kernel_64.S objtool clean
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.202621656@infradead.org>
References: <20200324160924.202621656@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731743.28353.7607166027983057055.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/objtool branch of tip:

Commit-ID:     36cc552055a5f95bab479533b4ebbad6a6cea0e1
Gitweb:        https://git.kernel.org/tip/36cc552055a5f95bab479533b4ebbad6a6cea0e1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Mar 2020 15:35:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:28 +01:00

x86/kexec: Make relocate_kernel_64.S objtool clean

Having fixed the biggest objtool issue in this file; fix up the rest
and remove the exception.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.202621656@infradead.org
---
 arch/x86/kernel/Makefile             | 1 -
 arch/x86/kernel/relocate_kernel_64.S | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 9b294c1..8be5926 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -28,7 +28,6 @@ KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 
-OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o	:= y
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 OBJECT_FILES_NON_STANDARD_paravirt_patch.o		:= y
 
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index cc5c8b9..a4d9a26 100644
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
@@ -192,6 +196,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 1:
 	popq	%rdx
 	leaq	PAGE_SIZE(%r10), %rsp
+	ANNOTATE_RETPOLINE_SAFE
 	call	*%rdx
 
 	/* get the re-entry point of the peer system */
@@ -209,6 +214,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
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
