Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4061C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FD920758
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgGGLp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:45:59 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:41686 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgGGLp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:45:58 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 5B2E2C5E20;
        Tue,  7 Jul 2020 19:45:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from [172.16.12.76] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P6414T140040252917504S1594122354512473_;
        Tue, 07 Jul 2020 19:45:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <300cd0b1a0c0d271cb68e5e4f6176328>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_2/2=5d_drm=3a_rockchip=3a_add_NV15=2c_N?=
 =?UTF-8?B?VjIwIGFuZCBOVjMwIHN1cHBvcnTjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFsaW51?=
 =?UTF-8?Q?x-rockchip-bounces+sandy=2ehuang=3drock-chips=2ecom=40lists=2einf?=
 =?UTF-8?B?cmFkZWFkLm9yZ+S7o+WPkeOAkQ==?=
To:     Jonas Karlman <jonas@kwiboo.se>,
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
From:   Huang Jiachai <hjc@rock-chips.com>
Message-ID: <d639a703-f382-1760-b339-afec70e0e9b9@rock-chips.com>
Date:   Tue, 7 Jul 2020 19:45:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706223009.1200-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/7/7 6:30, Jonas Karlman 写道:
> Add support for displaying 10-bit 4:2:0 and 4:2:2 formats produced by the
> Rockchip Video Decoder on RK322X, RK3288, RK3328, RK3368 and RK3399.
> Also add support for 10-bit 4:4:4 format while at it.
>
> V2: Added NV30 support
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
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

Reviewed-by: Sandy Huang <hjc@rock-chips.com>

-- 
Best Regard

黄家钗
Sandy Huang
Addr: 福州市鼓楼区铜盘路软件大道89号福州软件园A区21号楼(350003)
       No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
Tel：+86 0591-87884919  8690
E-mail：hjc@rock-chips.com



