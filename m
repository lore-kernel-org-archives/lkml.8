Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03C7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A4E208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCEOiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:38:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40923 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCEOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:38:18 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1j9rdY-0001EN-Iq; Thu, 05 Mar 2020 15:38:08 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1j9rdV-000208-Sz; Thu, 05 Mar 2020 15:38:05 +0100
Date:   Thu, 5 Mar 2020 15:38:05 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Message-ID: <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200305134928.19775-1-philippe.schenker@toradex.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:27:00 up 111 days,  5:45, 138 users,  load average: 0.18, 0.14,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On Thu, Mar 05, 2020 at 02:49:28PM +0100, Philippe Schenker wrote:
> The MAC of the i.MX6 SoC is compliant with RGMII v1.3. The KSZ9131 PHY
> is like KSZ9031 adhering to RGMII v2.0 specification. This means the
> MAC should provide a delay to the TXC line. Because the i.MX6 MAC does
> not provide this delay this has to be done in the PHY.
> 
> This patch adds by default ~1.6ns delay to the TXC line. This should
> be good for all boards that have the RGMII signals routed with the
> same length.
> 
> The KSZ9131 has relatively high tolerances on skew registers from
> MMD 2.4 to MMD 2.8. Therefore the new DLL-based delay of 2ns is used
> and then as little as possibly subtracted from that so we get more
> accurate delay. This is actually needed because the i.MX6 SoC has
> an asynchron skew on TXC from -100ps to 900ps, to get all RGMII
> values within spec.

This configuration has nothing to do in mach-imx/* It belongs to the
board devicetree. Please see DT binding documentation for needed
properties:
Documentation/devicetree/bindings/net/micrel-ksz90x1.txt

All of this mach-imx fixups are evil and should be removed or disabled by Kconfig
option. Since they will run on all i.MX based boards even if this PHY are
connected to some switch and not connected to the FEC directly.
And.. If driver didn't made this configuration all this changes will be lost on
suspend/resume cycle or on PHY reset.

Regards,
Oleksij

> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> 
> ---
> 
>  arch/arm/mach-imx/mach-imx6q.c | 37 ++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index edd26e0ffeec..8ae5f2fa33e2 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -61,6 +61,14 @@ static void mmd_write_reg(struct phy_device *dev, int device, int reg, int val)
>  	phy_write(dev, 0x0e, val);
>  }
>  
> +static int mmd_read_reg(struct phy_device *dev, int device, int reg)
> +{
> +	phy_write(dev, 0x0d, device);
> +	phy_write(dev, 0x0e, reg);
> +	phy_write(dev, 0x0d, (1 << 14) | device);
> +	return phy_read(dev, 0x0e);
> +}
> +
>  static int ksz9031rn_phy_fixup(struct phy_device *dev)
>  {
>  	/*
> @@ -74,6 +82,33 @@ static int ksz9031rn_phy_fixup(struct phy_device *dev)
>  	return 0;
>  }
>  
> +#define KSZ9131_RXTXDLL_BYPASS	12
> +
> +static int ksz9131rn_phy_fixup(struct phy_device *dev)
> +{
> +	int tmp;
> +
> +	tmp = mmd_read_reg(dev, 2, 0x4c);
> +	/* disable rxdll bypass (enable 2ns skew delay on RXC) */
> +	tmp &= ~(1 << KSZ9131_RXTXDLL_BYPASS);
> +	mmd_write_reg(dev, 2, 0x4c, tmp);
> +
> +	tmp = mmd_read_reg(dev, 2, 0x4d);
> +	/* disable txdll bypass (enable 2ns skew delay on TXC) */
> +	tmp &= ~(1 << KSZ9131_RXTXDLL_BYPASS);
> +	mmd_write_reg(dev, 2, 0x4d, tmp);
> +
> +	/*
> +	 * Subtract ~0.6ns from txdll = ~1.4ns delay.
> +	 * leave RXC path untouched
> +	 */
> +	mmd_write_reg(dev, 2, 4, 0x007d);
> +	mmd_write_reg(dev, 2, 6, 0xdddd);
> +	mmd_write_reg(dev, 2, 8, 0x0007);
> +
> +	return 0;
> +}
> +
>  /*
>   * fixup for PLX PEX8909 bridge to configure GPIO1-7 as output High
>   * as they are used for slots1-7 PERST#
> @@ -167,6 +202,8 @@ static void __init imx6q_enet_phy_init(void)
>  				ksz9021rn_phy_fixup);
>  		phy_register_fixup_for_uid(PHY_ID_KSZ9031, MICREL_PHY_ID_MASK,
>  				ksz9031rn_phy_fixup);
> +		phy_register_fixup_for_uid(PHY_ID_KSZ9131, MICREL_PHY_ID_MASK,
> +				ksz9131rn_phy_fixup);
>  		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffef,
>  				ar8031_phy_fixup);
>  		phy_register_fixup_for_uid(PHY_ID_AR8035, 0xffffffef,
> -- 
> 2.25.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
