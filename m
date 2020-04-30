Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A351C83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DA62192A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD3HDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:03:32 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:59058 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgD3HDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:03:32 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 089F0804F6;
        Thu, 30 Apr 2020 09:03:25 +0200 (CEST)
Date:   Thu, 30 Apr 2020 09:03:24 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v8 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
Message-ID: <20200430070324.GA9545@ravnborg.org>
References: <cover.1587880280.git.xji@analogixsemi.com>
 <4d14400b6c19f17c28267f6ebdbce9673333c05c.1587880280.git.xji@analogixsemi.com>
 <20200427200044.GC15880@ravnborg.org>
 <20200430062416.GD6645@xin-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430062416.GD6645@xin-VirtualBox>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=J-B6ajXd8xN2lFXSAU4A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin Ji.

> > > +static void anx7625_power_on_init(struct anx7625_data *ctx)
> > > +{
> > > +	int retry_count, i;
> > > +	int ret;
> > > +	struct device *dev = &ctx->client->dev;
> > > +
> > > +	for (retry_count = 0; retry_count < 3; retry_count++) {
> > > +		anx7625_power_on(ctx);
> > > +		anx7625_config(ctx);
> > > +
> > > +		for (i = 0; i < OCM_LOADING_TIME; i++) {
> > Code in this for loop is a candidate for a helper function.
> I didn't find any helper function can be used, so I'll keep it.
I was not very clear in my way to express this, sorry.

> > 
> > > +			/* check interface workable */
> > > +			ret = anx7625_reg_read(ctx, ctx->i2c.rx_p0_client,
> > > +					       FLASH_LOAD_STA);
> > > +			if (ret < 0) {
> > > +				DRM_ERROR("IO error : access flash load.\n");
> > > +				return;
> > > +			}
> > > +			if ((ret & FLASH_LOAD_STA_CHK) == FLASH_LOAD_STA_CHK) {
> > > +				anx7625_disable_pd_protocol(ctx);
> > > +				DRM_DEV_DEBUG_DRIVER(dev,
> > > +						     "Firmware ver %02x%02x,",
> > > +					anx7625_reg_read(ctx,
> > > +							 ctx->i2c.rx_p0_client,
> > > +							 OCM_FW_VERSION),
> > > +					anx7625_reg_read(ctx,
> > > +							 ctx->i2c.rx_p0_client,
> > > +							 OCM_FW_REVERSION));
> > > +				DRM_DEV_DEBUG_DRIVER(dev, "Driver version %s\n",
> > > +						     ANX7625_DRV_VERSION);
> > > +
> > > +				return;
> > > +			}
> > > +			usleep_range(1000, 1100);
> > > +		}
What I wanted to express is that the for loop is heavily indented.
So create a small function like:

anx7625_power_on_interface(ctx)
{
	/* check interface workable */
	ret = anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, FLASH_LOAD_STA);
	if (ret < 0) {
	        DRM_ERROR("IO error : access flash load.\n");
	        return;
	}
	if ((ret & FLASH_LOAD_STA_CHK) == FLASH_LOAD_STA_CHK) {
	        anx7625_disable_pd_protocol(ctx);
	        DRM_DEV_DEBUG_DRIVER(dev, "Firmware ver %02x%02x,",
	                anx7625_reg_read(ctx, ctx->i2c.rx_p0_client,
                                         OCM_FW_VERSION), anx7625_reg_read(ctx,
	                                 ctx->i2c.rx_p0_client, OCM_FW_REVERSION));
	        DRM_DEV_DEBUG_DRIVER(dev, "Driver version %s\n",
	                             ANX7625_DRV_VERSION);
		retunrn 1;
	}
	return 0;
}

and then

	for (i = 0; i < OCM_LOADING_TIME; i++) {
		if (anx7625_power_on_interface(ctx))
			return;
		else
			usleep_range(1000, 1100);
	}

Or something like that. To make it more readable.
I think you get the idea now.


> > > +		container_of(work, struct anx7625_data, extcon_wq);
> > > +	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_DP);
> > > +
> > > +	mutex_lock(&ctx->lock);
> > > +	anx7625_chip_control(ctx, state);
> > > +	mutex_unlock(&ctx->lock);
> > I tried to follow the locking - but failed.
> > Could you check that locking seems correct.
> > 
> > A standard bridge driver do not need locking,
> > but this is no small bridge driver so I do not imply that
> > locking is not needed. Only that I would like you
> > to check it again as I could not follow it.
> OK, it seems lock is not necessary, I'll remove itA
It has a worker, so please be careful in you analysis.

> > 
> > > +
> > > +	if (pdata->panel_flags == 1)
> > > +		pdata->internal_panel = 1;
> > > +	else if (pdata->panel_flags == 2)
> > > +		pdata->extcon_supported = 1;
> > > +	DRM_DEV_DEBUG_DRIVER(dev, "%s support extcon, %s internal panel\n",
> > > +			     pdata->extcon_supported ? "" : "not",
> > > +			     pdata->internal_panel ? "has" : "no");
> > > +
> > The way the internal panel - versus external connector is modelled
> > looks like it could use some of the abstractions used by other bridge
> > drivers.
> > 
> > The connector_type shall for example for internal panels come
> > form the panel.
> > And use the panel bridge driver - see examples in patches I referenced
> > before.
> > 
> > And external connectors may beneft from using the
> > display-connector bridge driver.
> I'm not familiar with it, the extcon interface is Google engineer give
> to me, I just follow their sample driver. If you think it is not good,
> I'll remove the extcon support.
It would be better to start without, and then add it later
so we end up with a clean design.

I for one would have an easier time reviewing.

So please go ahead and remove it for now.


	Sam
