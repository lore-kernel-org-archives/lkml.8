Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8623AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E66520776
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 14:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MeBd19A0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbgEXOpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 10:45:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46914 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgEXOpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 10:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=r5lP4P/zXAC9X9cI/T0QNDk1uosk4NujHsVjZWzO95Q=; b=MeBd19A0+gN1tME6e05fLVAtcy
        n8sBeTMNhzmHBZTvAeSgIeFP5blPB74PPAJrKmYQH60kddNcsyv9QHchSENHDkhrsdv7ff6mG7cSG
        EsOtIxLgkNnvkKGOMVg1JM8g2Mq3ptxMRCrGTNaYtphxf9kZu7aEjwKIMuqVC7uSSv0o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jcrrt-0037ra-Lq; Sun, 24 May 2020 16:44:49 +0200
Date:   Sun, 24 May 2020 16:44:49 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        madalin.bucur@oss.nxp.com, calvin.johnson@oss.nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 08/11] net: phy: Allow mdio buses to auto-probe c45 devices
Message-ID: <20200524144449.GP610998@lunn.ch>
References: <20200522213059.1535892-1-jeremy.linton@arm.com>
 <20200522213059.1535892-9-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522213059.1535892-9-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/include/linux/phy.h
> @@ -275,6 +275,11 @@ struct mii_bus {
>  	int reset_delay_us;
>  	/* RESET GPIO descriptor pointer */
>  	struct gpio_desc *reset_gpiod;
> +	/* bus capabilities, used for probing */
> +	enum {
> +		MDIOBUS_C22_ONLY = 0,
> +		MDIOBUS_C45_FIRST,
> +	} probe_capabilities;
>  };


I'm not so keen on _FIRST. It suggest _LAST would also be valid.  But
that then suggests this is not a bus property, but a PHY property, and
some PHYs might need _FIRST and other phys need _LAST, and then you
have a bus which has both sorts of PHY on it, and you have a problem.

So i think it would be better to have

	enum {
		MDIOBUS_UNKNOWN = 0,
		MDIOBUS_C22,
		MDIOBUS_C45,
		MDIOBUS_C45_C22,
	} bus_capabilities;

Describe just what the bus master can support.

	 Andrew
