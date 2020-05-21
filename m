Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3006C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0D420748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="slV1NT9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgEUP4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgEUP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:56:17 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260CFC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:56:17 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id r25so6621327oij.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8vYYXmeN5jPKZ8yHl1zcQTrk3+2MBfEvZOrsg6uMWz0=;
        b=slV1NT9Kmw9gIGPFL64AKgnZtLSVTVxRMvTeUjYnQctDiz/6T8czmC8Q3Ok+HDigX5
         1o5tk5qs9S8evmRNALsJRSQRmIj5vVxTU6dVNIYK+UmM/YU3cNy8YuO0AE+YS2PnMzBE
         f+Z8wOIiXlnpnYOtkZNn9/LWFqoixCsaVY3LZRBoe7o4whn1qo7J8eWFXIBGZJXY3lpk
         tXWL2zGiF2WIDZJWLX5AcnkSBZFI0pGmMlEXP+NlirYU6HKGTuBcSNSc1tDLDtJpIo3r
         WOLGBP9ud/kFhAZpqMuhShW/4CGzi0RRkt4VpBawsZAfzlPCYBrUclxGvj0dtSk7t+qw
         aIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8vYYXmeN5jPKZ8yHl1zcQTrk3+2MBfEvZOrsg6uMWz0=;
        b=KD1mVhlUcx4TzU0PcUQV5ilTAeJN0O+VN4OLx7sKVTbUa3Kwt07dm596LXrjyt5GA4
         MXKwYIdKp15vGQurGHq/FBYmYHbj1CZDs1yt7Ql/ZML+mrSNkK/kZ9cDyi2kFU+ECXvl
         8z2n666kFI3C/I/nb2EjZGbSfi+Hudq9dMN72lGlf/62Dp20E22fcMxkAAy5Fs/hJqOM
         ++AB+n5dkvdekWBCexsZl75zMZDeMKwORqqLSxfYc1ipBnuDQe6JyEzNSh/yFLZHw/Zo
         bpLVVsiaDugHWnCpFsN/F9CeyEllHOA5+Qad9HElCXAm0S2nm6EM8pebCxzGaoOZGUTk
         CW+g==
X-Gm-Message-State: AOAM531Ysln+9YiWmrtatl6D7r5yUELTl5/gFwdqeznatf5I3+woXJfg
        Lx5HVpnf6EqMgditwb1043cFccizVrb8B7eRjq6yQg==
X-Google-Smtp-Source: ABdhPJy1z6pfeCPw1pWfVSSf1a0FvzBy/xV8oCNlLV6yNes/xmwH+hthAwIjJ/mwMj5W2DsBfYqcAq1aV1CAlY5JPvI=
X-Received: by 2002:aca:534c:: with SMTP id h73mr6942846oib.52.1590076576468;
 Thu, 21 May 2020 08:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <1587999532-30006-1-git-send-email-abel.vesa@nxp.com>
 <0d301ed303faea4895d30b682133ec5c9d44bd8b.camel@pengutronix.de>
 <AM6PR04MB504745F6EB1FB17F6DBDD9A387AF0@AM6PR04MB5047.eurprd04.prod.outlook.com>
 <97aa62e8aaf8fa1c462c7db117fca9b6ea9bfec0.camel@pengutronix.de>
