Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D6BC2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F79920747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="EDHW+hVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbgELW2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727899AbgELW2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:28:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97DDC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:28:44 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 188so11910290lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Yd6UTaPAb2FR7bBeSDIETddPBi1BC2Xst6NzALQxfFE=;
        b=EDHW+hVhMyr+diUJcQfeEXL71+toyM5AFY1xZBuNohp7VMM23zBGHCeTs8u0ivUqUX
         wFbgQeKmp/gZFzOLUEiLptUmUH1yup3T360ik90AXpX6bqSBC9d+XVPp2npld6+/9hVR
         5emyLEtOCz6Nrp0Oo9eKIk5qxcxKZfnQGT6Av0UTuhVfXMuw5bF91ULFLMfAj0HvxyGi
         iXpBi7WQrPcj1xA7dN5teJh8JTCXYuhNx0aE2PIz1VeLVVBrMwyNoaH0sRh+/rhBLOVT
         /JqmMIKVKzi31n0rqVECujzdd/texRunl0Jl02UmSqun7hcDgEV8aCHud1TuNvrT7Gy6
         N1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Yd6UTaPAb2FR7bBeSDIETddPBi1BC2Xst6NzALQxfFE=;
        b=hFeHJFVHaFDWoo1+HKUjXwB3XIjFN5aEcqEjH2u+lTL2t7HiP3LMamwYjigVZEOe7k
         ESz3Joy4O9lR6aVXSZhhHpOs1aQeVhwwQn6rGSPBbIcYAcaT5GeOAnaRh3JGEHTJJIiJ
         0oVjZnHs0U5p8uKGjI30zy+Y9CWWCLvRjgiGK1R6hMe5eznJZNV3/cBZZFhXHOmiipja
         38crT5enXfJnBuMPyIJca8S9frWpTcPq8gNPM8Tm4p70T7pZJqUAKGbY35a0wRmfsKho
         jYWEO3a8dgkR4OM3m9eeV/9MsoNJgwFJHvBaZZWj3s0XNRZsH+0IMW03u+XTNo3yyb4a
         2W5w==
X-Gm-Message-State: AOAM5334gEgDR8Pi67ld4mrWh+heIYyC2zIR/+KabYhZfpjbX/x6rsx8
        wwPROjPC1uQ7gl5h8MD3BaK1Sg==
X-Google-Smtp-Source: ABdhPJwKafBveyWoomRdtLoMhAo3gKkzcwpPZZz7PuekZpDLOn7NHUaoVIp5m4RE+IIt0gdybMoxTg==
X-Received: by 2002:a19:d55:: with SMTP id 82mr16119754lfn.89.1589322522058;
        Tue, 12 May 2020 15:28:42 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id w15sm13497560ljd.35.2020.05.12.15.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:28:41 -0700 (PDT)
Date:   Wed, 13 May 2020 00:28:40 +0200
From:   Niklas <niklas.soderlund@ragnatech.se>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v4 2/3] media: rcar-vin: Add support for
 MEDIA_BUS_FMT_SRGGB8_1X8 format
Message-ID: <20200512222840.GE2542285@oden.dyn.berto.se>
References: <1586945948-11026-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1586945948-11026-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1586945948-11026-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

Thanks for your work.

On 2020-04-15 11:19:07 +0100, Lad Prabhakar wrote:
> Add support for MEDIA_BUS_FMT_SRGGB8_1X8 format in rcar-vin by setting
> format type to RAW8 in VNMC register and appropriately setting the bpp
> and bytesperline to enable V4L2_PIX_FMT_SRGGB8.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/platform/rcar-vin/rcar-dma.c  | 15 ++++++++++++++-
>  drivers/media/platform/rcar-vin/rcar-v4l2.c |  4 ++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
> index 48bd9bfc3948..3e8e29573e6d 100644
> --- a/drivers/media/platform/rcar-vin/rcar-dma.c
> +++ b/drivers/media/platform/rcar-vin/rcar-dma.c
> @@ -85,6 +85,7 @@
>  #define VNMC_INF_YUV8_BT601	(1 << 16)
>  #define VNMC_INF_YUV10_BT656	(2 << 16)
>  #define VNMC_INF_YUV10_BT601	(3 << 16)
> +#define VNMC_INF_RAW8		(4 << 16)
>  #define VNMC_INF_YUV16		(5 << 16)
>  #define VNMC_INF_RGB888		(6 << 16)
>  #define VNMC_VUP		(1 << 10)
> @@ -587,13 +588,19 @@ void rvin_crop_scale_comp(struct rvin_dev *vin)
>  	rvin_write(vin, vin->crop.top, VNSLPRC_REG);
>  	rvin_write(vin, vin->crop.top + vin->crop.height - 1, VNELPRC_REG);
>  
> -
>  	/* TODO: Add support for the UDS scaler. */
>  	if (vin->info->model != RCAR_GEN3)
>  		rvin_crop_scale_comp_gen2(vin);
>  
>  	fmt = rvin_format_from_pixel(vin, vin->format.pixelformat);
>  	stride = vin->format.bytesperline / fmt->bpp;
> +
> +	/* For RAW8 format bpp is 1, but the hardware process RAW8
> +	 * format in 2 pixel unit hence configure VNIS_REG as stride / 2.
> +	 */
> +	if (vin->format.pixelformat == V4L2_PIX_FMT_SRGGB8)
> +		stride /= 2;
> +
>  	rvin_write(vin, stride, VNIS_REG);
>  }
>  
> @@ -676,6 +683,9 @@ static int rvin_setup(struct rvin_dev *vin)
>  
>  		input_is_yuv = true;
>  		break;
> +	case MEDIA_BUS_FMT_SRGGB8_1X8:
> +		vnmc |= VNMC_INF_RAW8;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -737,6 +747,9 @@ static int rvin_setup(struct rvin_dev *vin)
>  	case V4L2_PIX_FMT_ABGR32:
>  		dmr = VNDMR_A8BIT(vin->alpha) | VNDMR_EXRGB | VNDMR_DTMD_ARGB;
>  		break;
> +	case V4L2_PIX_FMT_SRGGB8:
> +		dmr = 0;
> +		break;
>  	default:
>  		vin_err(vin, "Invalid pixelformat (0x%x)\n",
>  			vin->format.pixelformat);
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> index 5151a3cd8a6e..ca542219e8ae 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -66,6 +66,10 @@ static const struct rvin_video_format rvin_formats[] = {
>  		.fourcc			= V4L2_PIX_FMT_ABGR32,
>  		.bpp			= 4,
>  	},
> +	{
> +		.fourcc			= V4L2_PIX_FMT_SRGGB8,
> +		.bpp			= 1,
> +	},
>  };
>  
>  const struct rvin_video_format *rvin_format_from_pixel(struct rvin_dev *vin,
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
