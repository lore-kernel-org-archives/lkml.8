Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3223DC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0935F204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMgJuSsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGNHea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:34:30 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5189C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:34:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id br7so6681472ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TyuW/xx8h+jTjzlNFqQOSd3i2+037YbxhESnvjt0MIs=;
        b=KMgJuSsNbNKH1EnVeb9w5Z2ElHZ3z+MbR2X1oeE5Mzqpg64n0X+7DWTmhPpYtFOqRe
         zpuIPE3q56w1zaBqMG3Ypq9y2uAXwiN006UBg23VDE8UfPRcRRFeK67BlOyuVcF8fHKk
         z2llW9leHnVkHKhU72uQrIXSHvruWaaocQdIVoKs3Z7xA34ajK8hTp6MQ0ru+663Ifbr
         1D9ljjJ2kv9d60TnTTS0B//pYsNPr37qNLgRBANKamFlCTCBzSKLoD+VIB5eG50UUlzo
         2s8JY1vlOFF4aat5PqZj3Ojgl9TnINAWk9zdC1hAWleCZc7mKKHxhCwdoJpVx38gPvjZ
         Sa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TyuW/xx8h+jTjzlNFqQOSd3i2+037YbxhESnvjt0MIs=;
        b=QwYuU8WTyrvVKG6+F5Uk6cjAqPelwO81sZB/7rQ93+mvUXFgsyrkgiGzxVEijkl+Kr
         Q0TydwqcJADl6kKZlkKORL83UzRO+ujcu2jXMcvY+E74mq01kFeipAUpGbppIYq9Ac64
         +eUjZKzhK21Fr+vkMP0oGrJjOLsbKuCoS31+yPp0TNJjzwepVvpjX/yga+DeBxTrwYl+
         IKFsg/GH9K0yqfYchnI0hs2rEhPZdLcEVhUkEuakm5dx8EKV4T0y1/SEeB/dFVP3EYcf
         6mhLS68xwAz2duxIJTfAT0/Ftec1YWmp2yeEQzajVAPjviutDHSCwPXia4pLRZmUCnq5
         /rFQ==
X-Gm-Message-State: AOAM531ovu5XEM40JwrGOAjx/WlheXGQnptAKIwgluZtIKKs7IePtJn0
        qcXBPY6myRsDIAequBlOTw==
X-Google-Smtp-Source: ABdhPJwLOzjABQV7Ob/I0kV2RhekApL/K1oLHY6aUbvzexJwglH9ehWzE6LFPNHCeX1E8VDNBBDfEA==
X-Received: by 2002:a17:906:d057:: with SMTP id bo23mr3382304ejb.210.1594712068469;
        Tue, 14 Jul 2020 00:34:28 -0700 (PDT)
Received: from ?IPv6:2a02:810b:f40:e00:2885:810e:fc9c:eda1? ([2a02:810b:f40:e00:2885:810e:fc9c:eda1])
        by smtp.gmail.com with ESMTPSA id cc9sm14628859edb.14.2020.07.14.00.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 00:34:27 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] drm: rockchip: add NV15, NV20 and NV30 support
To:     Jonas Karlman <jonas@kwiboo.se>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Davis <ben.davis@arm.com>
References: <20200607202521.18438-1-jonas@kwiboo.se>
 <20200706223009.1200-1-jonas@kwiboo.se>
 <20200706223009.1200-3-jonas@kwiboo.se>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <45143339-1efc-4709-1782-466e7923d7ea@gmail.com>
Date:   Tue, 14 Jul 2020 09:34:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706223009.1200-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

