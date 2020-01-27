Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D569DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B4621739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgA0NM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:12:57 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:36925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgA0NM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 08:12:56 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N5max-1jfm4C104B-017ALR for <linux-kernel@vger.kernel.org>; Mon, 27 Jan
 2020 14:12:55 +0100
Received: by mail-qk1-f180.google.com with SMTP id w15so7772862qkf.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 05:12:55 -0800 (PST)
X-Gm-Message-State: APjAAAUnbSknQ0zJ4GD0R1ND9itcN/JMIjTJM+kFJ5mnKqHM+ty4hg+n
        iSpPmTmaK5tARUY0eARf4+M7iqo7QzRNMcElR/k=
X-Google-Smtp-Source: APXvYqxbvFpeiM8Jlbq76v1COK9TQt9IgHSB9reHtWof52+MxgY5qWFvlyLbK38KNCc7xX0a4X/9uw7X/O9LDCisT4g=
X-Received: by 2002:a05:620a:12e1:: with SMTP id f1mr15895676qkl.394.1580130774164;
 Mon, 27 Jan 2020 05:12:54 -0800 (PST)
MIME-Version: 1.0
References: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
 <CAK8P3a2YLo4rNBXu9NhvKv6QOFUcZhCVXNR4XJe_0Kc_RJ=ubA@mail.gmail.com> <AM0PR04MB4481E1AACAC4285D49E721AD880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481E1AACAC4285D49E721AD880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jan 2020 14:12:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a30vieqOdend-o+_1AesAQCN97cW6KtQmAgV3uhDWi_jw@mail.gmail.com>
Message-ID: <CAK8P3a30vieqOdend-o+_1AesAQCN97cW6KtQmAgV3uhDWi_jw@mail.gmail.com>
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
X-Provags-ID: V03:K1:qE2yDiwHg7JNQtxjcQlnFbX5nu1u3yPS7jitsxKbQ68nLfeR9Vw
 Ug+YpPNBZ3NjvfQ+L3NkQxYlwdV3MLTOuRGljHfAL7g7cfDNHVXB9B2XnHyKpnCgzjOOzZy
 nXcLbH/UOVCyzAZDXZa6b2v+2t2ASdWZ7nqiH+0eAxxk5rom031NGbcX7zsu+apKfY63sv4
 rIesKHM1kV+IBE/fKfTDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nWFo/m0Rd7Y=:GgsDSlmps7slgP7nwCG9EF
 eht/O8TOOxe8NeueGZt0DriZqp6gvCdGldcWJiA0+l7ZRdlLpWL/rJuruNKTJM6igcUD2G92W
 DzxEIg0/Sxtu5ObNi6/H/JpFvR8SoV6BFuGQocJp1IdYFOq8COktj6ZQxYIVexNC9JWhwMK2D
 olEMyOkgj3pb9xZPnLJfstd8QAY+VfscyE/qdofCYjB88E/ds1YuJE3gktJdVdD2LxzI5JtMK
 UoSwFaqaNbg47fz1rxf/b6lTms4A+iEC9LAuly7WbdcwJL5PtqpO+ZhHIoWrrsU+C4KmjSKGp
 H7c1zTT3v04vB7T3M8rXd7snWzuFE65fn9/oo4atwgfeO6ATaQQMOAa/ZiW6g4QQwez55XV/z
 h5WGI3sEY70E/tuKPnblBM3JBuYQEx68s8ca2WFFKYUpgIUR1CSHXBvS3VSFatgyjjD8VY1Y7
 DdUMxaOrTS+yz1LYFHmFSmw5x2JI+jZtGQ2F+7aUTF+PTpDo6wZ1FHLckfUe2sewDdsHR+3I0
 XKzS/utdEhDM/r9jWaDRHQ7q4PufX2lMfejw8u0KTM9Ad/357NrVAyiOtVBdjhBhji79c9msY
 Em/rhmO0qxlUJBPCWRYGPc8OGjFAmDK9yGz2t20rHZj4lHOfzDcWKCryTZqB0fxbYXUK0yM6u
 x7upDV0E1ovXrIqAAxh86tZ8YQEXY4B2DPL/OTRovS1sdt8UXFeWTdjc2zDInqXVdpbpDm63U
 9AxZKP3HTbZ3FwtF9fIMDxpDQKBHdNnROtQmbUVvrqd9vQnEtunnXvPTE4KUhGy18kBGgsdeD
 g867ngB01VPV52gtvJUR3sDl8vZjZ9wyRP1eDdqUjsVIkqjqM4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 1:33 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Arnd,
>
> > Subject: Re: [PATCH V2 0/5] soc: imx: increase build coverage for imx8 soc
> > driver
> >
> > On Mon, Jan 27, 2020 at 10:44 AM Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > >
> > > V2:
> > >  Include Leonard's patch to fix build break after enable compile test
> > > Add Leonard's R-b tag
> > >
> > > Rename soc-imx8.c to soc-imx8m.c which is for i.MX8M family Add
> > > SOC_IMX8M for build gate soc-imx8m.c Increase build coverage for i.MX
> > > SoC driver
> >
> > The changes all look good to me, but I'd just do it all in one combined patch, as
> > the changes are all logically part of the same thing. You can leave Leonard's fix
> > as a [PATCH 1/2]  if you want, but the rest should clearly be a single change.
>
> There is a arm64 defconfig change, should it be also included in the single change?

Good point, that one is probably better left separate indeed.

      Arnd
