Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B05C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CB720848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SZ8uvajC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCENyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:54:09 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40878 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgCENyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/znnv7ajhQ5TmvcAKLfdrl+ierT+u9g1+qLprIJAs1U=; b=SZ8uvajCpIK3VzpBXQRGwDD4w
        abJQR1HorYMMElSvKzqJ6WMG0iTiNmyfo9hHrTdhuoFR55g7Dvk/JxUV+3v580AtWUhfMF+u8bAKI
        js8f5AjrTFYYkBnGaT1/KUlDTvCcYqmZYSOVjjN8TMkhPFtP5aSqOo47OwqkggAyaC5X+UdMiIqFS
        g22Hq38sKP27NW7+p/HreshsRvSyCdchAaqyHkHnaceGv72s8rQGPV8nCgg8YBPCIPntGg963Iyhf
        qwQPpMB+zRjDG/y4dYlvS8c6OBGnsD2SPzRLN3PMka+1g9AN2CBdDnEOI6aRahn1Ns1fMInV8eFAp
        /S7g8J8RQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:56526)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j9qwh-0006mH-7U; Thu, 05 Mar 2020 13:53:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j9qwc-0007y5-JN; Thu, 05 Mar 2020 13:53:46 +0000
Date:   Thu, 5 Mar 2020 13:53:46 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Message-ID: <20200305135346.GD25745@shell.armlinux.org.uk>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305134928.19775-1-philippe.schenker@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
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

These look like the standard MII MMD registers, and it also looks like
you're reinventing phy_read_mmd() - but badly due to lack of locking.

I guess you need this because phy_read_mmd() may be modular - maybe
we should arrange for the accessors to be separately buildable into
the kernel, so that such fixups can stop badly reinventing the wheel?

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

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
