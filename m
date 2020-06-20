Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DA3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D71223C8D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 15:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFTPVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 11:21:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50130 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgFTPVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 11:21:44 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jmfJO-001PND-Rz; Sat, 20 Jun 2020 17:21:42 +0200
Date:   Sat, 20 Jun 2020 17:21:42 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        richardcochran@gmail.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        allan.nielsen@microchip.com, foss@0leil.net
Subject: Re: [PATCH net-next v3 6/8] net: phy: mscc: timestamping and PHC
 support
Message-ID: <20200620152142.GN304147@lunn.ch>
References: <20200619122300.2510533-1-antoine.tenart@bootlin.com>
 <20200619122300.2510533-7-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619122300.2510533-7-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Retrieve the shared load/save GPIO. Request it as non exclusive as
> +	 * the same GPIO can be requested by all the PHYs of the same package.
> +	 * Ths GPIO must be used with the phc_lock taken (the lock is shared
> +	 * between all PHYs).
> +	 */
> +	vsc8531->load_save = devm_gpiod_get_optional(&phydev->mdio.dev, "load-save",
> +						     GPIOD_FLAGS_BIT_NONEXCLUSIVE |
> +						     GPIOD_OUT_LOW);
> +	if (IS_ERR(vsc8531->load_save)) {
> +		phydev_err(phydev, "Can't get load-save GPIO (%ld)\n",
> +			   PTR_ERR(vsc8531->load_save));
> +		return PTR_ERR(vsc8531->load_save);
> +	}
> +

I can understand the GPIO being optional, it is only needed when PTP
is being used. But i don't see a test anywhere that when PTP is being
used the GPIO is provided. What actually happens if it is missing and
somebody tries to use the PTP? Maybe only register the PTP parts with
the core if the GPIO has been found in DT?

    Andrew
