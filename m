Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6CCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F185220671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5NWmiHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgETQTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgETQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:19:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5481C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:19:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so1810731pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEObS9qWpB+AbLMm/kvK2cUqzqqcGuDXnjK3PVfCHfw=;
        b=E5NWmiHTF69FCRCanpQg3vvwn77xAZQe37Qqa97tVqJ7EW1mWzQnuniaiQS5wfs52J
         t3ZDATQoFWFgp+tLwqv42TtkQ2AaCRqLPuHZ29qmkEjlMg+ieErC5vFQARwqYt2+jwPg
         g2SLkJDMvvl1FUWw/dOZyl/ReK0Wlg/ttpbgyYGLoidQBxLKS1RGjhsQkTp0eAGGF84g
         ZQ93vbDCFo3rRTF/khonwtOZ1073xk5UVjmcawiQ3KW80az0ffqE+hg/N/hR3llepr9q
         599W3VmVPLyztO1ajy3OGXVPNWjuL55Bq3Q7LfloiJ3FNZI6JGTTS8Cb2EUs1UNH0qCy
         6XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEObS9qWpB+AbLMm/kvK2cUqzqqcGuDXnjK3PVfCHfw=;
        b=aIxYQToSpGvt2SsDapO40OMWPo6LTMMAF963MGwuMMjTWkAKYNzbblSIicNZfBxuin
         0UOwQwZ64HkpTGHNcDSndNoFwI+woBIUywukITTk0+/jXKckrHloPTxrqonCMTWAac8I
         umrt8M1DbtU1I98Z1UQOqwFgapXTSgNSK8qjIIzMPIBanN3kuGz7UVXOiQiIk9aIGpLK
         Y9z6YPYl++2fzLMv2V+vkAgwRQfkVl+SL+tFfCYwOZQYFdsvZP764qPZx/Dncmo86DE1
         E7jajz0fiZ509reLprYzztARbg336d+wvODo4sZU3pJGZrTnzExRZVMFDDNjvmeB1VzM
         AeHA==
X-Gm-Message-State: AOAM5304lXjvhpb6l1M0EYCV5NoVs1JI5CiC+ep7WpkvLmVIvFv0OSMz
        5QYtp7/zZ+viDSDzuwHzHyh+2MmA84GMPhCWfUWuiA==
X-Google-Smtp-Source: ABdhPJzcB8MgWy8rQzlYICWijN1J82PlbtinkDB6zPpjpwuiEJi9vwrndwHoCqLKREaDiwXa1ExDTCH+Bzs4TmPKCb8=
X-Received: by 2002:a63:4f09:: with SMTP id d9mr4681983pgb.10.1589991591807;
 Wed, 20 May 2020 09:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200519220923.1601303-1-arnd@arndb.de> <CAKwvOdmH6bMJHzxSs2mVN=P5BBYjYrDs13-oq-Qq+S4ykHSYvA@mail.gmail.com>
 <CAKwvOd=EphyUWNOZ59FkrfDvDwHHU2yrXW+KML-w_6mHowK=QA@mail.gmail.com> <20200520083631.GJ27289@arm.com>
In-Reply-To: <20200520083631.GJ27289@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 May 2020 09:19:40 -0700
Message-ID: <CAKwvOd=Ui8TdnCmkDLJz85zzkFtMDsmAFWPS1MYUFL8JffZhtw@mail.gmail.com>
Subject: Re: [PATCH] ARM: pass -msoft-float to gcc earlier
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 1:36 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
>
> The 05/19/2020 17:38, Nick Desaulniers wrote:
> > sorry, hit tab/enter too soon...
> >
> > On Tue, May 19, 2020 at 5:37 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, May 19, 2020 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > Szabolcs Nagy ran into a kernel build failure with a custom gcc
> > > > toochain that sets -mfpu=auto -mfloat-abi=hard:
> > > >
> > > >  /tmp/ccmNdcdf.s:1898: Error: selected processor does not support `cpsid i' in ARM mode
> > > >
> > > > The problem is that $(call cc-option, -march=armv7-a) fails before the
> > > > kernel overrides the gcc options to also pass -msoft-float.
> > >
> > > The call to `$(call cc-option, -march=armv7-a) is th
> >
> > The call to `$(call cc-option, -march=armv7-a) is the one that fails or...?
>
> the flag -march=armv7-a is invalid if the float abi
> is hard and no fpu is specified (since gcc-8).
>
> either an fpu should be specified or -march=armv7-a+fp
> (my toolchain was configured with the latter and it does
> not work if the kernel overrides it with -march=armv7-a)
>
> because of this cc-option failure the kernel goes on to
> pass nonsense flags everywhere (-march=armv5t) and some
> compilation eventually fails with an asm error.

Cool, thanks for the additional info.  Arnd, if you wanted to include
more of that snippet the commit message when submitting, I wouldn't
complain. :)
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> > > >
> > > > Move the option to the beginning the Makefile, before we call
> > >
> > > beginning of the
> > >
> > > > cc-option for the first time.
> > > >
> > > > Reported-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > > > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87302
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Moving this looks harmless enough, though it's not clear to me how the
> > > failure you're describing would occur.  I don't see calls to as-instr
> > > in arch/arm/Makefile.  Which object is being built before -msoft-float
> > > is being set?
> >
> > ... ^
> >
> > >
> > > > ---
> > > >  arch/arm/Makefile | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > > index 7d5cd0f85461..e428ea6eb0fa 100644
> > > > --- a/arch/arm/Makefile
> > > > +++ b/arch/arm/Makefile
> > > > @@ -16,6 +16,8 @@ LDFLAGS_vmlinux       += --be8
> > > >  KBUILD_LDFLAGS_MODULE  += --be8
> > > >  endif
> > > >
> > > > +KBUILD_CFLAGS  += -msoft-float
> > > > +
> > > >  ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
> > > >  KBUILD_LDS_MODULE      += $(srctree)/arch/arm/kernel/module.lds
> > > >  endif
> > > > @@ -135,7 +137,7 @@ AFLAGS_ISA  :=$(CFLAGS_ISA)
> > > >  endif
> > > >
> > > >  # Need -Uarm for gcc < 3.x
> > > > -KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
> > > > +KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -Uarm
> > > >  KBUILD_AFLAGS  +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
> > > >
> > > >  CHECKFLAGS     += -D__arm__
> > > > --
> > > > 2.26.2
> > > >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> --



-- 
Thanks,
~Nick Desaulniers
