Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF0C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC2F2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgEFKXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:23:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgEFKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:23:17 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MmQUL-1ioS942yyv-00iVlS for <linux-kernel@vger.kernel.org>; Wed, 06 May
 2020 12:23:15 +0200
Received: by mail-qt1-f177.google.com with SMTP id l18so989997qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 03:23:15 -0700 (PDT)
X-Gm-Message-State: AGi0PuaB37Yem6/VamAStebf1HvcWugXdLjovtCd5IS1ZpPYW8bRIwWd
        KflbCHboLNbfCE1MAkFhobnA2mnXDhJoZXyIM6E=
X-Google-Smtp-Source: APiQypJEVCAJL0nnBQR+WXzvg/lecWv1dnYBKyRgMwq6Opxqks7AT+sOQGN1GWfSzNLaMViCqUCLAgMB9LCAPAS5gWY=
X-Received: by 2002:ac8:2bce:: with SMTP id n14mr7247646qtn.18.1588760594548;
 Wed, 06 May 2020 03:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200505141257.707945-1-arnd@arndb.de> <20200505142556.GF82823@C02TD0UTHF1T.local>
 <20200505194243.5bfc6ec6@blackhole> <20200506034523.GA564255@ubuntu-s3-xlarge-x86>
In-Reply-To: <20200506034523.GA564255@ubuntu-s3-xlarge-x86>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 May 2020 12:22:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a24EiEvGAenL0FdgGakmwWi=giReOJuiisnzkgC_SuhZg@mail.gmail.com>
Message-ID: <CAK8P3a24EiEvGAenL0FdgGakmwWi=giReOJuiisnzkgC_SuhZg@mail.gmail.com>
Subject: Re: [PATCH] arm64: disable patchable function entry on big-endian
 clang builds
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Torsten Duwe <duwe@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DBFf79e2HDVCGSZUDxn6IOV+QVQgJN237vSxdArlmWB/yLex+bT
 08rNvKMzsQ7YjLFyl9Ur2d5xMp+FC53rDJc63JWEJksvJCTr6rac8pJUiscDjJXPU26sG8i
 5A7O0VCYYncf/tjPU7TnYu76rpD+wrT5pJsyEUtl1sEUm8SqH7cjbffabHwBBCM7pKKlvVm
 e11DFT1jpY2vSDMa5I6SQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OhvwMSvbUOU=:vN8iUfWiF5Y0isCPVpvWO5
 imYw2ndSZzRjFfzlfutk1iyybPyICSIQWBuj0QW9C0eMd1QujCzAWp+vIXzdnOppGaBtfPYib
 ajvbn3d1R9TpKGFr/nQV6Z3f90B/2yC5Gq8A0HL52BPo2Ek2Vg0RfT2Qi1lNCTcC+Xy1yJVT6
 mIYKYANaEUTolPfGWKQfRMxPclZyKBnNGd8oUEbu37Q8JPg/izw2r8gZVChEwHwr7SR0MeFHq
 UiJvGTWoaWqYn2LgaSyBoj8cWSJ295jTzeEvHdnFp1NOuORQPObgu7IKRnHPSUIfu/MYfxKPT
 AEXigwnseWF5GSWqEWbwPs2+xR0Wx1QfCXUdBVPqw+jaBae3NNGn5E8Vaj/V8i+PD1UyBb+oY
 gJKOCwuTMKPKKijo9p27p4YN+n+wueNrObnEHD6kbWfssNW+4MiGaRk+jXzbBNnVOKTegkh7t
 NM2/JUNEJ1WXCjmCsIAcMNCRDtbi91Lbbr0HHibaTGOfXqA6EvqKjyoLmWiYihQGZqjRvEBnE
 N8tRwhsQ414pbdQMauUxFTvmc9OoDOLVp5d3fBb4rvtlcEUsx7dkDjOO3GdwaLzsZ18cDP6x6
 1EIU5qD87flryNu98opMpV2zyM1522afAtZNX5dTt52ycrUXW5UtwFmZSTrZYQbBFRp2fbbVV
 dMHh/x0Lz1j7SgN3z+kMXb69KAQmdZNvB6CRvSlw/2DnoxRYWtKYQbBFY0s6NlOe1vyMRHwlL
 LigKoKJUBi/ONT9Rh6Sx3MZ9YYk8YnBrMFMhD3JKYZwlNU4iZFNuitUSuP7hwv5SBI1Dw0nyB
 U+56mYwxowe2ceo8ZdM0ceO2vSQTx/33IZuLm5UFRwAtiHfVgg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 5:45 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Tue, May 05, 2020 at 07:42:43PM +0200, Torsten Duwe wrote:
> > On Tue, 5 May 2020 15:25:56 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Tue, May 05, 2020 at 04:12:36PM +0200, Arnd Bergmann wrote:
> > > This practically rules out a BE distro kernel with things like PAC,
> > > which isn't ideal.
>
> To be fair, are there big endian AArch64 distros?
>
> https://wiki.debian.org/Arm64Port: "There is also a big-endian version
> of the architecture/ABI: aarch64_be-linux-gnu but we're not supporting
> that in Debian (so there is no corresponding Debian architecture name)
> and hopefully will never have to. Nevertheless you might want to check
> for this by way of completeness in upstream code."
>
> OpenSUSE and Fedora don't appear to have support for big endian.

I don't think any of the binary distros ship big endian ARM64. There are
a couple of users that tend to build everything from source using Yocto
or similar embedded distros, but as far as I can tell this is getting less
common over time as applications get ported to be compatible with
big-endian, or get phased out and replaced by code running on regular
little-endian systems.

The users we see today are likely in telco, military or aerospace
settings (While earth is mostly little-endian these days, space is
definitely big-endian) that got ported from big-endian hardware, but
often with a high degree of customization and long service life.

My policy for Arm specific kernel code submissions is generally that
it should be written so it can work on either big-endian or little-endian
using the available abstractions (just like any architecture independent
code), but I don't normally expect it to be tested on big endian.

There are some important examples of code that just doesn't work
on big-endian because it's far too hard, e.g. the UEFI runtime services.
That is also ok, if anyone really needs it, they can do the work.

> > I suggest to get a quote from clang folks first about their schedule and
> > regarded importance of patchable-function-entries on BE, and leave it as
> > is: broken on certain clang configurations. It's not the kernel's fault.
>
> We can file an upstream PR (https://bugs.llvm.org) to talk about this
> (although I've CC'd Fangrui) but you would rather the kernel fail to
> work properly than prevent the user from being able to select that
> option? Why even have the "select" or "depends on" keyword then?

I definitely want all randconfig kernels to build without warnings,
and I agree with you that making it just fail at build time is not
a good solution.

> That said, I do think we should hold off on this patch until we hear
> from the LLVM developers.

+1

      Arnd
