Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9DAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80252204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pKgI8FPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgESN0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:26:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38810 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgESN0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8n7QbL4CNWDNJgApYky9vIvZRe1axoMpHBCOkpZcb6k=; b=pKgI8FPQgtmEv9vHZUozTszU8n
        xv+ZnZoCrDRhK6jrdW/9DhEShy/FkgyJDNCAH6IStPwT4BqCNHwTc8nYWkVwgGj7QeNExYwdk3iB8
        F9lQuyeEeXwyV0ZSU5pBZpHOhTiCNA2d0AVOwNePLqk+gwKmhuB6OZKWBRCICuVouinw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jb2GM-002i3F-Sb; Tue, 19 May 2020 15:26:30 +0200
Date:   Tue, 19 May 2020 15:26:30 +0200
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
Message-ID: <20200519132630.GH610998@lunn.ch>
References: <20200519075200.24631-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519075200.24631-1-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 09:51:59AM +0200, Oleksij Rempel wrote:
> Signal Quality Index is a mandatory value required by "OPEN Alliance
> SIG" for the 100Base-T1 PHYs [1]. This indicator can be used for cable
> integrity diagnostic and investigating other noise sources and
> implement by at least two vendors: NXP[2] and TI[3].

Hi Oleksij

With a multi part patch set, please always include a cover note,
describing what the patchset as a whole does.

> +int __ethtool_get_sqi(struct net_device *dev)
> +{
> +	struct phy_device *phydev = dev->phydev;
> +
> +	if (!phydev->drv->get_sqi)
> +		return -EOPNOTSUPP;
> +
> +	return phydev->drv->get_sqi(phydev);
> +}

You are not doing any locking here, which you should. Due to modules
vs built in, it can be a bit tricky getting this right. Take a look at
how ethtool ioctl.c uses phy_ethtool_get_stats() and that inline
function itself.

    Andrew
