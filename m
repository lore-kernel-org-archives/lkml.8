Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00874C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41E620706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="itSqhEL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbgFWJae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbgFWJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:30:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:30:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q8so22820810iow.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oLaLVpG0MyDInMfdyKDIo+dI3RLGik3lpc5kwQdQ/vw=;
        b=itSqhEL9M1HNMjjg0HmGB6ODcp78KKoys2tcbmkfbxbnFf0gtzRbl1v0p9UyS87C8U
         yBHI8y2mDuy/mYr4ZiVTXs0cIFQwbnoQ+DZ9UbLCGrsDywa5eSErM0ZGFTcKNGqeHDAk
         I0xodIoqS41AnBblnoQzKSN47HDqK9EAE48fnMz7osH1NcTj39rXx6xxY1XJla4eeFm5
         9FR6iUvRSFkvNghRKuu/IUf2XlRd3VycKWML0IuQRexvK7ewZL+Qhna1Amw9TZZjSCfF
         4ISeQ29W2dUdLJDTabFJPAc9GXCAnZuqCrfBpDCrs8JLKV9piimbaQ8MqthMBFgCJdF3
         lHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oLaLVpG0MyDInMfdyKDIo+dI3RLGik3lpc5kwQdQ/vw=;
        b=fzoQArEqJTe9Z5WuBSx3jmRLlZCC9PtQjLslfTnrvdL1XmKRodZnKZpUnJKBWrrRPO
         bYA7uuMWbUJYYeAMrOQHlDefzX1x7/wMV3H0ufkLRqiO/M2h2WvdI5Ej9WeNpfoGO5+n
         30kgF2Tx6xYjhC+M7rwNpSzXAN2K64+eCspP1/QK9/uqqVSwRbDzDXoO4FoAH6cffvGb
         UZmE/77TfuLuCQkZeT04IHHgvwosmxWuqjaqS48MiyTyj4hlgSUWJM6uBPI+Me9LyOsG
         J9iE62psoxXiin6ef+5ai6iXxQJBd8lOJRK2V10hj4Vxtb69jFE8x0Tahz2Ym01sqYeq
         MTSQ==
X-Gm-Message-State: AOAM53013/FyPZhRynkpEr1AaPDHRdqEEaguohGPmCBfjps1IonmRu18
        +NoTkvZ2LplX7+cXI5RyacOXo5jyDrxCy3i/8ChPbg==
X-Google-Smtp-Source: ABdhPJzAIxv0yIi9GjnJO0SiHwTFon80qm+0CZass27KwI8p5hZbCaGVWbdjSE1htxm4yeVgmXJhlPla03/26+P1YPU=
X-Received: by 2002:a05:6638:979:: with SMTP id o25mr21315946jaj.24.1592904630490;
 Tue, 23 Jun 2020 02:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200622093744.13685-1-brgl@bgdev.pl> <20200622093744.13685-14-brgl@bgdev.pl>
 <20200622132504.GH1551@shell.armlinux.org.uk>
In-Reply-To: <20200622132504.GH1551@shell.armlinux.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 23 Jun 2020 11:30:19 +0200
Message-ID: <CAMRc=MeXst5fOD+PJHHzXbDvf-i_jcJp_srzjH1P=Y03OPGxag@mail.gmail.com>
Subject: Re: [PATCH 13/15] net: phy: mdio: add support for PHY supply regulator
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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

pon., 22 cze 2020 o 15:25 Russell King - ARM Linux admin
<linux@armlinux.org.uk> napisa=C5=82(a):
>
> On Mon, Jun 22, 2020 at 11:37:42AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Currently many MAC drivers control the regulator supplying the PHY but
> > this is conceptually wrong. The regulator should be defined as a proper=
ty
> > of the PHY node on the MDIO bus and controlled by the MDIO sub-system.
> >
> > Add support for an optional PHY regulator which will be enabled before
> > optional deasserting of the reset signal.
>
> I wonder if this is the right place for this - MDIO devices do not have
> to be PHYs - they can be switches, and using "phy-supply" for a switch
> doesn't seem logical.
>
> However, I can see the utility of having having a supply provided for
> all mdio devices, so it seems to me to be a naming issue.  Andrew?
>

I followed the example of the phy reset retrieved in
mdiobus_register_reset(). I'm happy to change it to some other name.

Bart
