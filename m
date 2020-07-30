Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D6EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA38C20842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgG3F1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:27:08 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:42206 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgG3F1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:27:08 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 022F0804D8;
        Thu, 30 Jul 2020 07:27:03 +0200 (CEST)
Date:   Thu, 30 Jul 2020 07:27:02 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/ingenic: ipu: Only restart manually on older SoCs
Message-ID: <20200730052702.GA1429781@ravnborg.org>
References: <20200730014626.83895-1-paul@crapouillou.net>
 <20200730014626.83895-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730014626.83895-2-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=7gkXJVJtAAAA:8
        a=OIODGcd-7M2Q43qThiUA:9 a=tsY6iTuTbHcPZO7O:21 a=fjEtzezOzUu0zJxH:21
        a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:46:24AM +0200, Paul Cercueil wrote:
> On older SoCs, it is necessary to restart manually the IPU when a frame
> is done processing. Doing so on newer SoCs (JZ4760/70) kinds of work
> too, until the input or output resolutions or the framerate are too
> high.
> 
> Make it work properly on newer SoCs by letting the LCD controller
> trigger the IPU frame restart signal.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/ingenic/ingenic-ipu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> index 7a0a8bd865d3..7eae56fa92ea 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> @@ -35,6 +35,7 @@ struct soc_info {
>  	const u32 *formats;
>  	size_t num_formats;
>  	bool has_bicubic;
> +	bool manual_restart;
>  
>  	void (*set_coefs)(struct ingenic_ipu *ipu, unsigned int reg,
>  			  unsigned int sharpness, bool downscale,
> @@ -645,7 +646,8 @@ static irqreturn_t ingenic_ipu_irq_handler(int irq, void *arg)
>  	unsigned int dummy;
>  
>  	/* dummy read allows CPU to reconfigure IPU */
> -	regmap_read(ipu->map, JZ_REG_IPU_STATUS, &dummy);
> +	if (ipu->soc_info->manual_restart)
> +		regmap_read(ipu->map, JZ_REG_IPU_STATUS, &dummy);
>  
>  	/* ACK interrupt */
>  	regmap_write(ipu->map, JZ_REG_IPU_STATUS, 0);
> @@ -656,7 +658,8 @@ static irqreturn_t ingenic_ipu_irq_handler(int irq, void *arg)
>  	regmap_write(ipu->map, JZ_REG_IPU_V_ADDR, ipu->addr_v);
>  
>  	/* Run IPU for the new frame */
> -	regmap_set_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_RUN);
> +	if (ipu->soc_info->manual_restart)
> +		regmap_set_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_RUN);
>  
>  	drm_crtc_handle_vblank(crtc);
>  
> @@ -806,6 +809,7 @@ static const struct soc_info jz4725b_soc_info = {
>  	.formats	= jz4725b_ipu_formats,
>  	.num_formats	= ARRAY_SIZE(jz4725b_ipu_formats),
>  	.has_bicubic	= false,
> +	.manual_restart	= true,
>  	.set_coefs	= jz4725b_set_coefs,
>  };
>  
> @@ -831,6 +835,7 @@ static const struct soc_info jz4760_soc_info = {
>  	.formats	= jz4760_ipu_formats,
>  	.num_formats	= ARRAY_SIZE(jz4760_ipu_formats),
>  	.has_bicubic	= true,
> +	.manual_restart	= false,
>  	.set_coefs	= jz4760_set_coefs,
>  };
>  
> -- 
> 2.27.0
