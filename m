Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDECC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3D820734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="Qbll/Bjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgFJNAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgFJNA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:00:29 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC0C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:00:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so2368233lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PNyrBZppNk3Cjv2T06G1zQBWJHpOfeyJqDojTtGkqc0=;
        b=Qbll/Bjm7pPCbjqueebN+hgqtenuC0SeH2KoV1L2PcrPvu1yr0DVTGD35LdOIPOFGb
         rIUL5CIDe3nVW7glCNLBRARyF2Hd/kOd6yH9rVut2I1yxnc5fIE4tKF1eML+3wiJYmzW
         k47efqsigrCnZmaJOG1bj5Y+Z9GxJLHG+7y0dfoelNMlFa7Kmia9UsST1NVNP3XIh7fW
         k1tZ1o1Gytst8WLFzGcavIjhKjKIx/zZeNFNXovrOfbLgHNNsrp6SRkyvdvBzKsj8Imh
         v/dQO/fuSL5us9jXZoS4Ps56ircqY/aQM+akRQnc/WHRxe1jBYlFsWzNF/NGn1O71Pb/
         rj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PNyrBZppNk3Cjv2T06G1zQBWJHpOfeyJqDojTtGkqc0=;
        b=OzOQ+XQF+Z1Mv10zE2+Cp70DYCp5XgSV2tp0/aK8SEQl5zRKT+1z0lRvZqVL20Vnde
         C5nCvxOmNEjvQ6gz8BMNPWoXu70v0gjKYRKz//sJjT/48hj4Yp07PNpZhSjnoisrJ1Nq
         1P7uB/Q59DSN5kRfCoIsWXuXMlIqCCK6qu8KajvVxc+t6TfQlqMRI/lLohVV6HLNN+2D
         9d61e/aJPHR/aNIFepHzmjvGb06ltqM1GGFpZTW58ZW7MqBb777KhYWZeKE5tcu5jXF8
         kfq94AFFFN02Av356WD4gqBpQQw9ZR4UGutcKIRcEq4OGWzjlhYs1WwwAghgaIHKqUzJ
         +76w==
X-Gm-Message-State: AOAM530yQ/Y1QxwzhRY8yA30ScXtA1cDIcbt6aqYcbPI46+3QgwH5Ce/
        KKdCY/wunrWSX2mbOIEx4DbLaQ==
X-Google-Smtp-Source: ABdhPJyz49dL94Sea0DJLV1WyFieZrGEQPrJqr/qrzgylWAQVW3IiN5+3jH4CECthyOGqzH2YpP66g==
X-Received: by 2002:a2e:8554:: with SMTP id u20mr1734783ljj.188.1591794026560;
        Wed, 10 Jun 2020 06:00:26 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id h15sm1001700ljk.24.2020.06.10.06.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 06:00:25 -0700 (PDT)
Date:   Wed, 10 Jun 2020 15:00:24 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] media: rcar-vin: Invalidate pipeline if
 conversion is not possible on input formats
Message-ID: <20200610130024.GA184623@oden.dyn.berto.se>
References: <1590581810-19317-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590581810-19317-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1590581810-19317-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

Thanks for your work.

On 2020-05-27 13:16:48 +0100, Lad Prabhakar wrote:
> Up until now the VIN was capable to convert any of its supported input mbus
> formats to any of it's supported output pixel formats. With the addition of
> RAW formats this is no longer true.
> 
> This patch invalidates the pipeline by adding a check if given vin input
> format can be converted to supported output pixel format.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/platform/rcar-vin/rcar-dma.c  |  6 +++++-
>  drivers/media/platform/rcar-vin/rcar-v4l2.c | 11 ++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
> index 1a30cd036371..2b26204910fd 100644
> --- a/drivers/media/platform/rcar-vin/rcar-dma.c
> +++ b/drivers/media/platform/rcar-vin/rcar-dma.c
> @@ -1110,11 +1110,15 @@ static int rvin_mc_validate_format(struct rvin_dev *vin, struct v4l2_subdev *sd,
>  	case MEDIA_BUS_FMT_UYVY8_2X8:
>  	case MEDIA_BUS_FMT_UYVY10_2X10:
>  	case MEDIA_BUS_FMT_RGB888_1X24:
> -		vin->mbus_code = fmt.format.code;
> +		break;
> +	case MEDIA_BUS_FMT_SRGGB8_1X8:
> +		if (vin->format.pixelformat != V4L2_PIX_FMT_SRGGB8)
> +			return -EPIPE;
>  		break;
>  	default:
>  		return -EPIPE;
>  	}
> +	vin->mbus_code = fmt.format.code;
>  
>  	switch (fmt.format.field) {
>  	case V4L2_FIELD_TOP:
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> index f421e2584875..d3b6a992b4a2 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -350,9 +350,9 @@ static int rvin_enum_fmt_vid_cap(struct file *file, void *priv,
>  	 * all of the related pixel formats. If mbus_code is not set enumerate
>  	 * all possible pixelformats.
>  	 *
> -	 * TODO: Once raw capture formats are added to the driver this needs
> -	 * to be extended so raw media bus codes only result in raw pixel
> -	 * formats.
> +	 * TODO: Once raw MEDIA_BUS_FMT_SRGGB12_1X12 format is added to the
> +	 * driver this needs to be extended so raw media bus code only result in
> +	 * raw pixel format.
>  	 */
>  	switch (f->mbus_code) {
>  	case 0:
> @@ -362,6 +362,11 @@ static int rvin_enum_fmt_vid_cap(struct file *file, void *priv,
>  	case MEDIA_BUS_FMT_UYVY10_2X10:
>  	case MEDIA_BUS_FMT_RGB888_1X24:
>  		break;
> +	case MEDIA_BUS_FMT_SRGGB8_1X8:
> +		if (f->index)
> +			return -EINVAL;
> +		f->pixelformat = V4L2_PIX_FMT_SRGGB8;
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
