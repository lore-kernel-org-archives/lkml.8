Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99F7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB6B2078E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWKkvmYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbgFXAIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbgFXAIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:08:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4278C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:08:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z63so240340pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRgmfafY1mJluwYuJJ0X9+G+6ttRBFMzFbyrEBuldZU=;
        b=ZWKkvmYq76sEFQ5D5SKrVoXbpVHbtmeMcZxyeb7qllyZD5JRFlwAeKdA8z2EX5vfWH
         tGLE/098qS/AHYcvtV+Eiv8Cm4X86J2Jyexc6Zs2yy5ckZywUP3R4n7AIkGgtex+QjYs
         q/bxsdSIlhftg6iMEFxyPnJv2xP29e01UsRDcrV3MEA3EeXUG+GRWbeebc8594jAhR/a
         1QpLI/l52KqXi5ttmPa8CAjls7fFuGJwh5R1xtRQhRFp4hWsL+jg51PO7znuvzrhJrZq
         KeFppVjtZQaNn994XhCUc5pp/ewO6WulXiIqir2lNdvawWGhxuKvbLIc2vyaDEkwxzhZ
         1mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRgmfafY1mJluwYuJJ0X9+G+6ttRBFMzFbyrEBuldZU=;
        b=NfWRctw6LHYiIXH9g+BKdqtodFbJiGs8FYH6W4zUtlqqPW4BAnT4Nte5YepGUZPRuj
         2KEIWqBAWD6z9ePI4/D7D+t8MK4IhgyN3mHyAmTLgf0euRfRzUHQa7XeC0pLNtCr9DD3
         xQVQvyOJpHpYmr2XrNJ/CiEXnehdjwIy0GdHkbaJGLjjYHigDQP5Jm39ywd+HFd6y15m
         kmCXO3W9Dw0scy+mN5WKnT9WyMkkxk+wLhzPV+NkQH6H7ptvk5TonDQJWVGhaF5p1kss
         h38aTYSqhFGwtn3LPDVINlvAzf7s01izj0ST4ImWZeBjCUNmkFObP2w/r8A85okhDFi5
         rUNw==
X-Gm-Message-State: AOAM5339b0WS9DIRjvtKG6pSCtWY90j10Nro0anJ9TlUo2rJ8/ffsBex
        zdExCF/4LYMYiUIIVOpKtOHdBOI6iMG3k2qDYIruUg==
X-Google-Smtp-Source: ABdhPJw+7tt9ppb+wbWUQRgjdyIBDB0MLJhcd4yY9cI4qfuGbB2kUl1H+gul0cUULuHUG+kBiVnEUb79K/QEMdd6Xx4=
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr27661737pfu.169.1592957321214;
 Tue, 23 Jun 2020 17:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200622204915.2987555-1-keescook@chromium.org> <20200622204915.2987555-3-keescook@chromium.org>
In-Reply-To: <20200622204915.2987555-3-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jun 2020 17:08:30 -0700
Message-ID: <CAKwvOdnvgHS4bUbf58m9dpZp7=0dYLVQ=EW-LDY=u5a5_AfO9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm/boot: Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 1:49 PM Kees Cook <keescook@chromium.org> wrote:
>
> We don't want to depend on the linker's orphan section placement
> heuristics as these can vary between linkers, and may change between
> versions. All sections need to be explicitly named in the linker
> script.
>
> Use common macros for debug sections, discards, and text stubs. Add
> discards for unwanted .note, and .rel sections. Finally, enable orphan
> section warning.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm/boot/compressed/Makefile      |  2 ++
>  arch/arm/boot/compressed/vmlinux.lds.S | 17 +++++++----------
>  2 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 00602a6fba04..b8a97d81662d 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -128,6 +128,8 @@ endif
>  LDFLAGS_vmlinux += --no-undefined
>  # Delete all temporary local symbols
>  LDFLAGS_vmlinux += -X
> +# Report orphan sections
> +LDFLAGS_vmlinux += --orphan-handling=warn
>  # Next argument is a linker script
>  LDFLAGS_vmlinux += -T
>
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> index 09ac33f52814..c2a8509f876f 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -2,6 +2,7 @@
>  /*
>   *  Copyright (C) 2000 Russell King
>   */
> +#include <asm/vmlinux.lds.h>
>
>  #ifdef CONFIG_CPU_ENDIAN_BE8
>  #define ZIMAGE_MAGIC(x) ( (((x) >> 24) & 0x000000ff) | \
> @@ -17,8 +18,11 @@ ENTRY(_start)
>  SECTIONS
>  {
>    /DISCARD/ : {
> +    ARM_COMMON_DISCARD
>      *(.ARM.exidx*)
>      *(.ARM.extab*)
> +    *(.note.*)
> +    *(.rel.*)

.rel.* is the only case I'm curious about.  Why do we want it in
vmlinux, but not the compressed image?  Should `.rel.*` just be part
of ARM_COMMON_DISCARD from the previous patch?

>      /*
>       * Discard any r/w data - this produces a link error if we have any,
>       * which is required for PIC decompression.  Local data generates
> @@ -36,9 +40,7 @@ SECTIONS
>      *(.start)
>      *(.text)
>      *(.text.*)
> -    *(.gnu.warning)
> -    *(.glue_7t)
> -    *(.glue_7)
> +    ARM_STUBS_TEXT
>    }
>    .table : ALIGN(4) {
>      _table_start = .;
> @@ -128,12 +130,7 @@ SECTIONS
>    PROVIDE(__pecoff_data_size = ALIGN(512) - ADDR(.data));
>    PROVIDE(__pecoff_end = ALIGN(512));
>
> -  .stab 0              : { *(.stab) }
> -  .stabstr 0           : { *(.stabstr) }
> -  .stab.excl 0         : { *(.stab.excl) }
> -  .stab.exclstr 0      : { *(.stab.exclstr) }
> -  .stab.index 0                : { *(.stab.index) }
> -  .stab.indexstr 0     : { *(.stab.indexstr) }
> -  .comment 0           : { *(.comment) }
> +  STABS_DEBUG
> +  DWARF_DEBUG
>  }
>  ASSERT(_edata_real == _edata, "error: zImage file size is incorrect");
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
