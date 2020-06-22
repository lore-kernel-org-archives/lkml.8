Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD78AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4ACD20702
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgFVNb0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:31:26 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48261 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgFVNb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:31:26 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3F9231BF205;
        Mon, 22 Jun 2020 13:31:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200620152142.GN304147@lunn.ch>
References: <20200619122300.2510533-1-antoine.tenart@bootlin.com> <20200619122300.2510533-7-antoine.tenart@bootlin.com> <20200620152142.GN304147@lunn.ch>
Subject: Re: [PATCH net-next v3 6/8] net: phy: mscc: timestamping and PHC support
To:     Andrew Lunn <andrew@lunn.ch>
From:   Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        richardcochran@gmail.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        allan.nielsen@microchip.com, foss@0leil.net
Message-ID: <159283268232.1456598.9115634655953641273@kwain>
Date:   Mon, 22 Jun 2020 15:31:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Quoting Andrew Lunn (2020-06-20 17:21:42)
> > +     /* Retrieve the shared load/save GPIO. Request it as non exclusive as
> > +      * the same GPIO can be requested by all the PHYs of the same package.
> > +      * Ths GPIO must be used with the phc_lock taken (the lock is shared
> > +      * between all PHYs).
> > +      */
> > +     vsc8531->load_save = devm_gpiod_get_optional(&phydev->mdio.dev, "load-save",
> > +                                                  GPIOD_FLAGS_BIT_NONEXCLUSIVE |
> > +                                                  GPIOD_OUT_LOW);
> > +     if (IS_ERR(vsc8531->load_save)) {
> > +             phydev_err(phydev, "Can't get load-save GPIO (%ld)\n",
> > +                        PTR_ERR(vsc8531->load_save));
> > +             return PTR_ERR(vsc8531->load_save);
> > +     }
> > +
> 
> I can understand the GPIO being optional, it is only needed when PTP
> is being used. But i don't see a test anywhere that when PTP is being
> used the GPIO is provided. What actually happens if it is missing and
> somebody tries to use the PTP?

Not much would happen, the time set/get wouldn't be correct.

> Maybe only register the PTP parts with the core if the GPIO has been
> found in DT?

It's not easy, as some versions of the PHY (or the way it's integrated,
I'm not sure) do not need the GPIO. I'll double check, and if it is
required for PHC operations in this series, I'll do that.

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
