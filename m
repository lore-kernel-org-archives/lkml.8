Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9D1C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFFAB20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqQeVNYC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LxBE1+2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHNPXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:23:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgHNPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:23:43 -0400
Date:   Fri, 14 Aug 2020 15:23:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597418621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+S/QZFCVS3Li9qsFuSlTf5u5lS7GoLVdaRUIdLgwwrM=;
        b=LqQeVNYCB75dS85cR73/ELfO8I58RWwVoJBcUGmxceDUtCalw8UwQ5htO1dqczw60fb3SL
        KO40d3NpXtIx6GRE2gMdu7fBjjxRktv0ttouJB2cJQAkRxvRpEIFAsczN2g1YbMQCLlhTh
        BMJWuIB29aJeorDMs0ashtxxDG5zEcTq6dYzBo9sQulFMd7B2OPSnIUu0T63hmzVAJ9glg
        FShZZDcOSeOSCrBnMcgsoOAmXsJYNgyUFJSPDLntAhaEfim0fe6i6SQfiR66Qcsg2E3aHY
        7R19ZIinemyx3j8QY0Jcvy6DxZTjeUKBuRZ3EkW+4QKeblxOfnEPFtP0cqHEsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597418621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+S/QZFCVS3Li9qsFuSlTf5u5lS7GoLVdaRUIdLgwwrM=;
        b=LxBE1+2NCRmoDruel3oZV3J4FFm6cKebhU11qQiYfBbnJdjiIJDm064H8XF2dVibDcs2Px
        laelGdMcAvFvnDCA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Get rid of GOT fixup code
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200731230820.1742553-4-keescook@chromium.org>
References: <20200731230820.1742553-4-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159741862017.3192.5772162309097866591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     423e4d198a036689de73fd6b073fc4349c4fa1ee
Gitweb:        https://git.kernel.org/tip/423e4d198a036689de73fd6b073fc4349c4fa1ee
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 31 Jul 2020 16:07:47 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Aug 2020 12:52:35 +02:00

x86/boot/compressed: Get rid of GOT fixup code

In a previous patch, we have eliminated GOT entries from the decompressor
binary and added an assertion that the .got section is empty. This means
that the GOT fixup routines that exist in both the 32-bit and 64-bit
startup routines have become dead code, and can be removed.

While at it, drop the KEEP() from the linker script, as it has no effect
on the contents of output sections that are created by the linker itself.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200731230820.1742553-4-keescook@chromium.org
---
 arch/x86/boot/compressed/head_32.S     | 24 +----------
 arch/x86/boot/compressed/head_64.S     | 57 +-------------------------
 arch/x86/boot/compressed/vmlinux.lds.S |  4 +--
 3 files changed, 5 insertions(+), 80 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 03557f2..39f0bb4 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -49,16 +49,13 @@
  * Position Independent Executable (PIE) so that linker won't optimize
  * R_386_GOT32X relocation to its fixed symbol address.  Older
  * linkers generate R_386_32 relocations against locally defined symbols,
- * _bss, _ebss, _got, _egot and _end, in PIE.  It isn't wrong, just less
- * optimal than R_386_RELATIVE.  But the x86 kernel fails to properly handle
- * R_386_32 relocations when relocating the kernel.  To generate
- * R_386_RELATIVE relocations, we mark _bss, _ebss, _got, _egot and _end as
- * hidden:
+ * _bss, _ebss and _end, in PIE.  It isn't wrong, just less optimal than
+ * R_386_RELATIVE.  But the x86 kernel fails to properly handle R_386_32
+ * relocations when relocating the kernel.  To generate R_386_RELATIVE
+ * relocations, we mark _bss, _ebss and _end as hidden:
  */
 	.hidden _bss
 	.hidden _ebss
-	.hidden _got
-	.hidden _egot
 	.hidden _end
 
 	__HEAD
@@ -193,19 +190,6 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	rep	stosl
 
 /*
- * Adjust our own GOT
- */
-	leal	_got(%ebx), %edx
-	leal	_egot(%ebx), %ecx
-1:
-	cmpl	%ecx, %edx
-	jae	2f
-	addl	%ebx, (%edx)
-	addl	$4, %edx
-	jmp	1b
-2:
-
-/*
  * Do the extraction, and jump to the new kernel..
  */
 				/* push arguments for extract_kernel: */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 97d37f0..bf1ab30 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -40,8 +40,6 @@
  */
 	.hidden _bss
 	.hidden _ebss
-	.hidden _got
-	.hidden _egot
 	.hidden _end
 
 	__HEAD
@@ -354,25 +352,6 @@ SYM_CODE_START(startup_64)
 	leaq	boot_stack_end(%rbx), %rsp
 
 	/*
-	 * paging_prepare() and cleanup_trampoline() below can have GOT
-	 * references. Adjust the table with address we are running at.
-	 *
-	 * Zero RAX for adjust_got: the GOT was not adjusted before;
-	 * there's no adjustment to undo.
-	 */
-	xorq	%rax, %rax
-
-	/*
-	 * Calculate the address the binary is loaded at and use it as
-	 * a GOT adjustment.
-	 */
-	call	1f
-1:	popq	%rdi
-	subq	$1b, %rdi
-
-	call	.Ladjust_got
-
-	/*
 	 * At this point we are in long mode with 4-level paging enabled,
 	 * but we might want to enable 5-level paging or vice versa.
 	 *
@@ -464,21 +443,6 @@ trampoline_return:
 	pushq	$0
 	popfq
 
-	/*
-	 * Previously we've adjusted the GOT with address the binary was
-	 * loaded at. Now we need to re-adjust for relocation address.
-	 *
-	 * Calculate the address the binary is loaded at, so that we can
-	 * undo the previous GOT adjustment.
-	 */
-	call	1f
-1:	popq	%rax
-	subq	$1b, %rax
-
-	/* The new adjustment is the relocation address */
-	movq	%rbx, %rdi
-	call	.Ladjust_got
-
 /*
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
@@ -556,27 +520,6 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
-/*
- * Adjust the global offset table
- *
- * RAX is the previous adjustment of the table to undo (use 0 if it's the
- * first time we touch GOT).
- * RDI is the new adjustment to apply.
- */
-.Ladjust_got:
-	/* Walk through the GOT adding the address to the entries */
-	leaq	_got(%rip), %rdx
-	leaq	_egot(%rip), %rcx
-1:
-	cmpq	%rcx, %rdx
-	jae	2f
-	subq	%rax, (%rdx)	/* Undo previous adjustment */
-	addq	%rdi, (%rdx)	/* Apply the new adjustment */
-	addq	$8, %rdx
-	jmp	1b
-2:
-	ret
-
 	.code32
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 4bcc943..a4a4a59 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -43,9 +43,7 @@ SECTIONS
 		_erodata = . ;
 	}
 	.got : {
-		_got = .;
-		KEEP(*(.got))
-		_egot = .;
+		*(.got)
 	}
 	.got.plt : {
 		*(.got.plt)
