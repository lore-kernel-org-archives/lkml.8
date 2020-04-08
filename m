Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF5C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68491206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgDHUWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:22:35 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47732 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgDHUWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:22:35 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id DA9F780516;
        Wed,  8 Apr 2020 22:22:32 +0200 (CEST)
Date:   Wed, 8 Apr 2020 22:22:31 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Lu <david.lu@bitland.com.cn>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jungle.chiang@bitland.com.cn,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-n16: extend LCD support list
Message-ID: <20200408202231.GC612@ravnborg.org>
References: <20200324075734.1802-1-david.lu@bitland.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324075734.1802-1-david.lu@bitland.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=iKCrp2iyAAAA:8
        a=e5mUnYsNAAAA:8 a=he46yxwc6qcuFeRiDoMA:9 a=CjuIK1q_8ugA:10
        a=6dnM-gFdnRAg0d82BWIM:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

On Tue, Mar 24, 2020 at 03:57:34PM +0800, David Lu wrote:
> Add entries for BOE TV105WUM-NW0 10.5" WUXGA TFT LCD panel.
> 
> Signed-off-by: David Lu <david.lu@bitland.com.cn>
> Change-Id: I5b1cef259de5fb498220dcc47baa035083c41667
Deleted Change-Id, and updated subject as suggested by Nicholas.
Applied to drm-misc-next and pushed out.

	Sam

> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 48a164257d18..f89861c8598a 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -696,6 +696,34 @@ static const struct panel_desc auo_b101uan08_3_desc = {
>  	.init_cmds = auo_b101uan08_3_init_cmd,
>  };
>  
> +static const struct drm_display_mode boe_tv105wum_nw0_default_mode = {
> +	.clock = 159260,
> +	.hdisplay = 1200,
> +	.hsync_start = 1200 + 80,
> +	.hsync_end = 1200 + 80 + 24,
> +	.htotal = 1200 + 80 + 24 + 60,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 10,
> +	.vsync_end = 1920 + 10 + 2,
> +	.vtotal = 1920 + 10 + 2 + 14,
> +	.vrefresh = 60,
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct panel_desc boe_tv105wum_nw0_desc = {
> +	.modes = &boe_tv105wum_nw0_default_mode,
> +	.bpc = 8,
> +	.size = {
> +		.width_mm = 141,
> +		.height_mm = 226,
> +	},
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_MODE_LPM,
> +	.init_cmds = boe_init_cmd,
> +};
> +
>  static int boe_panel_get_modes(struct drm_panel *panel,
>  			       struct drm_connector *connector)
>  {
> @@ -834,6 +862,9 @@ static const struct of_device_id boe_of_match[] = {
>  	{ .compatible = "auo,b101uan08.3",
>  	  .data = &auo_b101uan08_3_desc
>  	},
> +	{ .compatible = "boe,tv105wum-nw0",
> +	  .data = &boe_tv105wum_nw0_desc
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, boe_of_match);
> -- 
> 2.24.1
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
