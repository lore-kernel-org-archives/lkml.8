Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EBCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D411820885
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Im8v5EGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgF2TsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388105AbgF2TrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:47:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08817C03E97A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:47:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so7498479plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gz1zQHU9+r/YpON9C/k1EX29gyKSkYfOsfpz38zwBA=;
        b=Im8v5EGyC2StppMSLYm6OQn+oLGyJfaUm6K7ize3Z/Umh4ZYnOr1TcUmPi9B+HpLUQ
         cLC2XsUaCI472AeGUmVPqaS4Bmla9oHo9I+AIWRkU0tKMAkgxKOPmsmCHTRZotVKURc+
         3Ej3S2v2UMRKvyl3Q/MUcNjQN9lw0K08BG3VVAlkAHIGdIZymVTArWa791V22RfReKvK
         d4Xn9SrFlNP5F7C5P+8Tu8DV3TMfCi8RkBELIdz9ah/XgEYZ0E2gxGyacBn2DlN9d4M/
         w6i7bvKZcnFz+1hsf9o46nd5nuTk8SAC+MJFu9ob0741d4CQ4emNSBIyIp+27VDHdBTP
         6/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gz1zQHU9+r/YpON9C/k1EX29gyKSkYfOsfpz38zwBA=;
        b=cP8p/cXlvsdSEkW0Fsj2pFTMrYl0gNxNgWAK7egK/2l6H74YZyjZszsZL7RVUw+XiQ
         epApdicI9WIaoVczO6kntubjg9ekMt1EbhiZuOZ6Hanwr1OWx94zFB0kVg8riXHcQc2M
         Oogl/I464ap0bB/rOtk2sp1V/9M5MP1ZrPjm1/VXBl1cBWARkN+aXMMFWSDCvC+NaJv6
         m6azUcEhSzDhiz4IHPsIi/TffMNv1r7rXWw9kRlGpq/ejeVDL80tE8sU9OPvCp4vDn5I
         ItxD0JN6ZJyE89I43F1zV/jZCs6Lp90E++zTxvffqTedgFLBlG9CRgvmujEFedLSzk+z
         4wzA==
X-Gm-Message-State: AOAM532k468H5Q/ATuH/X+B69eK1qZ7HPCQMFfyQyEVerR0gE4b/NzOY
        dFXVJo0DC/1Ow6TFNmjHis+i2jwcft0x0TXdpf7T6g==
X-Google-Smtp-Source: ABdhPJxD+NDMzpTLVtkwIahVlE1Ojd9ohblWdC3y8HeoT1NdlP3ApesamY48WnXvCXAzV3iGs4MYCMe98HbhJvlJHpE=
X-Received: by 2002:a17:90a:30ea:: with SMTP id h97mr18995233pjb.32.1593460035317;
 Mon, 29 Jun 2020 12:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200629061840.4065483-1-keescook@chromium.org> <20200629061840.4065483-15-keescook@chromium.org>
In-Reply-To: <20200629061840.4065483-15-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jun 2020 12:47:03 -0700
Message-ID: <CAKwvOdnErUWrJUaw9gm3ZSOpD2JepZKod3REBctzBr4QuHLiAA@mail.gmail.com>
Subject: Re: [PATCH v4 14/17] arm/build: Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> We don't want to depend on the linker's orphan section placement
> heuristics as these can vary between linkers, and may change between
> versions. All sections need to be explicitly named in the linker
> script.
>
> Specifically, this would have made a recently fixed bug very obvious:
>
> ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'
>
> Discard unneeded sections .iplt, .rel.iplt, .igot.plt, and .modinfo.
>
> Add missing text stub sections .vfp11_veneer and .v4_bx.
>
> Add debug sections explicitly.
>
> Finally enable orphan section warning.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for following up on the previous suggestion regarding .glu_7 /
.glu_7t ordering. LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/include/asm/vmlinux.lds.h | 6 +++++-
>  arch/arm/kernel/vmlinux-xip.lds.S  | 1 +
>  arch/arm/kernel/vmlinux.lds.S      | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
> index c66b16cd8837..d44fae722e7a 100644
> --- a/arch/arm/include/asm/vmlinux.lds.h
> +++ b/arch/arm/include/asm/vmlinux.lds.h
> @@ -39,6 +39,8 @@
>                 __idmap_text_end = .;                                   \
>
>  #define ARM_COMMON_DISCARD                                             \
> +               *(.iplt) *(.rel.iplt) *(.igot.plt)                      \
> +               *(.modinfo)                                             \
>                 *(.discard)                                             \
>                 *(.discard.*)
>
> @@ -63,7 +65,9 @@
>  #define ARM_STUBS_TEXT                                                 \
>                 *(.gnu.warning)                                         \
>                 *(.glue_7)                                              \
> -               *(.glue_7t)
> +               *(.glue_7t)                                             \
> +               *(.vfp11_veneer)                                        \
> +               *(.v4_bx)
>
>  #define ARM_TEXT                                                       \
>                 IDMAP_TEXT                                              \
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 57fcbf55f913..11ffa79751da 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -150,6 +150,7 @@ SECTIONS
>         _end = .;
>
>         STABS_DEBUG
> +       DWARF_DEBUG
>         ARM_DETAILS
>  }
>
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 1d3d3b599635..dc672fe35de3 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -149,6 +149,7 @@ SECTIONS
>         _end = .;
>
>         STABS_DEBUG
> +       DWARF_DEBUG
>         ARM_DETAILS
>  }
>
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200629061840.4065483-15-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
