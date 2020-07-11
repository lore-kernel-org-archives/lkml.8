Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B702076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594479737;
	bh=thegBoeKlCc9Hando3InB6eZrnjks6/2imYKIUDsj1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MeT1MVuG7DHPey/ZhSPHmYs3UQt35AB4EacCJTX4kyoEb6vFFoMe1sIcbtKAkPf0V
	 upvAuR2AzgcQiCoV8K8RyZty4ItKvh38sEOjS5NYj6RLtKnFrUeMjU6c7+lFcBLKCZ
	 OklPoYflUrZYaZACIyV/zzyRA19M+0zaNFTM9fww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgGKPAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 11:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgGKPAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 11:00:12 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869E7207D4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594479611;
        bh=thegBoeKlCc9Hando3InB6eZrnjks6/2imYKIUDsj1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bZ63pOrjr5eKUWn8dQZuyIPwOgYa2XiDtiQShZ3B8VQFebj/7fuge8r257Ks89fua
         WKrUpevn50vtknBnCfudJ1hWRBmqbUnZpKSR4oS04cmp/hh0vFJow6/0OzDQCgjuBh
         W8ZawIdNYMJRMFVG0TzNGXuOuFJnopL4A9iyDLn4=
Received: by mail-oi1-f180.google.com with SMTP id t4so7332005oij.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 08:00:11 -0700 (PDT)
X-Gm-Message-State: AOAM533Lec92OWFz2yJJqgVX8N/8Fmr+teyb7eO8c8gNWJlZmBjnaIu1
        35+qxVhEWyounzkLWBFvzGHR9x0lesoV+cRqM+M=
X-Google-Smtp-Source: ABdhPJxiA3Ng3C1QlOJteaWU820bLOUDxyG0pH+nb6rnJ5QSgMiY25GSbFC08MRYgDF5yQ1UqufwrfKAUJcRrI0KQrA=
X-Received: by 2002:aca:5516:: with SMTP id j22mr7652467oib.47.1594479610891;
 Sat, 11 Jul 2020 08:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <202007111901.282t0ZCv%lkp@intel.com> <20200711123025.GM1551@shell.armlinux.org.uk>
In-Reply-To: <20200711123025.GM1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 11 Jul 2020 17:59:59 +0300
X-Gmail-Original-Message-ID: <CAMj1kXG1OgFHmS2J=FODHNHgCbLWmmrAzn9jNpN2OmD9+c6__g@mail.gmail.com>
Message-ID: <CAMj1kXG1OgFHmS2J=FODHNHgCbLWmmrAzn9jNpN2OmD9+c6__g@mail.gmail.com>
Subject: Re: arm-linux-gnueabi-ld: section .rodata VMA overlaps section .bss VMA
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Arnd)

On Sat, 11 Jul 2020 at 15:30, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> I doubt anyone is going to fix this; it's an XIP kernel, and it looks
> like the .data and .rodata sections are correctly placed as per the
> configuration, but for some reason the .text (and sections that follow)
> are incorrectly placed in VMA space.  The configuration file says that
> the kernel should start at 0x00080000, and there's no way the .text
> VMA should be starting at 0x3f0801a0.
>

Note that only one of those lines has the >> prefix, and so this
config was broken even before this patch got applied.

> Unless one of the XIP using folk can debug this, I doubt there will be
> any movement on it.  Especially as it's 5 months old...
>
> What do we do with bugs like this that people won't fix?  Remove XIP
> support from the kernel?
>

I fail to see the point of randconfig testing for xip kernels tbh, and
i don't think it is fair to disable xip altogether if the configs that
those people care about still build as expected.

But it would indeed be nice if we could at least get rid of these
pointless build reports. Is there any way we can avoid xip from being
selected by randconfig?


> On Sat, Jul 11, 2020 at 07:05:04PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   1df0d8960499e58963fd6c8ac75e544f2b417b29
> > commit: f87b1c49bc675da30d8e1e8f4b60b800312c7b90 ARM: 8958/1: rename missed uaccess .fixup section
> > date:   5 months ago
> > config: arm-randconfig-c004-20200711 (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    arm-linux-gnueabi-ld: section .data VMA [0000000040008000,00000000401e9edf] overlaps section .text VMA [000000003f0801a0,0000000040515887]
> > >> arm-linux-gnueabi-ld: section .rodata VMA [0000000040516000,00000000409a24ee] overlaps section .bss VMA [0000000040208000,00000000409d80db]
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
