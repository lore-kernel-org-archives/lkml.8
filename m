Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D0C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842DB20704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDYPoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:44:02 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:48752 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgDYPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 11:44:01 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id AB86A20089;
        Sat, 25 Apr 2020 17:43:58 +0200 (CEST)
Date:   Sat, 25 Apr 2020 17:43:57 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] panel: simple: Add BOE NV133FHM-N61
Message-ID: <20200425154357.GJ32235@ravnborg.org>
References: <20200420215742.1927498-1-bjorn.andersson@linaro.org>
 <20200420215742.1927498-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420215742.1927498-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=KKAkSRfTAAAA:8 a=e5mUnYsNAAAA:8
        a=ZHUanIRT7T1iIWuw79kA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 02:57:42PM -0700, Bjorn Andersson wrote:
> The BOE NV133FHM-N61 panel is a 13.3" 1920x1080 eDP panel, add support
> for it in panel-simple.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

While applying I fixed so boe_nv133fhm_n61 is defined before boe_nv140fhmn49.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-simple.c | 33 ++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 3ad828eaefe1..5b92583bccdf 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1124,6 +1124,36 @@ static const struct panel_desc boe_nv140fhmn49 = {
>  	.connector_type = DRM_MODE_CONNECTOR_eDP,
>  };
>  
> +static const struct drm_display_mode boe_nv133fhm_n61_modes = {
> +	.clock = 147840,
> +	.hdisplay = 1920,
> +	.hsync_start = 1920 + 48,
> +	.hsync_end = 1920 + 48 + 32,
> +	.htotal = 1920 + 48 + 32 + 200,
> +	.vdisplay = 1080,
> +	.vsync_start = 1080 + 3,
> +	.vsync_end = 1080 + 3 + 6,
> +	.vtotal = 1080 + 3 + 6 + 31,
> +	.vrefresh = 60,
> +};
> +
> +static const struct panel_desc boe_nv133fhm_n61 = {
> +	.modes = &boe_nv133fhm_n61_modes,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 300,
> +		.height = 187,
> +	},
> +	.delay = {
> +		.hpd_absent_delay = 200,
> +		.unprepare = 500,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DATA_MSB_TO_LSB,
> +	.connector_type = DRM_MODE_CONNECTOR_eDP,
> +};
> +
>  static const struct drm_display_mode cdtech_s043wq26h_ct7_mode = {
>  	.clock = 9000,
>  	.hdisplay = 480,
> @@ -3478,6 +3508,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "boe,nv101wxmn51",
>  		.data = &boe_nv101wxmn51,
> +	}, {
> +		.compatible = "boe,nv133fhm-n61",
> +		.data = &boe_nv133fhm_n61,
>  	}, {
>  		.compatible = "boe,nv140fhmn49",
>  		.data = &boe_nv140fhmn49,
> -- 
> 2.26.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
