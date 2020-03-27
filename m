Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96CC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8964920748
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CosXR2MJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgC0P3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:29:04 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35816 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgC0P3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bh2PgbYLfBfl9wWC6MpbC6nc2/y6kXZr0xP8G3jYT2Q=; b=CosXR2MJzHJpTA3wj2pJJohdn
        /w1wU3lKnYz6VmQ8QZRiKi6lc+zPrgSQHGnOC4PGBwcr5c1mDGylsGY0pwzE80wPfzSMABZ+6UBMj
        gVGaFbSdIF+QwyK7L9teiBZ8fTrsX/7N359Fy1F6KRJaRZETS73myABadC4R43mmMmtHvdoQNq9sm
        933wmMVbxgpvyz70/XwHIBj8hhmc0hOWw0/cS8evPOssDG6CoC4wV/Vb7sInLArZ1VJ5sXejxW9kf
        uQpzRmhdPmDqk2MCWH8lVT5BjmYobOeBvLfiuD22Nqv49UZgiHfum1qIyyXgcKvGSwxVEfsDLU0MW
        qg1lUZ4Zg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42102)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jHqui-0001qV-EU; Fri, 27 Mar 2020 15:28:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jHquf-0004Ki-LV; Fri, 27 Mar 2020 15:28:49 +0000
Date:   Fri, 27 Mar 2020 15:28:49 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Florinel Iordache <florinel.iordache@nxp.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "Madalin Bucur (OSS)" <madalin.bucur@oss.nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH net-next 2/9] dt-bindings: net: add backplane
 dt bindings
Message-ID: <20200327152849.GP25745@shell.armlinux.org.uk>
References: <1585230682-24417-1-git-send-email-florinel.iordache@nxp.com>
 <1585230682-24417-3-git-send-email-florinel.iordache@nxp.com>
 <20200327010411.GM3819@lunn.ch>
 <AM0PR04MB5443185A1236F621B9EC9873FBCC0@AM0PR04MB5443.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB5443185A1236F621B9EC9873FBCC0@AM0PR04MB5443.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:00:22PM +0000, Florinel Iordache wrote:
> > On Thu, Mar 26, 2020 at 03:51:15PM +0200, Florinel Iordache wrote:
> > > Add ethernet backplane device tree bindings
> > 
> > > +  - |
> > > +    /* Backplane configurations for specific setup */
> > > +    &mdio9 {
> > > +        bpphy6: ethernet-phy@0 {
> > > +            compatible = "ethernet-phy-ieee802.3-c45";
> > > +            reg = <0x0>;
> > > +            lane-handle = <&lane_d>; /* use lane D */
> > > +            eq-algorithm = "bee";
> > > +            /* 10G Short cables setup: up to 30 cm cable */
> > > +            eq-init = <0x2 0x5 0x29>;
> > > +            eq-params = <0>;
> > > +        };
> > > +    };
> > 
> > So you are modelling this as just another PHY? Does the driver get loaded based
> > on the PHY ID in registers 2 and 3? Does the standard define these IDs or are
> > they vendor specific?
> > 
> > Thanks
> >         Andrew
> 
> Hi Andrew,
> Thank you all for the feedback.
> I am currently working to address the entire feedback received 
> so far for this new Backplane driver.
> 
> Yes, we are modelling backplane driver as a phy driver.

I think we need to think very carefully about that, and consider
whether that really is a good idea.  phylib is currently built
primarily around copper PHYs, although there are some which also
support fiber as well in weird "non-standard" forms.

What worries me is the situation which I've been working on, where
we want access to the PCS PHYs, and we can't have the PCS PHYs
represented as a phylib PHY because we may have a copper PHY behind
the PCS PHY, and we want to be talking to the copper PHY in the
first instance (the PCS PHY effectivel ybecomes a slave to the
copper PHY.)

My worry is that we're ending up with conflicting implementations
for the same hardware which may only end up causing problems down
the line.

Please can you look at my DPAA2 PCS series which has been previously
posted to netdev - it's rather difficult to work out who in NXP should
be copied, because that information is not visible to those of us in
the community - we only find that out after someone inside NXP posts
patches, and even then the MAINTAINERS file doesn't seem to get
updated.

It's also worth mentioning that on other SoCs, such as Marvell SoCs,
the serdes and "PCS" are entirely separate hardware blocks, and the
implementation in the kernel, which works very well, is to use the
drivers/phy for the serdes/comphy as they call it, and the ethernet
driver binds to the comphy to control the serdes settings, whereas
the ethernet driver looks after the PCS.  I haven't been able to
look at your code enough yet to work out if that would be possible.

I also wonder whether we want a separate class of MDIO device for
PCS PHYs, just as we have things like DSA switches implemented
entirely separately from phylib - they're basically different sub-
classes of a mdio device.

I think we have around 20 or so weeks to hash this out, since it's
clear that the 10gbase-kr (10GKR) phy interface mode can't be used
until we've eliminated it from existing dts files.

> The driver is loaded based on PHY ID in registers 2 and 3 which 
> are specified by the standard but it is a vendor specific value: 
> 32-Bit identifier composed of the 3rd through 24th bits of the 
> Organizationally Unique Identifier (OUI) assigned to the device 
> manufacturer by the IEEE, plus a six-bit model number, plus a 
> four-bit revision number.
> This is done in the device specific code and not in backplane 
> generic driver.
> You can check support for QorIQ devices where qoriq_backplane_driver 
> is registered as a phy_driver:
>  
> @file: qoriq_backplane.c
> +static struct phy_driver qoriq_backplane_driver[] = {
> +	{
> +	.phy_id		= PCS_PHY_DEVICE_ID,
> +	.name		= QORIQ_BACKPLANE_DRIVER_NAME,
> +	.phy_id_mask	= PCS_PHY_DEVICE_ID_MASK,
> +	.features       = BACKPLANE_FEATURES,
> +	.probe          = qoriq_backplane_probe,
> +	.remove         = backplane_remove,
> +	.config_init    = qoriq_backplane_config_init,
> +	.aneg_done      = backplane_aneg_done,
> 
> Here we register the particular phy device ID/mask and driver name 
> specific for qoriq devices. 
> Also we can use generic routines provided by generic backplane driver 
> if they are suitable for particular qoriq device or otherwise we can use 
> more specialized specific routines like: qoriq_backplane_config_init
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