In-Reply-To: <97aa62e8aaf8fa1c462c7db117fca9b6ea9bfec0.camel@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 21 May 2020 08:56:04 -0700
Message-ID: <CAJ+vNU3oMSpbysJ+BXyGGFknZs6BHH6hZ_qLpnsxmSBJ1Log7A@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Add power domain driver support for i.mx8m family
To:     Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 2:19 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Montag, den 27.04.2020, 15:37 +0000 schrieb Jacky Bai:
> > > -----Original Message-----
> > > From: Lucas Stach <l.stach@pengutronix.de>
> > > Sent: Monday, April 27, 2020 11:11 PM
> > > To: Abel Vesa <abel.vesa@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Shaw=
n
> > > Guo <shawnguo@kernel.org>; Sascha Hauer <kernel@pengutronix.de>; Liam
> > > Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>
> > > Cc: Aisheng Dong <aisheng.dong@nxp.com>; dl-linux-imx
> > > <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org; Linux Kern=
el
> > > Mailing List <linux-kernel@vger.kernel.org>
> > > Subject: Re: [PATCH] soc: imx: Add power domain driver support for i.=
mx8m
> > > family
> > >
> > > Am Montag, den 27.04.2020, 17:58 +0300 schrieb Abel Vesa:
> > > > From: Jacky Bai <ping.bai@nxp.com>
> > > >
> > > > The i.MX8M family is a set of NXP product focus on delivering the
> > > > latest and greatest video and audio experience combining
> > > > state-of-the-art media-specific features with high-performance
> > > > processing while optimized for lowest power consumption.
> > > >
> > > > i.MX8MQ, i.MX8MM, i.MX8MN, even the furture i.MX8MP are all belong =
to
> > > > this family. A GPC module is used to manage all the PU power domain
> > > > on/off. But the situation is that the number of power domains & the
> > > > power up sequence has significate difference on those SoCs. Even on
> > > > the same SoC. The power up sequence still has big difference. It ma=
kes
> > > > us hard to reuse the GPCv2 driver to cover the whole i.MX8M family.
> > > > Each time a new SoC is supported in the mainline kernel, we need to
> > > > modify the GPCv2 driver to support it. We need to add or modify
> > > > hundred lines of code in worst case.
> > > > It is a bad practice for the driver maintainability.
> > > >
> > > > This driver add a more generic power domain driver that the actual
> > > > power on/off is done by TF-A code. the abstraction give us the
> > > > possibility that using one driver to cover the whole i.MX8M family =
in
> > > > kernel side.
> > > >
> > >
> > > Again: what does this driver bring to the table, other than moving a =
fraction of
> > > the power domain functionality into the firmware?
> > >
> > > The discussions on the last submissions of this driver already establ=
ished that
> > > we can't move all functionality for the power domains into the firmwa=
re, as
> > > controlling regulators is probably not easy to do from this context. =
Also the
> > > TF-A side implementation of this driver is "interesting" IMHO, it doe=
s stuff like
> > > accessing the clock controller registers without any locking or other=
 means of
> > > mutual exclusion with the Linux kernel clock controller driver.
> > >
> >
> > The clock handling is in kernel side through CCF, not in ATF. See the p=
atch below.
> >
> > > Why can't we just extend the existing GPCv2 driver with support for t=
he other
> > > i.MX8M family members?
> > >
> >
> > The reason that why I don=E2=80=99t like to extend the GPCv2 is that wh=
en doing domain on/off,
> > We need to access some special control register in each domain & do som=
e special flow,
> > These control register(mediamix block control, vpumix block control) is=
 not in GPC
> > module's address range. No benefit to reuse the GPCv2. Only bring compl=
exity to the
> > GPCv2 driver each time a new SoC is added.
> >
> > Yes, the i.MX8M power domain support has been pending for a while. ARM =
guys rejected this patchset
> > because they suggest us to use SCMI rather than SiP. But SCMI is only p=
artial suitable for our
> > case.
>
> Can you please point me to the most resent version of the TF-A side
> implementation of this? The i.MX8MM implementation in the
> imx_5.4.3_2.0.0 branch in the codeaurora imx-atf repo still contains
> writes to the clock controller register range.
>
> Also I would love to learn why the GPC needs to access Mediamix and
> VPUmix domain registers. If you are talking about the NOC configuration
> I would strongly suggest that those should be handled by a Linux side
> interconnect driver, this has nothing to do with the power domain
> sequencing, it just happens to lose state over the power down and needs
> to be reprogrammed after power on. The NOC configuration though is use-
> case dependent, so this should be properly handled in a rich OS driver.
>
> Sure we needs to extend the Linux side GPC driver for each new SoC
> generation, but that's no different from any other hardware driver in
> Linux. Drivers are the abstraction around the hardware, there is no
> need to invent another one if there are no clear benefits.
>

Jacky / Abel,

Any movement on this? As I see it the lack of imx8mm power-domain
support in the kernel is holding up USB, PCIe, VPU, and perhaps
GPU/CSI as well. I would tend to agree that hiding this functionality
in the TF-A is probably not the best approach especially as that
requires a NXP version of the TF-A. I really don't see the issue with
the gpc driver getting a little more complicated if it needs to. There
is bound to be some complication as there is such a large variation of
IMX8 products out there! (talk about confusing!).

Best Regards,

Tim
