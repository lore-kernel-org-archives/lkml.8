Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E27C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9694C20825
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fhdjhq9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgESOD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:03:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38936 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgESOD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TN/CXi3D/lMLDHmyY1ueBQoAKOPRiUPLI1/uNun8uT0=; b=Fhdjhq9m3Obnk9hioP6xSMePcy
        LY1tyVoFYi3HMZGdViE0MSjBC7VXxsh0I0gjMHR56K30eHa5AsIaXLGylm19WpjkT6bAEgepycKo+
        sosGEMbPKYvaajp2Vgv8pPdY1ue1x0Q7PlsaJJ3JjKiN0ovAML7qQDfTmt3eP5YiEI7w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jb2qS-002iHN-PC; Tue, 19 May 2020 16:03:48 +0200
Date:   Tue, 19 May 2020 16:03:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Kubecek <mkubecek@suse.cz>,
        David Jander <david@protonic.nl>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, mkl@pengutronix.de,
        Marek Vasut <marex@denx.de>,
        Christian Herber <christian.herber@nxp.com>
Subject: Re: [PATCH net-next v1 1/2] ethtool: provide UAPI for PHY Signal
 Quality Index (SQI)
Message-ID: <20200519140348.GI624248@lunn.ch>
References: <20200519075200.24631-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519075200.24631-1-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -310,6 +310,16 @@ int __ethtool_get_link(struct net_device *dev)
>  	return netif_running(dev) && dev->ethtool_ops->get_link(dev);
>  }
>  
> +int __ethtool_get_sqi(struct net_device *dev)
> +{
> +	struct phy_device *phydev = dev->phydev;
> +
> +	if (!phydev->drv->get_sqi)
> +		return -EOPNOTSUPP;
> +
> +	return phydev->drv->get_sqi(phydev);
> +}
> +

You are only providing access via netlink ethtool? There is no ioctl
method to get this. If so, i wonder if common.c is the correct place
for this, or if it should be moved into linkstate.c. You can then drop
the __.

Michal?

	Andrew
