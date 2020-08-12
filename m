Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DA3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BB120781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jahJjF01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHLRms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHLRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:42:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4769C061384
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:42:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f10so1428210plj.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7lVOCmkI+O7/barsvdFAonBSJY77xfLcdY4hWtrU8E=;
        b=jahJjF019IWeZ+BNfrxeznJTrfR1c2QYGhhSLhuAHR5iJp24yKoX7RP6BGWItP1ekC
         ERyp/j0bljsW8ojmOumYe2oGwKKa9OcJgL4uQMtWduQgWjYFs6BYMCLdcpUfiUVi1RwI
         bHzFigpwBmCXiYSQMlqhPv5daXMIYO8Z+USVnvoK5XP143Iu1bWnt66+F3POP8uJA8GH
         lPFBb4y2pG5a2ovbbl325favh4TsFqlLDXfZGYcs/lKzrdvrCt8TWdsNGX/hQAJYWxtS
         duqPqvQRKZYysxAkjEQGTuebp/R3BBcgE8Q7wr3bKtX3AyAXmQvwbO8eQQtWN0ceqSR9
         WJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7lVOCmkI+O7/barsvdFAonBSJY77xfLcdY4hWtrU8E=;
        b=rYgllQlotVMxL3+sB+m0oGNloFFBh2GupDq3YCKXHKFGK3HFMVo9L3fYPyrYBDd8vT
         5V1NN3wBen7nntnOVE6sPmFnfcUbgTCNrFHbDPbttfY/NfDWU/L2Q/u6fH3Da1YVeNaZ
         6/2W6TPLVAz1Erk/YznZ9SHtPqRGdUdMba8zTneS2+zknNZdsS6TxgCu1Rx8Hi9SSW4i
         nQ+G/tyvvJGo8Xoc8YBfVgTuCgjDGR0A8dKxsXylWCfpkUFPzkmMFlCF82eHaXVJbNht
         7zdBqPJv7z5ZiaS43j9twjLMk4moUMEkhP433BWmfUy7BKkxPTVl02luR+c4yGzsAXC+
         SVGA==
X-Gm-Message-State: AOAM531AtSTZxPAruCTp93vi/iCufxPYL6eBgnqhGtyuOlsqE6DVw2nx
        SPEno8HgN2/agMu9mIAMjej9gNKZq6Htgw3hN84jcA==
X-Google-Smtp-Source: ABdhPJxU0a+JqCX/ZqStj24HUP9zNoor7jR8UWBY+W4ekdzMs7E+T9VovrtJW7ZoWh9PxIgaBi55OH0pPDC1sAobhI4=
X-Received: by 2002:a17:90a:3ad1:: with SMTP id b75mr1067394pjc.25.1597254165017;
 Wed, 12 Aug 2020 10:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200812004158.GA1447296@rani.riverdale.lan> <20200812004308.1448603-1-nivedita@alum.mit.edu>
In-Reply-To: <20200812004308.1448603-1-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Aug 2020 10:42:34 -0700
Message-ID: <CAKwvOd==e69E82FY937E5cSX5tPGgLGTLenWQR-GUUVFN9=epA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/boot/compressed: Disable relocation relaxation
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

On Tue, Aug 11, 2020 at 5:43 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
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
> the -mrelax-relocations=no option. For ease of backporting, do this
> unconditionally.
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

LGTM

> ---
>  arch/x86/boot/compressed/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 3962f592633d..ff7894f39e0e 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -43,6 +43,8 @@ KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  KBUILD_CFLAGS += -D__DISABLE_EXPORTS
> +# Disable relocation relaxation in case the link is not PIE.
> +KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
>
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  GCOV_PROFILE := n
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers
