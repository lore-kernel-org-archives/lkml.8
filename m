Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC93C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725402070A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgESUbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:31:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESUbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:31:44 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MUGmL-1jT8IA2Lbf-00RGAu for <linux-kernel@vger.kernel.org>; Tue, 19 May
 2020 22:31:41 +0200
Received: by mail-qt1-f181.google.com with SMTP id i68so782723qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:31:41 -0700 (PDT)
X-Gm-Message-State: AOAM530nwnBhZni83CQHp5ENTQRDFZr/NrvggTDm1lvA44upPceLr1tK
        05gzvfkLb/c6+dhAgCxOL5X9V7xJ2dLu1SAMwqU=
X-Google-Smtp-Source: ABdhPJwnFPtRSDJVnDnHL5c/dqE67Ig3qeBa0DrpfVygpw767tSMU+pDkvKG7qSXMmmSfY8tCzkK5UyIjTK6Dw2jmGk=
X-Received: by 2002:aed:2441:: with SMTP id s1mr1854319qtc.304.1589920300436;
 Tue, 19 May 2020 13:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2Tw2w73ZkK-W6AA9veMK4-miLUx-TL1EuOdP7EdW-AmQ@mail.gmail.com>
 <0c2abcd1-7da8-2559-1e93-4c3bdd38dec1@linaro.org>
In-Reply-To: <0c2abcd1-7da8-2559-1e93-4c3bdd38dec1@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 May 2020 22:31:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3fxs+14ZdCRmt_GwJGv3Aipm1r9sAHH6aVj2UrWBNuQQ@mail.gmail.com>
Message-ID: <CAK8P3a3fxs+14ZdCRmt_GwJGv3Aipm1r9sAHH6aVj2UrWBNuQQ@mail.gmail.com>
Subject: Re: clock_gettime64 vdso bug on 32-bit arm, rpi-4
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Rich Felker <dalias@libc.org>,
        Jack Schmidt <jack.schmidt@uky.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:R61+xch5PKye34n896QCyNuXyWEqzYGvBnm8OAf4h6R7zcyz6ue
 BFxbzruKHOjhLnnTKyCQ2TJECbb/0/BhaqalQgBSrpGg5ytG8qqtDwRpr8qyxFx4wiR+yEx
 g7qlmfK68394Jf0cRtay7uPpo2fEUSrZEhXev+0eclvykHDsJBVa3NVWax9/YdPYci6U+wD
 MQvpwMQeYSuShtunVJ6jA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jYW8KXCMu3s=:asBD/RgNzkrPwOL7v268Dx
 IkB1ymRpSMGt6vIdOfvAUnXHT/0OGXZmGw9N0gPApYEeDM8TRmHB4qMVWCZ2mI1hKoIiGF0f7
 kiJm+inKEGQ9kclakWrZhaDJOpDDNUSPtBcYANrhPji+8qQmBT4sQuOqH9LH/nwX8eyzQH7nq
 y1Vg90gFCTWB/MbPIpgjm03zj6HN2B87Qx5ljSkuPDbTO8Rf3LsTCmOYhOwKTb0hd278/FKkR
 fsB9+eTe6D/vPMiGan59soVinU15yE8cU+xxlaNcKm61+j+rfCHQydLeBQc69stli4rgQwCJ7
 qDFRfD4DBbxQwzGjvNlvYOJ0rmZ9YtqRJn2vC1JpxU3HGYXy/LKIbVsaXbN+kLAn1Cz5Fh5fp
 r1TmcOJSGBDvsCkkGXywMnJ7LcyoT5sT1GAd2ImEF8B8x/pmuLuk6CYdrjekj7gD5X71Y7pSw
 cJhCsZl2rfXM2VUnWBtc4gfIDYmlzASEKTGEvfFsjbeNtsD0Dr+CvmKpG1wshyOCKy4P9eD8d
 tIGKbJT2xrBiZSLfd2fRJdtEbYYFthm504aVgwhRwocgd+4ScMgLCkcMIZ4gmaLZi2CxfolPe
 u5T/QyYcxRPvQUTCW6FSFxBjkk/beP6THVxdHgy9wOtMBkXaUUpfnFlUoJdIHq+IIl+HC94Vb
 IRkcBufunGBgneN6K3m95Ikd1v/DdX3jqS8eAikDzuIX9smXRBj9PBcZ3kfFrQx6160YT0UVY
 +zIewDT5mo3RLxMgT/tFueTiLIC5Rcfn2pYeUpfH0Lbn2OpzOlZ7WE3S9kY88VhLy52lGUY7p
 Opq87SW/ilN7kCzkLC77xoVXGQ9T0jTOIFpVbKoGGpwDoCwHTI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:24 PM Adhemerval Zanella
