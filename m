Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D5EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862BE2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFQJxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgFQJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:53:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D664C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:53:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jlUks-0003EN-LW; Wed, 17 Jun 2020 11:53:14 +0200
Message-ID: <befc07e1d630dbc5a6f96fba4e47e083e6386090.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/etnaviv: fix ref count leak via
 pm_runtime_get_sync
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kjlu@umn.edu, mccamant@cs.umn.edu, andy.shevchenko@gmail.com,
        emamd001@umn.edu, wu000273@umn.edu
Date:   Wed, 17 Jun 2020 11:53:08 +0200
In-Reply-To: <20200615061220.68711-1-navid.emamdoost@gmail.com>
References: <CAHp75VcLR2w9Ym0YOqUT9G8xT9qWrdD1-wP4UA-1wtuwCNxqSA@mail.gmail.com>
         <20200615061220.68711-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Navid,

Am Montag, den 15.06.2020, 01:12 -0500 schrieb Navid Emamdoost:
> in etnaviv_gpu_submit, etnaviv_gpu_recover_hang, etnaviv_gpu_debugfs,
> and etnaviv_gpu_init the call to pm_runtime_get_sync increments the
> counter even in case of failure, leading to incorrect ref count.
> In case of failure, decrement the ref count before returning.

While that change is correct with the current API, may I ask the
question why the way this API works is considered reasonable? A API
call that fails, but still changes internal state and expects the
caller to clean up the mess it not really what I would consider fool-
proof API design. Is there a specific reason why it is done this way
and not handled internally?

Regards,
Lucas

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> Changes in v2:
> 	- replace pm_runtime_put with  pm_runtime_put_noidle
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index a31eeff2b297..7c9f3f9ba123 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -722,7 +722,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>  	ret = pm_runtime_get_sync(gpu->dev);
>  	if (ret < 0) {
>  		dev_err(gpu->dev, "Failed to enable GPU power domain\n");
> -		return ret;
> +		goto pm_put;
>  	}
>  
>  	etnaviv_hw_identify(gpu);
> @@ -819,6 +819,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>  
>  fail:
>  	pm_runtime_mark_last_busy(gpu->dev);
> +pm_put:
>  	pm_runtime_put_autosuspend(gpu->dev);
>  
>  	return ret;
> @@ -859,7 +860,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
>  
>  	ret = pm_runtime_get_sync(gpu->dev);
>  	if (ret < 0)
> -		return ret;
> +		goto pm_put;
>  
>  	dma_lo = gpu_read(gpu, VIVS_FE_DMA_LOW);
>  	dma_hi = gpu_read(gpu, VIVS_FE_DMA_HIGH);
> @@ -1003,6 +1004,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
>  	ret = 0;
>  
>  	pm_runtime_mark_last_busy(gpu->dev);
> +pm_put:
>  	pm_runtime_put_autosuspend(gpu->dev);
>  
>  	return ret;
> @@ -1016,7 +1018,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
>  	dev_err(gpu->dev, "recover hung GPU!\n");
>  
>  	if (pm_runtime_get_sync(gpu->dev) < 0)
> -		return;
> +		goto pm_put;
>  
>  	mutex_lock(&gpu->lock);
>  
> @@ -1035,6 +1037,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
>  
>  	mutex_unlock(&gpu->lock);
>  	pm_runtime_mark_last_busy(gpu->dev);
> +pm_put:
>  	pm_runtime_put_autosuspend(gpu->dev);
>  }
>  
> @@ -1308,8 +1311,10 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
>  
>  	if (!submit->runtime_resumed) {
>  		ret = pm_runtime_get_sync(gpu->dev);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			pm_runtime_put_noidle(gpu->dev);
>  			return NULL;
> +		}
>  		submit->runtime_resumed = true;
>  	}
>  
> @@ -1326,6 +1331,7 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
>  	ret = event_alloc(gpu, nr_events, event);
>  	if (ret) {
>  		DRM_ERROR("no free events\n");
> +		pm_runtime_put_noidle(gpu->dev);
>  		return NULL;
>  	}
>  

