Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D91C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D5520720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgGKSpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 14:45:19 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58726 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgGKSpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:45:18 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1juKUq-004eGe-99; Sat, 11 Jul 2020 20:45:12 +0200
Date:   Sat, 11 Jul 2020 20:45:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        robh@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: DP83822: Add ability to
 advertise Fiber connection
Message-ID: <20200711184512.GR1014141@lunn.ch>
References: <20200710143733.30751-1-dmurphy@ti.com>
 <20200710143733.30751-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710143733.30751-3-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define MII_DP83822_FIBER_ADVERTISE	(SUPPORTED_AUI | SUPPORTED_FIBRE | \
> +					 SUPPORTED_BNC | SUPPORTED_Pause | \
> +					 SUPPORTED_Asym_Pause | \
> +					 SUPPORTED_100baseT_Full)
> +
> +		/* Setup fiber advertisement */
> +		err = phy_modify_changed(phydev, MII_ADVERTISE,
> +					 ADVERTISE_1000XFULL |
> +					 ADVERTISE_1000XPAUSE |
> +					 ADVERTISE_1000XPSE_ASYM,
> +					 MII_DP83822_FIBER_ADVERTISE);

That looks very odd. SUPPORTED_AUI #define has nothing to do with
MII_ADVERTISE register. It is not a bit you can read/write in that
register.

	Andrew
