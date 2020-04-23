Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8773C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8E92077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgDWMuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:50:09 -0400
Received: from foss.arm.com ([217.140.110.172]:39262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgDWMuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:50:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D73AD31B;
        Thu, 23 Apr 2020 05:50:08 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7E223F6CF;
        Thu, 23 Apr 2020 05:50:08 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 767A4682F3D; Thu, 23 Apr 2020 13:50:07 +0100 (BST)
Date:   Thu, 23 Apr 2020 13:50:07 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] drm/arm: cleanup coding style in arm a bit
Message-ID: <20200423125007.GG364558@e110455-lin.cambridge.arm.com>
References: <20200422021046.4375-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422021046.4375-1-bernard@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard,

On Tue, Apr 21, 2020 at 07:10:46PM -0700, Bernard Zhao wrote:
> For the code logic, an alarm is thrown after failure, but the
> code continues to run and returns successfully, so to the caller
> the if check and return branch will never run.
> The change is to make the code a bit more readable.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index af67fefed38d..32bda13250f5 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -160,9 +160,7 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  	hdlcd_write(hdlcd, HDLCD_REG_H_SYNC, vm.hsync_len - 1);
>  	hdlcd_write(hdlcd, HDLCD_REG_POLARITIES, polarities);
>  
> -	err = hdlcd_set_pxl_fmt(crtc);
> -	if (err)
> -		return;
> +	hdlcd_set_pxl_fmt(crtc);

I think you found a real bug. hdlcd_set_pxl_fmt() is not supposed to return zero if
the format is not supported and here we would stop enabling the pixel clock.

Do you care to send a patch for fixing the bug, rather than this one?

Best regards,
Liviu

>  
>  	clk_set_rate(hdlcd->clk, m->crtc_clock * 1000);
>  }
> -- 
> 2.26.2
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
