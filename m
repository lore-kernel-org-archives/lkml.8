Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A36C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A62206D4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nzrlgS6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgICPa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgICPaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:30:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CBAC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 08:30:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C86A3277;
        Thu,  3 Sep 2020 17:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599147015;
        bh=ZKox1fePS8w4e2RgWars+NqmMnnJ90Zax8raV/zcX8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzrlgS6EQvX8cQu4wSntXGIiJTOzhmjYT34L1c3nu59w/d12iHx7D2mf89f+Vh2bf
         3OsrRA1gCGoS3qsVgES4nmeV0mQwOINxmE7rsfVUUoBVl99vIzVpJvLDIVA8WLvX+H
         a7Ktawfn9npjWQ+34PChxy0rqDiIojk9Y5eIxCLE=
Date:   Thu, 3 Sep 2020 18:29:51 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
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
Message-ID: <20200903152951.GE6492@pendragon.ideasonboard.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
 <1598293711-23362-3-git-send-email-sjakhade@cadence.com>
 <20200902002956.GE14351@pendragon.ideasonboard.com>
 <DM6PR07MB6154CC4A67BC3568A7339CC9C52F0@DM6PR07MB6154.namprd07.prod.outlook.com>
 <20200902121722.GA16811@pendragon.ideasonboard.com>
 <DM6PR07MB6154F54322C38E6D864C7797C52C0@DM6PR07MB6154.namprd07.prod.outlook.com>
 <b7903295-6482-53a5-2f08-3da17ced0c87@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7903295-6482-53a5-2f08-3da17ced0c87@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Thu, Sep 03, 2020 at 05:00:14PM +0530, Kishon Vijay Abraham I wrote:
> On 9/3/2020 4:29 PM, Swapnil Kashinath Jakhade wrote:
> > On Wednesday, September 2, 2020 5:47 PM, Laurent Pinchart wrote:
> >> On Wed, Sep 02, 2020 at 07:09:21AM +0000, Swapnil Kashinath Jakhade wrote:
> >>> On Wednesday, September 2, 2020 6:00 AM Laurent Pinchart wrote:
> >>>> On Mon, Aug 24, 2020 at 08:28:31PM +0200, Swapnil Jakhade wrote:
> >>>>> Use generic PHY framework function phy_set_attrs() to set number
> >>>>> of lanes and maximum link rate supported by PHY.
> >>>>>
> >>>>> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> >>>>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>>> ---
> >>>>>  drivers/phy/cadence/phy-cadence-torrent.c | 7 +++++++
> >>>>>  1 file changed, 7 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> >>>>> b/drivers/phy/cadence/phy-cadence-torrent.c
> >>>>> index 7116127358ee..eca71467c4a8 100644
> >>>>> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> >>>>> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> >>>>> @@ -1710,6 +1710,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
> >>>>>  	struct cdns_torrent_phy *cdns_phy;
> >>>>>  	struct device *dev = &pdev->dev;
> >>>>>  	struct phy_provider *phy_provider;
> >>>>> +	struct phy_attrs torrent_attr;
> >>>>>  	const struct of_device_id *match;
> >>>>>  	struct cdns_torrent_data *data;
> >>>>>  	struct device_node *child;
> >>>>> @@ -1852,6 +1853,12 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
> >>>>>  				 cdns_phy->phys[node].num_lanes,
> >>>>>  				 cdns_phy->max_bit_rate / 1000,
> >>>>>  				 cdns_phy->max_bit_rate % 1000);
> >>>>> +
> >>>>> +			torrent_attr.bus_width = cdns_phy->phys[node].num_lanes;
> >>>>> +			torrent_attr.max_link_rate = cdns_phy->max_bit_rate;
> >>>>> +			torrent_attr.mode = PHY_MODE_DP;
> >>>>> +
> >>>>> +			phy_set_attrs(gphy, &torrent_attr);
> >>>>
> >>>> Why is this better than accessing the attributes manually as follows ?
> >>>>
> >>>> 			gphy->attrs.bus_width = cdns_phy->phys[node].num_lanes;
> >>>> 			gphy->attrs.max_link_rate = cdns_phy->max_bit_rate;
> >>>> 			gphy->attrs.mode = PHY_MODE_DP;
> >>>>
> >>>> This is called in cdns_torrent_phy_probe(), before the PHY provider
> >>>> is registered, so nothing can access the PHY yet. What race
> >>>> condition are you trying to protect against with usage of phy_set_attrs() ?
> >>>
> >>> I agree that for Cadence DP bridge driver and Torrent PHY driver use
> >>> case, it would not matter even if we set the attributes in Torrent PHY
> >>> driver in a way you suggested above.
> >>> But as per the discussion in [1], phy_set_attrs/phy_get_attrs APIs in
> >>> future could maybe used by other drivers replacing existing individual
> >>> functions for attributes bus_width and mode which are
> >>> phy_set_bus_width/phy_get_bus_width and phy_set_mode/phy_get_mode. So
> >>> this usage in Torrent PHY driver is an example implementation of the API.
> >>>
> >>> [1]
> >>> https://urldefense.com/v3/__https://lkml.org/lkml/2020/5/18/472__;!!EH
> >>> scmS1ygiU1lA!QKTTI7BS1R35a_zoMfJsY4A4yCtEKrQNtiAXTyIZ-SYIEEibYdpBMJTll
> >>> Yrd-00$
> >>
> >> This doesn't seem a very good API to me :-S It will require callers to always
> >> call phy_get_attrs() first, modify the attributes they want to set, and then call
> >> phy_set_attrs(). Not only will be copy the whole phy_attrs structure
> >> needlessly, it will also not be an atomic operation as someone else could
> >> modify attributes between the get and set calls.
> >> The lack of atomicity may not be an issue in practice if there's a single user of
> >> the PHY at all times, but in that case no mutex is needed.
> 
> What if the consumer tries to set an attribute at the middle of a
> phy_power_on() operation? That is still a valid operation and phy core layer
> should try to prevent it no?

