Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D563EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE89D2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mVevxdRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCFNiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:38:55 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49472 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFNiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SMdbthzv3TX7S1U2DSWTkquAEKDYnwquXKKkz97UBdo=; b=mVevxdRoYevK+SpcVyNNWfMuUt
        c/62GzTNWFUryEFoFm1VRfCjAZeAz86XA44dOrcJ5d4Gsdvo6NZSGvmMQVMa3NxHCg415gFTS5QdN
        5+bK1tJ2mwZm+W300PDhoQm4TI95F+rx+yKfcYBq8SH5mV7c5IpflwvPMSc6eI8Ic9So=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jADBg-00051y-7e; Fri, 06 Mar 2020 14:38:48 +0100
Date:   Fri, 6 Mar 2020 14:38:48 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Message-ID: <20200306133848.GB18310@lunn.ch>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
 <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
 <20200305165145.GA25183@lunn.ch>
 <7191ffe6-642a-477c-ec37-e37dc9be4bf8@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7191ffe6-642a-477c-ec37-e37dc9be4bf8@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > It probably does not even need that. Just
> > 
> > phy-mode = <rgmii-txid>
> 
> Looks to me like this isn't supported by the Micrel PHY driver or am
> I missing something?

Ah, you are correct. It just has:

        if (of_node) {
                ksz9021_load_values_from_of(phydev, of_node,
                                    MII_KSZPHY_CLK_CONTROL_PAD_SKEW,
                                    "txen-skew-ps", "txc-skew-ps",
                                    "rxdv-skew-ps", "rxc-skew-ps");
                ksz9021_load_values_from_of(phydev, of_node,
                                    MII_KSZPHY_RX_DATA_PAD_SKEW,
                                    "rxd0-skew-ps", "rxd1-skew-ps",
                                    "rxd2-skew-ps", "rxd3-skew-ps");
                ksz9021_load_values_from_of(phydev, of_node,
                                    MII_KSZPHY_TX_DATA_PAD_SKEW,
                                    "txd0-skew-ps", "txd1-skew-ps",
                                    "txd2-skew-ps", "txd3-skew-ps");
        }

and no support for phydev->interface.

At minimum, you should use these DT properties, not a platform fixup.

If you want to, you can add support for rgmii-id, etc. There are five
modes you need to support:

        PHY_INTERFACE_MODE_NA,
        PHY_INTERFACE_MODE_RGMII,
        PHY_INTERFACE_MODE_RGMII_ID,
        PHY_INTERFACE_MODE_RGMII_RXID,
        PHY_INTERFACE_MODE_RGMII_TXID,

NA means "don't touch". Leave the RGMII delays alone, as configured by
hardware default, strapping, bootloader, etc.

	 Andrew