Am 07.07.20 um 00:30 schrieb Jonas Karlman:
> Add support for displaying 10-bit 4:2:0 and 4:2:2 formats produced by the
> Rockchip Video Decoder on RK322X, RK3288, RK3328, RK3368 and RK3399.
> Also add support for 10-bit 4:4:4 format while at it.
>
> V2: Added NV30 support
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Sandy Huang <hjc@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 29 +++++++++++++++++--
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 32 +++++++++++++++++----
>   3 files changed, 54 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index c80f7d9fd13f..eb663e25ad9e 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -261,6 +261,18 @@ static bool has_rb_swapped(uint32_t format)
>   	}
>   }
>   
> +static bool is_fmt_10(uint32_t format)
> +{
> +	switch (format) {
> +	case DRM_FORMAT_NV15:
> +	case DRM_FORMAT_NV20:
> +	case DRM_FORMAT_NV30:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static enum vop_data_format vop_convert_format(uint32_t format)
>   {
>   	switch (format) {
> @@ -276,10 +288,13 @@ static enum vop_data_format vop_convert_format(uint32_t format)
>   	case DRM_FORMAT_BGR565:
>   		return VOP_FMT_RGB565;
>   	case DRM_FORMAT_NV12:
> +	case DRM_FORMAT_NV15:
>   		return VOP_FMT_YUV420SP;
>   	case DRM_FORMAT_NV16:
> +	case DRM_FORMAT_NV20:
>   		return VOP_FMT_YUV422SP;
>   	case DRM_FORMAT_NV24:
> +	case DRM_FORMAT_NV30:
>   		return VOP_FMT_YUV444SP;
>   	default:
>   		DRM_ERROR("unsupported format[%08x]\n", format);
> @@ -922,7 +937,12 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>   	dsp_sty = dest->y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
>   	dsp_st = dsp_sty << 16 | (dsp_stx & 0xffff);
>   
> -	offset = (src->x1 >> 16) * fb->format->cpp[0];
> +	if (fb->format->block_w[0])
> +		offset = (src->x1 >> 16) * fb->format->char_per_block[0] /
> +			 fb->format->block_w[0];
> +	else
> +		offset = (src->x1 >> 16) * fb->format->cpp[0];
> +
>   	offset += (src->y1 >> 16) * fb->pitches[0];
>   	dma_addr = rk_obj->dma_addr + offset + fb->offsets[0];
>   
> @@ -948,6 +968,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>   	}
>   
>   	VOP_WIN_SET(vop, win, format, format);
> +	VOP_WIN_SET(vop, win, fmt_10, is_fmt_10(fb->format->format));
>   	VOP_WIN_SET(vop, win, yrgb_vir, DIV_ROUND_UP(fb->pitches[0], 4));
>   	VOP_WIN_SET(vop, win, yrgb_mst, dma_addr);
>   	VOP_WIN_YUV2YUV_SET(vop, win_yuv2yuv, y2r_en, is_yuv);
> @@ -964,7 +985,11 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>   		uv_obj = fb->obj[1];
>   		rk_uv_obj = to_rockchip_obj(uv_obj);
>   
> -		offset = (src->x1 >> 16) * bpp / hsub;
> +		if (fb->format->block_w[1])
> +			offset = (src->x1 >> 16) * bpp /
> +				 fb->format->block_w[1] / hsub;
> +		else
> +			offset = (src->x1 >> 16) * bpp / hsub;
>   		offset += (src->y1 >> 16) * fb->pitches[1] / vsub;
>   
>   		dma_addr = rk_uv_obj->dma_addr + offset + fb->offsets[1];
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> index 4a2099cb582e..eab055d9b56d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> @@ -154,6 +154,7 @@ struct vop_win_phy {
>   	struct vop_reg enable;
>   	struct vop_reg gate;
>   	struct vop_reg format;
> +	struct vop_reg fmt_10;
>   	struct vop_reg rb_swap;
>   	struct vop_reg act_info;
>   	struct vop_reg dsp_info;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index 80053d91a301..2c55e1852c3d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -50,6 +50,23 @@ static const uint32_t formats_win_full[] = {
>   	DRM_FORMAT_NV24,
>   };
>   
> +static const uint32_t formats_win_full_10[] = {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_BGR888,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_BGR565,
> +	DRM_FORMAT_NV12,
> +	DRM_FORMAT_NV16,
> +	DRM_FORMAT_NV24,
> +	DRM_FORMAT_NV15,
> +	DRM_FORMAT_NV20,
> +	DRM_FORMAT_NV30,
> +};
> +
>   static const uint64_t format_modifiers_win_full[] = {
>   	DRM_FORMAT_MOD_LINEAR,
>   	DRM_FORMAT_MOD_INVALID,
> @@ -579,11 +596,12 @@ static const struct vop_scl_regs rk3288_win_full_scl = {
>   
>   static const struct vop_win_phy rk3288_win01_data = {
>   	.scl = &rk3288_win_full_scl,
> -	.data_formats = formats_win_full,
> -	.nformats = ARRAY_SIZE(formats_win_full),
> +	.data_formats = formats_win_full_10,
> +	.nformats = ARRAY_SIZE(formats_win_full_10),
>   	.format_modifiers = format_modifiers_win_full,
>   	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
>   	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
> +	.fmt_10 = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 4),
>   	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
>   	.act_info = VOP_REG(RK3288_WIN0_ACT_INFO, 0x1fff1fff, 0),
>   	.dsp_info = VOP_REG(RK3288_WIN0_DSP_INFO, 0x0fff0fff, 0),
> @@ -713,11 +731,12 @@ static const struct vop_intr rk3368_vop_intr = {
>   
>   static const struct vop_win_phy rk3368_win01_data = {
>   	.scl = &rk3288_win_full_scl,
> -	.data_formats = formats_win_full,
> -	.nformats = ARRAY_SIZE(formats_win_full),
> +	.data_formats = formats_win_full_10,
> +	.nformats = ARRAY_SIZE(formats_win_full_10),
>   	.format_modifiers = format_modifiers_win_full,
>   	.enable = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 0),
>   	.format = VOP_REG(RK3368_WIN0_CTRL0, 0x7, 1),
> +	.fmt_10 = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 4),
>   	.rb_swap = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 12),
>   	.x_mir_en = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 21),
>   	.y_mir_en = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 22),

As per TRM/datasheet RK3368's VOP does not support 10-bit color formats.

Therefore data_formats should be kept at formats_win_full here.

> @@ -862,11 +881,12 @@ static const struct vop_win_yuv2yuv_data rk3399_vop_big_win_yuv2yuv_data[] = {
>   
>   static const struct vop_win_phy rk3399_win01_data = {
>   	.scl = &rk3288_win_full_scl,
> -	.data_formats = formats_win_full,
> -	.nformats = ARRAY_SIZE(formats_win_full),
> +	.data_formats = formats_win_full_10,
> +	.nformats = ARRAY_SIZE(formats_win_full_10),
>   	.format_modifiers = format_modifiers_win_full_afbc,
>   	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
>   	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
> +	.fmt_10 = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 4),
>   	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
>   	.y_mir_en = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 22),
>   	.act_info = VOP_REG(RK3288_WIN0_ACT_INFO, 0x1fff1fff, 0),

Regards,

Alex

