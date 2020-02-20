Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6187FC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E5C222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MtgKWlPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgBTNrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:47:04 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54340 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgBTNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:47:04 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A7EBF563;
        Thu, 20 Feb 2020 14:47:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1582206422;
        bh=uiVkPCvjcZdbiY3qcGURFlvVQ3c1CcE3A2NnKP1Gewo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtgKWlPnwMeA86TLEK/5cvysfXWA1tk4Oq5Bi3hPaI8PFUv6u74R4gH6iBbDBz+lv
         9yuMr9/Yg1uwc31+VVI6mNTWIZbC+aCmorWGlxualPlBre5pNvFD2tQ36tJeb1ubBl
         ezWEmwz7OYlmwBlMRm4wDz3G54bdiGesQx1R2xVU=
Date:   Thu, 20 Feb 2020 15:46:43 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] drm/bridge: anx6345: Fix getting anx6345 regulators
Message-ID: <20200220134643.GB4998@pendragon.ideasonboard.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
 <20200220083508.792071-2-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220083508.792071-2-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily,

Thank you for the patch.

On Thu, Feb 20, 2020 at 12:35:03AM -0800, Vasily Khoruzhick wrote:
> From: Samuel Holland <samuel@sholland.org>
> 
> We don't need to pass '-supply' suffix to devm_get_regulator()
> 
> Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index 56f55c53abfd..0d8d083b0207 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -712,14 +712,14 @@ static int anx6345_i2c_probe(struct i2c_client *client,
>  		DRM_DEBUG("No panel found\n");
>  
>  	/* 1.2V digital core power regulator  */
> -	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12-supply");
> +	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12");
>  	if (IS_ERR(anx6345->dvdd12)) {
>  		DRM_ERROR("dvdd12-supply not found\n");
>  		return PTR_ERR(anx6345->dvdd12);
>  	}
>  
>  	/* 2.5V digital core power regulator  */
> -	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25-supply");
> +	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25");
>  	if (IS_ERR(anx6345->dvdd25)) {
>  		DRM_ERROR("dvdd25-supply not found\n");
>  		return PTR_ERR(anx6345->dvdd25);

-- 
Regards,

Laurent Pinchart
