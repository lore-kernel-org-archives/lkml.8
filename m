Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC3EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2468920756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6lLvYIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgETAhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETAhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:37:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C053FC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:37:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so612619pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQAC1NT3NV5Ww2kROWBg4S08R6BZXLL6056v3cyEbG4=;
        b=T6lLvYIBngb6iPsCaE8JllJMmnC3vdeLg2p6PFsZt1Pwjh0pU90liHRmcMUVmbtfZM
         vk95GAlvhSiLZtivLWgBNv2R5GF0r1t6qWcHjs9nN+BNY1VeZmwyTRnqUBZ7IBOSZj/0
         hftWoYHs6selOoE08s26T8YhCYg1PiYtoe0c3O1lZ/5p9gH7X93WTtaHsBEMKQx9iJHI
         slLNSEeZ8/4jdXT8G/ZTZPvEjA2Fui2amNauBYfBYtI44R0el3tGP3DGT3H990vdgwEu
         P/xsoce1HxzME/QhfOCrVjsnavKsWAlDIDw+1ooD5oKxBiSPgfe+1cgEHeOBY2AIlxBA
         6HBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQAC1NT3NV5Ww2kROWBg4S08R6BZXLL6056v3cyEbG4=;
        b=NTgWTKQVCO3/9Q9ofevJ1iHHGuA78tv8JtUnuN9vBuFfxnhF7F0FJllToLxLWxDWwX
         xKO5oMa4Sub1H+Jc6l96aBdqWgEHJs39gsJLFHF4jPKtE8b2kST5egVFyeOsSeuVQIc2
         MUvZ98jhM7oN2cQ1kdCMRG8k6zmb51y5L5oRA22liqn16YrlzLAynL+qbA5pr76a6pzz
         UGGp6pG0oDDJtr1p24aGtWuenVuaG87owCbkds6iQcbO/MxUvxwd3RJp6hHNfs2bNgwJ
         DpZQxsVYQQXpFsPHNUqnzksMgsa/qPSHBkb53uaSpKsJjU/LVojY47NhyGd9rNNTPKm7
         HL8A==
X-Gm-Message-State: AOAM532inu9kFEmLDC5UJl4K9o18oW06o+sbqgwMxzCI1f69c1jVmsd4
        NLLXKldXgGtSiUvMXsZX6W/PpkpNAUG1UB95PIt0+w==
X-Google-Smtp-Source: ABdhPJykkPJYM8ZFPfm85nN9F6Z6DBqxzVVeRgleCd3daeC11p6ktS1REPTfebjsB5jDE3fwEvjIoG/9DlXUlA2jjlM=
X-Received: by 2002:aa7:8c44:: with SMTP id e4mr1708302pfd.108.1589935068779;
 Tue, 19 May 2020 17:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200519220923.1601303-1-arnd@arndb.de>
In-Reply-To: <20200519220923.1601303-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 May 2020 17:37:37 -0700
Message-ID: <CAKwvOdmH6bMJHzxSs2mVN=P5BBYjYrDs13-oq-Qq+S4ykHSYvA@mail.gmail.com>
Subject: Re: [PATCH] ARM: pass -msoft-float to gcc earlier
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Szabolcs Nagy ran into a kernel build failure with a custom gcc
> toochain that sets -mfpu=auto -mfloat-abi=hard:
>
>  /tmp/ccmNdcdf.s:1898: Error: selected processor does not support `cpsid i' in ARM mode
>
> The problem is that $(call cc-option, -march=armv7-a) fails before the
> kernel overrides the gcc options to also pass -msoft-float.

The call to `$(call cc-option, -march=armv7-a)

>
> Move the option to the beginning the Makefile, before we call

beginning of the

> cc-option for the first time.
>
> Reported-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87302
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Moving this looks harmless enough, though it's not clear to me how the
failure you're describing would occur.  I don't see calls to as-instr
in arch/arm/Makefile.  Which object is being built before -msoft-float
is being set?

> ---
>  arch/arm/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 7d5cd0f85461..e428ea6eb0fa 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -16,6 +16,8 @@ LDFLAGS_vmlinux       += --be8
>  KBUILD_LDFLAGS_MODULE  += --be8
>  endif
>
> +KBUILD_CFLAGS  += -msoft-float
> +
>  ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
>  KBUILD_LDS_MODULE      += $(srctree)/arch/arm/kernel/module.lds
>  endif
> @@ -135,7 +137,7 @@ AFLAGS_ISA  :=$(CFLAGS_ISA)
>  endif
>
>  # Need -Uarm for gcc < 3.x
> -KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
> +KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -Uarm
>  KBUILD_AFLAGS  +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
>
>  CHECKFLAGS     += -D__arm__
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers
