Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EC6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5708420756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcZxfBfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgETAi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETAi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:38:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EC8C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:38:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z26so712538pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUd/WgjoZPsx+toSaRGP/ejM9YY6HjPYSZOKYhK7Aq4=;
        b=FcZxfBfHJ/OI6RRmKYEaeLCAdglZPcdKY04CaufK/RV3QdW3p2Q7xLCONkzEkxmwF9
         6U57NQNUqXw15Qm+aITU0/QV/BoxdY2UiVj9Ot+RvuNdefgzXXGS8RTSeX//wZrypEK7
         3OLBRzguhKnOJp8khZh94qz69ZRm7+XReh1na6pKOfXcnAE7frtjtzVQeWZaI/6v0z6d
         TS67jkZIFBB5rX4oyCUl1McYwEOxEabF8tnnh4N0dy+TylPKFBXfSwfID+3M8w9YsOvN
         gZlaLIHHCv3ckZ+YzWc0GrpZhgkdh/1HvHut7d+oUbc3eXxC1wrTsNoBSDz4DH58X2tw
         G6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUd/WgjoZPsx+toSaRGP/ejM9YY6HjPYSZOKYhK7Aq4=;
        b=sPA2aHiLi3l8WZK/HDUb/cNeh4bSYhax9m3UgcXRbvYuoZw1OTTabpi+Zwj+TouNWC
         Xu6gE+yUOn/D7Ap4UX56g3Znx6XFIy/y1GXdr4IbLJumTfLIsbJ3w3lV1rAC2p1gM2os
         lPyDFrIeeDwlAlbcnEI+Mcay04l4N6nU62AAn261zwO1lVVM/X/EgerB01l18/aeW2Xs
         HpoCHwoHSyD8CU4V0KW6t8qw9ehD0z6Zi5IxWdqoQUiZojw/NbQmle5ZqlAThgr+zZIF
         +f/09oSiFVown/h0qmsDdDaM6GI2nf39itBA3SfJXN2Q4/dooI6izmri6uTSKZiJ1EMM
         D9zg==
X-Gm-Message-State: AOAM531F9Qg5LCrOIQxAMOouxA3V9KQY8RlO4tntKwrXCbv10h/rG/MH
        jMHJmhKoLdJiNX/rCDaNj+N5ZZwmAUSZGRsNH1Y7mA==
X-Google-Smtp-Source: ABdhPJy8WmD7U3F+xMtZlJi00vLpJ42adVkJ+ZO0KSJVg33XDjtJiYA+NLVM3BsPMsK41bDBzpvYpZbtoYpCde0EkVs=
X-Received: by 2002:aa7:8084:: with SMTP id v4mr1674036pff.39.1589935136101;
 Tue, 19 May 2020 17:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200519220923.1601303-1-arnd@arndb.de> <CAKwvOdmH6bMJHzxSs2mVN=P5BBYjYrDs13-oq-Qq+S4ykHSYvA@mail.gmail.com>
In-Reply-To: <CAKwvOdmH6bMJHzxSs2mVN=P5BBYjYrDs13-oq-Qq+S4ykHSYvA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 May 2020 17:38:44 -0700
Message-ID: <CAKwvOd=EphyUWNOZ59FkrfDvDwHHU2yrXW+KML-w_6mHowK=QA@mail.gmail.com>
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

sorry, hit tab/enter too soon...

On Tue, May 19, 2020 at 5:37 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, May 19, 2020 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Szabolcs Nagy ran into a kernel build failure with a custom gcc
> > toochain that sets -mfpu=auto -mfloat-abi=hard:
> >
> >  /tmp/ccmNdcdf.s:1898: Error: selected processor does not support `cpsid i' in ARM mode
> >
> > The problem is that $(call cc-option, -march=armv7-a) fails before the
> > kernel overrides the gcc options to also pass -msoft-float.
>
> The call to `$(call cc-option, -march=armv7-a) is th

The call to `$(call cc-option, -march=armv7-a) is the one that fails or...?

>
> >
> > Move the option to the beginning the Makefile, before we call
>
> beginning of the
>
> > cc-option for the first time.
> >
> > Reported-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87302
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Moving this looks harmless enough, though it's not clear to me how the
> failure you're describing would occur.  I don't see calls to as-instr
> in arch/arm/Makefile.  Which object is being built before -msoft-float
> is being set?

... ^

>
> > ---
> >  arch/arm/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index 7d5cd0f85461..e428ea6eb0fa 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -16,6 +16,8 @@ LDFLAGS_vmlinux       += --be8
> >  KBUILD_LDFLAGS_MODULE  += --be8
> >  endif
> >
> > +KBUILD_CFLAGS  += -msoft-float
> > +
> >  ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
> >  KBUILD_LDS_MODULE      += $(srctree)/arch/arm/kernel/module.lds
> >  endif
> > @@ -135,7 +137,7 @@ AFLAGS_ISA  :=$(CFLAGS_ISA)
> >  endif
> >
> >  # Need -Uarm for gcc < 3.x
> > -KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
> > +KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -Uarm
> >  KBUILD_AFLAGS  +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
> >
> >  CHECKFLAGS     += -D__arm__
> > --
> > 2.26.2
> >

-- 
Thanks,
~Nick Desaulniers
