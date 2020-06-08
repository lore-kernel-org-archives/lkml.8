Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED518C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C360D2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y8KMgJvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbgFHQgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:36:39 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39716 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730432AbgFHQgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=88MeFKvCY6T0QrZdQ+i9CPgwNPj+1wwn8P8nThk+OnE=; b=Y8KMgJvgWNbSr18uYw2huKiS+P
        stY5qeIzYxS6W/lg9xGTQ99h9AEJ7WyjSKLK4oX9MVCkvC1Q0OFQUCMZPOzpW8ZvEbjz0Infp2R1B
        PbLNvn3peyY6lZMM5oEDZm3fS2VDbOgwM2SoxVFHilleCzrmykl3tw4xQ5Y0ROH6BFlQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jiKlB-004Pxy-4L; Mon, 08 Jun 2020 18:36:29 +0200
Date:   Mon, 8 Jun 2020 18:36:29 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org,
        f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH] net: phy: mscc: handle the clkout control on some phy
 variants
Message-ID: <20200608163629.GH1006885@lunn.ch>
References: <20200608160207.1316052-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608160207.1316052-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 06:02:07PM +0200, Heiko Stuebner wrote:
> +static int vsc8531_probe(struct phy_device *phydev)
> +{
> +	struct vsc8531_private *vsc8531;
> +	int rate_magic;
> +	u32 default_mode[2] = {VSC8531_LINK_1000_ACTIVITY,
> +	   VSC8531_LINK_100_ACTIVITY};
> +
> +	rate_magic = vsc85xx_edge_rate_magic_get(phydev);
> +	if (rate_magic < 0)
> +		return rate_magic;
> +
> +	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
> +	if (!vsc8531)
> +		return -ENOMEM;
> +
> +	phydev->priv = vsc8531;
> +
> +	vsc8531->rate_magic = rate_magic;
> +	vsc8531->nleds = 2;
> +	vsc8531->supp_led_modes = VSC85XX_SUPP_LED_MODES;
> +	vsc8531->hw_stats = vsc85xx_hw_stats;
> +	vsc8531->nstats = ARRAY_SIZE(vsc85xx_hw_stats);
> +	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
> +				      sizeof(u64), GFP_KERNEL);
> +	if (!vsc8531->stats)
> +		return -ENOMEM;
> +
> +	vsc8531_dt_clkout_rate_get(phydev);
> +
> +	return vsc85xx_dt_led_modes_get(phydev, default_mode);
> +}

Hi Heiko

The clock change itself looks O.K. Maybe we want to standardize on the
name of the DT property, since it could be shared across all PHYs
which have a clock output?

Could you add another patch first which refactors the _probe()
functions. There is a lot of repeated code which could be put into a
helper.

Thanks
	Andrew
