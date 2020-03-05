Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC76C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6206820637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NKgKXtBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCEQv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:51:59 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:47802 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgCEQv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zeR+H7dn9cUFtnRC0x5I2lV7x72XaKNcFrXhJbZx+zE=; b=NKgKXtBftkTbcpjFm+o7nq6lzK
        +okGpzirVXjC1s0/urazl6+TZ6IW7vmFVZDvOhbZ7KQf1F1mh33r4dmd8ud4TF4YgAu5MxuKhyD7P
        WCI8vBd7TKsJTceWVDQUK15C/PiWDXfJRYsPewdXKWNR+8pKwKtEzMRtCQN1unxh2urI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j9tir-0006jV-1a; Thu, 05 Mar 2020 17:51:45 +0100
Date:   Thu, 5 Mar 2020 17:51:45 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Message-ID: <20200305165145.GA25183@lunn.ch>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
 <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 03:38:05PM +0100, Oleksij Rempel wrote:
> Hi Philippe,
> 
> On Thu, Mar 05, 2020 at 02:49:28PM +0100, Philippe Schenker wrote:
> > The MAC of the i.MX6 SoC is compliant with RGMII v1.3. The KSZ9131 PHY
> > is like KSZ9031 adhering to RGMII v2.0 specification. This means the
> > MAC should provide a delay to the TXC line. Because the i.MX6 MAC does
> > not provide this delay this has to be done in the PHY.
> > 
> > This patch adds by default ~1.6ns delay to the TXC line. This should
> > be good for all boards that have the RGMII signals routed with the
> > same length.
> > 
> > The KSZ9131 has relatively high tolerances on skew registers from
> > MMD 2.4 to MMD 2.8. Therefore the new DLL-based delay of 2ns is used
> > and then as little as possibly subtracted from that so we get more
> > accurate delay. This is actually needed because the i.MX6 SoC has
> > an asynchron skew on TXC from -100ps to 900ps, to get all RGMII
> > values within spec.
> 
> This configuration has nothing to do in mach-imx/* It belongs to the
> board devicetree. Please see DT binding documentation for needed
> properties:
> Documentation/devicetree/bindings/net/micrel-ksz90x1.txt

It probably does not even need that. Just

phy-mode = <rgmii-txid>

Also, please Cc: netdev for network code.

      Andrew
