Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E6C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8084A20714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGZQ7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:59:44 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51610 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZQ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:59:44 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B617C804BA;
        Sun, 26 Jul 2020 18:59:40 +0200 (CEST)
Date:   Sun, 26 Jul 2020 18:59:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        huijuan.xie@mediatek.com, stonea168@163.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] drm/panel: Fix auo, kd101n80-45na horizontal noise on
 edges of panel
Message-ID: <20200726165939.GA3275923@ravnborg.org>
References: <20200714123332.37609-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714123332.37609-1-jitao.shi@mediatek.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=mpaa-ttXAAAA:8 a=UV5ITszz9WeBkyDU53UA:9
        a=CjuIK1q_8ugA:10 a=6heAxKwa5pAsJatQ0mat:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:33:32PM +0800, Jitao Shi wrote:
> Fine tune the HBP and HFP to avoid the dot noise on the left and right edges.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 48a164257d18..3edb33e61908 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -615,9 +615,9 @@ static const struct panel_desc boe_tv101wum_nl6_desc = {
>  static const struct drm_display_mode auo_kd101n80_45na_default_mode = {
>  	.clock = 157000,
>  	.hdisplay = 1200,
> -	.hsync_start = 1200 + 80,
> -	.hsync_end = 1200 + 80 + 24,
> -	.htotal = 1200 + 80 + 24 + 36,
> +	.hsync_start = 1200 + 60,
> +	.hsync_end = 1200 + 60 + 24,
> +	.htotal = 1200 + 60 + 24 + 56,
>  	.vdisplay = 1920,
>  	.vsync_start = 1920 + 16,
>  	.vsync_end = 1920 + 16 + 4,

Applied to drm-misc-fixes.

	Sam
