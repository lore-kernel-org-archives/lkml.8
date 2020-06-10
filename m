Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588A5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E79207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgFJPBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:01:02 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:41996 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgFJPBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:01:02 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E177480615;
        Wed, 10 Jun 2020 17:00:59 +0200 (CEST)
Date:   Wed, 10 Jun 2020 17:00:58 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/panel: simple: add Tianma TM070JVHG33
Message-ID: <20200610150058.GB135509@ravnborg.org>
References: <20200610120131.3069-1-matthias.schiffer@ew.tq-group.com>
 <20200610120131.3069-5-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610120131.3069-5-matthias.schiffer@ew.tq-group.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=G88y7es5 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8f9FM25-AAAA:8 a=MJQEDvMior-I7x-TAk4A:9
        a=CjuIK1q_8ugA:10 a=uSNRK0Bqq4PXrUp6LDpb:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias.

Thanks,
also a few details here to fix.

	Sam

On Wed, Jun 10, 2020 at 02:01:31PM +0200, Matthias Schiffer wrote:
> From: Max Merchel <Max.Merchel@tq-group.com>
> 
> Add support for the Tianma Micro-electronics TM070JVHG33 7.0" WXGA display
> to panel-simple.
> 
> Signed-off-by: Max Merchel <Max.Merchel@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 1673113e5a5a..68fcf68da1f3 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3421,6 +3421,17 @@ static const struct panel_desc tianma_tm070jdhg30 = {
>  	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>  };
>  
> +static const struct panel_desc tianma_tm070jvhg33 = {
> +	.timings = &tianma_tm070jdhg30_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 150,
> +		.height = 94,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
.bus_flags??
And again .connector_type.

	Sam

> +};
> +
>  static const struct display_timing tianma_tm070rvhg71_timing = {
>  	.pixelclock = { 27700000, 29200000, 39600000 },
>  	.hactive = { 800, 800, 800 },
> @@ -4029,6 +4040,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "tianma,tm070jdhg30",
>  		.data = &tianma_tm070jdhg30,
> +	}, {
> +		.compatible = "tianma,tm070jvhg33",
> +		.data = &tianma_tm070jvhg33,
>  	}, {
>  		.compatible = "tianma,tm070rvhg71",
>  		.data = &tianma_tm070rvhg71,
> -- 
> 2.17.1
