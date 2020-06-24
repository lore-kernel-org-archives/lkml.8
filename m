Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA301C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3CC20768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="f0fHUh57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbgFXVPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:15:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35394 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389905AbgFXVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:15:01 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 59C3B2A8;
        Wed, 24 Jun 2020 23:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593033299;
        bh=O456LASQn9kO/3hkrQBpyo1bbr1iLz/VwItz+lFwffU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0fHUh57lgRqR9IpMOjXoZK3Twxsd/ZWfJQm+2hA0sVIRWeRIZO2MX/jELjW3RNyB
         48IdhD2OXlfK0afif8c8zY3u1PFxQqTpmuh4UmFp5AcXqSCujRE6aH5TSRlMhQAE45
         eYSABfTxAZhVCiHfU3S95gmqFKjCyWcVj3buK2/M=
Date:   Thu, 25 Jun 2020 00:14:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v8 2/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP
 Gigabit Transceiver
Message-ID: <20200624211458.GA29023@pendragon.ideasonboard.com>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
 <20200513172239.26444-3-laurent.pinchart@ideasonboard.com>
 <20200624151121.GF2324254@vkoul-mobl>
 <20200624163927.GF5980@pendragon.ideasonboard.com>
 <20200624172635.GI2324254@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624172635.GI2324254@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Wed, Jun 24, 2020 at 10:56:35PM +0530, Vinod Koul wrote:
> On 24-06-20, 19:39, Laurent Pinchart wrote:
> 
> > > > +/* Number of GT lanes */
> > > > +#define NUM_LANES			4
> > > 
> > > Should this be coded in driver like this? Maybe future versions of
> > > hardware will have more lanes..? Why not describe this in DT?
> > 
> > This macro is used to avoid hardcoding 4 in the driver, to make sure
> > that all the code that deal with the number of lanes use a consistent
> > value and is readable. There's no foreseen new version of the IP that
> > would have more lane, so I don't think this should go in DT. Otherwise
> > we'd have to encode there pretty much any parameter that could one day
> > possibly change in a different universe :-)
> > 
> > Let's also note that even when parameters change between IP versions, it
> > doesn't always make sense to specify them explicitly in DT. It's totally
> > fine to have a table of parameter values in the driver, indexed by
> > compatible string. Whether to set a parameter explicitly in DT or handle
> > it in the driver usually depends on how frequently that parameter can
> > change, if it can vary between different integrations of the same IP
> > version, ...
> > 
> > In this specific case, as there's no foreseen change, we can't really
> > tell how it would change if it did one day. I thus think hardcoding the
> > parameter in the driver is fine, and in the worst case, we can add a
> > parameter in DT later and default to 4 if not specified. Same reasoning
> > for CONTROLLERS_PER_LANE.
> 
> yeah not every parameter can be coded and we should use compatible as
> well, but I would disagree with no future revision planned. It will
> happen not now, but sometime in year or so :) Been around devices has
> taught me that only constant thing is change in hardware!

I don't dispute it will not happen, my point is that, without a new
revision planned, we don't have enough information to tell which option
would be best to support future revisions. As I know we won't be blocked
(both compat string matching and adding new optional properties with
appropriate defaults will be viable options), I'm not concerned.

> Yes but this is not a deal breaker atm, will leave upto you
> 
> > > > +
> > > > +/* SIOU SATA control register */
> > > > +#define SATA_CONTROL_OFFSET		0x0100
> > > > +
> > > > +/* Total number of controllers */
> > > > +#define CONTROLLERS_PER_LANE		5
> > > 
> > > Same question for this as well..
> > > 
> > > > +/*
> > > > + * I/O Accessors
> > > > + */
> > > > +
> > > > +static inline u32 xpsgtr_read(struct xpsgtr_dev *gtr_dev, u32 reg)
> > > > +{
> > > > +	return readl(gtr_dev->serdes + reg);
> > > > +}
> > > > +
> > > > +static inline void xpsgtr_write(struct xpsgtr_dev *gtr_dev, u32 reg, u32 value)
> > > > +{
> > > > +	writel(value, gtr_dev->serdes + reg);
> > > > +}
> > > > +
> > > > +static inline void xpsgtr_clr_set(struct xpsgtr_dev *gtr_dev, u32 reg,
> > > > +				  u32 clr, u32 set)
> > > 
> > > wouldn't it be apt to rename this to xpsgtr_modify() and with args as
> > > value and mask, somehow I find that more simpler...
> > 
> > "modify" sounds more vague to me. I've also kept xpsgtr_clr_set() as
> > that's what the original author used.
> 
> yeah maybe that was a wrong choice of term, I guess update looks best.
> We really are missing update api in kernel! I see regmap does provide
> _update_bits() api
> 
> > > Also, please align second line with opening brace of preceding line
> > 
> > It is aligned, the first line is affected by the + and > in the mail,
> > while the second line uses tabs and thus isn't.
> 
> ok

-- 
Regards,

Laurent Pinchart
