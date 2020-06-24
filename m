Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D167CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981A320C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0jvmCkm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391121AbgFXNtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391102AbgFXNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:49:01 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19A8C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:49:01 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z2so2136896ilq.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HMgVoQ0NH17cOLvd+EMrZ4qMVzF5NeVckkBSBDB5GLs=;
        b=0jvmCkm1uxOa1uyi4BAYlDRMMqRDa38wgi9E8/XIDdGrA9oQ5L4spIW2A1eGA4BtF2
         S8zElmWx4UIeuMFNfhPYYnWZuScbEVueJuWuV4FXywiqce4LL2run2a4ymvcOzIu/C/+
         6Fe7gIuaYQNI6sGKgF4WgNb2BUsmVdRrHfRKrtAsfldLg5IvcbHl6PWauCZhmFQojQhm
         9a7Q5RrPl/lbr4+33xEC9+RPw7xZD15uxySVT5i1FJFwQookYTDkrFsYT0wH0jVU3Rlu
         L9Tp3z1r1c62MEmeG50kWokbFvxn6cOtU/lGUbjrNM0wFfDadl3nZISJG+6IalJfMcDf
         33mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HMgVoQ0NH17cOLvd+EMrZ4qMVzF5NeVckkBSBDB5GLs=;
        b=UhQOk5MbUGWm3JtRytqindywQIGmjd2xlqya67ROJQgRfumpGmFWe8GFCaC/0jkWcd
         kBSLhwF6Ss1dkt6zcPRNi4tYi9vt90RBob7Kgy44oiUrXsdbBt9E+7evS1MaKeGa53eZ
         UK7IxnH2gqKbtWEtRsC1orDKG6B3DVFVoKaaskpN+POEjo6qR1lnMShlQOz2CIX2642h
         u7C1djOUWxsOuzC037ZR3U0C0CtfKWQfuLtLcqqUUG7SMD5And8NgH+ZE1cQIPPc3Wa+
         2SuqLqd16bQCRuIODorsXsWuVE7s8RWxmPEvyKS5E7XmIA2HDiCsIG8Nc6tamwlmJUbV
         g6Qg==
X-Gm-Message-State: AOAM533+UCmECAAuQrkmJemMHThhF8qfhyvMbTfi1lZlWD0MTODPna18
        0F4bMEzZVOkBdN1uYSFVaBQ7uyCpFMv9BkjLnHy6SQ==
X-Google-Smtp-Source: ABdhPJxdX8ruFrJVm8CZiU93LA3RvFI3WisGoVFQmLOi9T6/smGz8KDwDETgwAqF6p43r34eXBRDqfcPxFBj5bX92S8=
X-Received: by 2002:a92:de10:: with SMTP id x16mr29799293ilm.6.1593006540971;
 Wed, 24 Jun 2020 06:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200622093744.13685-1-brgl@bgdev.pl> <20200622093744.13685-10-brgl@bgdev.pl>
 <20200622133940.GL338481@lunn.ch> <20200622135106.GK4560@sirena.org.uk>
 <dca54c57-a3bd-1147-63b2-4631194963f0@gmail.com> <20200624094302.GA5472@sirena.org.uk>
In-Reply-To: <20200624094302.GA5472@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 24 Jun 2020 15:48:50 +0200
Message-ID: <CAMRc=McBxJdujCyjQF3NA=bCWHF1dx8xJ1Nc2snmqukvJ_VyoQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] net: phy: delay PHY driver probe until PHY registration
To:     Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 24 cze 2020 o 11:43 Mark Brown <broonie@kernel.org> napisa=C5=82(=
a):
>
> On Tue, Jun 23, 2020 at 12:49:15PM -0700, Florian Fainelli wrote:
> > On 6/22/20 6:51 AM, Mark Brown wrote:
>
> > > If the bus includes power management for the devices on the bus the
> > > controller is generally responsible for that rather than the devices,
> > > the devices access this via facilities provided by the bus if needed.
> > > If the device is enumerated by firmware prior to being physically
> > > enumerable then the bus will generally instantiate the device model
> > > device and then arrange to wait for the physical device to appear and
> > > get joined up with the device model device, typically in such situati=
ons
> > > the physical device might appear and disappear dynamically at runtime
> > > based on what the driver is doing anyway.
>
> > In premise there is nothing that prevents the MDIO bus from taking care
> > of the regulators, resets, prior to probing the PHY driver, what is
> > complicated here is that we do need to issue a read of the actual PHY t=
o
> > know its 32-bit unique identifier and match it with an appropriate
> > driver. The way that we have worked around this with if you do not wish
> > such a hardware access to be made, is to provide an Ethernet PHY node
> > compatible string that encodes that 32-bit OUI directly. In premise the
> > same challenges exist with PCI devices/endpoints as well as USB, would
> > they have reset or regulator typically attached to them.
>
> That all sounds very normal and is covered by both cases I describe?
>
> > > We could use a pre-probe stage in the device model for hotpluggable
> > > buses in embedded contexts where you might need to bring things out o=
f
> > > reset or power them up before they'll appear on the bus for enumerati=
on
> > > but buses have mostly handled that at their level.
>
> > That sounds like a better solution, are there any subsystems currently
> > implementing that, or would this be a generic Linux device driver model
> > addition that needs to be done?
>
> Like I say I'm suggesting doing something at the device model level.

I didn't expect to open such a can of worms...

This has evolved into several new concepts being proposed vs my
use-case which is relatively simple. The former will probably take
several months of development, reviews and discussions and it will
block supporting the phy supply on pumpkin boards upstream. I would
prefer not to redo what other MAC drivers do (phy-supply property on
the MAC node, controlling it from the MAC driver itself) if we've
already established it's wrong.

Is there any compromise we could reach to add support for a basic,
common use-case of a single regulator supplying a PHY that needs
enabling before reading its ID short-term (just like we currently
support a single reset or reset-gpios property for PHYs) and
introducing a whole new concept to the device model for more advanced
(but currently mostly hypothetical) cases long-term?

Bart
