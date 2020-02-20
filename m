Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD038C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933DB20722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Y/aOJcaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgBTNxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:53:21 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54472 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgBTNxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:53:21 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 63B1CE7C;
        Thu, 20 Feb 2020 14:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1582206798;
        bh=bIqv4ZGZOGT3b6xmaqujXh3xaygrfzUiArc2j1fuRB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/aOJcazvIBhp5356NPaYzBh8ptng3KYAzVlkyNIahWk4GT+WfCiq+Uv781MXXdHy
         wmwvMnJXDs1t/Mwf7e/OEdrwWCpQmsstG307HQv5+Cn7yXMtFU8Ptp5zHZMPPw9LOJ
         VCrPmcpkEf4a+liOR16kPm7uV/zJy8w1+qv8Efp8=
Date:   Thu, 20 Feb 2020 15:52:59 +0200
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
Subject: Re: [PATCH 2/6] drm/bridge: anx6345: Clean up error handling in
 probe()
Message-ID: <20200220135259.GC4998@pendragon.ideasonboard.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
 <20200220083508.792071-3-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220083508.792071-3-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily,

Thank you for the patch.

On Thu, Feb 20, 2020 at 12:35:04AM -0800, Vasily Khoruzhick wrote:
> devm_regulator_get() returns either a dummy regulator or -EPROBE_DEFER,
> we don't need to print scary message in either case.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index 0d8d083b0207..0204bbe4f0a0 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -713,17 +713,13 @@ static int anx6345_i2c_probe(struct i2c_client *client,
>  
>  	/* 1.2V digital core power regulator  */
>  	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12");
> -	if (IS_ERR(anx6345->dvdd12)) {
> -		DRM_ERROR("dvdd12-supply not found\n");
> +	if (IS_ERR(anx6345->dvdd12))
>  		return PTR_ERR(anx6345->dvdd12);
> -	}

There could be other errors such as -EBUSY or -EPERM. The following
would ensure a message gets printed in those cases, while avoiding
spamming the kernel log in the EPROBE_DEFER case.

	if (IS_ERR(anx6345->dvdd12)) {
		if (PTR_ERR(anx6345->dvdd12) != -EPROBE_DEFER)
			DRM_ERROR("Failed to get dvdd12 supply (%d)\n",
				  PTR_ERR(anx6345->dvdd12));
		return PTR_ERR(anx6345->dvdd12);
	}

But maybe it's overkill ? With or without that change (for the second
regulator below too),

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	/* 2.5V digital core power regulator  */
>  	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25");
> -	if (IS_ERR(anx6345->dvdd25)) {
> -		DRM_ERROR("dvdd25-supply not found\n");
> +	if (IS_ERR(anx6345->dvdd25))
>  		return PTR_ERR(anx6345->dvdd25);
> -	}
>  
>  	/* GPIO for chip reset */
>  	anx6345->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);

-- 
Regards,

Laurent Pinchart
