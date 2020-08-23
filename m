Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334E7C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2152067C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 15:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHWPGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 11:06:01 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:36338 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgHWPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 11:05:46 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 89A7780511;
        Sun, 23 Aug 2020 17:05:24 +0200 (CEST)
Date:   Sun, 23 Aug 2020 17:05:22 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Vinay Simha BN <simhavcs@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/bridge/tc358775: Fix for PTR_ERR
Message-ID: <20200823150522.GA1047718@ravnborg.org>
References: <1597557042-5154-1-git-send-email-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597557042-5154-1-git-send-email-simhavcs@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
        a=UHwIiPJw-E6kj9bz9bIA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 11:20:41AM +0530, Vinay Simha BN wrote:
> passing zero to 'PTR_ERR'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>

Applied to drm-misc-next - thanks.

	Sam

> ---
>  drivers/gpu/drm/bridge/tc358775.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
> index 7da15cd..d951cdc 100644
> --- a/drivers/gpu/drm/bridge/tc358775.c
> +++ b/drivers/gpu/drm/bridge/tc358775.c
> @@ -684,7 +684,7 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	tc->vdd = devm_regulator_get(dev, "vdd-supply");
>  	if (IS_ERR(tc->vdd)) {
> -		ret = PTR_ERR(tc->vddio);
> +		ret = PTR_ERR(tc->vdd);
>  		dev_err(dev, "vdd-supply not found\n");
>  		return ret;
>  	}
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
