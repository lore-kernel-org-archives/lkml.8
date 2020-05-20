Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B52C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6F8207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kkk5H18m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgETO3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:29:32 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41318 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgETO3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OHskyG7pfGBQXNfmwfOQ3/GNfVRie7Lid2IAYDcVZew=; b=kkk5H18mQynkYQ1KMSL/J0ri04
        Jcg8DM9cqSl5bND2HXZjqTIwA2quTMOuHKNiZo991hHOc7CLCFLwSETjMq78p9dHRW/fdpRmD55aV
        VFw+BqVt/13PMZcAdGsZSu+rJrZjDxWhhsDieq8CIq42oAbNQ8szhusgymvBYLZpU4CA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jbPil-002oQQ-0G; Wed, 20 May 2020 16:29:23 +0200
Date:   Wed, 20 May 2020 16:29:22 +0200
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
Subject: Re: [PATCH net-next v3 1/2] ethtool: provide UAPI for PHY Signal
 Quality Index (SQI)
Message-ID: <20200520142922.GE652285@lunn.ch>
References: <20200520062915.29493-1-o.rempel@pengutronix.de>
 <20200520062915.29493-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520062915.29493-2-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 08:29:14AM +0200, Oleksij Rempel wrote:
> Signal Quality Index is a mandatory value required by "OPEN Alliance
> SIG" for the 100Base-T1 PHYs [1]. This indicator can be used for cable
> integrity diagnostic and investigating other noise sources and
> implement by at least two vendors: NXP[2] and TI[3].
> 
> [1] http://www.opensig.org/download/document/218/Advanced_PHY_features_for_automotive_Ethernet_V1.0.pdf
> [2] https://www.nxp.com/docs/en/data-sheet/TJA1100.pdf
> [3] https://www.ti.com/product/DP83TC811R-Q1
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
