Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F115C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB792076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgH2VIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:08:32 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51722 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgH2VIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:08:31 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8C421804A4;
        Sat, 29 Aug 2020 23:08:28 +0200 (CEST)
Date:   Sat, 29 Aug 2020 23:08:27 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        od@zcrc.me
Subject: Re: [PATCH v2 2/2] drm/ingenic: Fix driver not probing when IPU port
 is missing
Message-ID: <20200829210827.GF796939@ravnborg.org>
References: <20200827114404.36748-1-paul@crapouillou.net>
 <20200827114404.36748-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827114404.36748-2-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=A5ZCwZeG c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=7gkXJVJtAAAA:8
        a=8Y5p9mnmN_Fc2c6ofskA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 01:44:04PM +0200, Paul Cercueil wrote:
> Even if support for the IPU was compiled in, we may run on a device
> (e.g. the Qi LB60) where the IPU is not available, or simply with an old
> devicetree without the IPU node. In that case the ingenic-drm refused to
> probe.
> 
> Fix the driver so that it will probe even if the IPU node is not present
> in devicetree (but then IPU support is disabled of course).
> 
> v2: Take a different approach
> 
> Fixes: fc1acf317b01 ("drm/ingenic: Add support for the IPU")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index c1bcb93aed2d..b7074161ccf0 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -673,7 +673,7 @@ static void ingenic_drm_unbind_all(void *d)
>  	component_unbind_all(priv->dev, &priv->drm);
>  }
>  
> -static int ingenic_drm_bind(struct device *dev)
> +static int ingenic_drm_bind(struct device *dev, bool has_components)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	const struct jz_soc_info *soc_info;
> @@ -808,7 +808,7 @@ static int ingenic_drm_bind(struct device *dev)
>  			return ret;
>  		}
>  
> -		if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU)) {
> +		if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU) && has_components) {
>  			ret = component_bind_all(dev, drm);
>  			if (ret) {
>  				if (ret != -EPROBE_DEFER)
> @@ -939,6 +939,11 @@ static int ingenic_drm_bind(struct device *dev)
>  	return ret;
>  }
>  
> +static int ingenic_drm_bind_with_components(struct device *dev)
> +{
> +	return ingenic_drm_bind(dev, true);
> +}
> +
>  static int compare_of(struct device *dev, void *data)
>  {
>  	return dev->of_node == data;
> @@ -957,7 +962,7 @@ static void ingenic_drm_unbind(struct device *dev)
>  }
>  
>  static const struct component_master_ops ingenic_master_ops = {
> -	.bind = ingenic_drm_bind,
> +	.bind = ingenic_drm_bind_with_components,
>  	.unbind = ingenic_drm_unbind,
>  };
>  
> @@ -968,14 +973,12 @@ static int ingenic_drm_probe(struct platform_device *pdev)
>  	struct device_node *np;
>  
>  	if (!IS_ENABLED(CONFIG_DRM_INGENIC_IPU))
> -		return ingenic_drm_bind(dev);
> +		return ingenic_drm_bind(dev, false);
>  
>  	/* IPU is at port address 8 */
>  	np = of_graph_get_remote_node(dev->of_node, 8, 0);
> -	if (!np) {
> -		dev_err(dev, "Unable to get IPU node\n");
> -		return -EINVAL;
> -	}
> +	if (!np)
> +		return ingenic_drm_bind(dev, false);
>  
>  	drm_of_component_match_add(dev, &match, compare_of, np);
>  	of_node_put(np);
> -- 
> 2.28.0
