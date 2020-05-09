Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DAAC54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 21:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F06B20A8B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 21:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgEIVJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 17:09:29 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:45488 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgEIVJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 17:09:28 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 25EB42003E;
        Sat,  9 May 2020 23:09:26 +0200 (CEST)
Date:   Sat, 9 May 2020 23:09:24 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: pxa168fb: make pxa168fb_init_mode() return
 void
Message-ID: <20200509210924.GB12666@ravnborg.org>
References: <20200506061745.19451-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506061745.19451-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=LIjMPlzXlnp3mKN0Lz4A:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason.

On Wed, May 06, 2020 at 02:17:45PM +0800, Jason Yan wrote:
> No other functions use the return value of pxa168fb_init_mode() and the
> return value is always 0 now. Make it return void. This fixes the
> following coccicheck warning:
> 
> drivers/video/fbdev/pxa168fb.c:565:5-8: Unneeded variable: "ret". Return
> "0" on line 597
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/pxa168fb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index aef8a3042590..eedfbd3572a8 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -557,12 +557,11 @@ static const struct fb_ops pxa168fb_ops = {
>  	.fb_imageblit	= cfb_imageblit,
>  };
>  
> -static int pxa168fb_init_mode(struct fb_info *info,
> +static void pxa168fb_init_mode(struct fb_info *info,
>  			      struct pxa168fb_mach_info *mi)
>  {
>  	struct pxa168fb_info *fbi = info->par;
>  	struct fb_var_screeninfo *var = &info->var;
> -	int ret = 0;
>  	u32 total_w, total_h, refresh;
>  	u64 div_result;
>  	const struct fb_videomode *m;
> @@ -593,8 +592,6 @@ static int pxa168fb_init_mode(struct fb_info *info,
>  	div_result = 1000000000000ll;
>  	do_div(div_result, total_w * total_h * refresh);
>  	var->pixclock = (u32)div_result;
> -
> -	return ret;
>  }
>  
>  static int pxa168fb_probe(struct platform_device *pdev)
> -- 
> 2.21.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
