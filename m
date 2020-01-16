Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD95C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251F42064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbgAPUFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:05:24 -0500
Received: from mailoutvs53.siol.net ([185.57.226.244]:40873 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730357AbgAPUFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:05:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A5E355243C8;
        Thu, 16 Jan 2020 21:05:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pO70ArcDTR1J; Thu, 16 Jan 2020 21:05:20 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 3912A5243C0;
        Thu, 16 Jan 2020 21:05:20 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id A29E85243C8;
        Thu, 16 Jan 2020 21:05:19 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        roman.stratiienko@globallogic.com
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: Re: [PATCH v3 2/2] drm/sun4i: Add alpha property for sun8i and sun50i VI layer
Date:   Thu, 16 Jan 2020 21:05:19 +0100
Message-ID: <2397109.Lt9SDvczpP@jernej-laptop>
In-Reply-To: <20200103211901.44201-2-roman.stratiienko@globallogic.com>
References: <20200103211901.44201-1-roman.stratiienko@globallogic.com> <20200103211901.44201-2-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry for late reply.

Dne petek, 03. januar 2020 ob 22:19:01 CET je 
roman.stratiienko@globallogic.com napisal(a):
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> DE3.0 VI layers supports plane-global alpha channel.
> DE2.0 FCC block have GLOBAL_ALPHA register that can be used as alpha source
> for blender.
> 
> Add alpha property to the DRM plane and connect it to the
> corresponding registers in the mixer.
> 
> Do not add alpha property for systems with DE2.0 and more than 1 VI planes.
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>

This looks fine to me.
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej

> ---
> v2: Initial version by mistake
> v3:
> - Skip adding & applying alpha property if VI count > 1
> ---
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 48 +++++++++++++++++++++-----
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 11 ++++++
>  2 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index 42d445d23773..e61aec7d6d07
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -65,6 +65,36 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer
> *mixer, int channel, }
>  }
> 
> +static void sun8i_vi_layer_update_alpha(struct sun8i_mixer *mixer, int
> channel, +					int overlay, struct 
drm_plane *plane)
> +{
> +	u32 mask, val, ch_base;
> +
> +	ch_base = sun8i_channel_base(mixer, channel);
> +
> +	if (mixer->cfg->is_de3) {
> +		mask = SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK |
> +		       SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_MASK;
> +		val = SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA
> +			(plane->state->alpha >> 8);
> +
> +		val |= (plane->state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
> +			
SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_PIXEL :
> +			
SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_COMBINED;
> +
> +		regmap_update_bits(mixer->engine.regs,
> +				   
SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
> +								
  overlay),
> +				   mask, val);
> +	} else if (mixer->cfg->vi_num == 1) {
> +		regmap_update_bits(mixer->engine.regs,
> +				   
SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG,
> +				   
SUN8I_MIXER_FCC_GLOBAL_ALPHA_MASK,
> +				   SUN8I_MIXER_FCC_GLOBAL_ALPHA
> +					(plane->state->alpha >> 
8));
> +	}
> +}
> +
>  static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int
> channel, int overlay, struct drm_plane *plane,
>  				       unsigned int zpos)
> @@ -248,14 +278,6 @@ static int sun8i_vi_layer_update_formats(struct
> sun8i_mixer *mixer, int channel, SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
> overlay),
>  			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, 
val);
> 
> -	/* It seems that YUV formats use global alpha setting. */
> -	if (mixer->cfg->is_de3)
> -		regmap_update_bits(mixer->engine.regs,
> -				   
SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
> -								
  overlay),
> -				   
SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK,
> -				   
SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(0xff));
> -
>  	return 0;
>  }
> 
> @@ -373,6 +395,8 @@ static void sun8i_vi_layer_atomic_update(struct
> drm_plane *plane,
> 
>  	sun8i_vi_layer_update_coord(mixer, layer->channel,
>  				    layer->overlay, plane, zpos);
> +	sun8i_vi_layer_update_alpha(mixer, layer->channel,
> +				    layer->overlay, plane);
>  	sun8i_vi_layer_update_formats(mixer, layer->channel,
>  				      layer->overlay, plane);
>  	sun8i_vi_layer_update_buffer(mixer, layer->channel,
> @@ -464,6 +488,14 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct
> drm_device *drm,
> 
>  	plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
> 
> +	if (mixer->cfg->vi_num == 1 || mixer->cfg->is_de3) {
> +		ret = drm_plane_create_alpha_property(&layer->plane);
> +		if (ret) {
> +			dev_err(drm->dev, "Couldn't add alpha 
property\n");
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
>  	ret = drm_plane_create_zpos_property(&layer->plane, index,
>  					     0, plane_cnt - 
1);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
> b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h index eaa6076f5dbc..48c399e1c86d
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
> @@ -29,14 +29,25 @@
>  #define SUN8I_MIXER_CHAN_VI_VDS_UV(base) \
>  		((base) + 0xfc)
> 
> +#define SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG \
> +		(0xAA000 + 0x90)
> +
> +#define SUN8I_MIXER_FCC_GLOBAL_ALPHA(x)			((x) << 24)
> +#define SUN8I_MIXER_FCC_GLOBAL_ALPHA_MASK		GENMASK(31, 
24)
> +
>  #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN		BIT(0)
>  /* RGB mode should be set for RGB formats and cleared for YCbCr */
>  #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE		BIT(15)
>  #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET	8
>  #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
> +#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
>  #define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
>  #define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(x)	((x) << 24)
> 
> +#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_PIXEL	((0) << 1)
> +#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_LAYER	((1) << 1)
> +#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_COMBINED	((2) << 1)
> +
>  #define SUN8I_MIXER_CHAN_VI_DS_N(x)			((x) << 16)
>  #define SUN8I_MIXER_CHAN_VI_DS_M(x)			((x) << 0)




