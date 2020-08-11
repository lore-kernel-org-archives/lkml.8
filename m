Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9904C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F9520768
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hppMyx4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgHKR6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKR6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:58:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2924FC061788
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:58:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so7152193plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwLucdZe8Zl1sdg+rBs5gzd1/sOQ/Nnh9Dc69W2ZlPY=;
        b=hppMyx4QKg2UJb3qxcOpI1jplSB7I/4IFRBebdNFDIqOIqmv+o7ixbitDdJGq3vcUG
         /KLrDrbfIybVPxf4/FXQdluXL88QfJ4XeHlgDSolu6c9dhZgMa2k/A4bIO1QoVD7GpgV
         Xwf3wYgXY3X/aoeA7y5BvM3uCAnmjfQ6O8cf/kfy+Jutrx4PW4ESll6hVdsA6UBh8a9o
         HzLpmRdRsGUmK5Tgd0bGDdJBTbblNpmqczmsB0ax2StXBX0bj9yxckMDjNwn4O119Kqj
         5QrM6y8TkZa3EXfv60POSf2PJEcWYUpNGyED/o7RYz4ryhrU01nYUgmZDFGPDTj1Clfs
         Oy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwLucdZe8Zl1sdg+rBs5gzd1/sOQ/Nnh9Dc69W2ZlPY=;
        b=DJmQAMAQf4BIghPFztv9AOPvbZeUDTPuWdxDGOalTetzcPKw9Tdsd5sRjXHhbShFNM
         LRECmYFTXGrhg3BOaOWlspOAO9NGWdVMntzEf/8Z/Kng34qEoltWDw9b4Phta9c+uC4Q
         iGP4fZVEvZb+VAnQnk2ZTa2OsTNS7C0HNUBHjHzV1MDmMb5JEAup3Mqz+XEYoMyHlQB7
         umX9Bv36bh9tpe5Uk1rWtXdpYCdeJf1vD6+lTHIdA5PdHgKQpWK584SI/YFXnGhN9qi4
         jKjl87/VnzKT+c317iqbjJ7UsVzg1OHHn1HIpC+p9FfIQvj9V+3wzvy4CZ1W2M6I2ze0
         Uc0w==
X-Gm-Message-State: AOAM533gX3XuBXGNm63ig28Q5YEnZllhXafczF5W9ZwgbbngDOEj+X6y
        jFxIfYH6/LWLQ0Pf8/MPUO8ZyaMYIp68OtKJGljlZw==
X-Google-Smtp-Source: ABdhPJxrSYKU0WVBLGO8gzWsZ4Pu3tdO1qmy4CCNWHjfKq3SyuYhth5Im8WYLZE7blUD1zlIfFUbNzPcZ9l5upHTYZ8=
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr2287166pjp.32.1597168731165;
 Tue, 11 Aug 2020 10:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=ypa8xE-kaDa7XtzPsBH8=Xu_pZj2rnWaeawNs=3dDkw@mail.gmail.com>
 <20200811173655.1162093-1-nivedita@alum.mit.edu>
In-Reply-To: <20200811173655.1162093-1-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Aug 2020 10:58:40 -0700
Message-ID: <CAKwvOdnjLfQ0fWsrFYDJ2O+qFAfEFnTEEnW-aHrPha8G3_WTrg@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/compressed: Disable relocation relaxation for
 non-pie link
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fangrui Song <maskray@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        e5ten.arch@gmail.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:36 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> The x86-64 psABI [0] specifies special relocation types
> (R_X86_64_[REX_]GOTPCRELX) for indirection through the Global Offset
> Table, semantically equivalent to R_X86_64_GOTPCREL, which the linker
> can take advantage of for optimization (relaxation) at link time. This
> is supported by LLD and binutils versions 2.26 onwards.
>
> The compressed kernel is position-independent code, however, when using
> LLD or binutils versions before 2.27, it must be linked without the -pie
> option. In this case, the linker may optimize certain instructions into
> a non-position-independent form, by converting foo@GOTPCREL(%rip) to $foo.
>
> This potential issue has been present with LLD and binutils-2.26 for a
> long time, but it has never manifested itself before now:
> - LLD and binutils-2.26 only relax
>         movq    foo@GOTPCREL(%rip), %reg
>   to
>         leaq    foo(%rip), %reg
>   which is still position-independent, rather than
>         mov     $foo, %reg
>   which is permitted by the psABI when -pie is not enabled.
> - gcc happens to only generate GOTPCREL relocations on mov instructions.
> - clang does generate GOTPCREL relocations on non-mov instructions, but
>   when building the compressed kernel, it uses its integrated assembler
>   (due to the redefinition of KBUILD_CFLAGS dropping -no-integrated-as),
>   which has so far defaulted to not generating the GOTPCRELX
>   relocations.
>
> Nick Desaulniers reports [1,2]:
>   A recent change [3] to a default value of configuration variable
>   (ENABLE_X86_RELAX_RELOCATIONS OFF -> ON) in LLVM now causes Clang's
>   integrated assembler to emit R_X86_64_GOTPCRELX/R_X86_64_REX_GOTPCRELX
>   relocations. LLD will relax instructions with these relocations based
>   on whether the image is being linked as position independent or not.
>   When not, then LLD will relax these instructions to use absolute
>   addressing mode (R_RELAX_GOT_PC_NOPIC). This causes kernels built with
>   Clang and linked with LLD to fail to boot.
>
> Patch series [4] is a solution to allow the compressed kernel to be
> linked with -pie unconditionally, but even if merged is unlikely to be
> backported. As a simple solution that can be applied to stable as well,
> prevent the assembler from generating the relaxed relocation types using
> the -mrelax-relocations=no option.
>
> [0] https://gitlab.com/x86-psABIs/x86-64-ABI/-/blob/master/x86-64-ABI/linker-optimization.tex#L65
> [1] https://lore.kernel.org/lkml/20200807194100.3570838-1-ndesaulniers@google.com/
> [2] https://github.com/ClangBuiltLinux/linux/issues/1121
> [3] https://reviews.llvm.org/rGc41a18cf61790fc898dcda1055c3efbf442c14c0
> [4] https://lore.kernel.org/lkml/20200731202738.2577854-1-nivedita@alum.mit.edu/
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Cc: stable@vger.kernel.org # 4.19.x

Thanks Arvind, good write up.  Just curious about this stable tag, how
come you picked 4.19?  I can see boot failures in our CI for x86+LLD
back to 4.9.  Can we amend that tag to use `# 4.9`? I'd be happy to
help submit backports should they fail to apply cleanly.
https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/builds/179237488

> ---
>  arch/x86/boot/compressed/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 3962f592633d..c5449bea58ec 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -62,6 +62,12 @@ KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
>  endif
>  LDFLAGS_vmlinux := -T
>
> +# Disable relocation relaxation if not linking as PIE
> +ifeq ($(filter -pie,$(KBUILD_LDFLAGS)),)
> +KBUILD_CFLAGS += $(call as-option, -Wa$(comma)-mrelax-relocations=no)
> +KBUILD_AFLAGS += $(call as-option, -Wa$(comma)-mrelax-relocations=no)
> +endif
> +
>  hostprogs      := mkpiggy
>  HOST_EXTRACFLAGS += -I$(srctree)/tools/include
>
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers
