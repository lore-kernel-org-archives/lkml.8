Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F93C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33CB206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rNfsLC2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbgFWQ1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732212AbgFWQ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:27:19 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE82EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:27:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i18so8564025ilk.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2HfYUl27ws6rzUdD3KtQEV+gfmF8af8Ah+cfE/GhpU0=;
        b=rNfsLC2jhNPskzrBCvMUiHmMQhtgQHZRNee+zxTRxsUSJ9sABsKMttIhODtAJEKc5Y
         ScZo4QlGKQZWPhsJ/n02X2L/URyh8JSsNhSmkT+OCYBiRLamvRZ7wCorHduH4pbUKmPC
         XgZGwZJ+VAIxJCX9rAlvnABk2Sv/XTe4g/vAiINxGvKjqaJ+msVJ4gQzyECvqGdXct7I
         GzYmJjf7Q0KbSU7qxIYlDOO+KRq/iZqe2yOmCpyN5uKCkmyTEUqY2Ler9C7PSVWe8JNP
         mEX2+5Ff4/qzcIN96B5xb5NyyEHc8oiHh8tuiDCAQQMVHvM04XX+j8WGQLMHSGs3O7HS
         2ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2HfYUl27ws6rzUdD3KtQEV+gfmF8af8Ah+cfE/GhpU0=;
        b=d5pz5P69ST3uBXK4DkELj8XKnp5L/WPXZM04eIsHybIpDfkY9kZbpIXUm1D+B9P6jd
         pymnky+KgO5tE1pIDqKE/eIzcSw3MC1+Jn9QzF/ZCSYpJ8u8jb0vTkptv8+e4J94an+1
         3tGjWiZRnb7HvZNgJetJh8IqsI7D8TRdJBwgQwHWNcY4b6NFYe+6L8umtt1a70JqJ0v1
         lSQ6bfzdhbssQ/h4HMnahBqZZkSLMw8eWv9e4WnmWmoqnRMsCDXZiNj5NOBy6lTRqMFI
         wFZOvZpcgENr2pmnd1dkhBKT3rf2BjBwY8cwnqd1z6TFh4jABxkKj7H/voDeR71jhmD9
         hTEw==
X-Gm-Message-State: AOAM533LY2S9+SDgFERN+6r2L1nxpkhVRZGau99HgpzNPOqL2aQLYmmA
        lgGK9nAwzlbj02nugxhaO3auKyyThuWhPikcIhPupA==
X-Google-Smtp-Source: ABdhPJxuRp1kY0Pjp+MMdWj5T/28lVrk2yLNcq6IbmjVHcQQMX5N/hsJ+Bg1RgVxEBhjOZebPX9QJrWrcsZrxc0i0U4=
X-Received: by 2002:a92:c509:: with SMTP id r9mr22887128ilg.189.1592929637036;
 Tue, 23 Jun 2020 09:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200622093744.13685-1-brgl@bgdev.pl> <20200622093744.13685-15-brgl@bgdev.pl>
 <20200622132921.GI1551@shell.armlinux.org.uk> <CAMRc=Me1r3Mzfg3-gTsGk4rEtvB=P9ESkn9q=c7z0Q=YQDsw2A@mail.gmail.com>
 <20200623094252.GS1551@shell.armlinux.org.uk> <CAMpxmJVP9db-4-AA4e1JkEfrajvJ4s0T6zo5+oFzpJHRBcuSsg@mail.gmail.com>
 <20200623095646.GT1551@shell.armlinux.org.uk>
In-Reply-To: <20200623095646.GT1551@shell.armlinux.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 23 Jun 2020 18:27:06 +0200
Message-ID: <CAMRc=MeKE12sXZycyGA7vmjNai0JfDhRX+XDTp3r3YtrmLQj3A@mail.gmail.com>
Subject: Re: [PATCH 14/15] net: phy: add PHY regulator support
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 cze 2020 o 11:56 Russell King - ARM Linux admin
<linux@armlinux.org.uk> napisa=C5=82(a):
>
> On Tue, Jun 23, 2020 at 11:46:15AM +0200, Bartosz Golaszewski wrote:
> > wt., 23 cze 2020 o 11:43 Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> napisa=C5=82(a):
> > >
> > > On Tue, Jun 23, 2020 at 11:41:11AM +0200, Bartosz Golaszewski wrote:
> > > > pon., 22 cze 2020 o 15:29 Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> napisa=C5=82(a):
> > > > >
> > > >
> > > > [snip!]
> > > >
> > > > >
> > > > > This is likely to cause issues for some PHY drivers.  Note that w=
e have
> > > > > some PHY drivers which register a temperature sensor in the probe
> > > > > function, which means they can be accessed independently of the l=
ifetime
> > > > > of the PHY bound to the network driver (which may only be while t=
he
> > > > > network device is "up".)  We certainly do not want hwmon failing =
just
> > > > > because the network device is down.
> > > > >
> > > > > That's kind of worked around for the reset stuff, because there a=
re two
> > > > > layers to that: the mdio device layer reset support which knows n=
othing
> > > > > of the PHY binding state to the network driver, and the phylib re=
set
> > > > > support, but it is not nice.
> > > > >
> > > >
> > > > Regulators are reference counted so if the hwmon driver enables it
> > > > using mdio_device_power_on() it will stay on even after the PHY dri=
ver
> > > > calls phy_device_power_off(), right? Am I missing something?
> > >
> > > If that is true, you will need to audit the PHY drivers to add that.
> > >
> >
> > This change doesn't have any effect on devices which don't have a
> > regulator assigned in DT though. The one I'm adding in the last patch
> > is the first to use this.
>
> It's quality of implementation.
>
> Should we wait for someone else to make use of the new regulator
> support that has been added with a PHY that uses hwmon, and they
> don't realise that it breaks hwmon on it, and several kernel versions
> go by without it being noticed.  It will only be a noticable issue
> when the associated network device is down, and that network device
> driver detaches from the PHY, so _is_ likely not to be noticed.
>
> Or should we do a small amount of work now to properly implement
> regulator support, which includes a trivial grep for "hwmon" amongst
> the PHY drivers, and add the necessary call to avoid the regulator
> being shut off.
>

I'm not sure what the correct approach is here. Provide some helper
that, when called, would increase the regulator's reference count even
more to keep it enabled from the moment hwmon is registered to when
the driver is detached?

Bart
