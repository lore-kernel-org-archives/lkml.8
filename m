Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCA2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCC720714
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 13:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AC10VTLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFNNrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 09:47:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6156CC05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 06:47:23 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 580AFF9;
        Sun, 14 Jun 2020 15:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592142437;
        bh=78M8/Iqg3S3zq/AYzhpfmb4A0g++NPy6J82ruz/ctlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AC10VTLShWRiPx1ZaBkblj33hHeMqBK2vUYAS/uOxQW9wkYL/5Dv7/ssN/BqJQu7c
         6zK9jfCUqAHe3ByXr31lHTmFQPcf2SbvwrLn08Hc2fetelZJrZ8UsLIJ3W3/eozyqo
         dEQ/mOKPq7ZIXAgBOZs33tKtudg/Pi0sWHhKSavo=
Date:   Sun, 14 Jun 2020 16:46:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] drm/bridge: fix reference count leaks due to
 pm_runtime_get_sync()
Message-ID: <20200614134655.GA5960@pendragon.ideasonboard.com>
References: <20200614024005.125578-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200614024005.125578-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

(CC'ing Rafael)

Thank you for the patch.

On Sat, Jun 13, 2020 at 09:40:05PM -0500, Aditya Pakki wrote:
> On calling pm_runtime_get_sync() the reference count of the device
> is incremented. In case of failure, decrement the
> reference count before returning the error.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

I've seen lots of similar patches recently. Instead of mass-patching the
drivers this way, shouldn't pm_runtime_get_sync() (and similar
functions) decrease the refcount on their failure path ? That would
require patching drivers that already handle this issue, but I believe
that would cause less churn, and more importantly, avoid the issue once
and for good for new code.

> ---
>  drivers/gpu/drm/bridge/cdns-dsi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> index 69c3892caee5..583cb8547106 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -788,8 +788,10 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
>  	u32 tmp, reg_wakeup, div;
>  	int nlanes;
>  
> -	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
> +	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0)) {
> +		pm_runtime_put(dsi->base.dev);
>  		return;
> +	}
>  
>  	mode = &bridge->encoder->crtc->state->adjusted_mode;
>  	nlanes = output->dev->lanes;
> @@ -1028,8 +1030,10 @@ static ssize_t cdns_dsi_transfer(struct mipi_dsi_host *host,
>  	int ret, i, tx_len, rx_len;
>  
>  	ret = pm_runtime_get_sync(host->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put(host->dev);
>  		return ret;
> +	}
>  
>  	cdns_dsi_init_link(dsi);
>  

-- 
Regards,

Laurent Pinchart