<adhemerval.zanella@linaro.org> wrote:
> On 19/05/2020 16:54, Arnd Bergmann wrote:
> > Jack Schmidt reported a bug for the arm32 clock_gettimeofday64 vdso call last
> > month: https://github.com/richfelker/musl-cross-make/issues/96 and
> > https://github.com/raspberrypi/linux/issues/3579
> >
> > As Will Deacon pointed out, this was never reported on the mailing list,
> > so I'll try to summarize what we know, so this can hopefully be resolved soon.
> >
> > - This happened reproducibly on Linux-5.6 on a 32-bit Raspberry Pi patched
> >    kernel running on a 64-bit Raspberry Pi 4b (bcm2711) when calling
> >    clock_gettime64(CLOCK_REALTIME)
>
> Does it happen with other clocks as well?

Unclear.

> > - The kernel tree is at https://github.com/raspberrypi/linux/, but I could
> >   see no relevant changes compared to a mainline kernel.
>
> Is this bug reproducible with mainline kernel or mainline kernel can't be
> booted on bcm2711?

Mainline linux-5.6 should boot on that machine but might not have
all the other features, so I think users tend to use the raspberry pi
kernel sources for now.

> > - From the report, I see that the returned time value is larger than the
> >   expected time, by 3.4 to 14.5 million seconds in four samples, my
> >   guess is that a random number gets added in at some point.
>
> What kind code are you using to reproduce it? It is threaded or issue
> clock_gettime from signal handlers?

The reproducer is very simple without threads or signals,
see the start of https://github.com/richfelker/musl-cross-make/issues/96

It does rely on calling into the musl wrapper, not the direct vdso
call.

> > - From other sources, I found that the Raspberry Pi clocksource runs
> >   at 54 MHz, with a mask value of 0xffffffffffffff. From these numbers
> >   I would expect that reading a completely random hardware register
> >   value would result in an offset up to 1.33 billion seconds, which is
> >   around factor 100 more than the error we see, though similar.
> >
> > - The test case calls the musl clock_gettime() function, which falls back to
> >   the clock_gettime64() syscall on kernels prior to 5.5, or to the 32-bit
> >   clock_gettime() prior to Linux-5.1. As reported in the bug, Linux-4.19 does
> >   not show the bug.
> >
> > - The behavior was not reproduced on the same user space in qemu,
> >   though I cannot tell whether the exact same kernel binary was used.
> >
> > - glibc-2.31 calls the same clock_gettime64() vdso function on arm to
> >   implement clock_gettime(), but earlier versions did not. I have not
> >   seen any reports of this bug, which could be explained by users
> >   generally being on older versions.
> >
> > - As far as I can tell, there are no reports of this bug from other users,
> >   and so far nobody could reproduce it.
> >
> > - The current musl git tree has been patched to not call clock_gettime64
> >    on ARM because of this problem, so it cannot be used for reproducing it.
>
> So should glibc follow musl and remove arm clock_gettime6y4 vDSO support
> or this bug is localized to an specific kernel version running on an
> specific hardware?

I hope we can figure out what is actually going on soon, there is probably
no need to change glibc before we have.

          Arnd
