Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C573C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561952074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZGHYljfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgFIN2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:28:50 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41578 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgFIN2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UbfHPwkmXzUEv5TXx4dznj/38f1H17CuZRM3RaUTV8U=; b=ZGHYljfqzyYx0rKCK2hvXhZA7S
        eKPv/0fjooFG9D2TQWK6WxVjLqDDRWHXtb8Gzfi5StuX+aHQrdD21GV4KZBM7V+4GlzxHL+RR89IO
        kA9gPPnwVJtdZcJO/vLTs8f1xw/0mqRm+DN5SSlWcjzhqNSMMN71op3V8ma/VEVhhKpQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jieJ6-004W4U-Be; Tue, 09 Jun 2020 15:28:48 +0200
Date:   Tue, 9 Jun 2020 15:28:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] net: mvneta: Fix Serdes configuration for 2.5Gbps modes
Message-ID: <20200609132848.GA1076317@lunn.ch>
References: <20200609131152.22836-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609131152.22836-1-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 03:11:52PM +0200, Sascha Hauer wrote:
> The Marvell MVNETA Ethernet controller supports a 2.5Gbps SGMII mode
> called DRSGMII. Depending on the Port MAC Control Register0 PortType
> setting this seems to be either an overclocked SGMII mode or 2500BaseX.
> 
> This patch adds the necessary Serdes Configuration setting for the
> 2.5Gbps modes. There is no phy interface mode define for overclocked
> SGMII, so only 2500BaseX is handled for now.
> 
> As phy_interface_mode_is_8023z() returns true for both
> PHY_INTERFACE_MODE_1000BASEX and PHY_INTERFACE_MODE_2500BASEX we
> explicitly test for 1000BaseX instead of using
> phy_interface_mode_is_8023z() to differentiate the different
> possibilities.

Hi Sascha

This seems like it should have a Fixes: tag, and be submitted to the
net tree. Please see the Networking FAQ.

Otherwise it looks O.K.

    Andrew
