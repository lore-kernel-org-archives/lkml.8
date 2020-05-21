Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA8C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FEA20826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ID1dvrYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEUPuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUPuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:50:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E07CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:50:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so1746210wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I5QXaX52IPaG+95gPfmlZ0rD63JTAUJslTJmrnwNjQc=;
        b=ID1dvrYmYK5R1R7a0Cw6H9ckAbwIgzD1jEh8cLijWGS6z4cOVQD8npfgacuW3YzbTR
         6p53ASb2F8xqyBMI8KhptHeaQt1pyG6j16NzI19RwIF22j7IKpB1vdhv2vKICxvPmIGS
         L9IwRDjpD8PgKAcggZu7EgMhLsHQK5hYnPirU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I5QXaX52IPaG+95gPfmlZ0rD63JTAUJslTJmrnwNjQc=;
        b=Xe/hf71Ky/xHkSg7dVUqas/OUis3C/k5EJJQ2JLy80G6/Y91Sm/Dtng9ugbw9lAVlj
         gnQGrYXrUQ8W++ULDGLcCTuwY1cMoARYXQAPDsOo0IWyvt2/szZkPIDbZWtekZ31uVlJ
         n8yWUmsaluThhuGa3DkpvWl4J5OgR+e+Afbq5NAl5XeVrSjuA7hN85vsl2KRgxyhFLrz
         RscjghJa1cXJtFiP+eP8gIlIaD6QJ7F8r23UVza2OHToxm7DIquqh0NLMwvDack02BBK
         N3po1V2ZOs64QrMKRrAu17r2F3Xhu7i2GzOH0Rce4Yvm2RjGpU6H5vOmfNpvG+9H0wj7
         9CmQ==
X-Gm-Message-State: AOAM5316tU5Gpne1i7N95V3tEC++c4Yu9Hqi7jlF9F5gP53NK9xOuu+B
        2iZZ+187tTAbgj+IitC7y5fHqg==
X-Google-Smtp-Source: ABdhPJw5KfY6ZCQuAckjsE5E7cfiDb7ScpWMpUV7bgUyKbpKFR20CCu1lyQfVtv8YMw85K8xToqg9w==
X-Received: by 2002:adf:ec87:: with SMTP id z7mr9942589wrn.149.1590076200716;
        Thu, 21 May 2020 08:50:00 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id r3sm6663037wmh.48.2020.05.21.08.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:50:00 -0700 (PDT)
Date:   Thu, 21 May 2020 15:49:58 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Xia Jiang <xia.jiang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        srv_heupstream@mediatek.com, senozhatsky@chromium.org,
        mojahsu@chromium.org, drinkcat@chromium.org,
        maoguang.meng@mediatek.com, sj.huang@mediatek.com
Subject: Re: [PATCH v8 10/14] media: platform: Delete redundant code for
 improving code quality
Message-ID: <20200521154958.GI209565@chromium.org>
References: <20200403094033.8288-1-xia.jiang@mediatek.com>
 <20200403094033.8288-11-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403094033.8288-11-xia.jiang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xia,

On Fri, Apr 03, 2020 at 05:40:29PM +0800, Xia Jiang wrote:
> Delete unused member variables annotation.
> Delete unused variable definition.
> Delete redundant log print, because V4L2 debug logs already print it.
> 
> Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> ---
> v8: no changes
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 16 ++--------------
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h |  5 +++--
>  2 files changed, 5 insertions(+), 16 deletions(-)
> 

Thank you for the patch. Please see my comments inline.

> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> index 4e64046a6854..9e59b9a51ef0 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -182,7 +182,6 @@ static int mtk_jpeg_try_fmt_mplane(struct v4l2_format *f,
>  				   struct mtk_jpeg_ctx *ctx, int q_type)
>  {
>  	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> -	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
>  	int i;
>  
>  	memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
> @@ -190,7 +189,7 @@ static int mtk_jpeg_try_fmt_mplane(struct v4l2_format *f,
>  
>  	if (ctx->state != MTK_JPEG_INIT) {
>  		mtk_jpeg_adjust_fmt_mplane(ctx, f);
> -		goto end;
> +		return 0;
>  	}
>  
>  	pix_mp->num_planes = fmt->colplanes;
> @@ -210,7 +209,7 @@ static int mtk_jpeg_try_fmt_mplane(struct v4l2_format *f,
>  		pfmt->sizeimage = round_up(pfmt->sizeimage, 128);
>  		if (pfmt->sizeimage == 0)
>  			pfmt->sizeimage = MTK_JPEG_DEFAULT_SIZEIMAGE;
> -		goto end;
> +		return 0;
>  	}
>  
>  	/* type is MTK_JPEG_FMT_TYPE_CAPTURE */
> @@ -224,20 +223,9 @@ static int mtk_jpeg_try_fmt_mplane(struct v4l2_format *f,
>  		u32 stride = pix_mp->width * fmt->h_sample[i] / 4;
>  		u32 h = pix_mp->height * fmt->v_sample[i] / 4;
>  
> -		memset(pfmt->reserved, 0, sizeof(pfmt->reserved));

This change is not mentioned in the description. I'd suggest moving it
to a separate patch, because it's a functional change.

>  		pfmt->bytesperline = stride;
>  		pfmt->sizeimage = stride * h;
>  	}
> -end:
> -	v4l2_dbg(2, debug, &jpeg->v4l2_dev, "wxh:%ux%u\n",
> -		 pix_mp->width, pix_mp->height);
> -	for (i = 0; i < pix_mp->num_planes; i++) {
> -		v4l2_dbg(2, debug, &jpeg->v4l2_dev,
> -			 "plane[%d] bpl=%u, size=%u\n",
> -			 i,
> -			 pix_mp->plane_fmt[i].bytesperline,
> -			 pix_mp->plane_fmt[i].sizeimage);
> -	}
>  	return 0;
>  }
>  
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> index 64a731261214..9bbd615b1067 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> @@ -30,6 +30,9 @@
>  
>  #define MTK_JPEG_DEFAULT_SIZEIMAGE	(1 * 1024 * 1024)
>  
> +/**
> + * enum mtk_jpeg_ctx_state - contex state of jpeg

typo: s/contex/context/

But I'd rephrase it to "states of the context state machine".

> + */

Not mentioned in the description. Also, the documentation of an enum
should have descriptions for the values.

Best regards,
Tomasz
