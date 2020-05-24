Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF04AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956CE20776
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdA3XEiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbgEXXWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbgEXXWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:22:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AEAC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:22:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n15so7770545pjt.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1v9i69sL4QICbaidphEj2SUMbixrvb6wzpMA1fDBRz4=;
        b=qdA3XEiNpc4s3LOJdybF95r2coHrr4EYw1Kd9/E8t+hWRVSr1qrADWhihQgPdIeROt
         9x4FWqxmQeMd2z5nOEAlFZHgcKPmzGTTxSHkEcDFIPf6klNTuMMYHARstzZR1R0TUq4T
         HjkbBSLyHsQB6EZx+IyPpA52mpXfOvEKAJ1VRbl2Z5TktoTgLmAXbbwrCxvCNm6KoTqr
         fRzoOG8WxyaE7OAnXGVNLUrnScDTpsCQ/xVXH6sGVG6t4spU3YnsAmr1vybMZU4rqUGe
         n7V2F24ZX/HQsgGiaWYXqXfbahkC/fW3GHul63KZ4hnqwjaM1U3SKxTx7ZksGI4SpTWm
         SrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1v9i69sL4QICbaidphEj2SUMbixrvb6wzpMA1fDBRz4=;
        b=JXjSVYnp/kPTR6l5nspdVQCVSBsrRpjPg6muzzLtaw4x9zBxuM8VHtpvi4856+vaeT
         XaWTNdfEKdw7xbPY5brj4o1szzTcinjUjvxR5fONaQtGQWME8rb9hCmq8r9ljLxfXKf0
         QtVdWRHO7V9CLN3+UbmZwfarEv5ln0+ozBY6fLM524YukWouEWVNKR9tYCaOfWXFwHAa
         mFy4SFCkwKJkaMw/OEt0YW9zN2iBmg/dD7X4m6LujkVACh6038zY5SZDty1zacUEysWr
         RjjhzYEII0rQEzFgvzU/YSCvQXeKstKRi7iPQi2EihFMlVK1M5Lesg1perqLKjBWSr6s
         Owjw==
X-Gm-Message-State: AOAM530cbcj9ea8iHyNKMLZA/Vvro4Vf6OR5LKEP/jbFTcc9gLzRhXfC
        X29y/4NoQcjSywAmR8enMfO9QA==
X-Google-Smtp-Source: ABdhPJwQgIfXysyUDKLKOooM6eLO2jR91+HtP1xRVU2oAmyu5D2Z09yo5jed8mOQc4nCuaxt2vjIbg==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr24655796plr.160.1590362538802;
        Sun, 24 May 2020 16:22:18 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id t20sm11471717pjo.13.2020.05.24.16.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:22:17 -0700 (PDT)
Date:   Sun, 24 May 2020 16:22:14 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/boot: Remove runtime relocations from
 head_{32,64}.S
