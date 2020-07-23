Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C112080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgGWLmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:42:38 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWLmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:42:37 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MNccf-1k9leC3Trf-00P9IZ for <linux-kernel@vger.kernel.org>; Thu, 23 Jul
 2020 13:42:36 +0200
Received: by mail-qt1-f181.google.com with SMTP id s23so4089951qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 04:42:35 -0700 (PDT)
X-Gm-Message-State: AOAM532v+j310qrTPXzlzWBCr30JPPWwqhrNWNmvRVjpy7qmwnQFA0Kv
        FNgnD60TSNYdRpRYBtcK5J164wnRcbB+s+hvhhA=
X-Google-Smtp-Source: ABdhPJx5qjP0r0I48HRs9uh9YzB955WBqq+sW5h7vxrSLXjPFG4cD8QRrNdR2Tw+C6gZIqaA0LBOxbyNyClsp+cCkio=
X-Received: by 2002:aed:33e7:: with SMTP id v94mr1585679qtd.18.1595504554703;
 Thu, 23 Jul 2020 04:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
 <20200720204925.3654302-12-ndesaulniers@google.com> <87365izj7i.fsf@nanos.tec.linutronix.de>
 <87zh7qy4i4.fsf@nanos.tec.linutronix.de> <CA+icZUVz0opOb0LihLvPvKM-t0Y=pcUWDyb+u-L_UVnnbPh1rQ@mail.gmail.com>
In-Reply-To: <CA+icZUVz0opOb0LihLvPvKM-t0Y=pcUWDyb+u-L_UVnnbPh1rQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Jul 2020 13:42:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Ms1uvLcbhmbsU+-u11BCrXPaU5Dro=P9LjAG7CYm8ww@mail.gmail.com>
Message-ID: <CAK8P3a3Ms1uvLcbhmbsU+-u11BCrXPaU5Dro=P9LjAG7CYm8ww@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] x86: support i386 with Clang
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Golovin <dima@golovin.in>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:N89iYYF9WKdLNmh6sseJV99tANygn1TDP2wTS6QyGhL+R41yiuR
 y1tK9Fo0bJmuGT7eZxu3jOR6Ny+QzcaQyRk8EWFxyW3sroCgXcuGN3fqLCuWwT4gNyjccGw
 My8YBPFTUAmftg6jCD3V96OwhJDsf9VJoP9eGkdu2Xoj7/X4wVGMNKReciGZ6l6mWf+ol/E
 QQywlk+eGrZ8R8Ug+aebg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JGUPFvAAb9k=:unU5wnQ4t8IVGAvxNkhunY
 3iVIB+oaw2VV2XxXoMmTdcz9LAX6DG1b60MWMSgsdvCXj0S4DSuT9sUb/SAiXvu2ysytpSkO+
 Oue6m2H77meWBj+ACfDypab9oG8JnEuqRSiu3jL0HLLRuQ+923yMaI49VWyafvyEMj2X6OWb2
 fmf1Of4kB+/RFI7JvzAZz5Mq0fpgY2X/FqrvDdAkjWh+GuUYpph0NzsEPOqTFk/xOoLPQeTVl
 bry4vfIQzNmrM6A+4ujURV3WnEts5QbvRy7ZEeXDDBiTb4BV9A9vSXAFOWKvqhklBE6/Vq4Fi
 K1PcMk16FqL3x1HEXUCgC2/4Yl6svEydI1ScTbKD519hHN/GiOxf6DFMAuv3SkIv1WiRmYQVx
 PkXuSTMIgGfMIIGQMI+DS1wiffr6/gDSd7BwhFleqk2nw+Q/O0avYNHKiVOJO05Kv9dHqEtfR
 PG1YzCEHvfm19C35JXEkRInflL/HNxIVGo5UtffA59z8qXaWl/TOECMC7hw1iS9LiP1ffkoFj
 CmvF1m+cNRHylAzhlM8g4GQNk6o207s7/jdS0T8dCN4ZPIRW1YQDurbZRiIkViKO5xA7J/qEz
 nO9+L8W6FoV1zP5po2tPCGfuU/Mmqm1ANGHjFP7KyI8CHjqpmWv+idF9a/iPBActiBuP6XbV3
 dfSFXdu03N1d848YV5xRqmTDSokEnQ/H9+g/Huue7zaesUkWyptDB+mtYKguGHhn2knpfThIm
 yFGn3T+tVQHNeeSJirHheUkCU7P9ycehlBvyWhhTr7E25eEYFQyzS6f/p17hJ1L3fVUKyJhrv
 aA0sH/HBaxreZiOuReyRQh5q5869fgaXbV2jpYQIO3pNfwg1fwt7D7mi8nievlrVMR38H2AZu
 PpNC5K6wP/gksiGHGWM+xKD5tl3yg/PkBANWS48soGmI9RZNPTscezVI7RpyUb3YpB0SmysIc
 uLkKEPFKLnkJdneT+iR2BuWJOqRIDYpGDaA6/nCP54PgePQsa25dX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 1:07 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Thu, Jul 23, 2020 at 11:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Thomas Gleixner <tglx@linutronix.de> writes:
>
> I have applied this patch-series v3 but some basics of "i386" usage
> are not clear to me when I wanted to test it and give some feedback.
>
> [1] is the original place in CBL where this was reported and I have
> commented on this.
>
> Beyond some old cruft in i386_defconfig like non-existent
> "CONFIG_CRYPTO_AES_586" I have some fundamental questions:
>
> What means "ARCH=i386" and where it is used (for)?
>
> I can do:
>
> $ ARCH=x86 make V=1 -j3 $MAKE_OPTS i386_defconfig
> $ make V=1 -j3 $MAKE_OPTS i386_defconfig
>
> ...which results in the same .config.
>
> Whereas when I do:
>
> $ ARCH=i386 make V=1 -j3 $MAKE_OPTS i386_defconfig
>
> ...drops CONFIG_64BIT line entirely.
>
> But "# CONFIG_64BIT is not set" is explicitly set in
> arch/x86/configs/i386_defconfig but gets dropped.
>
> Unsure if above is the same like:
> $ ARCH=i386 make V=1 -j3 $MAKE_OPTS defconfig

The logic was introduced when arch/i386 and arch/x86_64 got
merged into arch/x86, to stay compatible with the original behavior
that would produce a 32-bit or 64-bit kernel depending on which
machine you are running on.

There are probably not a lot of people building kernels on 32-bit
machines any more (real 32-bit machines are really slow compared
to modern ones, and 64-bit machines running 32-bit distros usually
want a 64-bit kernel), so it could in theory be changed.

It will certainly break someone's workflow though, so nobody has
proposed actually changing it so far.

> When generating via "make ... i386_defconfig" modern gcc-9 and and a
> snapshot version of clang-11 build both with:
>
> $ ARCH=x86 make V=1 -j3 $MAKE_OPTS
> ... -march=i686 -mtune=generic ...
>
> Checking generated .config reveals:
>
> CONFIG_M686=y
>
> So, I guess modern compilers do at least support "i686" as lowest CPU?

i686 compiler support goes back to the 1990s, and the kernel now
requires at least gcc-4.9 from 2014, so yes.

> Nick D. says:
> > I usually test with make ... i386_defconfig.
>
> Can you enlighten a bit?
>
> Of course, I can send a patch to remove the "CONFIG_CRYPTO_AES_586=y"
> line from i386_defconfig.

The "i386" in i386_defconfig is just a synonym for x86-32, it does not
imply a particular CPU generation. The original i386 is no longer supported,
i486sx (barely) is and in practice most 32-bit Linux code gets compiled
for some variant of i586 or i686 variant but run on 64-bit hardware.

      Arnd