I see multiple questions here.

First of all, unless I'm mistaken, the attributes set here are static
properties, set by the PHY driver at probe time, and only read by PHY
consumers. There should be no need for any kind of protection or special
API to access them.

Then, there's the question of how to handle dynamic attributes. In
theory a dynamic attribute could be changed at any time, and thus race
wit, for instance phy_power_on(). However, the proposed API won't help
much address this issue. Using a mutex will indeed ensure that the
attribute change will be serialized with other operations, but it won't
give any guarantee to the PHY consumer on whether the attribute will be
set before or after phy_power_on() is processed. The consumer will not
know if the new value of the attribute has been taken into account.

The question is thus whether we want to make the PHY consumer API
thread-safe (note that due to the usage of a mutex, we don't support
calling most of the API functions from an interrupt handler, so it
really requires the consumer to use a work queue, a thread, or possibly
a threaded interrupt). If the answer is yes, the API should define what
use cases are valid, and how the PHY has to behave. This includes
documenting when new attribute values can be set, and when they are
taken into account. If we had to document this as part of this patch
series, we would have to state that the new values are taken into
account at an undefined point of time if the attribute set call is
concurrent with other API calls, which makes the API ill-defined in my
opinion. I expect that we would need to turn attribute setting into a
callback to the PHY driver in that case, or at least make it a more
complex operation handled by the PHY core that would use the existing
PHY ops to reconfigure the PHY.

Is it worth it allowing drivers to call the PHY API from different
threads as opposed to requiring consumers to serialize calls if their
use cases require so ? I would expect most consumers to only try to
reconfigure a PHY when it's stopped, or to manually stop, reconfigure
and restart the PHY.

> >> I think this series tries to fix a problem that doesn't exist.
> > 
> > Thanks Laurent for your comments.
> > 
> > Hi Kishon,
> > 
> > Could you please suggest what would be the better approach regarding this PHY
> > attributes series. Should we add individual get/set functions for new attribute
> > max_link_rate just like mode and bus_width, or should we use phy_get_attrs()
> > and phy_set_attrs() functions removing mutex.  Your suggestions would really help.
> 
> I think Laurent's point is not having an API at all for configuring attributes
> and access them manually?

If the answer to the above question is that a thread-safe API isn't
worth it as we wouldn't have good use cases for it, then I think
accessing the attributes manually is all we need.

> >>>>>  		} else {
> >>>>>  			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
> >>>>>  			ret = -ENOTSUPP;

-- 
Regards,

Laurent Pinchart
