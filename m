Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E688C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679AD20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GGkUcQvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgIBMSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:18:54 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42170 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgIBMRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:17:52 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 646589CC;
        Wed,  2 Sep 2020 14:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599049067;
        bh=CAysycQjBAG8FFPdgBPgW9RzoPqP0mNlHgugOAceGoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGkUcQvN9VDwoiv1MZunEeee06DCQPZvGwjsqBDMP6hxCBB1GN3regmNK1PqCaF7g
         gUlDlRzmQ+NaH+2Fbf33jtWgQTnfcV95EliUYnXhLUpW+QdDNmw5YagA8OCbNqRRKu
         QgzFCDGYxOOE4KoEOILF41BQ4atpeE1tqJX+2jIY=
Date:   Wed, 2 Sep 2020 15:17:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: Re: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set
 PHY attributes
Message-ID: <20200902121722.GA16811@pendragon.ideasonboard.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
 <1598293711-23362-3-git-send-email-sjakhade@cadence.com>
 <20200902002956.GE14351@pendragon.ideasonboard.com>
 <DM6PR07MB6154CC4A67BC3568A7339CC9C52F0@DM6PR07MB6154.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR07MB6154CC4A67BC3568A7339CC9C52F0@DM6PR07MB6154.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On Wed, Sep 02, 2020 at 07:09:21AM +0000, Swapnil Kashinath Jakhade wrote:
> On Wednesday, September 2, 2020 6:00 AM Laurent Pinchart wrote:
> > On Mon, Aug 24, 2020 at 08:28:31PM +0200, Swapnil Jakhade wrote:
> > > Use generic PHY framework function phy_set_attrs() to set number of
> > > lanes and maximum link rate supported by PHY.
> > >
> > > Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> > > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > ---
> > >  drivers/phy/cadence/phy-cadence-torrent.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> > > b/drivers/phy/cadence/phy-cadence-torrent.c
> > > index 7116127358ee..eca71467c4a8 100644
> > > --- a/drivers/phy/cadence/phy-cadence-torrent.c
> > > +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> > > @@ -1710,6 +1710,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
> > >  	struct cdns_torrent_phy *cdns_phy;
> > >  	struct device *dev = &pdev->dev;
> > >  	struct phy_provider *phy_provider;
> > > +	struct phy_attrs torrent_attr;
> > >  	const struct of_device_id *match;
> > >  	struct cdns_torrent_data *data;
> > >  	struct device_node *child;
> > > @@ -1852,6 +1853,12 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
> > >  				 cdns_phy->phys[node].num_lanes,
> > >  				 cdns_phy->max_bit_rate / 1000,
> > >  				 cdns_phy->max_bit_rate % 1000);
> > > +
> > > +			torrent_attr.bus_width = cdns_phy- >phys[node].num_lanes;
> > > +			torrent_attr.max_link_rate = cdns_phy->max_bit_rate;
> > > +			torrent_attr.mode = PHY_MODE_DP;
> > > +
> > > +			phy_set_attrs(gphy, &torrent_attr);
> > 
> > Why is this better than accessing the attributes manually as follows ?
> > 
> > 			gphy->attrs.bus_width = cdns_phy->phys[node].num_lanes;
> > 			gphy->attrs.max_link_rate = cdns_phy->max_bit_rate;
> > 			gphy->attrs.mode = PHY_MODE_DP;
> > 
> > This is called in cdns_torrent_phy_probe(), before the PHY provider is
> > registered, so nothing can access the PHY yet. What race condition are you
> > trying to protect against with usage of phy_set_attrs() ?
> 
> I agree that for Cadence DP bridge driver and Torrent PHY driver use case, it
> would not matter even if we set the attributes in Torrent PHY driver in a way
> you suggested above.
> But as per the discussion in [1], phy_set_attrs/phy_get_attrs APIs in future could
> maybe used by other drivers replacing existing individual functions for attributes
> bus_width and mode which are phy_set_bus_width/phy_get_bus_width and
> phy_set_mode/phy_get_mode. So this usage in Torrent PHY driver is an example
> implementation of the API.
> 
> [1] https://lkml.org/lkml/2020/5/18/472

This doesn't seem a very good API to me :-S It will require callers to
always call phy_get_attrs() first, modify the attributes they want to
set, and then call phy_set_attrs(). Not only will be copy the whole
phy_attrs structure needlessly, it will also not be an atomic operation
as someone else could modify attributes between the get and set calls.
The lack of atomicity may not be an issue in practice if there's a
single user of the PHY at all times, but in that case no mutex is
needed.

I think this series tries to fix a problem that doesn't exist.

> > >  		} else {
> > >  			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
> > >  			ret = -ENOTSUPP;

-- 
Regards,

Laurent Pinchart
