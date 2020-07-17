Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA06CC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3CE20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgGQUSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:18:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45141 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQUSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:18:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id c139so9904485qkg.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvSdlOf3kzh25xbOpQnu6TCTUcLGC5ccHXqfCxF4O6c=;
        b=LLMTOvzpt21yp5J5gf0GuLzot8GQjXwPCKkVmkJA4JiU6+2E0QuC0PRguD9xG46I/N
         TpQaH8wsO9BBysb7V0VxVjPD813GVEFWmL9bkE4wH0H4DxmEZHv5C2NGAIXG3JjjfIkI
         bKDYDZtmMHS1dW7bAh2sFnCiyaSU7tMv+p1VglZppgThstxgLd2PWSWplvCjQ2LgNOWA
         9OcMihOW/OzOAwvGhtGd1Q6NO6FLi8+QloEtl3LF1I699nuoNe1L0++A9aNFzGqcGPTM
         +FVGCXXji9P/WkuAsOfrsS1g6a/9RUrjYeyhkz47Z/BT70priw3bq11VufHrfbd+WbLO
         ekYA==
X-Gm-Message-State: AOAM5301b7Wqi+Gd4BSsHOS9W/hdNep74vKNNZ2H4kEDCjaONyMmxdu5
        Gs2IyQ/rEZTl+PLvILLwIGY=
X-Google-Smtp-Source: ABdhPJxuOb7DGDo2zwQTCda8jmcnSE4me2Qoh+NLMjLU6+JykJKbC3m/h7xMOsh/qJNkkDvu3gxovA==
X-Received: by 2002:ae9:de82:: with SMTP id s124mr5784988qkf.438.1595017089696;
        Fri, 17 Jul 2020 13:18:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a28sm9509977qko.45.2020.07.17.13.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 13:18:09 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: [PATCH-next v5 6/7] x86/boot: Remove run-time relocations from head_{32,64}.S
Date:   Fri, 17 Jul 2020 16:18:00 -0400
Message-Id: <20200717201801.3661843-7-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
References: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BFD linker generates run-time relocations for z_input_len and
z_output_len, even though they are absolute symbols.

This is fixed for binutils-2.35 [1]. Work around this for earlier
versions by defining two variables input_len and output_len in addition
to the symbols, and use them via position-independent references.

This eliminates the last two run-time relocations in the head code and
allows us to drop the -z noreloc-overflow flag to the linker.

Move the -pie and --no-dynamic-linker LDFLAGS to LDFLAGS_vmlinux instead
of KBUILD_LDFLAGS. There shouldn't be anything else getting linked, but
this is the more logical location for these flags, and modversions might
call the linker if an EXPORT_SYMBOL is left over accidentally in one of
the decompressors.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=25754

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/Makefile  | 12 ++----------
 arch/x86/boot/compressed/head_32.S | 17 ++++++++---------
 arch/x86/boot/compressed/head_64.S |  4 ++--
 arch/x86/boot/compressed/mkpiggy.c |  6 ++++++
 4 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index b6d7caaaef9e..4a3953a596e0 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -51,16 +51,8 @@ UBSAN_SANITIZE :=n
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
-ifeq ($(CONFIG_X86_32),y)
-KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
-else
-# To build 64-bit compressed kernel as PIE, we disable relocation
-# overflow check to avoid relocation overflow error with a new linker
-# command-line option, -z noreloc-overflow.
-KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
-	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
-endif
-LDFLAGS_vmlinux := -T
+LDFLAGS_vmlinux := $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
+LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 8c1a4f5610f5..659fad53ca82 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -178,18 +178,17 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 /*
  * Do the extraction, and jump to the new kernel..
  */
-				/* push arguments for extract_kernel: */
-	pushl	$z_output_len	/* decompressed length, end of relocs */
+	/* push arguments for extract_kernel: */
 
-	pushl	%ebp		/* output address */
-
-	pushl	$z_input_len	/* input_len */
+	pushl	output_len@GOTOFF(%ebx)	/* decompressed length, end of relocs */
+	pushl	%ebp			/* output address */
+	pushl	input_len@GOTOFF(%ebx)	/* input_len */
 	leal	input_data@GOTOFF(%ebx), %eax
-	pushl	%eax		/* input_data */
+	pushl	%eax			/* input_data */
 	leal	boot_heap@GOTOFF(%ebx), %eax
-	pushl	%eax		/* heap area */
-	pushl	%esi		/* real mode pointer */
-	call	extract_kernel	/* returns kernel location in %eax */
+	pushl	%eax			/* heap area */
+	pushl	%esi			/* real mode pointer */
+	call	extract_kernel		/* returns kernel location in %eax */
 	addl	$24, %esp
 
 /*
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 11429092c224..9e46729cf162 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -534,9 +534,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	movq	%rsi, %rdi		/* real mode address */
 	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
 	leaq	input_data(%rip), %rdx  /* input_data */
-	movl	$z_input_len, %ecx	/* input_len */
+	movl	input_len(%rip), %ecx	/* input_len */
 	movq	%rbp, %r8		/* output target address */
-	movl	$z_output_len, %r9d	/* decompressed length, end of relocs */
+	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
 	call	extract_kernel		/* returns kernel location in %rax */
 	popq	%rsi
 
diff --git a/arch/x86/boot/compressed/mkpiggy.c b/arch/x86/boot/compressed/mkpiggy.c
index 7e01248765b2..52aa56cdbacc 100644
--- a/arch/x86/boot/compressed/mkpiggy.c
+++ b/arch/x86/boot/compressed/mkpiggy.c
@@ -60,6 +60,12 @@ int main(int argc, char *argv[])
 	printf(".incbin \"%s\"\n", argv[1]);
 	printf("input_data_end:\n");
 
+	printf(".section \".rodata\",\"a\",@progbits\n");
+	printf(".globl input_len\n");
+	printf("input_len:\n\t.long %lu\n", ilen);
+	printf(".globl output_len\n");
+	printf("output_len:\n\t.long %lu\n", (unsigned long)olen);
+
 	retval = 0;
 bail:
 	if (f)
-- 
2.26.2

