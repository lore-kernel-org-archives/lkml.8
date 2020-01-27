Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0647C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCFC214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgA0OMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:12:40 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgA0OMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:12:40 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M9Evp-1iz7GD2fZ9-006PAL for <linux-kernel@vger.kernel.org>; Mon, 27 Jan
 2020 15:12:38 +0100
Received: by mail-qk1-f174.google.com with SMTP id x1so9647522qkl.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 06:12:38 -0800 (PST)
X-Gm-Message-State: APjAAAVm7AmPjQMDAFUfAFZz/Xl2b3rEgygEr1fGktaXg6NTKWT9SFIN
        5OlVJSQKmMBeISSlqByR5vflMLhxi7j4mNTJ0nQ=
X-Google-Smtp-Source: APXvYqyqkXSPHKaHYaA/H+oE3DOuo2nHc6OjSUgoQDX3Sn/WOCgNZb3dWH6MiCz5XzO50aznK8fftZ2JxIouPMX9yfU=
X-Received: by 2002:a37:84a:: with SMTP id 71mr16274917qki.138.1580134357497;
 Mon, 27 Jan 2020 06:12:37 -0800 (PST)
MIME-Version: 1.0
References: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
 <CAK8P3a2YLo4rNBXu9NhvKv6QOFUcZhCVXNR4XJe_0Kc_RJ=ubA@mail.gmail.com>
 <AM0PR04MB4481E1AACAC4285D49E721AD880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a30vieqOdend-o+_1AesAQCN97cW6KtQmAgV3uhDWi_jw@mail.gmail.com> <AM0PR04MB4481724FC5F8345502860B08880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481724FC5F8345502860B08880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jan 2020 15:12:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3VcPhPDskzrGL2UZJz1YK+7nGLC3S0soY0c78j3=LVwg@mail.gmail.com>
Message-ID: <CAK8P3a3VcPhPDskzrGL2UZJz1YK+7nGLC3S0soY0c78j3=LVwg@mail.gmail.com>
Subject: Re: [PATCH V2 0/5] soc: imx: increase build coverage for imx8 soc driver
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8JsE9jQFypV1wQD8H80XVpA/fy+Hlym9DaquqcqggJgFBAUQ8vJ
 GA4GQayoeKAqaOeLy0WEoxSbpQZ1xtcQbE5jSFZf8PdLE3wPMRqnH36qBC2POhRz4N6ZHf+
 EK0Q3whHNUz+l4nSVA3YDW3vM+Qtf6v350VX/abkybcby+Gu+h5UPzg6mmyd2X3oGchO/c3
 hp8kLQPuxf/sSCi8yU1vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t3C4NtErNlU=:gZvTHbAWDD0BRsFMjICgAl
 wQs+09p6TYBnqE40mBGn7NzfnopavQSocMcX6F6xe1oHsh62QbKEsHkYfYk3T/JHpAaHnJTZl
 AzR8WyolTQuwV839aaMc00mXsDMnGM9BLB1U9iitXr8UdCsatn7UL17WqV7gyjjOsNnaC0GK4
 0CWDl1pjJsjFvzhk8VNfUhCkYugG2JZ/tuR/GbfW9Pn8j+fwuh9ajBjg84RA2AJOTRpPAevth
 Khix8HQKLxuC5rwUrOLRiWfEZUaC8Pa1U4DdK13lQ+I/V209as/oaEaLlWO1UNM1BunTtkk9O
 ab6kPsnhBOS1t3Qy4GpKy1wIp8niOqwKFgPKtZsEJLv2734svgBVUkZaSGxvKNPZxyMjwOpYC
 hzM9aaZXSqOlySNrW1YsZeVz1FmkY+cMmd9WP2YSyg7CwE7lqa1DylplfTsVTfb9VRaFxzcSz
 KvGJisuiZZmv9zZqfUJHja3Tmj5U1riXBrC5A+XgWpfbRN8T7QP8oWYCHc9sJUD6qqE0J2enM
 DsD10BSIJnnXEQhfHdKU096yADTnkqfknajEEb21X+69rL7bSchIxquyUJKR6y851X94wCGTr
 Zg1SWoFp+f6/QUrmXAv2Ml/8TJ8va6eKkrMk+VPZfl7MDOPL8DHgdfaNPclTPUzBXlQnRuByl
 dz6oj9Y5dL5fstlYPLTDMYx17mIE60uJxlebGdK61FDCf8+lYga2oZwK0PU3nY8tiQ35jFtq9
 tS/2lOTGX2/BSFpr11wa/gXIbqZqa8kcWtGwDIKiWkFq9iK0zd56tkOOdKguSr1xob0H3WuK2
 IqniEPUnMEQ9DCakizYYyKr8K9RwlTZ2l5J/N1bZDQmFzzgYp4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 2:22 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH V2 0/5] soc: imx: increase build coverage for imx8 soc
> > driver
> >
> > On Mon, Jan 27, 2020 at 1:33 PM Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > > Subject: Re: [PATCH V2 0/5] soc: imx: increase build coverage for
> > > > imx8 soc driver
> > > >
> > > > On Mon, Jan 27, 2020 at 10:44 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > >
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > >
> > > > > V2:
> > > > >  Include Leonard's patch to fix build break after enable compile
> > > > > test Add Leonard's R-b tag
> > > > >
> > > > > Rename soc-imx8.c to soc-imx8m.c which is for i.MX8M family Add
> > > > > SOC_IMX8M for build gate soc-imx8m.c Increase build coverage for
> > > > > i.MX SoC driver
> > > >
> > > > The changes all look good to me, but I'd just do it all in one
> > > > combined patch, as the changes are all logically part of the same
> > > > thing. You can leave Leonard's fix as a [PATCH 1/2]  if you want, but the
> > rest should clearly be a single change.
> > >
> > > There is a arm64 defconfig change, should it be also included in the single
> > change?
> >
> > Good point, that one is probably better left separate indeed.
>
> Since the defconfig change needs stay alone in a patch,
> merge other patches into one might not be good. The patchset
> I did is to make sure the soc-imx8m.c could always be built. If
> I merge the others into one, without the defconfig patch set CONFIG
> option to y, soc-imx8m.c will not be built. This might break git bisect
> to check the soc-imx8m.c
>
> So I prefer not to merge the others into one patch. Do you agree?

I'm generally not too worried about intermittent defconfig breaks during
bisection, as the defconfig is not use all that much in practice. Splitting
the other changes into separate patches wouldn't help here either
unless you want to spread it out over multiple merge windows.

I'd probably just put it all in one patch (including the defconfig change)
in this case, alternatively you could add a 'default ARCH_MXC && ARM64'
to the Kconfig symbol.

       Arnd
