Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D189AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29BB246B9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mxrD3pbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgCBJ72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:59:28 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51506 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCBJ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:59:28 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 71BF454A;
        Mon,  2 Mar 2020 10:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583143166;
        bh=5i4HpQvtX4R1slyHT+952QHgBdgl3htQsX3B0F6Xj3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxrD3pbc3SRTjb14W8QJAbbVj9qN5FxqkZyS8CiumvpluJv2iFvSkaxTRyZ5vW9ZZ
         8TQMjaLKgs1gdZJ3P99IYfZSnkXezeOC4NjklKpumGr8Kl82afPcRBDFwa82isRnNh
         C4DcfimCx1B2bep+2jvjye2CSNiqYN5FGn+aeraU=
Date:   Mon, 2 Mar 2020 11:59:02 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com, linux-amlogic@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/11] drm/meson: venc: make drm_display_mode const
Message-ID: <20200302095902.GA16626@pendragon.ideasonboard.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
 <20200206191834.6125-7-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206191834.6125-7-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Thank you for the patch.

On Thu, Feb 06, 2020 at 08:18:29PM +0100, Neil Armstrong wrote:
> Before switching to bridge funcs, make sure drm_display_mode is passed
> as const to the venc functions.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/meson/meson_venc.c | 2 +-
>  drivers/gpu/drm/meson/meson_venc.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 4efd7864d5bf..a9ab78970bfe 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -946,7 +946,7 @@ bool meson_venc_hdmi_venc_repeat(int vic)
>  EXPORT_SYMBOL_GPL(meson_venc_hdmi_venc_repeat);
>  
>  void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
> -			      struct drm_display_mode *mode)
> +			      const struct drm_display_mode *mode)
>  {
>  	union meson_hdmi_venc_mode *vmode = NULL;
>  	union meson_hdmi_venc_mode vmode_dmt;
> diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
> index 576768bdd08d..1abdcbdf51c0 100644
> --- a/drivers/gpu/drm/meson/meson_venc.h
> +++ b/drivers/gpu/drm/meson/meson_venc.h
> @@ -60,7 +60,7 @@ extern struct meson_cvbs_enci_mode meson_cvbs_enci_ntsc;
>  void meson_venci_cvbs_mode_set(struct meson_drm *priv,
>  			       struct meson_cvbs_enci_mode *mode);
>  void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
> -			      struct drm_display_mode *mode);
> +			      const struct drm_display_mode *mode);
>  unsigned int meson_venci_get_field(struct meson_drm *priv);
>  
>  void meson_venc_enable_vsync(struct meson_drm *priv);

-- 
Regards,

Laurent Pinchart
