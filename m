Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDAEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9854F2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hiN6V5fY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgFVPUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbgFVPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:20:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:20:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so3592670wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bvM9454sRyA92BdNMIYVPsWeTtYzc5gscpDaZUrZXIM=;
        b=hiN6V5fYiV42xZzkshiJzCPOup3DMGX/aE+Org/kcuCAhPN+c17r5f53SNVsKPtzto
         R01HBTBg8CJwAeAApPlU2GucRPaUgoalhvObh14ZrrdEZmnXzKU/T65mEXz58pPpGBfH
         qx8G5Ho41ica8wIzh+bEmk8UXvVnzV9ydEzdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bvM9454sRyA92BdNMIYVPsWeTtYzc5gscpDaZUrZXIM=;
        b=Unhh8SiZHRUaTceemec4EwSEZgVwoDaoNGk+fAUdnx6X7ayD7E+yyqTpfw614rFjZ3
         rt/++UuSOec5L18baVVTosaRDbA4757yNcuigO+qt6HlEYehOvESCIKH7VEFS4AbU0Em
         7guBgzNQqs1dV0ckXL+Px7vseiPGiNxAxeuCiukyYRTSsvy/SgoG26e4ciPdDGO27dj8
         XuxnmJZeaxo46lp92fEzeSwVYK+hhEME3n4zJa+GLJUyHg0VNanzHBClFGb9i19CiYtJ
         fd5ZQIcK84qi7ScTUz5o/kOQsQBdcVxkpAqeurwTWxAv7XJ/H57spyJB7AeURMdDjbKt
         6Fig==
X-Gm-Message-State: AOAM530H3C02SiuaOBwtsGbCf4haJdXxfgd86vbt82YQsZKRPkseztt9
        d8XITgiVX2oR73ZtLMuyp6B59Q==
X-Google-Smtp-Source: ABdhPJzuBniBAoKdpG7zL5Yjc2gC4M7NaH//NmLtjnw9ouao4w7jITuLZrfsFG4STEoZTaEt2XSUzw==
X-Received: by 2002:a1c:308:: with SMTP id 8mr18004734wmd.125.1592839216124;
        Mon, 22 Jun 2020 08:20:16 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id t5sm11677978wmj.37.2020.06.22.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:20:15 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:20:14 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yongqiang.niu@mediatek.com
Subject: Re: [PATCH v2] drm/mediatek: check plane visibility in atomic_update
Message-ID: <20200622152014.GA260716@chromium.org>
References: <20200622150109.91205-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622150109.91205-1-hsinyi@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On Mon, Jun 22, 2020 at 11:01:09PM +0800, Hsin-Yi Wang wrote:
> Disable the plane if it's not visible. Otherwise mtk_ovl_layer_config()
> would proceed with invalid plane and we may see vblank timeout.
> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
> v2: Add fixes tag
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 

Thank you for the patch. Please see my comments inline.

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> index c2bd683a87c8..74dc71c7f3b6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -164,6 +164,16 @@ static int mtk_plane_atomic_check(struct drm_plane *plane,
>  						   true, true);
>  }
>  
> +static void mtk_plane_atomic_disable(struct drm_plane *plane,
> +				     struct drm_plane_state *old_state)
> +{
> +	struct mtk_plane_state *state = to_mtk_plane_state(plane->state);
> +
> +	state->pending.enable = false;
> +	wmb(); /* Make sure the above parameter is set before update */
> +	state->pending.dirty = true;
> +}
> +
>  static void mtk_plane_atomic_update(struct drm_plane *plane,
>  				    struct drm_plane_state *old_state)
>  {
> @@ -178,6 +188,9 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
>  	if (!crtc || WARN_ON(!fb))
>  		return;
>  
> +	if (!plane->state->visible)
> +		return mtk_plane_atomic_disable(plane, old_state);

nit: Both this function and mtk_plane_atomic_disable() have the void return
type. Perhaps we should rather move the return, without a value, to a
separate statement?

Best regards,
Tomasz
