Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA0FC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578B42071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDYO6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:58:00 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:44488 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgDYO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:58:00 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 17FA420083;
        Sat, 25 Apr 2020 16:57:58 +0200 (CEST)
Date:   Sat, 25 Apr 2020 16:57:56 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/panel: remove set but not used variable
 'config'
Message-ID: <20200425145756.GG32235@ravnborg.org>
References: <20200417101401.19388-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200417101401.19388-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=IkcTkHD0fZMA:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=34DvTQX8muPqOaDScfQA:9 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing

On Fri, Apr 17, 2020 at 06:14:01PM +0800, YueHaibing wrote:
> drivers/gpu/drm/panel/panel-truly-nt35597.c:493:31: warning: variable ‘config’ set but not used [-Wunused-but-set-variable]
>   const struct nt35597_config *config;
>                                ^~~~~~
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks. Applied to drm-misc-next, so it will appear in mainline kernel
in the next merge window.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-truly-nt35597.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
> index 012ca62bf30e..f0ad6081570f 100644
> --- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
> +++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
> @@ -490,9 +490,7 @@ static int truly_nt35597_panel_add(struct truly_nt35597 *ctx)
>  {
>  	struct device *dev = ctx->dev;
>  	int ret, i;
> -	const struct nt35597_config *config;
>  
> -	config = ctx->config;
>  	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++)
>  		ctx->supplies[i].supply = regulator_names[i];
>  
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
