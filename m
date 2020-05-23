Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6838EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370C620759
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfwbX/Kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgEWP5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEWP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 11:57:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F7C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 08:57:40 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 205so637309qkg.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=A7fohaKepU2awKDpIN4Zxh95LCOVhhZj7F1ImfpRq2c=;
        b=tfwbX/Kf1MqDDhfPBWkMr6P5x6uajOdIDkY+yaRKC4BxNC+tZQZw20a9KICtaPP4X/
         AFbdyXqUyn3+sxEtz6LA7YXiM5PmPgM+POIZOIHx0RWKWfaeA6bViyU70f0GCERAgloX
         zFrg3P7pei9SYMQsMKOlAQZTg0Cu8b4Ol0obIKM/LSsujn8xmCjnr/kROjB46ZMrTOva
         9VX8o3YNqiE0061p9XYjr2VJqiHTPa6tYgAT2QxcgB7K5zh6P9RRvm7wc6xBZZzp/3Lw
         jZWNsFeIkWpzZeUJ6FAq73sUPTGXMkjXNK9g/UOY1p9i1rMgVRSZiN/3cVbDc3sZ14cQ
         M9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=A7fohaKepU2awKDpIN4Zxh95LCOVhhZj7F1ImfpRq2c=;
        b=eGOs0B23JzN81ygFP0NAU+c6TKsX+Jhoc82/Ub35/gNmWWf3l8DA0pa11RypnrcOYq
         GkTSiHJzZPyFTQK6ruBOuZI3v5TDcEzYT5Xiq08M+oJiuTOmi/AWcNmQFO4nXJ5nIPno
         Dj5WxAfYL2q9IVbxe74giUJxAe+cR/WyjXIIW64ngmEiHOorOPAnM1224M455GtSJjrJ
         vEGwbicR51Ycm9AazmGJ1CS/gjT5HT1Ots8ZJkKPmJnzo9ptDKJequBhRQT6wOhNcSEn
         UJs8my31KLsA5ZqcLLKA6XMrLn2wOzG6kmWdK2I/QpsxWf4m7/Zy47YKLVpDGDpP85iF
         XGEQ==
X-Gm-Message-State: AOAM531tOn4cBEe4EymlPPE2LPMp3Cm2G860j7UgYK7MSyLjBl7q8RCY
        1NiiEz4ZjPlev/mPcK6mkvw=
X-Google-Smtp-Source: ABdhPJx5fmypVRGHFV5O5RGDtWoLPSqn/e2AQn1iu9H9uw8calNeavhovf43wboF7LK/+Atf0dzGbQ==
X-Received: by 2002:a37:a551:: with SMTP id o78mr18771357qke.439.1590249459509;
        Sat, 23 May 2020 08:57:39 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m19sm2277835qtn.38.2020.05.23.08.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 08:57:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 23 May 2020 11:57:37 -0400
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: x86: Question about state of general purpose registers on switch to
 64-bit mode
Message-ID: <20200523155737.GC1189358@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question about the state of the upper 32 bits of the general
purpose registers following a switch from/to 64-bit mode.

Both the AMD [0] and Intel [1] manuals state that these bits are
undefined following a switch from 64 to 32-bit mode. Since they can't be
accessed in 32-bit mode, presumably this means they are undefined once
you switch back to 64-bit mode and can see them again.

However, at least the compressed kernel boot code in head_64.S makes
assumptions about these bits:

(1) We assume that registers that are set in 32-bit mode will have their
upper 32 bits clear when we switch to 64-bit mode. Eg the bootparams
pointer in %esi in startup_32 is assumed to remain valid following the
switch to the 64-bit startup_64 (or the EFI stub). The EFI stub assumes
that the 32-bit %esp setup in startup_32 will remain valid.

(2) We assume that 64-bit registers that are not touched by the 32-bit
code will retain their full 64-bit values on switching back. The 5-level
trampoline logic makes this assumption and depends on %rbx, %rbp, %rsi, %rdi
retaining their values.

Given that we don't keep seeing random boot failures, I would guess that
the above assumptions are actually valid in practice. However, they do
seem to be more than what the processors actually promise. I have a
preliminary patch to remove assumption (2) for the trampoline code at
the end of this e-mail, and I'm wondering if there is interest in doing
that + fixing up the rest of the boot code.

Thanks.

