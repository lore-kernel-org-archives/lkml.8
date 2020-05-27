Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AF6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2399D2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbgE0OeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:34:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389220AbgE0OeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:34:18 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N1xZX-1iu3dm353p-012KMn for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 16:34:15 +0200
Received: by mail-qk1-f180.google.com with SMTP id q8so8049736qkm.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:34:15 -0700 (PDT)
X-Gm-Message-State: AOAM532XZf6hvJXZEoDX35zNfu2PiUDVyWh4TZInPqv0bzQ477J88SOT
        fQoZgVbr4fP21fyy6jdvqjqEHMk1NWkzAD6iQQU=
X-Google-Smtp-Source: ABdhPJyfwVGTdtgVJM6vboGn7Ofw2Zfj5O1ji/GKWmD0RoktsMqPgLXu9v5sBjOvok2uK2b4VfiBqsO7bmQcDHEAqfQ=
X-Received: by 2002:a37:4c48:: with SMTP id z69mr4462545qka.138.1590590054575;
 Wed, 27 May 2020 07:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
 <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
 <20200501081002.GA1055721@kroah.com> <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
 <20200524212851.GG1192@bug> <CAK8P3a225pqBfzQ19e6Gt0s_tYBp29xLb8EG==hhz=1wc7aVCA@mail.gmail.com>
 <ac0534138facc25c4cbcbbff68fc0ba3c2de87b6.camel@linux.intel.com>
In-Reply-To: <ac0534138facc25c4cbcbbff68fc0ba3c2de87b6.camel@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 16:33:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2MzqF3P8nY3hAUaAXhTV8ZGQd187UDbNV1GBdu+_z5-g@mail.gmail.com>
Message-ID: <CAK8P3a2MzqF3P8nY3hAUaAXhTV8ZGQd187UDbNV1GBdu+_z5-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
To:     "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
Cc:     "pavel@ucw.cz" <pavel@ucw.cz>, "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniele.alessandrelli@linux.intel.com" 
        <daniele.alessandrelli@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:l4/GPB2ILu09kkV7XvWAVfsZeS+TnLTyig0qXH9kjw0osp/g9wC
 kj4ygUJaoaQibM6paQin4afYRdmPdTLpPuexPKuQbzGt1amoYqJKPKdN3io0C3nXCyzLOM9
 QYuUh49j4NnifsifPOm+s421ZPR1KY5YuwjIk8nxGiwdXfoZ+x059+lCBQCzz2s/acEUulj
 NTb4qGXnHq0cCKfUfOK5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cjFL+2I6Xsg=:qNiL2f79VozEMCfa/jspXE
 w9j/5Mk3Nlaqfx+BS1/D0CeJepKALN6BuJ5YfGeBOdNzecwZsMoLhsJ7O7YkhSk9wa/Ub6y34
 4IcInVVdIvb9EyV/D1CJ33PFblxSHNdBdY5vJnKYcOg3Z6T/1AAwsoY3ztxAblrZGrR8CQU/r
 DyrXWnPOooUYb8sNtSgNYcHkdtDkZCS7GYk6sJTFlKYOOiLAYqejmsX1g5zBA1SgYtYlpJFFv
 D48rK+lf97dxfS8MUyrkiLt8jvY1a2ndoKMa7x+PmZMTM8BBv4GPAN0n8960sShrgyoQeKcrC
 tSP4fUWb42hfMl2GaFfEEAPSFvReffhC9VA8U2aIEI+wLq94a2bEZAPE1oXflplcAB/OnMe2o
 Nps54dpEBESqEkQCVlIICYQ5JSI7H4tcxx5Esf1uaJSi9tjn7IlhGwi050Y4xpHIHPWasVMjt
 FVWPsIs6ZLgDO9roG3T1ViU/KKjIajPvKAzTeHBk5D+nwk9QOTPf5sDU5e8JqjkapABsYYvUH
 h8nPdasgRTr+a72cl3K3VrQdMocXQVzmPf20w8RVm+v78F458bA4uxr961LmQABaav97KVyum
 oT+BRQ1dwOFbx48/S5Ur2P9I5qM9bVX4XsBA/PVYLZcL8nhw+r/46GSwFpXOnILegVPci4wmy
 wqJTrb0tjx7SWkIf0gVOppVSqT8LHMoSINOZy2kBRT8VAkFqZTAljqj/Iwu07UmX77B5FZRC+
 ZIO2edlMDq+oXi6xFF4uQdbt/3105TRIWW4iX7Fd3139mDN1H3qXlL2gF/TzTmTfPcOYRBsTB
 PYKycy67oes3pxpQCETBxzpj8KERj3th9rgQVYg2QSNiU7d0cE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:31 PM Alessandrelli, Daniele
<daniele.alessandrelli@intel.com> wrote:
> > > Alternatively, take that memory off the "memory available" maps,
> > > and only re-add it once
> > > it is usable.
> > >
> > > Anything else is dangerous.
>
> That sounds like an interesting solution, thanks!
>
> Do you know any code that I can use as a reference?
>
> Since, the protected memory is just a few megabytes large, I guess that
> in theory we could just have U-Boot mark it as reserved memory and
> forget about it; but if there's a way to re-add it back once in Linux
> that would be great.

Adding it back later on with a loadable device driver should
not be a problem, as this is not a violation of the boot protocol.

> > Agreed, this sounds like an incompatible extension of the boot
> > protocol that we should otherwise not merge.
> >
> > However, there is also a lot of missing information here, and it is
> > always possible they are trying to something for a good reason.
> > As long as the problem that the bootloader is trying to solve is
> > explained well enough in the changelog, we can discuss it to see
> > how it should be done properly.
>
> Apologies, I should have provided more information. Here it is :)
>
> Basically, at boot time U-Boot code and core memory (.text, .data,
> .bss, etc.) is protected by this Isolated Memory Region (IMR) which
> prevents any device or processing units other than the ARM CPU to
> access/modify the memory.
>
> This is done for security reasons, to reduce the risks that a potential
> attacker can use "hijacked" HW devices to interfere with the boot
> process (and break the secure boot flow in place).
>
> Before booting the Kernel, U-Boot sets up a new IMR to protect the
> Kernel image (so that the kernel can benefit of a similar protection)
> and then starts the kernel, delegating to the kernel the task of
> switching off the U-Boot IMR.
>
> U-Boot doesn't turn off its own IMR because doing so would leave a
> (tiny) window in which the boot execution flow is not protected.
>
> If you have any additional questions or feedback, just let me know.

Thank you for the detailed explanation. I've never seen this done
in the Linux boot flow, but I can see how it helps prevent certain
kinds of attacks.

It seems that just reserving the u-boot area and optionally
freeing it later from a driver solves most of your problem.
I have one related question though: if the kernel itself is
protected, does that mean that any driver that does a DMA
to statically allocated memory inside of the kernel is broken
as well? I think this is something that a couple of USB drivers
do, though it is fairly rare. Does u-boot protect both only
the executable sections of the kernel or also data, and does
the hardware block both read and write on the IMR, or just
writes?

        Arnd
