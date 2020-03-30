Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87317C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5429B2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfJ05alJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgC3QsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:48:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38870 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgC3QsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:48:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id x7so8925472pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xILmCXBrlxgCXlypA1VxqpUiVu1uQ5MP80zGKCZ/XFo=;
        b=EfJ05alJ+PSOBVvnx/SndsN/62Lik+lUYdgqoSbZm1dfE4FuIESt6rxZHaxGXjH/U9
         +d4l7cVHmOjuD4J1o3mjDNAKHB3ToTh41KtnFF37XPu06WUI/Iw83xS3w5cJeXenY3rX
         uS/72YpxbbrJB/T9eo4LEZm4ebLSiI47xcAogZpS8iufGqlLGddOUHPq9l5Cs09jWxQW
         S4g8U4KV5y0IdNUvJGwaAbWKRJSI34pQFZAVT7EVrdzNEIrphgEGVmcuLw+mgdje+B20
         V37vak2nUZbO8RraT8fSZtYeItV70ljo0es3rOjE085Mu4d6l2aYmA58ScNmr5odYjbP
         foxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xILmCXBrlxgCXlypA1VxqpUiVu1uQ5MP80zGKCZ/XFo=;
        b=m3BEI9Lo4uQgi7SBEWADG2bSNziebNjWb6V5b+ospYqdGKMC+0UmL7tkeWu1gABrQb
         nJUuE5MapUlG8/5Ale9YrAHqA1OG+1C66PkRHMsJ27zviUWjhleO1/9L4QH0tgyESXmH
         TpC8s3sdwoWsKJuwm3r+I/xREvk7tX3dOry958W1x8Jdo9360o8LUmO5q0WX+DCwXfNF
         l4lim7YOcOGbh5XQ5zLKwHzCl6S0rXQTqs8fbfhbf3uUF++l8h7irAgqnkDSZRPvsZy5
         3Jhnv9lB9kPuh0al6BAg9CgPf6QGGyP8mI1jmzFrXetbICsufP/cXz9aclt/QW6hm8VA
         b1qg==
X-Gm-Message-State: ANhLgQ2Ph+EaHCKrIHfYu+Z6QXczTQkvCZVePTLLwza5ySGiWIg4xDua
        q8lpo0R/BA+ZIPFxyHjLk+dG+3Zdppw8wKZSBvbjGQ==
X-Google-Smtp-Source: ADFU+vuE0dYbf2hIpTmjKgH9JUJJ9vpNHTYnzEQlhr0Cr+zru6/CN2o72hgQNvyT3rdvuGOmqLgGUd7pqrvfUv+fSow=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr13917544pgb.263.1585586898655;
 Mon, 30 Mar 2020 09:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <a651d5eaf312c771c9d2e0160ddd905550bbd4e3.1585507235.git.stefan@agner.ch>
In-Reply-To: <a651d5eaf312c771c9d2e0160ddd905550bbd4e3.1585507235.git.stefan@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Mar 2020 09:48:07 -0700
Message-ID: <CAKwvOdkJLROtbMSf1pOV2XMV7LB0TTnLx-43WMt34wiT2VEMew@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: warn if pre-UAL assembler syntax is used
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Manoj Gupta <manojgupta@google.com>,
        Jian Cai <jiancai@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 11:43 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Remove the -mno-warn-deprecated assembler flag to make sure the GNU
> assembler warns in case non-unified syntax is used.
>
> This also prevents a warning when building with Clang and enabling its
> integrated assembler:
> clang-10: error: unsupported argument '-mno-warn-deprecated' to option 'Wa,'
>
> GCC before 5.1 emits pre-UAL assembler. This can lead to warnings if
> inline assembler explicitly switches to unified syntax by using the
> ".syntax unified" directive (e.g. arch/arm/include/asm/unified.h).
> Hence keep the flag for GCC versions before 5.1.
>
> This is a second attempt of commit e8c24bbda7d5 ("ARM: 8846/1: warn if
> divided syntax assembler is used") which has subsequently been reverted
> with commit b752bb405a13 ("Revert "ARM: 8846/1: warn if divided syntax
> assembler is used"").
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks for the added context.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> Changes in v2:
> - Reference revert commit b752bb405a13 ("Revert "ARM: 8846/1: warn if
>   divided syntax assembler is used"")
> - Reword commit message
>
>  arch/arm/Makefile | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 1fc32b611f8a..b37bb985a3c2 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -119,21 +119,25 @@ ifeq ($(CONFIG_CC_IS_CLANG),y)
>  CFLAGS_ABI     += -meabi gnu
>  endif
>
> -# Accept old syntax despite ".syntax unified"
> -AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
> -
>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
> -CFLAGS_ISA     :=-mthumb -Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
> +CFLAGS_ISA     :=-mthumb -Wa,-mimplicit-it=always
>  AFLAGS_ISA     :=$(CFLAGS_ISA) -Wa$(comma)-mthumb
>  # Work around buggy relocation from gas if requested:
>  ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
>  KBUILD_CFLAGS_MODULE   +=-fno-optimize-sibling-calls
>  endif
>  else
> -CFLAGS_ISA     :=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
> +CFLAGS_ISA     :=$(call cc-option,-marm,)
>  AFLAGS_ISA     :=$(CFLAGS_ISA)
>  endif
>
> +ifeq ($(CONFIG_CC_IS_GCC),y)
> +ifeq ($(call cc-ifversion, -lt, 0501, y), y)
> +# GCC <5.1 emits pre-UAL code and causes assembler warnings, suppress them
> +CFLAGS_ISA     +=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
> +endif
> +endif
> +
>  # Need -Uarm for gcc < 3.x
>  KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
>  KBUILD_AFLAGS  +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
