Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25AAC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 01:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDED2067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 01:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cr2o6TWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgFGBHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 21:07:40 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39632 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgFGBHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 21:07:40 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A5C02C9;
        Sun,  7 Jun 2020 03:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591492058;
        bh=Zr1iCyErWTU0WRKjkUvAEEYuxaVuxgsvQL9HIU+vA4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cr2o6TWGLCpjcr4w7QOlOnhr0lXE3tqqB5QbOqPWVY53mU9Z/w3n+YM5aQymExNtj
         K0TZC7nGR7FecTUM6vOkgjor5lV3AIkaEwf4qZcFjAykC+b9LQn/AbGxn9sALBO/3N
         uRIvWSAexk9pC4nyjBlXBhD7zbhtBJKfdho3SM3g=
Date:   Sun, 7 Jun 2020 04:07:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Buzdyk <dima.buzdyk@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] uvcvideo: Add mapping for HEVC payloads
Message-ID: <20200607010719.GU7339@pendragon.ideasonboard.com>
References: <20200529010547.GA630131@dmitry-T520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529010547.GA630131@dmitry-T520>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the patch.

On Fri, May 29, 2020 at 11:05:47AM +1000, Dmitry Buzdyk wrote:
> Add HEVC GUID and assotiate with HEVC pixel format so that frame
> based format descriptors recognized by the UVC video driver.

The patch itself looks OK to me, but could you share a bit more
information about which device(s) implement this ? Are they UVC 1.1
devices ? Could you share their full USB descriptors (retrieved with
'lsusb -v', running as root if possible) ?

Is there anything else needed to get HEVC capture working, such as
extension unit controls, or is this patch enough ? What userspace
software do you use to capture and decode HEVC (or capture it to disk) ?

> Signed-off-by: Dmitry Buzdyk <dima.buzdyk@gmail.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 5 +++++
>  drivers/media/usb/uvc/uvcvideo.h   | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 431d86e1c94b..825ee3601661 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -214,6 +214,11 @@ static struct uvc_format_desc uvc_fmts[] = {
>  		.guid		= UVC_GUID_FORMAT_CNF4,
>  		.fcc		= V4L2_PIX_FMT_CNF4,
>  	},
> +	{
> +		.name		= "HEVC",
> +		.guid		= UVC_GUID_FORMAT_HEVC,
> +		.fcc		= V4L2_PIX_FMT_HEVC,
> +	},
>  };
>  
>  /* ------------------------------------------------------------------------
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 6ab972c643e3..c7f043121b41 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -165,6 +165,10 @@
>  	{0x32, 0x00, 0x00, 0x00, 0x02, 0x00, 0x10, 0x00, \
>  	 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
>  
> +#define UVC_GUID_FORMAT_HEVC \
> +	{ 'H',  'E',  'V',  'C', 0x00, 0x00, 0x10, 0x00, \
> +	 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> +
>  
>  /* ------------------------------------------------------------------------
>   * Driver specific constants.

-- 
Regards,

Laurent Pinchart
