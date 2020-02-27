Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAABC35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FB6246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgB0OxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:53:23 -0500
Received: from foss.arm.com ([217.140.110.172]:53140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgB0OxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:53:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF34230E;
        Thu, 27 Feb 2020 06:53:21 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF87D3F7B4;
        Thu, 27 Feb 2020 06:53:21 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 8E879682F2C; Thu, 27 Feb 2020 14:53:20 +0000 (GMT)
Date:   Thu, 27 Feb 2020 14:53:20 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie,
        Brian Starkey <brian.starkey@arm.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 07/21] drm/arm: make hdlcd_debugfs_init() return void
Message-ID: <20200227145320.GY364558@e110455-lin.cambridge.arm.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
 <20200227120232.19413-8-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227120232.19413-8-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:02:18PM +0300, Wambui Karuga wrote:
> Since commit 987d65d01356 (drm: debugfs: make
> drm_debugfs_create_files() never fail), drm_debugfs_create_files()
> never fails, and should return void. Therefore, remove its use as a
> return value in hdlcd_debugfs_init and have the latter function
> return void.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Not sure how you're going to address Greg KH's comment (maybe one single patch that
converts debugfs_init to void *and* changes the signature to all hooks?) but I'm
going to assume that you will get the whole series merged in one go so I don't have
to push this individual patch into HDLCD tree.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/hdlcd_drv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index 2e053815b54a..194419f47c5e 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -224,10 +224,11 @@ static struct drm_info_list hdlcd_debugfs_list[] = {
>  	{ "clocks", hdlcd_show_pxlclock, 0 },
>  };
>  
> -static int hdlcd_debugfs_init(struct drm_minor *minor)
> +static void hdlcd_debugfs_init(struct drm_minor *minor)
>  {
> -	return drm_debugfs_create_files(hdlcd_debugfs_list,
> -		ARRAY_SIZE(hdlcd_debugfs_list),	minor->debugfs_root, minor);
> +	drm_debugfs_create_files(hdlcd_debugfs_list,
> +				 ARRAY_SIZE(hdlcd_debugfs_list),
> +				 minor->debugfs_root, minor);
>  }
>  #endif
>  
> -- 
> 2.25.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
