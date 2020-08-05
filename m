Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E388C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61447206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7zDMfTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgHETSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgHETQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:16:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39238C061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 12:16:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ep8so4947646pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkmFyG52wjJPsFo+KzVqJsJKl7IJxS/xx3YOl+eRHzM=;
        b=k7zDMfTFxk8JnB8TgeYLfypFbQ2++Busy0lqmkagGYMVzK9j/01eZytdPYe6nZunW3
         /PudDDvJsjceVLXm89FLA9DKT6Yfz9OVU6pGkEmYcUFARSUiPR0z1CtKTuF2NV3cVsVi
         eZK/o4FjojYVX8LpYyDMoUPaam7ytKFie+CaNpaSg0hoJ3WH7ogQKPx2YnJaooYnytMU
         Takd+XWse1MQkhYWNnAR4FMyhmf0/LYEj9nqVfEKk/mimbuXIDOyNPsT0re8wzoNKvA1
         xb6mARrtUBzLAe4Ye6zcO2RlVTrecnOTJGZ+DhZiwmfR7OQ43wopmfzw/Zd5Rx9xwBGN
         7snQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkmFyG52wjJPsFo+KzVqJsJKl7IJxS/xx3YOl+eRHzM=;
        b=Fv5/BJMQROZrlu1x4Zidt4MVrMxEw1Q2C+mZvZcgLyNtD3FxMC2ni6EB4tRocAn87t
         AQAKr3/ec6bH+7Dw1GWF1D+3ZAmtx8mt0iWmKu15eeR01fli8zoyElI9ugVm0PeAJBOM
         FLzrrHqp4ii4OkdPPCOCy4gZllttPGqShxdblGeJexRtd/50XGYKwMGfCnivMKxXMAVn
         H65U9AF7rgAinljyRGeqbVIMKZ8JiyLlSyjb3D7KyCQKouGKFZC4UeaiQrCpB1AyrIlM
         7/l5tqEKZA8Ll9wruS22YDwnBll+H9JCaRLwadc0FDCRbClmNAHdHJ3fMwqJNIG3U4ZY
         P6Gg==
X-Gm-Message-State: AOAM532MhKsa/fB7xAyt9lC6BFVagtkaIFDWKW9FJL5iirYS6s4HQ+1X
        RujQrR9yZiBm/al+Maq9tFX5KxeF71XjEqpziQrVIA==
X-Google-Smtp-Source: ABdhPJyCA9qw2gaHKPatgawhFP9M09a/tCzHU/LtleaJuYAh5YXNaloSDteGKH1rjGVtpXRVQjLAAnQ9pI05jjtDYI4=
X-Received: by 2002:a17:90a:fc98:: with SMTP id ci24mr4860374pjb.101.1596654965300;
 Wed, 05 Aug 2020 12:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200805181920.4013059-1-samitolvanen@google.com>
In-Reply-To: <20200805181920.4013059-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Aug 2020 12:15:54 -0700
Message-ID: <CAKwvOdncvJbxphoDFdWTeiMnuu4pDie9xCxA-dC=__CK9p1KBw@mail.gmail.com>
Subject: Re: [PATCH] arm64: tlb: fix ARM64_TLB_RANGE with LLVM's integrated assembler
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 11:19 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Commit 7c78f67e9bd9 ("arm64: enable tlbi range instructions") breaks
> LLVM's integrated assembler, because -Wa,-march is only passed to
> external assemblers and therefore, the new instructions are not enabled
> when IAS is used.
>
> As binutils doesn't support .arch_extension tlb-rmi, this change adds
> .arch armv8.4-a to __TLBI_0 and __TLBI_1 to fix the issue with both LLVM
> IAS and binutils.
>
> Fixes: 7c78f67e9bd9 ("arm64: enable tlbi range instructions")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1106
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I've filed https://sourceware.org/bugzilla/show_bug.cgi?id=26339 to
discuss more with ARM binutils devs about some of the compat issues
around these assembler directives.

> ---
>  arch/arm64/include/asm/tlbflush.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index d493174415db..66c2aab5e9cb 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -16,6 +16,16 @@
>  #include <asm/cputype.h>
>  #include <asm/mmu.h>
>
> +/*
> + * Enable ARMv8.4-TLBI instructions with ARM64_TLB_RANGE. Note that binutils
> + * doesn't support .arch_extension tlb-rmi, so use .arch armv8.4-a instead.
> + */
> +#ifdef CONFIG_ARM64_TLB_RANGE
> +#define __TLBI_PREAMBLE        ".arch armv8.4-a\n"
> +#else
> +#define __TLBI_PREAMBLE
> +#endif
> +
>  /*
>   * Raw TLBI operations.
>   *
> @@ -28,14 +38,16 @@
>   * not. The macros handles invoking the asm with or without the
>   * register argument as appropriate.
>   */
> -#define __TLBI_0(op, arg) asm ("tlbi " #op "\n"                                       \
> +#define __TLBI_0(op, arg) asm (__TLBI_PREAMBLE                                \
> +                              "tlbi " #op "\n"                                \
>                    ALTERNATIVE("nop\n                   nop",                  \
>                                "dsb ish\n               tlbi " #op,            \
>                                ARM64_WORKAROUND_REPEAT_TLBI,                   \
>                                CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)            \
>                             : : )
>
> -#define __TLBI_1(op, arg) asm ("tlbi " #op ", %0\n"                           \
> +#define __TLBI_1(op, arg) asm (__TLBI_PREAMBLE                                \
> +                              "tlbi " #op ", %0\n"                            \
>                    ALTERNATIVE("nop\n                   nop",                  \
>                                "dsb ish\n               tlbi " #op ", %0",     \
>                                ARM64_WORKAROUND_REPEAT_TLBI,                   \
>
> base-commit: 4834ce9d8e074bb7ae197632e0708219b9f389b5
> --
> 2.28.0.163.g6104cc2f0b6-goog
>


-- 
Thanks,
~Nick Desaulniers
