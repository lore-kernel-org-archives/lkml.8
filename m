Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B873FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB4C20724
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDXIY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:24:28 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51937 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDXIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:24:28 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MirfI-1iy5Bm2knE-00ermo for <linux-kernel@vger.kernel.org>; Fri, 24 Apr
 2020 10:24:26 +0200
Received: by mail-qt1-f178.google.com with SMTP id c23so6702945qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:24:26 -0700 (PDT)
X-Gm-Message-State: AGi0PubbSM2MMsL3F1/OZTSC5t5Od9DJ9u1P7EPrt1VmHsliQQ/PCAGR
        ehTn+RplmfYYDEDk3cCvuDidwbf5LdxWEI0Kz+c=
X-Google-Smtp-Source: APiQypI5XKKeYpph2srgBYptReM/Zy+X8DRo7uaSXOoQaczls9rUfDwM4DHkoEvZ2EFyHutZ4c/nmGywPTpyagyzaIk=
X-Received: by 2002:ac8:6757:: with SMTP id n23mr8169715qtp.304.1587716665488;
 Fri, 24 Apr 2020 01:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587088646.git.baolin.wang7@gmail.com> <96d444cd73239e0166316bd8f44082031cf72491.1587088646.git.baolin.wang7@gmail.com>
 <20200424081138.GP3612@dell>
In-Reply-To: <20200424081138.GP3612@dell>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Apr 2020 10:24:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1e15P6xRUgYLYxT8XUx7FREbs5mMbfL1Qj+qwoDfFX+Q@mail.gmail.com>
Message-ID: <CAK8P3a1e15P6xRUgYLYxT8XUx7FREbs5mMbfL1Qj+qwoDfFX+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: syscon: Support physical regmap bus
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2K+GAGwFhQmpVmBIpjaWQD045qweWak1znMe5IElenplRHB83/p
 rfFyfdjPHps/upi/qoIomw7X6jwDR6y/lKeSHY2YbPX1YKyq3pITGvTAKc3yRHYUXNdSg/z
 QOhGICO/UIymow9wI21jq3xUWFubIEo7e6PQU3bvCxNVDCnrywk8So6y3FPgC4HU5ZTDxpQ
 bXjiIrlDJox1entBgZugA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nQRoZ+27ENQ=:SAMUZguhLGVZxEaMbhTvS4
 2sS50cUBpWfEJXXQpXimDz8dSli0Ho+nWMpWCf0r0UCYkWZju5ufoQFrr4WLnJRyK2UmI9hcp
 AaDS2fH2r3q+WC34sq+rZB5lL29vwbqWP6LrkfHitV72Hwuduthd5SinD1YWU5508pOPxDFym
 M3yuvND9DDd6Nn0s1FdmxhhYkA+IynfOsA6h1c5TLwB7+Gl1dLQAnptH4bJJCmjoq7BNBCP0Z
 kG7sVVeha9R7ukNL2aPk31RjqKaMRIp6N4OoJZBL7+IU91IF2WOkvkxlooU6CY7oYq12OkHkH
 4umkU3UIwtq5hsIapvX3CWdLsrrOXCVwTaaXS00yc9KotMWTSLF3lda+Debaqdl9yJDW7HjVQ
 SFwOavgXOqHzFeaBktb0+jS2plKGs/hR0p88EsmouQlpGOplY+g6wLRnMd4By8GZFWxoFvYjn
 8niZm3wmXTYwCM0O8B7yf84kcGWGUPuTWYfHH6ZsXiGrnVVOim/pmp1xofLhNsMHeMTpKxNwp
 x7y61+D2VYDIbeHDNn0iMkLTPH61mqKJ23CEntS7dbYJx+iDahyrFP+p6w+TWCduclGBAjNp9
 pvmdkS1SiBJPhvmhNxtjri8jPzdpOFehkzY/tFSebzmEpi7GRc0V4vSGk3a5Oz8A87+mCv+k6
 qXpfQ7Oif5BGY5tKWIlWCHDacMriKRQhg0cSTRycrzGJcznjPcqO7OcAIZjkfjJmHYoyg/5Uf
 R2ZMqVl0pAo+Rl1UhEnwHuyEJuLrWosaek4Cj1ximvMyFbPX1c3khr5r4J3c+DbMxiH/odZwA
 5XDnIXQlsfwd5ycZrhvRrTXGB27X9v/ya75s0VQPXokKaifvkI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 10:11 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 17 Apr 2020, Baolin Wang wrote:
> > @@ -106,14 +107,25 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> >       syscon_config.val_bits = reg_io_width * 8;
> >       syscon_config.max_register = resource_size(&res) - reg_io_width;
> >
> > -     regmap = regmap_init_mmio(NULL, base, &syscon_config);
> > +      /*
> > +       * The Spreadtrum syscon need register a real physical regmap bus
> > +       * with new atomic bits updating operation instead of using
> > +       * read-modify-write.
> > +       */
> > +     if (IS_ENABLED(CONFIG_ARCH_SPRD) &&
> > +         of_device_is_compatible(np, "sprd,atomic-syscon") &&
>
> Please find a more generic way of supporting your use-case.  This is a
> generic driver, and as such I am vehemently against adding any sort of
> vendor specific code in here.

I suggested doing it this way, as all alternatives seemed worse than this.

        Arnd
