Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAA5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A523F20720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390664AbgF2VPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:15:39 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbgF2VPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:15:34 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M5wTr-1jjXoK1ZIx-007XtN for <linux-kernel@vger.kernel.org>; Mon, 29 Jun
 2020 13:47:51 +0200
Received: by mail-qk1-f179.google.com with SMTP id b185so4303789qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:47:51 -0700 (PDT)
X-Gm-Message-State: AOAM531kW7xXBzqwARsG0zlpZpRPRhMTKSQ6PV/w66JyMVCMVOxJo9Yn
        IH56xAQpbSQzO8d0yw6dj4AWRJzuz00vs84XHUY=
X-Google-Smtp-Source: ABdhPJz/2Mk0UBypqySiBXzhbwhOOuuPjmaRdr8KCETbhDaAxvWInXHpxUDFWzD6SVaYXVOZ7MjowFJGo49t+l9Ai6c=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr15045562qke.352.1593431270287;
 Mon, 29 Jun 2020 04:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <1593425623-31810-3-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2wsaS9i9BrV6o845Qx4TJrZM=+13C1haqBLg17HKVgXw@mail.gmail.com>
 <DB3PR0402MB3916E7A184549BF302C7401FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916E7A184549BF302C7401FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:47:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1qSdiKfcgXLAQ8JTWeg4_i+8+qh-7hH5rYiEjp-dJMkA@mail.gmail.com>
Message-ID: <CAK8P3a1qSdiKfcgXLAQ8JTWeg4_i+8+qh-7hH5rYiEjp-dJMkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: imx: Select RESET_IMX7 for i.MX7D
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tVOg2jD1oItr1kXIzUR7X2b82Ivgn5xZGNS4yrdmYUxa9YbdP/W
 RFHKLgKHH6lujFrgoh65TfQo5T0ZXHE5h4LWTzP2UMXd+ZsDScFBRu0QZhGOrwq+7yaPgRz
 aoGHnMczEFbIv1+8NVwWzmrgwozv+ra+Q4TgV04NBeMCHyhifMBmAp4rE+VAkYQ3WVNsK1p
 D5f7TCM0UY0j9dAWfRx3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p6Ba7RHcT38=:pK4VQat1pFN7MMQGGxwTDW
 1dXFPEBpGG/kNmNUgVBsRe6i5EWTzcU5XY5XB8G50JuGBWqsfQsUyrZo+u5bS8RjdNi5j8qTJ
 fQwxdqNlCITb5Z0Mq9ns1v8mL8dC9VH0AkgJln8kW6lK+3NEMoL0qJqyyUeGnSxijaKz5ABlI
 OM0mLeo4JpwYD0TNG7Z0fh+pFbLYZyu/3pRP+skjBz0fYDcbdmRCCXpuVHIzI2WfcgvTPfsx9
 +vHwqJhWDi/Nui0WcU/DEt0m/97MUueJ7pNrDdIZNboK9RZzClLtTlF9MTyW6neiOCULlJK4L
 1KzaFGBB2GX96kykBV8akvOJy1C9vUIsSCdXJQLnrOitmdzOcsJSnygDuf6hzk21CXK7KRJO+
 9Ah8JaT3bT0iLYsFzKdo3NAlYlrFKMn3dkRhGMZ1Yb5RMXkBNvJ/5UagiqYWOb9mmHvLxL49E
 hmzFW8YlIvx1YeLFUVsz7uUwWRIeNfxyLFe2iO6KNVEcK/60ZvCOO0iUDVP3P1rGHe+eA5iD3
 GtOQ8PrSV20ZgIIhbXlUAxGam5yyoarrVVbBk+lodkGY6MV2uQHP2dV+FiYoyWHg+1vvF3v6s
 r0fhWgPTSPFHM4nxW98watdrs/zk/6lKTpnvfEobLo4Vvz1/tYOSJmPn75jVDjxbMw4B4b9DL
 3WxeMtfkY7hg4WcF0wCEFYYhr+8SATzslxhMyl3l0TM3q2+jWqCylLkG3jX7esyRnH8tAIEk0
 ppDblCvGWmj6JYAGR3Cn7nu6q2rQpx6CRSRZ+HwEIIFheO8xZr1y/T6tpLwfSvObl0Y0lKDNJ
 /VBw1e/3zt3O3uXwBDzGQ49DITw3B0rL2kFoRYADWo0Uw4FfF1nT2ZmiZLQE2bUfjDqDUIoHz
 Eshva/sdIBYtY2RDpFcCWog+H5hjt0SqE/d9k8MX0+iFit2B0gnaHxwujvVommdPLCe5wmt1u
 Rb4Ce7WfjSRy5gE95AXIEWCAXQnJemDsC3voIfnpdPDYp53cw0cLp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 1:36 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH 3/3] ARM: imx: Select RESET_IMX7 for i.MX7D
> >
> > On Mon, Jun 29, 2020 at 12:25 PM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > >
> > > i.MX7 reset driver now supports module build, it is no longer built in
> > > by default, need to select it explicitly for i.MX7D.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  arch/arm/mach-imx/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > index e7d7b90..3540483 100644
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -561,6 +561,7 @@ config SOC_IMX7D_CM4  config SOC_IMX7D
> > >         bool "i.MX7 Dual support"
> > >         select PINCTRL_IMX7D
> > > +       select RESET_IMX7
> >
> > Please drop this patch, it breaks the intent of the first one by forcing the driver
> > to be built-in again rather than a loadable module.
> >
>
> One thing to clarify is, the loadable module support is ONLY for i.MX ARMv8 SoCs,

I don't understand. Why can't this driver be a loadable module on i.MX7?
Please clarify in the changelog what the bug is on i.MX7.

> ARMv7 SoCs is NOT in the plan, that is why I add this patch to make it same as previously
> when this reset driver is =y by default. Without this patch, this reset driver will NOT be
> enabled by default for i.MX ARMv7 SoCs, function will be broken.

But it's the same driver, make it work the same way on all chips!

I think artificially limiting a new driver feature to one chip just
because nobody
asked for it on another chip is not helpful.

      Arnd
