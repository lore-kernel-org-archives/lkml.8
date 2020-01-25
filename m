Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B4C35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 06:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628A32071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 06:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgAYGMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 01:12:43 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:55026 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAYGMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 01:12:42 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id AD421200BF;
        Sat, 25 Jan 2020 07:12:37 +0100 (CET)
Date:   Sat, 25 Jan 2020 07:12:36 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: Fix boe,tv101wum-n53 htotal timing
Message-ID: <20200125061236.GA25729@ravnborg.org>
References: <20200125050256.107404-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125050256.107404-1-drinkcat@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8
        a=O7XAfuiZUNRsPy4Z4nUA:9 a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas.

On Sat, Jan 25, 2020 at 01:02:56PM +0800, Nicolas Boichat wrote:
> The datasheet suggests 60 for tHFP, so let's adjust the number
> accordingly.
> 
> This also makes the framerate be 60Hz as intended:
> 159916.0 * 1000 / ((1200 + 80 + 24 + 60)*(1920 + 20 + 4 + 10))
> => 60.00 Hz
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Thanks. Added Fixes: tag and applied to drm-misc-next.

	Sam


> 
> ---
> 
> This also matches the values that we use in our chromeos-4.19
> vendor kernel.
> 
> Applies on top or drm-misc/drm-misc-next.
> 
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 01faf8597700005..48a164257d18c35 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -645,7 +645,7 @@ static const struct drm_display_mode boe_tv101wum_n53_default_mode = {
>  	.hdisplay = 1200,
>  	.hsync_start = 1200 + 80,
>  	.hsync_end = 1200 + 80 + 24,
> -	.htotal = 1200 + 80 + 24 + 40,
> +	.htotal = 1200 + 80 + 24 + 60,
>  	.vdisplay = 1920,
>  	.vsync_start = 1920 + 20,
>  	.vsync_end = 1920 + 20 + 4,
> -- 
> 2.25.0.341.g760bfbb309-goog
