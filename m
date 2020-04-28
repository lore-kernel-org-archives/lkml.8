Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CB9C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858F6205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KUdP9lUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgD1Pre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:47:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57318 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgD1Pre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WuBNSxGz0GAmdJ8bMObcwhw4PUFEzUK2Rx0IAHo9GwA=; b=KUdP9lUEvZWpYNnf4gpCxQrjxL
        2xH8Gclat6ibocZijiMObC1+i2iI/Waq+sXPcO8SG5f4XFaSu9L7zA/Rh+/dm44IfbvVTDu5YcfZL
        E5Iw5aD9fT4CozKPlwz/6SbIBf6WWRtdlLZtGHzuN+8NSAtBlZ/L4DFGWV4RLBWOkxQg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jTSS6-0006ry-5F; Tue, 28 Apr 2020 17:47:18 +0200
Date:   Tue, 28 Apr 2020 17:47:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        David Jander <david@protonic.nl>,
        "David S. Miller" <davem@davemloft.net>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Russell King <linux@armlinux.org.uk>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: phy: micrel: add phy-mode support for
 the KSZ9031 PHY
Message-ID: <20200428154718.GA24923@lunn.ch>
References: <20200422072137.8517-1-o.rempel@pengutronix.de>
 <CAMuHMdU1ZmSm_tjtWxoFNako2fzmranGVz5qqD2YRNEFRjX0Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU1ZmSm_tjtWxoFNako2fzmranGVz5qqD2YRNEFRjX0Sw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 05:28:30PM +0200, Geert Uytterhoeven wrote:
> This triggers on Renesas Salvator-X(S):
> 
>     Micrel KSZ9031 Gigabit PHY e6800000.ethernet-ffffffff:00:
> *-skew-ps values should be used only with phy-mode = "rgmii"
> 
> which uses:
> 
>         phy-mode = "rgmii-txid";
> 
> and:
> 
>         rxc-skew-ps = <1500>;
> 
> If I understand Documentation/devicetree/bindings/net/ethernet-controller.yaml
> correctly:

Hi Geert

Checking for skews which might contradict the PHY-mode is new. I think
this is the first PHY driver to do it. So i'm not too surprised it has
triggered a warning, or there is contradictory documentation.

Your use cases is reasonable. Have the normal transmit delay, and a
bit shorted receive delay. So we should allow it. It just makes the
validation code more complex :-(

	   Andrew
