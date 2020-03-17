Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60275C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F543205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGpp5MKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbgCQABK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:01:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45606 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732932AbgCQABK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:01:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id m15so10657209pgv.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 17:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxhrdycLqRcl8yZff8EnF0nl6QUAsSQr4n1zOEszaCY=;
        b=hGpp5MKNrLkuVxANrcMITjU27Tdvqc3/M1B6yJhPIhrzb96wsFQn7k0MH8NlDeU5iw
         WMerX/ldZvWsQ4/hUYNJfmjG2mXU0t26LUSqZgdb+HLcHwoTrPovBW7SzykSPOz9Ipac
         RoM6uinpJk4FsyX6BAM3ms31dSgNn1e2qkI24GKFaDfZi4NvXpXlWLTqOLsdP/sOhxDq
         LfbMFjihhafmZNBGZuF/s8E4ft3KpWpA4oOvwKX9OW04Oz0GiGxFck3ZosNQB/Vj3hIE
         xMh1PlPk7oGt24pwKvW9ml6nSDdYa034I8zuT3UFoJCeeoieDzjRAlazAnXVNiqGt3Yc
         Qv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxhrdycLqRcl8yZff8EnF0nl6QUAsSQr4n1zOEszaCY=;
        b=O4w5Ts7xrCBSX+gNVFgYXNZPYQzV/B+v0DlbaCNAyeAu9zomPZjCqeGej6GjRoP6WA
         IE2rlqy1cNOPigjLstNg94KtfUWYn3TEkQNnmA+auHnUAMpe0iNE9o5f7LLRqAzAh6ym
         IwxIgdHE4iwqTiqe9CG8r4jteO0tg21UEmSE6uBZLNPNT13sGT/GjXKQIq9bmbYAoBmN
         tGu3fdSubnNBI85/AxEVk7GCMb/DFOGL2rmcVFDy5DH4YRYrlFR8GwGSJXMWk0aEbc5n
         z7G4y29iXuMAC9AKAqbe5SiZz+UN2w7Q2X0k8vbwaKbpQA1wqFCL6KPjLct2UlAm1lpM
         qCzg==
X-Gm-Message-State: ANhLgQ1eif4ZOBJ+mILf6+YxWweaptVdGJAKSZkbNhxd0KyeKPl8ACqk
        s8b/71HLX0uVseiZLAzaWNCMWHRiP2K9oyF6QUgNKg==
X-Google-Smtp-Source: ADFU+vv9AtJkgZLCZ1s4+2h7aCl6Dr9hKC9TPsDL0u4RkJ+TzVVPfEcn6f6bdRh8QyFFOH51PmZUbrPOwUpGb4mKEEw=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr2321252pgb.263.1584403269224;
 Mon, 16 Mar 2020 17:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <cd74f11eaee5d8fe3599280eb1e3812ce577c835.1582849064.git.stefan@agner.ch>
In-Reply-To: <cd74f11eaee5d8fe3599280eb1e3812ce577c835.1582849064.git.stefan@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Mar 2020 17:00:57 -0700
Message-ID: <CAKwvOdneF5nXgx3Rh6=NhPK+q93VRhs7mDCcK2eGY0e2rOqqnQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: warn if pre-UAL assembler syntax is used
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
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

Revert "ARM: 8846/1: warn if divided syntax assembler is used"On Thu,
Feb 27, 2020 at 4:19 PM Stefan Agner <stefan@agner.ch> wrote:
>
> Remove the -mno-warn-deprecated assembler flag for GCC versions newer
> than 5.1 to make sure the GNU assembler warns in case non-unified
> syntax is used.

Hi Stefan, sorry for the late reply from me; digging out my backlog.
Do you happen to have a godbolt link perhaps that demonstrates this?
It sounds like GCC itself is emitting pre-UAL?

>
> This also prevents a warning when building with Clang and enabling
> its integrated assembler:
> clang-10: error: unsupported argument '-mno-warn-deprecated' to option 'Wa,'
>
> This is a second attempt of commit e8c24bbda7d5 ("ARM: 8846/1: warn if
> divided syntax assembler is used").

Would it be helpful to also make note of
commit b752bb405a13 ("Revert "ARM: 8846/1: warn if divided syntax
assembler is used"")?


>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/Makefile | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index db857d07114f..a6c8c9f39185 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -119,21 +119,25 @@ ifeq ($(CONFIG_CC_IS_CLANG),y)
>  CFLAGS_ABI     += -meabi gnu
>  endif
>
> -# Accept old syntax despite ".syntax unified"
> -AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)

This existing code is quite bad for Clang, which doesn't support
`-Wa,-mno-warn-deprecated`, so this falls back to `-Wa,-W`, which
disables all warnings from the assembler, which we definitely do not
want.  That alone is worth putting in the GCC guard.  But I would like
more info about GCC above before signing off.

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

-- 
Thanks,
~Nick Desaulniers
