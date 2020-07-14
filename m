Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7931DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF14224B0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgGNNMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:12:48 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34704 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgGNNMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:12:47 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jvKjg-00535Z-TE; Tue, 14 Jul 2020 15:12:40 +0200
Date:   Tue, 14 Jul 2020 15:12:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH net-next v1 5/5] net: phy: micrel: ksz886x/ksz8081: add
 cabletest support
Message-ID: <20200714131240.GE1140268@lunn.ch>
References: <20200710120851.28984-1-o.rempel@pengutronix.de>
 <20200710120851.28984-6-o.rempel@pengutronix.de>
 <20200711182912.GP1014141@lunn.ch>
 <20200713041129.gyoldkmsti4vl4m2@pengutronix.de>
 <20200713151719.GE1078057@lunn.ch>
 <20200714072501.GA5072@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714072501.GA5072@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OK. So, i'll cover both errata with separate flags? Set flags in the DSA
> driver and apply workarounds in the PHY. ACK?

Yes. Assume the issues are limited to just the first PHY in this
switch. If there are discrete PHYs with the same issue, we can come up
with a different way to identify them.

     Andrew
