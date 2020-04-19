Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0556C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E86621D94
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tnMBKHko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgDSP46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:56:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48460 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgDSP46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nBLU5uDhRJ126WPInMV2v3q9bGLsLlC7SxGeR9SC2II=; b=tnMBKHkoMrDGfz+eZIH3S58UrQ
        dopyoEc6LvRi9XhD0qRI+cGkWhnkjapJJghMy+4p9U9/DmwBn183jtv507+flScAoknItQ1B9j0io
        ImC/OxKOxkonbSPCBiLYPcKGJ6xHxAw4HAuO279sci/IaDHNVneuRWRsjVdsEVuf+CWs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jQCJT-003eeE-1M; Sun, 19 Apr 2020 17:56:55 +0200
Date:   Sun, 19 Apr 2020 17:56:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 3/3] net: phy: bcm54140: add hwmon support
Message-ID: <20200419155655.GK836632@lunn.ch>
References: <20200419101249.28991-1-michael@walle.cc>
 <20200419101249.28991-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419101249.28991-3-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 12:12:49PM +0200, Michael Walle wrote:

Hi Michael

You have an #if here...

> +#if IS_ENABLED(CONFIG_HWMON)
> +static umode_t bcm54140_hwmon_is_visible(const void *data,
> +					 enum hwmon_sensor_types type,
> +					 u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_min:
> +		case hwmon_in_max:
> +			return 0644;
> +		case hwmon_in_label:
> +		case hwmon_in_input:
> +		case hwmon_in_alarm:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_min:
> +		case hwmon_temp_max:
> +			return 0644;
> +		case hwmon_temp_input:
> +		case hwmon_temp_alarm:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	default:
> +		return 0;
> +	}
> +}

...


> +static const struct hwmon_chip_info bcm54140_chip_info = {
> +	.ops = &bcm54140_hwmon_ops,
> +	.info = bcm54140_hwmon_info,
>  };
>  
>  static int bcm54140_phy_base_read_rdb(struct phy_device *phydev, u16 rdb)
> @@ -203,6 +522,72 @@ static int bcm54140_get_base_addr_and_port(struct phy_device *phydev)
>  	return 0;
>  }


Still inside the #if. Some original code is now inside the #if/#endif.
Is this correct? Hard to see from just the patch.

>  
> +/* Check if one PHY has already done the init of the parts common to all PHYs
> + * in the Quad PHY package.
> + */
> +static bool bcm54140_is_pkg_init(struct phy_device *phydev)
> +{
> +	struct bcm54140_phy_priv *priv = phydev->priv;
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int base_addr = priv->base_addr;
> +	struct phy_device *phy;
> +	int i;
> +

...

> +static int bcm54140_phy_probe_once(struct phy_device *phydev)
> +{
> +	struct device *hwmon;
> +	int ret;
> +
> +	/* enable hardware monitoring */
> +	ret = bcm54140_enable_monitoring(phydev);
> +	if (ret)
> +		return ret;
> +
> +	hwmon = devm_hwmon_device_register_with_info(&phydev->mdio.dev,
> +						     "BCM54140", phydev,
> +						     &bcm54140_chip_info,
> +						     NULL);
> +	return PTR_ERR_OR_ZERO(hwmon);
> +}
> +#endif


Thanks
  Andrew
