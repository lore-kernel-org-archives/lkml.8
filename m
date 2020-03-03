Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE394C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781DA2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ED8HguqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgCCOJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:09:18 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43560 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgCCOJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l7N/qCyUEC0aOSPXLe8sV209wk3xmRtSBQDdAdmN0kw=; b=ED8HguqO13RKccacLhW+C+poh0
        3ZxLItBVFyD0qLss4wB2a69xUk2jh+ywQTEcMV6vjLk+tOUCSjU1AmjKbNxl/5q0iexdh7bAtDCdf
        nU720OZQOAIrUfoTSJCVi/jgIRZvKHUUfZEa5kwHvBJFr7A+sOUUoOXL732WMCLq7LVY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j98ET-0006Up-04; Tue, 03 Mar 2020 15:09:13 +0100
Date:   Tue, 3 Mar 2020 15:09:12 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Christian Herber <christian.herber@nxp.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Marek Vasut <marex@denx.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v1] net: phy: tja11xx: add TJA1102 support
Message-ID: <20200303140912.GH31977@lunn.ch>
References: <AM0PR04MB70412893CFD2F553107148FC86E40@AM0PR04MB7041.eurprd04.prod.outlook.com>
 <2228b5de-89e3-d61a-4af9-8d1a8a5eb311@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2228b5de-89e3-d61a-4af9-8d1a8a5eb311@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Oleksij, Heiner, Marc,
> > 
> > You could also refer the solution implemented here as part of a TJA110x driver:
> > https://source.codeaurora.org/external/autoivnsw/tja110x_linux_phydev/about/
> 
> OK, thank you!
> 
> Suddenly, the solution in this driver is not mainlainable. It may match on
> ther PHYs with PHYID == 0.
> 
> See this part of the code:
> #define NXP_PHY_ID_TJA1102P1      (0x00000000U)
> ...
> 	, {
> 	.phy_id = NXP_PHY_ID_TJA1102P1,
> 	.name = "TJA1102_p1",
> 	.phy_id_mask = NXP_PHY_ID_MASK,

Noooo

You cannot assume NXP is the only silicon vendor to manufacture broken
silicon with a PHY ID of 0.

	Andrew