Message-ID: <20200524232214.i7rfpdzoam6tpt6n@google.com>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-4-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200524212816.243139-4-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-05-24, Arvind Sankar wrote:
>The BFD linker generates runtime relocations for z_input_len and
>z_output_len, even though they are absolute symbols.
>
>Work around this by defining two variables input_len and output_len in
>addition to the symbols, and use them via position-independent
>references.
>
>This eliminates the last two runtime relocations in the head code and
>allows us to drop the -z noreloc-overflow flag to the linker.
>
>Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>---
> arch/x86/boot/compressed/Makefile  |  8 --------
> arch/x86/boot/compressed/head_32.S | 17 ++++++++---------
> arch/x86/boot/compressed/head_64.S |  4 ++--
> arch/x86/boot/compressed/mkpiggy.c |  6 ++++++
> 4 files changed, 16 insertions(+), 19 deletions(-)
>
>diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>index aa9ed814e5fa..d3e882e855ee 100644
>--- a/arch/x86/boot/compressed/Makefile
>+++ b/arch/x86/boot/compressed/Makefile
>@@ -49,15 +49,7 @@ UBSAN_SANITIZE :=n
> KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> # Compressed kernel should be built as PIE since it may be loaded at any
> # address by the bootloader.
>-ifeq ($(CONFIG_X86_32),y)
> KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
>-else
>-# To build 64-bit compressed kernel as PIE, we disable relocation
>-# overflow check to avoid relocation overflow error with a new linker
>-# command-line option, -z noreloc-overflow.
>-KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
>-	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
>-endif
> LDFLAGS_vmlinux := -T
>
> hostprogs	:= mkpiggy
>diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
>index 66657bb99aae..064e895bad92 100644
>--- a/arch/x86/boot/compressed/head_32.S
>+++ b/arch/x86/boot/compressed/head_32.S
>@@ -193,18 +193,17 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> /*
>  * Do the extraction, and jump to the new kernel..
>  */
>-				/* push arguments for extract_kernel: */
>-	pushl	$z_output_len	/* decompressed length, end of relocs */
>+	/* push arguments for extract_kernel: */
>
>-	pushl	%ebp		/* output address */
>-
>-	pushl	$z_input_len	/* input_len */
>+	pushl	output_len@GOTOFF(%ebx)	/* decompressed length, end of relocs */
>+	pushl	%ebp			/* output address */
>+	pushl	input_len@GOTOFF(%ebx)	/* input_len */
> 	leal	input_data@GOTOFF(%ebx), %eax
>-	pushl	%eax		/* input_data */
>+	pushl	%eax			/* input_data */
> 	leal	boot_heap@GOTOFF(%ebx), %eax
>-	pushl	%eax		/* heap area */
>-	pushl	%esi		/* real mode pointer */
>-	call	extract_kernel	/* returns kernel location in %eax */
>+	pushl	%eax			/* heap area */
>+	pushl	%esi			/* real mode pointer */
>+	call	extract_kernel		/* returns kernel location in %eax */
> 	addl	$24, %esp
>
> /*
>diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
>index f6ba32cd5702..6e4704b6a94e 100644
>--- a/arch/x86/boot/compressed/head_64.S
>+++ b/arch/x86/boot/compressed/head_64.S
>@@ -508,9 +508,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> 	movq	%rsi, %rdi		/* real mode address */
> 	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
> 	leaq	input_data(%rip), %rdx  /* input_data */
>-	movl	$z_input_len, %ecx	/* input_len */
>+	movl	input_len(%rip), %ecx	/* input_len */
> 	movq	%rbp, %r8		/* output target address */
>-	movl	$z_output_len, %r9d	/* decompressed length, end of relocs */
>+	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
> 	call	extract_kernel		/* returns kernel location in %rax */
> 	popq	%rsi
>
>diff --git a/arch/x86/boot/compressed/mkpiggy.c b/arch/x86/boot/compressed/mkpiggy.c
>index 7e01248765b2..52aa56cdbacc 100644
>--- a/arch/x86/boot/compressed/mkpiggy.c
>+++ b/arch/x86/boot/compressed/mkpiggy.c
>@@ -60,6 +60,12 @@ int main(int argc, char *argv[])
> 	printf(".incbin \"%s\"\n", argv[1]);
> 	printf("input_data_end:\n");
>
>+	printf(".section \".rodata\",\"a\",@progbits\n");
>+	printf(".globl input_len\n");
>+	printf("input_len:\n\t.long %lu\n", ilen);
>+	printf(".globl output_len\n");
>+	printf("output_len:\n\t.long %lu\n", (unsigned long)olen);
>+
> 	retval = 0;
> bail:
> 	if (f)
>-- 
>2.26.2
>

Probably worth mentioning that this works around GNU ld<2.35


This commit fixing https://sourceware.org/bugzilla/show_bug.cgi?id=25754
also fixed the bug. (Just verified that both 2.24 and 2.34 have the bug. binutils-gdb HEAD (future 2.35) is good.)

% cat a.s
pushl $z_input_len
% cat b.s
.globl z_input_len
z_input_len = 0xb612
% gcc -m32 -c a.s b.s
% ld.bfd -m elf_i386 -pie a.o b.o  # has an incorrect R_386_RELATIVE before binutils 2.35


Reviewed-by: Fangrui Song <maskray@google.com>
