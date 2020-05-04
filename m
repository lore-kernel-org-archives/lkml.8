Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840E120707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgEDUUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:20:16 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37820 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgEDUUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:20:16 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id ACAFE804C8;
        Mon,  4 May 2020 22:20:10 +0200 (CEST)
Date:   Mon, 4 May 2020 22:20:09 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Lu <david.lu@bitland.com.cn>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     scott.chao@bitland.com.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        casper.chang@bitland.com.cn
Subject: Re: [PATCH] drm/panel: boe-tv101wum-n16: fine tune clock
Message-ID: <20200504202009.GD8122@ravnborg.org>
References: <20200428064521.21511-1-david.lu@bitland.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428064521.21511-1-david.lu@bitland.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=iKCrp2iyAAAA:8 a=e5mUnYsNAAAA:8
        a=USH4Leqcx4jq98t2q1IA:9 a=CjuIK1q_8ugA:10 a=6dnM-gFdnRAg0d82BWIM:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

On Tue, Apr 28, 2020 at 02:45:21PM +0800, David Lu wrote:
> fix boe_tv105wum_nw0 display shift.
> 
> Signed-off-by: David Lu <david.lu@bitland.com.cn>
Added fixes: tag and applied to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index f89861c8598a..46fe1805c588 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -697,15 +697,15 @@ static const struct panel_desc auo_b101uan08_3_desc = {
>  };
>  
>  static const struct drm_display_mode boe_tv105wum_nw0_default_mode = {
> -	.clock = 159260,
> +	.clock = 159916,
>  	.hdisplay = 1200,
>  	.hsync_start = 1200 + 80,
>  	.hsync_end = 1200 + 80 + 24,
>  	.htotal = 1200 + 80 + 24 + 60,
>  	.vdisplay = 1920,
> -	.vsync_start = 1920 + 10,
> -	.vsync_end = 1920 + 10 + 2,
> -	.vtotal = 1920 + 10 + 2 + 14,
> +	.vsync_start = 1920 + 20,
> +	.vsync_end = 1920 + 20 + 4,
> +	.vtotal = 1920 + 20 + 4 + 10,
>  	.vrefresh = 60,
>  	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
>  };
> -- 
> 2.17.1
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
