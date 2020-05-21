Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574C7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D6A20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYBwUI7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgEUQC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgEUQCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:02:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A5C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:02:55 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d7so8003555ioq.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FvB3nemWpSRg2EVLTdUggECQqohB5chkMGgTHaWJIMs=;
        b=oYBwUI7y72PnHahWzhW3tqjDl32RaJqIohkHHw3ioNmfCmgbGEjbzDg8cTFC0i6Cm0
         cAWBVydGkcbeeGMLBYVvqood/bdkDIdVJHgb2Lzllb7b0qQFKUUN2mKxiLYXVHXEqlS4
         d2F0l+UEnkOvA4dBmCiOPyUgR/TuiEwI2rFgPUVHRM9fqdt0OPZ3slRhrq732ERX+bXo
         hh9rHapYQq/Y4TqyO5L6PFheAB/IaU58A2N3sXzCLc2Kf0TUSXGfjBvnRtWe4T1Au/Rf
         7afUnUwxTUXYH+7arQhL1icKoDDaWiF8PlewYsDBjF1rGVb/mjCZh5d9lfWMxPw3KUdo
         uWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FvB3nemWpSRg2EVLTdUggECQqohB5chkMGgTHaWJIMs=;
        b=Gu5aVe+8xw+pkAnJz31rGVYcTRvYNLjfUCSSM32Qng+WfBuIRVgH1aPQn2W+nTqtwg
         CwSYnx5sUs/LuhLhkrMsIHvrFTQyyIbd+iVpP3nJH+yDROzKV/1pVJ+vVL9Oogao0wxB
         ykIG97kppZfezH0TjR2r/Vl+d2le+wgJbL99tGKfhbu4f8TWDeaBWscrCFTlQRlO/iwH
         pQXi64SMS3jRZR4XIgg9f5vHjehOeE5KVWi6USpcebALH856YgqbQvA7YAFs9Xwz/ymg
         wVQ0OtsBu1Yv40GPzlzDyRz6f/cHwawB/YiICKllkY2cNGoZTzfEBmmq+MD3udcLkLNZ
         X5fQ==
X-Gm-Message-State: AOAM5326kZ94GmM5eknQQlsW01wqPxLvVZZAeqnLlKQt+2jZLk+n/RzE
        L2JFKWCD76SD5vBgHqCO6HGUTrKtYy8vQIaH1P4=
X-Google-Smtp-Source: ABdhPJywF8W6dMwOjSrT7p/OY7kY9xXZeMvErBWRP/H0P/gbuIavWzR5KrdTLDllpBnwoRty9ILYpV3zNEa3kNesRvY=
X-Received: by 2002:a5d:9dc5:: with SMTP id 5mr7827124ioo.92.1590076974760;
 Thu, 21 May 2020 09:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <1587999532-30006-1-git-send-email-abel.vesa@nxp.com>
 <0d301ed303faea4895d30b682133ec5c9d44bd8b.camel@pengutronix.de>
 <AM6PR04MB504745F6EB1FB17F6DBDD9A387AF0@AM6PR04MB5047.eurprd04.prod.outlook.com>
 <97aa62e8aaf8fa1c462c7db117fca9b6ea9bfec0.camel@pengutronix.de> <CAJ+vNU3oMSpbysJ+BXyGGFknZs6BHH6hZ_qLpnsxmSBJ1Log7A@mail.gmail.com>