[0] https://www.amd.com/system/files/TechDocs/40332.pdf
Section 3.1.2.4 (GPR High 32 Bits Across Mode Switches):

The processor does not preserve the upper 32 bits of the 64-bit GPRs
across switches from 64-bit mode to compatibility or legacy modes. When
using 32-bit operands in compatibility or legacy mode, the high 32 bits
of GPRs are undefined. Software must not rely on these undefined bits,
because they can change from one implementation to the next or even on a
cycle-to-cycle basis within a given implementation. The undefined bits
are not a function of the data left by any previously running process.

[1] https://software.intel.com/content/dam/develop/public/us/en/documents/325462-sdm-vol-1-2abcd-3abcd.pdf
Volume 1, Section 3.4.1.1 (General-Purpose Registers in 64-Bit Mode):

Registers only available in 64-bit mode (R8-R15 and XMM8-XMM15) are
preserved across transitions from 64-bit mode into compatibility mode
then back into 64-bit mode. However, values of R8-R15 and XMM8-XMM15 are
undefined after transitions from 64-bit mode through compatibility mode
to legacy or real mode and then back through compatibility mode to
64-bit mode.
...
Because the upper 32 bits of 64-bit general-purpose registers are
undefined in 32-bit modes, the upper 32 bits of any general-purpose
register are not preserved when switching from 64-bit mode to a 32-bit
mode (to protected mode or compatibility mode). Software must not depend
on these bits to maintain a value after a 64-bit to 32-bit mode switch.

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 4f7e6b84be07..4e3d41d0c3ca 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -404,43 +404,61 @@ SYM_CODE_START(startup_64)
 	 *     paging.
 	 *
 	 * RSI holds real mode data and needs to be preserved across
-	 * this function call.
+	 * the trampoline setup/call/cleanup.
 	 */
 	pushq	%rsi
+
 	movq	%rsi, %rdi		/* real mode address */
 	call	paging_prepare
-	popq	%rsi
 
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
 
+	/* Save registers across trampoline call */
+	pushq	%rbx
+	pushq	%rbp
+	movq	%rsp, %rbp
+
+	/* Set up data and stack segments */
+	movl	$__KERNEL_DS, %eax
+	movl	%eax, %ds
+	movl	%eax, %ss
+
+	/* Set up new stack for the trampoline */
+	leaq	TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
+	/* Save the old stack pointer */
+	pushq	%rbp
+
 	/*
-	 * Load the address of trampoline_return() into RDI.
+	 * Push the address of trampoline_return().
 	 * It will be used by the trampoline to return to the main code.
 	 */
-	leaq	trampoline_return(%rip), %rdi
+	leaq	trampoline_return(%rip), %rax
+	pushq	%rax
 
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
-	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
+	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rcx), %rax
 	pushq	%rax
 	lretq
 trampoline_return:
 	/* Restore the stack, the 32-bit trampoline uses its own stack */
-	leaq	boot_stack_end(%rbx), %rsp
+	popq	%rsp
+
+	/* Restore saved registers */
+	popq	%rbp
+	popq	%rbx
 
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
 	 *
 	 * RDI is address of the page table to use instead of page table
 	 * in trampoline memory (if required).
-	 *
-	 * RSI holds real mode data and needs to be preserved across
-	 * this function call.
 	 */
-	pushq	%rsi
 	leaq	top_pgtable(%rbx), %rdi
 	call	cleanup_trampoline
+
+	/* Restore RSI */
 	popq	%rsi
 
 	/* Zero EFLAGS */
@@ -569,14 +587,6 @@ SYM_FUNC_END(.Lrelocated)
  * Non zero RDX means trampoline needs to enable 5-level paging.
  */
 SYM_CODE_START(trampoline_32bit_src)
-	/* Set up data and stack segments */
-	movl	$__KERNEL_DS, %eax
-	movl	%eax, %ds
-	movl	%eax, %ss
-
-	/* Set up new stack */
-	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -635,8 +645,10 @@ SYM_CODE_END(trampoline_32bit_src)
 
 	.code64
 SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
+	/* Make sure upper 32 bits of %rsp are clear */
+	movl	%esp, %esp
 	/* Return from the trampoline */
-	jmp	*%rdi
+	retq
 SYM_FUNC_END(.Lpaging_enabled)
 
 	/*
