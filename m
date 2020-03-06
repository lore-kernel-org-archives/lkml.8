Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58104C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3047920848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t+SFO1tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCFKw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:52:29 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55748 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCFKw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+eCbWq0p4lGocrZoNaHZbhQT4nz1r0kZeOfZlpXjdII=; b=t+SFO1txth65KjN4lnsPYlCCP
        DOVHUE+cdW6DWivbrqzzt57KhsZTQcBhGw1Le/i4UXZ6Nfxs069TdlVDwaOMBbZHfhWAtpZDnwV7S
        Ib2rPnNmMVpPQM0aJXN1/DNSZ5rinns2h1jqnPBsFEF+azwjsx94wDcA8sZphIXHXuOqVO3mzEc03
        rljV9Q8MH9rZTrzYUIjiJy5Xc+7S02yFCXNZFcSK60cjHBHVlR1bPnZk0t3A7qkF5c/L2T8J7gOeC
        hQNo+PjoJN/rVs4oY64EHtfUakKaE5QDd1XwTwDDVH19iej1CaNaX6Huh3QtavhuFxMKiCNId9no2
        IV5vsDnVw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:49386)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jAAaU-0004AJ-RS; Fri, 06 Mar 2020 10:52:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jAAaO-0000OM-IQ; Fri, 06 Mar 2020 10:52:08 +0000
Date:   Fri, 6 Mar 2020 10:52:08 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Message-ID: <20200306105208.GG25745@shell.armlinux.org.uk>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
 <20200305135346.GD25745@shell.armlinux.org.uk>
 <98f5901a121b83d4f7d75f9a9056bd3719e2ee89.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f5901a121b83d4f7d75f9a9056bd3719e2ee89.camel@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:57:15AM +0000, Philippe Schenker wrote:
> On Thu, 2020-03-05 at 13:53 +0000, Russell King - ARM Linux admin wrote:
> > On Thu, Mar 05, 2020 at 02:49:28PM +0100, Philippe Schenker wrote:
> > > The MAC of the i.MX6 SoC is compliant with RGMII v1.3. The KSZ9131
> > > PHY
> > > is like KSZ9031 adhering to RGMII v2.0 specification. This means the
> > > MAC should provide a delay to the TXC line. Because the i.MX6 MAC
> > > does
> > > not provide this delay this has to be done in the PHY.
> > > 
> > > This patch adds by default ~1.6ns delay to the TXC line. This should
> > > be good for all boards that have the RGMII signals routed with the
> > > same length.
> > > 
> > > The KSZ9131 has relatively high tolerances on skew registers from
> > > MMD 2.4 to MMD 2.8. Therefore the new DLL-based delay of 2ns is used
> > > and then as little as possibly subtracted from that so we get more
> > > accurate delay. This is actually needed because the i.MX6 SoC has
> > > an asynchron skew on TXC from -100ps to 900ps, to get all RGMII
> > > values within spec.
> > > 
> > > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > > 
> > > ---
> > > 
> > >  arch/arm/mach-imx/mach-imx6q.c | 37
> > > ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-
> > > imx/mach-imx6q.c
> > > index edd26e0ffeec..8ae5f2fa33e2 100644
> > > --- a/arch/arm/mach-imx/mach-imx6q.c
> > > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > > @@ -61,6 +61,14 @@ static void mmd_write_reg(struct phy_device *dev,
> > > int device, int reg, int val)
> > >  	phy_write(dev, 0x0e, val);
> > >  }
> > >  
> > > +static int mmd_read_reg(struct phy_device *dev, int device, int
> > > reg)
> > > +{
> > > +	phy_write(dev, 0x0d, device);
> > > +	phy_write(dev, 0x0e, reg);
> > > +	phy_write(dev, 0x0d, (1 << 14) | device);
> > > +	return phy_read(dev, 0x0e);
> > > +}
> > 
> > These look like the standard MII MMD registers, and it also looks like
> > you're reinventing phy_read_mmd() - but badly due to lack of locking.
> > 
> > I guess you need this because phy_read_mmd() may be modular - maybe
> > we should arrange for the accessors to be separately buildable into
> > the kernel, so that such fixups can stop badly reinventing the wheel?
> 
> Yes, I did that because of two reasons:
> 1. I tried phy_read_mmd() and phy_write_mmd() but this panic'd

That is because phydev->drv->read_mmd and phydev->drv is NULL at this
point.  There has been a patch around to solve that though.

> 2. There is already mmd_write_reg in that code so I thought it would be
> no big deal to also have a read in there.
> 
> But yeah, you're right that mmd_write_reg is from 2013...
> 
> How do you suggest to implement that?
> 
> Philippe

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
