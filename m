Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD4EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B96B20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgG3P3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:29:32 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:36560 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3P3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:29:31 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id E27A320038;
        Thu, 30 Jul 2020 17:29:26 +0200 (CEST)
Date:   Thu, 30 Jul 2020 17:29:25 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/ingenic: ipu: Remove YUV422 from supported
 formats on JZ4725B
Message-ID: <20200730152925.GA1474381@ravnborg.org>
References: <20200730144830.10479-1-paul@crapouillou.net>
 <20200730144830.10479-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730144830.10479-3-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=7gkXJVJtAAAA:8
        a=XF-YUntD94uUTtdHvy4A:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul

On Thu, Jul 30, 2020 at 04:48:29PM +0200, Paul Cercueil wrote:
> When configuring the IPU for packed YUV 4:2:2, depending on the scaling
> ratios given by the source and destination resolutions, it is possible
> to crash the IPU block, to the point where a software reset of the IP
> does not fix it. This can happen anytime, in the first few frames, or
> after dozens of minutes. The same crash also happens when the IPU is
> fully controlled by the LCD controller (in that case no HW register is
> written at any moment after startup), which points towards a hardware
> bug.
> 
> Thanksfully multiplanar YUV is not affected.
> 
> Until this bug is fixed or worked around, address this issue by removing
> support for YUV 4:2:2 on the IPU of the JZ4725B.
> 
> v2: Update commit message (remove the "crash beyond repair" bit)
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/ingenic/ingenic-ipu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> index 7eae56fa92ea..7dd2a6ae4994 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> @@ -795,10 +795,16 @@ static int ingenic_ipu_remove(struct platform_device *pdev)
>  }
>  
>  static const u32 jz4725b_ipu_formats[] = {
> +	/*
> +	 * While officially supported, packed YUV 4:2:2 formats can cause
> +	 * random hardware crashes on JZ4725B under certain circumstances.
> +	 * It seems to happen with some specific resize ratios.
> +	 * Until a proper workaround or fix is found, disable these formats.
>  	DRM_FORMAT_YUYV,
>  	DRM_FORMAT_YVYU,
>  	DRM_FORMAT_UYVY,
>  	DRM_FORMAT_VYUY,
> +	*/
>  	DRM_FORMAT_YUV411,
>  	DRM_FORMAT_YUV420,
>  	DRM_FORMAT_YUV422,
> -- 
> 2.27.0
