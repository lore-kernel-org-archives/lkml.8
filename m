Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C6AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D682073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C3MXryOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgE0OLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:11:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52100 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgE0OLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OxoZRRNFyEC3aeUrvp7I7AVP/BuK0CH9HF7YxNLFjfs=; b=C3MXryOhx1h1lN38xLxSDauguG
        2JQf4I5B8KWc1P/PSDlksb256/xVaykxHFLvACcbFOOfoV029nQ4kuFt/AUHsLeoJA7AJqwvFY9FA
        Qx+BomREiqbUNzSfJk0MSTWtYhooq2xLP3q/pHKB9MsCTQkRwy3TicHvn8VbyJ6e96Wc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jdwmG-003PYn-MO; Wed, 27 May 2020 16:11:28 +0200
Date:   Wed, 27 May 2020 16:11:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        allan.nielsen@microchip.com, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next 1/2] net: mscc: use the PHY MII ioctl interface
 when possible
Message-ID: <20200527141128.GC812580@lunn.ch>
References: <20200526150149.456719-1-antoine.tenart@bootlin.com>
 <20200526150149.456719-2-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526150149.456719-2-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 05:01:48PM +0200, Antoine Tenart wrote:
> Allow ioctl to be implemented by the PHY, when a PHY is attached to the
> Ocelot switch. In case the ioctl is a request to set or get the hardware
> timestamp, use the Ocelot switch implementation for now.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
