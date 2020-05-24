Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B82C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC382076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeeaUABZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbgEXXgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387914AbgEXXgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:36:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A90C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:36:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bg4so1520272plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/xSfk8UNIM4h1pIcoF/9EHCGXYkBOmPVW3Mq1rqJ1Bw=;
        b=QeeaUABZgKIL3kaH31FoNGWufVvWNec0TZ5UsuZOCEnRk8+eS9pjWgzJoSn40kG1/X
         jcFJsZBiLmNaB6+b303tdFBI8ErFJV3+8eH04UQ09wr6+O2uNq4lMQLFLCDvQlMR32+0
         RMQRBXbHx2kLpct8xh7/2/J1ysJavNbZXn/J9gcbrShTm+w9Oduh2gZDQR650KYJe8uH
         PWLitPBXKBd7t0Rvp93AHI1f4k6937DS2jmw8p0LFJzTEmA3wKtitNkgzH9YVclSyrVx
         diTra4psaw+vbpNgtDYUNQWP8nsVCZN5eqCJMfTCKxZi4fPf16rfpA7EWaP/n8lw4zZG
         UVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/xSfk8UNIM4h1pIcoF/9EHCGXYkBOmPVW3Mq1rqJ1Bw=;
        b=gh9h/TzeNWvw6zPZs8Fo0bzFoq5P2k/hVTjDKWzzChrknFeBC6G2+vP+LWa91sgT2w
         wDDmj6Mebn27TFOScPHZiEXJYLQinlWuPcQwY4pgTXYcqMMPXa74btx4rRs6nOYf9sC4
         9FK6A0FiK5Sod6+Q8QsTvQBHeyG3OLf7HApecod+I1m+I1pO6XPtAh4hVpwf0k4wO7+u
         /UVh7mxt6jyn4Bk522CgH9iEF+l0BbwVmllbkIEQ7IITLwuBVej+pIte0t82Z7mfQEe5
         82zGFNmN6dxxv/LXlQ8J7oayY1iQRO9iEaTn1Q4Wb4coOhTdepDuFuBWqR15BUk9IUCv
         8tDw==
X-Gm-Message-State: AOAM531A9bMR1+rhZSiDdvN7zhYOsONjiR7uUdEQ/Ky7UD+RlwmcIlw/
        KFqTgcQlxGp1smR11yBX35Zopg==
X-Google-Smtp-Source: ABdhPJwl3z03bzxPrfzpnHzT7q7i/5q9HmT8LeSs/4VODMqNHafKAP74M3UOCJZYTdUgne7W8QlTjQ==
X-Received: by 2002:a17:90a:64c6:: with SMTP id i6mr16719577pjm.14.1590363372259;
        Sun, 24 May 2020 16:36:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id 2sm11652343pfz.39.2020.05.24.16.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:36:11 -0700 (PDT)
Date:   Sun, 24 May 2020 16:36:07 -0700
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
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/boot: Check that there are no runtime relocations
Message-ID: <20200524233607.cihnsmxuaqoy7xi4@google.com>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-5-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200524212816.243139-5-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-24, Arvind Sankar wrote:
>Add a linker script check that there are no runtime relocations, and
>remove the old one that tries to check via looking for specially-named
>sections in the object files.
>
>Drop the tests for -fPIE compiler option and -pie linker option, as they
>are available in all supported gcc and binutils versions (as well as
>clang and lld).
>
>Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>---
> arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
> arch/x86/boot/compressed/vmlinux.lds.S | 11 ++++++++++
> 2 files changed, 14 insertions(+), 25 deletions(-)
>
>diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>index d3e882e855ee..679a2b383bfe 100644
>--- a/arch/x86/boot/compressed/Makefile
>+++ b/arch/x86/boot/compressed/Makefile
>@@ -27,7 +27,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
> 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
>
> KBUILD_CFLAGS := -m$(BITS) -O2
>-KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
>+KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
> KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> cflags-$(CONFIG_X86_32) := -march=i386
> cflags-$(CONFIG_X86_64) := -mcmodel=small
>@@ -49,7 +49,7 @@ UBSAN_SANITIZE :=n
> KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> # Compressed kernel should be built as PIE since it may be loaded at any
> # address by the bootloader.
>-KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
>+KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
> LDFLAGS_vmlinux := -T
>
> hostprogs	:= mkpiggy
>@@ -84,30 +84,8 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
> vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
>
>-# The compressed kernel is built with -fPIC/-fPIE so that a boot loader
>-# can place it anywhere in memory and it will still run. However, since
>-# it is executed as-is without any ELF relocation processing performed
>-# (and has already had all relocation sections stripped from the binary),
>-# none of the code can use data relocations (e.g. static assignments of
>-# pointer values), since they will be meaningless at runtime. This check
>-# will refuse to link the vmlinux if any of these relocations are found.
>-quiet_cmd_check_data_rel = DATAREL $@
>-define cmd_check_data_rel
>-	for obj in $(filter %.o,$^); do \
>-		$(READELF) -S $$obj | grep -qF .rel.local && { \
>-			echo "error: $$obj has data relocations!" >&2; \
>-			exit 1; \
>-		} || true; \
>-	done
>-endef
>-
>-# We need to run two commands under "if_changed", so merge them into a
>-# single invocation.
>-quiet_cmd_check-and-link-vmlinux = LD      $@
>-      cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
>-
> $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>-	$(call if_changed,check-and-link-vmlinux)
>+	$(call if_changed,ld)
>
> OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
> $(obj)/vmlinux.bin: vmlinux FORCE
>diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>index d826ab38a8f9..0ac14feacb24 100644
>--- a/arch/x86/boot/compressed/vmlinux.lds.S
>+++ b/arch/x86/boot/compressed/vmlinux.lds.S
>@@ -11,9 +11,15 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
> #ifdef CONFIG_X86_64
> OUTPUT_ARCH(i386:x86-64)
> ENTRY(startup_64)
>+
>+#define REL .rela
>+
> #else
> OUTPUT_ARCH(i386)
> ENTRY(startup_32)
>+
>+#define REL .rel
>+
> #endif
>
> SECTIONS
>@@ -42,6 +48,9 @@ SECTIONS
> 		*(.rodata.*)
> 		_erodata = . ;
> 	}
>+	REL.dyn : {
>+		*(REL.*)
>+	}
> 	.got : {
> 		*(.got)
> 	}
>@@ -83,3 +92,5 @@ ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT en
> #else
> ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> #endif
>+
>+ASSERT(SIZEOF(REL.dyn) == 0, "Unexpected runtime relocations detected!")
>-- 
>2.26.2
>

`grep -qF .rel.local` from 98f78525371b55ccd1c480207ce10296c72fa340
may be incorrect.. None of these synthesized dynamic relocation sections is
called *.rel.local* ...
(it probably wanted to name .rel.data.rel.ro or .rel.data)


Reviewed-by: Fangrui Song <maskray@google.com>
