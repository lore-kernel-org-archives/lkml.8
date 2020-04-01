Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DD8C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B70206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qa/VcPdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbgDANvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:51:48 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43064 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732705AbgDANvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BsnKKCm/0xhUX9Eh0r+sJcFsnyafS56/e7BV12MesKg=; b=qa/VcPdrBtpGUMbaqANfWFh9+W
        TP8qKQ3TYfGL8IXRLr3FchAEU2Azq8RAv55NSYoN8MxvVE2aeVkcSYIL7z6FPBhfIfIqpImHfzGVk
        +LF2NCoRc3+cUPjGCRZul8yh3r+BWj2M5OtAMdghdk/XxmBjQPurVS8ts1uwGAGlbblc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jJdmJ-000Qgk-52; Wed, 01 Apr 2020 15:51:35 +0200
Date:   Wed, 1 Apr 2020 15:51:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florinel Iordache <florinel.iordache@nxp.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH net-next 6/9] net: phy: add backplane kr driver support
Message-ID: <20200401135135.GA62290@lunn.ch>
References: <AM0PR04MB5443E8D583734C98C54C519EFBC90@AM0PR04MB5443.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB5443E8D583734C98C54C519EFBC90@AM0PR04MB5443.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 01:35:36PM +0000, Florinel Iordache wrote:
> > On Thu, Mar 26, 2020 at 03:51:19PM +0200, Florinel Iordache wrote:
> > > +static void setup_supported_linkmode(struct phy_device *bpphy) {
> > > +     struct backplane_phy_info *bp_phy = bpphy->priv;
> > 
> > I'm not sure it is a good idea to completely take over phydev->priv like this, in
> > what is just helper code. What if the PHY driver needs memory of its own? There
> > are a few examples of this already in other PHY drivers. Could a KR PHY contain
> > a temperature sensor? Could it contain statistics counters which need
> > accumulating?
> > 
> >         Andrew
> 
> Backplane KR driver allocates memory for structure backplane_phy_info
> which is saved in phydev->priv. After all this is the purpose of priv
> according to its description in phy.h: <<private data pointer For use
> by PHYs to maintain extra state>>. Here the priv is used to maintain
> extra state needed for backplane. This way the backplane specific data
> becomes available for all PHY callbacks (defined in struct phy_driver)
> that receive a pointer to phy_device structure. This initial version
> doesn't include accumulating statistics counters but we have in plan
> to add these in future versions. The counters will be kept in specific
> structures as members of the main backplane data mentioned above
> and entire support will be integrated with ethtool.

Hi Florinel

And what about hwmon, or anything else which a driver needs memory
for?

As far as i see it, we have two bodies of code here. There is a set of
helpers which implement most of the backplane functionality. And then
there is an example driver for your hardware. In the future we expect
other drivers to be added for other vendors hardware.

phydev->priv is for the driver. helpers should not assume they have
complete control over it.

Anyway, this may be a mute point. Lets first solve the problem of how
a PCS is represented.

  Andrew

