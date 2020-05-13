Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A5EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399672054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ir0crLbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbgEMQX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:23:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58346 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732380AbgEMQX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=C8VfVf/OuqyzLQjxfFBPY+9cZd8t31ZnOKlYly4ZIjA=; b=Ir0crLbYpBHkGMoZMC+PBfixUk
        eRtmYGBg48HCnVrUKMH9J1PJLSr4K7Vz1rsZ9K/QAJCGplxhuFE/89UAswzOUYb5zGM0oNW1xVfaS
        P0m8fkPIcSG8kfrnUfBdMjC6aVaGUINFApfcKeTHdQ3RAgTlWVbB7q20JXhn3EDIv0qU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jYuAl-002BN0-In; Wed, 13 May 2020 18:23:55 +0200
Date:   Wed, 13 May 2020 18:23:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        kernel@pengutronix.de, "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1] net: phy: at803x: add cable test support
Message-ID: <20200513162355.GJ499265@lunn.ch>
References: <20200513120648.14415-1-o.rempel@pengutronix.de>
 <0c80397b-58b8-0807-0b98-695db8068e25@gmail.com>
 <20200513154544.gwcccvbicpvrj6vm@pengutronix.de>
 <20200513154953.GI499265@lunn.ch>
 <20200513160026.fdls7kpxb6luuwed@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513160026.fdls7kpxb6luuwed@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:00:26PM +0200, Oleksij Rempel wrote:
> On Wed, May 13, 2020 at 05:49:53PM +0200, Andrew Lunn wrote:
> > > Uff.. i missed this. Then I'll need only to add some changes on top of
> > > his patch.
> > 
> > I've been chatting with mwalle on IRC today. There should be a repost
> > of the patches soon.
> 
> Cool!
> @Michael, please CC me.
> 
> you can include support for AR9331 and AR8032 in your patch (if you
> like)
> http://www.jhongtech.com/DOWN/ATHEROS--AR8032.pdf
> 
> They have same register, but only 2 pairs.

Hi Oleksij 

Michael just reposted. Please send a follow up patch adding these two
PHYs.

       Andrew
