Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADA72073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SgdRnKgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbgE0OLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:11:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52114 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387414AbgE0OLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=flzj/lngT18DPTCvNH2h32gcN6Il8dJnbGf7g1daBg8=; b=SgdRnKgI/MIjcHegg74DUMxNHV
        8C6j3H4oU/p1Dy371+McZfwjm9PEa5SfgYMkaMdQ2HTb3h47w/9TjV/gsjUf63ZX8lUps22xe9Za3
        OI6I6WmsXSk2J6I9/ZwDvCLrhNszXNo/YJ5LE/TfM3HFjTF9Q6o9UJ2U0h0RmLEk7H/c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jdwma-003PZI-He; Wed, 27 May 2020 16:11:48 +0200
Date:   Wed, 27 May 2020 16:11:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        allan.nielsen@microchip.com, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next 2/2] net: mscc: allow offloading timestamping
 operations to the PHY
Message-ID: <20200527141148.GD812580@lunn.ch>
References: <20200526150149.456719-1-antoine.tenart@bootlin.com>
 <20200526150149.456719-3-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526150149.456719-3-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 05:01:49PM +0200, Antoine Tenart wrote:
> This patch adds support for offloading timestamping operations not only
> to the Ocelot switch (as already supported) but to compatible PHYs.
> When both the PHY and the Ocelot switch support timestamping operations,
> the PHY implementation is chosen as the timestamp will happen closer to
> the medium.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
