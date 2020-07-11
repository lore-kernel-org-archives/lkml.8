Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BF3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 16:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6448620786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 16:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgGKQDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 12:03:37 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33967 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGKQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 12:03:36 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N336J-1ksHal3P2b-013NjL for <linux-kernel@vger.kernel.org>; Sat, 11 Jul
 2020 18:03:35 +0200
Received: by mail-qk1-f174.google.com with SMTP id c139so8266450qkg.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 09:03:34 -0700 (PDT)
X-Gm-Message-State: AOAM532nRwPsnqH59lHpa883nyyL9htVB/USZiCoe1jMFwb2iOdiMJS2
        EVHLjiBYRnEmsKs3n1cvoLJzjIn9lvyKEaIynz0=
X-Google-Smtp-Source: ABdhPJzGVD1fHX26aiySANqWRx7WKz2D3f/h0pIXu+Cou6uN/VJ+NixGsZD+MszgNoIO+HBtWAe3Cma3hdhUFpCOVZE=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr66511193qko.138.1594483413616;
 Sat, 11 Jul 2020 09:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <202007111901.282t0ZCv%lkp@intel.com> <20200711123025.GM1551@shell.armlinux.org.uk>
 <CAMj1kXG1OgFHmS2J=FODHNHgCbLWmmrAzn9jNpN2OmD9+c6__g@mail.gmail.com>
In-Reply-To: <CAMj1kXG1OgFHmS2J=FODHNHgCbLWmmrAzn9jNpN2OmD9+c6__g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 11 Jul 2020 18:03:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0-zTFF=DMY-Un+mQXnd9sZ8OykkeRy36nEQGJvPxW2jw@mail.gmail.com>
Message-ID: <CAK8P3a0-zTFF=DMY-Un+mQXnd9sZ8OykkeRy36nEQGJvPxW2jw@mail.gmail.com>
Subject: Re: arm-linux-gnueabi-ld: section .rodata VMA overlaps section .bss VMA
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4GbV6F0TL878B5MiXpqiudx/LMqNv+M3DYvj5y9qToLgpEcBXar
 5oSZ9gYhKlk8Ruc5NYUJBoKEvsVZYQ58Nf78uIOcyaZD35AQ+hX3iBFCEt9V6lyVWQsutgF
 lQvmg1whkKDGo+hnZ6fibdc9YwlFEDeLBL7pOFPPS9FcHDmeOPEXg6iccO7ctNyTne7xK3X
 RDk1mz/E/PHkHakaRmHgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YawJR4qlqpw=:MYhNWANggobCRI2TlsCI04
 bErdcJxLGbeXfaGlZv5vast9FCRApUttSDJV4mtgqC/5eTnMK8KR1Ol77ey7l8Fl8aide6peV
 8+GE7WlUfsXqciWJvzgC2QVli0t6n4wUo+ntpU2YLhBKSet+RyQGjmEaoDLLop1D3iZNV8nVn
 pseORG6M30f415XkMDszE0cYI0ulijGb0nMbLzzZHqEgNsDiemZtNaG4RDmECFHsnukAVpWsS
 An4UqTQjP/hVBcO8PBtjQbNQW756P8IOU1NMRX8zjdD9yMHEBhhqS3jjY9cz/H+RKssP2km9Y
 +8xgxNmykO+l33sAQArHzN2YJS3644ZBpYPVim/0nEnCD2lg3XZzVUgYln/oiJd6pcyqY3jSu
 odnKBEbX4FmHpQEaZ4x16ytKtkECgxGbosF42v3YJOf0vsc3Z1oNCl9NHu+dHtalw3Hv0tmJL
 pgxz/jHoGAQK3H3Np95OWe6UPeO/bK+mVI9DATzz9BNwL4+L3dcX7gqgzKBlCVh+3JF3LMMNx
 DW3yJ+IsXYyVWZCUWFHMGTeJxBNT6iv6opvwB1gMkoAT1nNP1sjl/ieYUM2NAdxjzeKhc3MOD
 s2Y1GZTLBR5qkJYC5clrNKzSdGKssi6gPhM71eoxZ/KpmKlhEU+kDj0n8qBFc35LuZ6GhjGpJ
 qg9nzFwwliVq5vt4B4cFHPiDHhHudCl4xm7iY1wXmhEGfHU/448baJG8b0WSk3fRk9V7u0qps
 gBvOg1+qWobRS1XNjwrmgTRlKiGYc4F0ZrDVhjySUFIQpxzgRtGyol+A4hzLcFPxG9IW8FS5t
 BOjfdGnkO8vQ5DpkqZsLKir8zzK5wlF+3a3mv4xOOId8I2m63XbwOBeVPS6rwcvBgT45XzBJC
 d3EJ+TYCz4cXMLjA0HiTRMG1WLJ9re3a1Xm8DQ5t1Z9k54tSZtFiouNnJxIEKvIqyKi2o37PR
 WEfhAggicHeMdaGutTm15aJ3GxBu7DvPuBDwIlkfauM5wsK4W4uTm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 5:00 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Sat, 11 Jul 2020 at 15:30, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > I doubt anyone is going to fix this; it's an XIP kernel, and it looks
> > like the .data and .rodata sections are correctly placed as per the
> > configuration, but for some reason the .text (and sections that follow)
> > are incorrectly placed in VMA space.  The configuration file says that
> > the kernel should start at 0x00080000, and there's no way the .text
> > VMA should be starting at 0x3f0801a0.
> >
>
> Note that only one of those lines has the >> prefix, and so this
> config was broken even before this patch got applied.
>
> > Unless one of the XIP using folk can debug this, I doubt there will be
> > any movement on it.  Especially as it's 5 months old...
> >
> > What do we do with bugs like this that people won't fix?  Remove XIP
> > support from the kernel?
> >
>
> I fail to see the point of randconfig testing for xip kernels tbh, and
> i don't think it is fair to disable xip altogether if the configs that
> those people care about still build as expected.
>
> But it would indeed be nice if we could at least get rid of these
> pointless build reports. Is there any way we can avoid xip from being
> selected by randconfig?

In my randconfig builds, I have a patch that makes CONFIG_XIP_KERNEL
and some other options depend on '!COMPILE_TEST', and I always enable
COMPILE_TEST for randconfig builds. I don't know whether that would
work for the kernel test robot as well.

      Arnd
