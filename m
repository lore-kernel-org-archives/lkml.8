Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C67C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF21C20759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbgF3Lfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:35:48 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:42248 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgF3Lfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:35:47 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id BFD1E8053C;
        Tue, 30 Jun 2020 13:35:43 +0200 (CEST)
Date:   Tue, 30 Jun 2020 13:35:42 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, od@zcrc.me, stable@vger.kernel.org
Subject: Re: [PATCH v2 05/10] drm/ingenic: Fix incorrect assumption about
 plane->index
Message-ID: <20200630113542.GA560155@ravnborg.org>
References: <20200629235210.441709-1-paul@crapouillou.net>
 <20200629235210.441709-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629235210.441709-5-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=ER_8r6IbAAAA:8 a=7gkXJVJtAAAA:8
        a=e5mUnYsNAAAA:8 a=h8Z_pZuLarzTNQul7jAA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=9LHmKk7ezEChjTCyhBa9:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 01:52:05AM +0200, Paul Cercueil wrote:
> plane->index is NOT the index of the color plane in a YUV frame.
> Actually, a YUV frame is represented by a single drm_plane, even though
> it contains three Y, U, V planes.
> 
> Cc: stable@vger.kernel.org # v5.3
> Fixes: 90b86fcc47b4 ("DRM: Add KMS driver for the Ingenic JZ47xx SoCs")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Look correct to me.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
As this is tagged fixes: I assume this is for drm-misc-fixes and
not for drm-misc-next.
If you resend could you move it as patch 1/10 so this is more obvious.

	Sam
> ---
> 
> Notes:
>     v2: No change
> 
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index a15f9a1940c6..924c8daf071a 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -386,7 +386,7 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
>  		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
>  		width = state->src_w >> 16;
>  		height = state->src_h >> 16;
> -		cpp = state->fb->format->cpp[plane->index];
> +		cpp = state->fb->format->cpp[0];
>  
>  		priv->dma_hwdesc->addr = addr;
>  		priv->dma_hwdesc->cmd = width * height * cpp / 4;
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
