Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC58C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB7320823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593019602;
	bh=QhkibFX5ONiQurz+bJ7EdBVRoQ37RDI3PIq3xkhBAjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZBiGtjVdCWAzO4dl2a5VY5CCZYOlxjSBcoSncTt6sZbXOrotINhiv+NzQWTVetds1
	 xjObZW/oY1NPddoZIC1ew+zx4W9sTFbRVNB8/zrGoXe8yM01k35fTzCoymYq9Gdf3R
	 tG2ljN8D0yVPoEhfVyPbdvWM6SbKML4XrsCwwEgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405533AbgFXR0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405427AbgFXR0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:26:40 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 457E820823;
        Wed, 24 Jun 2020 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593019599;
        bh=QhkibFX5ONiQurz+bJ7EdBVRoQ37RDI3PIq3xkhBAjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELZF954hFUl7p39bmYPAUW+LndZu61e7JsF7Yt55J7ik25vY9qc3b7h9sgaYOThKS
         AYjkDzGQeoGWWEBOfXNjDhTZdqy6Rfa1mlVdYy6KDwzA+wJkCfRbd3F4XtJjiRbTo0
         bRQFELyYmUtWcP1bTtkY7vM6BorCwy+N1Eeb/WG8=
Date:   Wed, 24 Jun 2020 22:56:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v8 2/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP
 Gigabit Transceiver
Message-ID: <20200624172635.GI2324254@vkoul-mobl>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
 <20200513172239.26444-3-laurent.pinchart@ideasonboard.com>
 <20200624151121.GF2324254@vkoul-mobl>
 <20200624163927.GF5980@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624163927.GF5980@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 24-06-20, 19:39, Laurent Pinchart wrote:

> > > +/* Number of GT lanes */
> > > +#define NUM_LANES			4
> > 
> > Should this be coded in driver like this? Maybe future versions of
> > hardware will have more lanes..? Why not describe this in DT?
> 
> This macro is used to avoid hardcoding 4 in the driver, to make sure
> that all the code that deal with the number of lanes use a consistent
> value and is readable. There's no foreseen new version of the IP that
> would have more lane, so I don't think this should go in DT. Otherwise
> we'd have to encode there pretty much any parameter that could one day
> possibly change in a different universe :-)
> 
> Let's also note that even when parameters change between IP versions, it
> doesn't always make sense to specify them explicitly in DT. It's totally
> fine to have a table of parameter values in the driver, indexed by
> compatible string. Whether to set a parameter explicitly in DT or handle
> it in the driver usually depends on how frequently that parameter can
> change, if it can vary between different integrations of the same IP
> version, ...
> 
> In this specific case, as there's no foreseen change, we can't really
> tell how it would change if it did one day. I thus think hardcoding the
> parameter in the driver is fine, and in the worst case, we can add a
> parameter in DT later and default to 4 if not specified. Same reasoning
> for CONTROLLERS_PER_LANE.

yeah not every parameter can be coded and we should use compatible as
well, but I would disagree with no future revision planned. It will
happen not now, but sometime in year or so :) Been around devices has
taught me that only constant thing is change in hardware!

Yes but this is not a deal breaker atm, will leave upto you

> 
> > > +
> > > +/* SIOU SATA control register */
> > > +#define SATA_CONTROL_OFFSET		0x0100
> > > +
> > > +/* Total number of controllers */
> > > +#define CONTROLLERS_PER_LANE		5
> > 
> > Same question for this as well..
> > 
> > > +/*
> > > + * I/O Accessors
> > > + */
> > > +
> > > +static inline u32 xpsgtr_read(struct xpsgtr_dev *gtr_dev, u32 reg)
> > > +{
> > > +	return readl(gtr_dev->serdes + reg);
> > > +}
> > > +
> > > +static inline void xpsgtr_write(struct xpsgtr_dev *gtr_dev, u32 reg, u32 value)
> > > +{
> > > +	writel(value, gtr_dev->serdes + reg);
> > > +}
> > > +
> > > +static inline void xpsgtr_clr_set(struct xpsgtr_dev *gtr_dev, u32 reg,
> > > +				  u32 clr, u32 set)
> > 
> > wouldn't it be apt to rename this to xpsgtr_modify() and with args as
> > value and mask, somehow I find that more simpler...
> 
> "modify" sounds more vague to me. I've also kept xpsgtr_clr_set() as
> that's what the original author used.

yeah maybe that was a wrong choice of term, I guess update looks best.
We really are missing update api in kernel! I see regmap does provide
_update_bits() api

> 
> > Also, please align second line with opening brace of preceding line
> 
> It is aligned, the first line is affected by the + and > in the mail,
> while the second line uses tabs and thus isn't.

ok

-- 
~Vinod
