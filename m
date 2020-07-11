Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3802DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1188D20786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594485778;
	bh=P8kOY8nTXCpfR8ol52up4J956me7tEyqEK4MgjpoRww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CglC7RqJVJ6hHDZzoZTIM+e0GHgYN5x3kNZ/rHO2B7j8es0QLqmIBmwulHNjXwjaf
	 JT9nNvpQsk7ORLP9Gydd+usKEs7x8HczpC7/HgIvkoV2d3Un40JwSYBLwjjPY6oexT
	 70k3nMTyukbNkzgw4+hn+mTQ117cnogvs56jUk6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgGKQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 12:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbgGKQm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 12:42:56 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB043207DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594485775;
        bh=P8kOY8nTXCpfR8ol52up4J956me7tEyqEK4MgjpoRww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jpw4pHL36LIwoKBD5wgpwOvhg2vDgR875ORQcmImZReYUeDLxv/wPViXj6c4qsIoF
         dx/NzyHXyFTpBCZSH0PlONu6+llEky0BuTsAKea7P1KXKloacLgKcZarIisJaXaNxR
         gOD9t7h47KOiyJEYUxmd+p7mtlGBM0LotMaKK9sE=
Received: by mail-oi1-f176.google.com with SMTP id k22so7529429oib.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 09:42:55 -0700 (PDT)
X-Gm-Message-State: AOAM530yF74FuBVKfc3vErrPQu8BDfmdi98S9EXEd0BX0xSPY5u+i4BN
        ek0wMF2kNTfrP3vzSvyn9B3pnPzLFmwnRmmmQw4=
X-Google-Smtp-Source: ABdhPJyMD5z2QbraDQrpl8R3xphMsyGmc3o6isvs+3ReykI0k9NiinVRDPPDPEUOV5teDLAFp8lcAwB4pf4KjnWejZQ=
X-Received: by 2002:aca:5516:: with SMTP id j22mr7932861oib.47.1594485775146;
 Sat, 11 Jul 2020 09:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <202007111901.282t0ZCv%lkp@intel.com> <20200711123025.GM1551@shell.armlinux.org.uk>
 <CAMj1kXG1OgFHmS2J=FODHNHgCbLWmmrAzn9jNpN2OmD9+c6__g@mail.gmail.com> <CAK8P3a0-zTFF=DMY-Un+mQXnd9sZ8OykkeRy36nEQGJvPxW2jw@mail.gmail.com>
In-Reply-To: <CAK8P3a0-zTFF=DMY-Un+mQXnd9sZ8OykkeRy36nEQGJvPxW2jw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 11 Jul 2020 19:42:43 +0300
X-Gmail-Original-Message-ID: <CAMj1kXED5EJRioKr2XMx5i6pbtcJJh29q-+jG547-=PFwHug3w@mail.gmail.com>
Message-ID: <CAMj1kXED5EJRioKr2XMx5i6pbtcJJh29q-+jG547-=PFwHug3w@mail.gmail.com>
Subject: Re: arm-linux-gnueabi-ld: section .rodata VMA overlaps section .bss VMA
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 at 19:03, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Jul 11, 2020 at 5:00 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Sat, 11 Jul 2020 at 15:30, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > I doubt anyone is going to fix this; it's an XIP kernel, and it looks
> > > like the .data and .rodata sections are correctly placed as per the
> > > configuration, but for some reason the .text (and sections that follow)
> > > are incorrectly placed in VMA space.  The configuration file says that
> > > the kernel should start at 0x00080000, and there's no way the .text
> > > VMA should be starting at 0x3f0801a0.
> > >
> >
> > Note that only one of those lines has the >> prefix, and so this
> > config was broken even before this patch got applied.
> >
> > > Unless one of the XIP using folk can debug this, I doubt there will be
> > > any movement on it.  Especially as it's 5 months old...
> > >
> > > What do we do with bugs like this that people won't fix?  Remove XIP
> > > support from the kernel?
> > >
> >
> > I fail to see the point of randconfig testing for xip kernels tbh, and
> > i don't think it is fair to disable xip altogether if the configs that
> > those people care about still build as expected.
> >
> > But it would indeed be nice if we could at least get rid of these
> > pointless build reports. Is there any way we can avoid xip from being
> > selected by randconfig?
>
> In my randconfig builds, I have a patch that makes CONFIG_XIP_KERNEL
> and some other options depend on '!COMPILE_TEST', and I always enable
> COMPILE_TEST for randconfig builds. I don't know whether that would
> work for the kernel test robot as well.
>
>

Both changes sound like things we might simply upstream, no?
Randconfig is only intended for compile testing anyway, and making xip
depend on !COMPILE_TEST seems uncontroversial to me as well.
