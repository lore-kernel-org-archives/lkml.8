Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFE8C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AE520656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgD0IlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:41:20 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:59904 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgD0IlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:41:19 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 23D6720037;
        Mon, 27 Apr 2020 10:41:14 +0200 (CEST)
Date:   Mon, 27 Apr 2020 10:41:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panel: simple: Add Newhaven ATXL#-CTP panel
Message-ID: <20200427084108.GA21216@ravnborg.org>
References: <1587975709-2092-1-git-send-email-gareth.williams.jx@renesas.com>
 <1587975709-2092-4-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587975709-2092-4-git-send-email-gareth.williams.jx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=yC-0_ovQAAAA:8 a=MtrMpk1ate3mC_r31NwA:9
        a=CjuIK1q_8ugA:10 a=QsnFDINu91a9xkgZirup:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gareth.

Looking forward to see the other patches - they seem to be stuck
awaiting approval.

A few comments in the following.

	Sam

On Mon, Apr 27, 2020 at 09:21:49AM +0100, Gareth Williams wrote:
> This commit adds support for the Newhaven ATXL#-CTP panel used by the
> Renesas RZ/N1 Demo Board.
> 
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 5a93c4e..0b57b0e 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2021,6 +2021,30 @@ static const struct panel_desc newhaven_nhd_43_480272ef_atxl = {
>  		     DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE,
>  };
>  
> +static const struct display_timing newhaven_nhd_50_800480tf_atxl_timing = {
> +	.pixelclock = { 33300000, 33400000, 33500000 },
> +	.hactive = { 800, 800, 800 },
> +	.hfront_porch = { 40, 40, 40 },
> +	.hback_porch = { 88, 88, 88 },
> +	.hsync_len = { 1, 1, 1 },
> +	.vactive = { 480, 480, 480 },
> +	.vfront_porch = { 13, 13, 13 },
> +	.vback_porch = { 32, 32, 32 },
> +	.vsync_len = { 3, 3, 3 },
> +	.flags = DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH,
> +};
> +
> +static const struct panel_desc newhaven_nhd_50_800480tf_atxl = {
> +		.timings = &newhaven_nhd_50_800480tf_atxl_timing,
> +		.num_timings = 1,
> +		.bpc = 8,
> +		.size = {
> +			.width = 400,
> +			.height = 300,
> +		},
> +		.bus_flags = DRM_BUS_FLAG_DE_HIGH,
Please add DRM_BUS_FLAG_PIXDATA too - as I assume this is an LVDS panel.

> +};
For new panels .connector_type is mandatory.


> +
>  static const struct display_timing nlt_nl192108ac18_02d_timing = {
>  	.pixelclock = { 130000000, 148350000, 163000000 },
>  	.hactive = { 1920, 1920, 1920 },
> @@ -2964,6 +2988,9 @@ static const struct of_device_id platform_of_match[] = {
>  		.compatible = "newhaven,nhd-4.3-480272ef-atxl",
>  		.data = &newhaven_nhd_43_480272ef_atxl,
>  	}, {
> +		.compatible = "newhaven,nhd-5.0-800480tf-atxl",
> +		.data = &newhaven_nhd_50_800480tf_atxl,
> +	}, {

I did not see the other patches - so this is maybe covered.
But newhaven,nhd-5.0-800480tf-atxl must be documented in
panel-simple.yaml before we can apply this.

	Sam

>  		.compatible = "nlt,nl192108ac18-02d",
>  		.data = &nlt_nl192108ac18_02d,
>  	}, {
> -- 
> 2.7.4
