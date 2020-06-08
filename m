Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F9C206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JfSonrYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgFHDPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 23:15:03 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52862 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgFHDPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 23:15:03 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B78224F;
        Mon,  8 Jun 2020 05:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591586101;
        bh=QV+lOpDHo16YfLuKBoENBe5tM6xEu1jtBHj3UkizTv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JfSonrYL8scdiV0ujrp9dSHanx/mEez8yCzlmmPGHkOSeVuHVmKeJoa/fcTDhnMOo
         3z1YreiphJWoe8mBDNz4NIUuPkYYq2GkVAPs1k45uN+01HsvFVSEgbKnvwBQ0849eQ
         OG4dAoWP+3Pm+35LFCOL0SYCokdrlsUrAIu0/Xzc=
Date:   Mon, 8 Jun 2020 06:14:42 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Qian Cai <cai@lca.pw>
Cc:     kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/rcar-du: DRM_RCAR_WRITEBACK depends on DRM
Message-ID: <20200608031442.GP22208@pendragon.ideasonboard.com>
References: <20200608025340.3050-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200608025340.3050-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

Thank you for the patch.

On Sun, Jun 07, 2020 at 10:53:40PM -0400, Qian Cai wrote:
> There is no need to select DRM_RCAR_WRITEBACK if DRM=n which just make

s/DRM=n/DRM_RCAR_DU=n/ here.

> the generated .config a bit ugly.
> 
>  # ARM devices
>  #
>  # end of ARM devices
> 
>  CONFIG_DRM_RCAR_WRITEBACK=y
> 
>  #
>  # Frame buffer Devices
> 
> Let DRM_RCAR_WRITEBACK depend on DRM_RCAR_DU instead.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

No need to submit a v3 if you agree with the above change, I'll fix it
in my tree.

> ---
>  drivers/gpu/drm/rcar-du/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
> index 0919f1f159a4..3304b41f5611 100644
> --- a/drivers/gpu/drm/rcar-du/Kconfig
> +++ b/drivers/gpu/drm/rcar-du/Kconfig
> @@ -48,3 +48,4 @@ config DRM_RCAR_VSP
>  config DRM_RCAR_WRITEBACK
>  	bool
>  	default y if ARM64
> +	depends on DRM_RCAR_DU

-- 
Regards,

Laurent Pinchart