In-Reply-To: <CAJ+vNU3oMSpbysJ+BXyGGFknZs6BHH6hZ_qLpnsxmSBJ1Log7A@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 21 May 2020 11:02:43 -0500
Message-ID: <CAHCN7x+GeC0TqGUAASP_cDCMw-ajZJAncqurvdQzrGgg72bFHw@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Add power domain driver support for i.mx8m family
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:56 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Mon, May 4, 2020 at 2:19 AM Lucas Stach <l.stach@pengutronix.de> wrote=
:
> >
> > Am Montag, den 27.04.2020, 15:37 +0000 schrieb Jacky Bai:
> > > > -----Original Message-----
> > > > From: Lucas Stach <l.stach@pengutronix.de>
> > > > Sent: Monday, April 27, 2020 11:11 PM
> > > > To: Abel Vesa <abel.vesa@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Sh=
awn
> > > > Guo <shawnguo@kernel.org>; Sascha Hauer <kernel@pengutronix.de>; Li=
am
> > > > Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>
> > > > Cc: Aisheng Dong <aisheng.dong@nxp.com>; dl-linux-imx
> > > > <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org; Linux Ke=
rnel
> > > > Mailing List <linux-kernel@vger.kernel.org>
> > > > Subject: Re: [PATCH] soc: imx: Add power domain driver support for =
i.mx8m
> > > > family
> > > >
> > > > Am Montag, den 27.04.2020, 17:58 +0300 schrieb Abel Vesa:
> > > > > From: Jacky Bai <ping.bai@nxp.com>
> > > > >
> > > > > The i.MX8M family is a set of NXP product focus on delivering the
> > > > > latest and greatest video and audio experience combining
> > > > > state-of-the-art media-specific features with high-performance
> > > > > processing while optimized for lowest power consumption.
> > > > >
> > > > > i.MX8MQ, i.MX8MM, i.MX8MN, even the furture i.MX8MP are all belon=
g to
> > > > > this family. A GPC module is used to manage all the PU power doma=
in
> > > > > on/off. But the situation is that the number of power domains & t=
he
> > > > > power up sequence has significate difference on those SoCs. Even =
on
> > > > > the same SoC. The power up sequence still has big difference. It =
makes
> > > > > us hard to reuse the GPCv2 driver to cover the whole i.MX8M famil=
y.
> > > > > Each time a new SoC is supported in the mainline kernel, we need =
to
> > > > > modify the GPCv2 driver to support it. We need to add or modify
> > > > > hundred lines of code in worst case.
> > > > > It is a bad practice for the driver maintainability.
> > > > >
> > > > > This driver add a more generic power domain driver that the actua=
l
> > > > > power on/off is done by TF-A code. the abstraction give us the
> > > > > possibility that using one driver to cover the whole i.MX8M famil=
y in
> > > > > kernel side.
> > > > >
> > > >
> > > > Again: what does this driver bring to the table, other than moving =
a fraction of
> > > > the power domain functionality into the firmware?
> > > >
> > > > The discussions on the last submissions of this driver already esta=
blished that
> > > > we can't move all functionality for the power domains into the firm=
ware, as
> > > > controlling regulators is probably not easy to do from this context=
. Also the
> > > > TF-A side implementation of this driver is "interesting" IMHO, it d=
oes stuff like
> > > > accessing the clock controller registers without any locking or oth=
er means of
> > > > mutual exclusion with the Linux kernel clock controller driver.
> > > >
> > >
> > > The clock handling is in kernel side through CCF, not in ATF. See the=
 patch below.
> > >
> > > > Why can't we just extend the existing GPCv2 driver with support for=
 the other
> > > > i.MX8M family members?
> > > >
> > >
> > > The reason that why I don=E2=80=99t like to extend the GPCv2 is that =
when doing domain on/off,
> > > We need to access some special control register in each domain & do s=
ome special flow,
> > > These control register(mediamix block control, vpumix block control) =
is not in GPC
> > > module's address range. No benefit to reuse the GPCv2. Only bring com=
plexity to the
> > > GPCv2 driver each time a new SoC is added.
> > >
> > > Yes, the i.MX8M power domain support has been pending for a while. AR=
M guys rejected this patchset
> > > because they suggest us to use SCMI rather than SiP. But SCMI is only=
 partial suitable for our
> > > case.
> >
> > Can you please point me to the most resent version of the TF-A side
> > implementation of this? The i.MX8MM implementation in the
> > imx_5.4.3_2.0.0 branch in the codeaurora imx-atf repo still contains
> > writes to the clock controller register range.
> >
> > Also I would love to learn why the GPC needs to access Mediamix and
> > VPUmix domain registers. If you are talking about the NOC configuration
> > I would strongly suggest that those should be handled by a Linux side
> > interconnect driver, this has nothing to do with the power domain
> > sequencing, it just happens to lose state over the power down and needs
> > to be reprogrammed after power on. The NOC configuration though is use-
> > case dependent, so this should be properly handled in a rich OS driver.
> >
> > Sure we needs to extend the Linux side GPC driver for each new SoC
> > generation, but that's no different from any other hardware driver in
> > Linux. Drivers are the abstraction around the hardware, there is no
> > need to invent another one if there are no clear benefits.
> >
>
> Jacky / Abel,
>
> Any movement on this? As I see it the lack of imx8mm power-domain
> support in the kernel is holding up USB, PCIe, VPU, and perhaps
> GPU/CSI as well. I would tend to agree that hiding this functionality
> in the TF-A is probably not the best approach especially as that
> requires a NXP version of the TF-A. I really don't see the issue with
> the gpc driver getting a little more complicated if it needs to. There
> is bound to be some complication as there is such a large variation of
> IMX8 products out there! (talk about confusing!).

NXP -

Please don't let perfect be the enemy of the good.  We have some
patches floating around which enable much of the functionality.  It
may not be perfect, but it's an improvement from what we currently
have - which is nothing.  Please let the patches in, and when the
alternative methods become available, we can remove these.

If TF_A is arguing about how to push the patches upstream, then maybe
Tim is wright and it's not a good idea, and we should consider
something else.

adam

>
> Best Regards,
>
> Tim
