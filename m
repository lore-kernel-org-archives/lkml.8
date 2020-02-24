Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F12C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB35D20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBXN7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:59:13 -0500
Received: from foss.arm.com ([217.140.110.172]:37450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbgBXN7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:59:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B4E630E;
        Mon, 24 Feb 2020 05:59:13 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0DB23F534;
        Mon, 24 Feb 2020 05:59:12 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id A1951682F2C; Mon, 24 Feb 2020 13:59:11 +0000 (GMT)
Date:   Mon, 24 Feb 2020 13:59:11 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     brian.starkey@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] drm/arm: make hdlcd_debugfs_init return 0
Message-ID: <20200224135911.GJ364558@e110455-lin.cambridge.arm.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
 <20200218172821.18378-2-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200218172821.18378-2-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 18, 2020 at 08:28:13PM +0300, Wambui Karuga wrote:
> As drm_debugfs_create_files should return void, remove its use as a
> return value in hdlcd_debugfs_init and have the latter function return 0
> directly.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/arm/hdlcd_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index 2e053815b54a..bd0ad6f46a97 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -226,8 +226,10 @@ static struct drm_info_list hdlcd_debugfs_list[] = {
>  
>  static int hdlcd_debugfs_init(struct drm_minor *minor)
>  {
> -	return drm_debugfs_create_files(hdlcd_debugfs_list,
> -		ARRAY_SIZE(hdlcd_debugfs_list),	minor->debugfs_root, minor);
> +	drm_debugfs_create_files(hdlcd_debugfs_list,
> +				 ARRAY_SIZE(hdlcd_debugfs_list),
> +				 minor->debugfs_root, minor);
> +	return 0;
>  }
>  #endif
>
> -- 
> 2.25.0
>

Thanks for your patch! I had to go into the ML and find out the series where this
patch belongs to and seen that you have already received some feedback, but I think
a summary is worth:

- you should look if it is possible to make .debugfs_init hook return void, it would
  simplify the cleanup in the drivers by not having to return 0.
- you should put in each driver patch a note that drm_debugfs_create_files() always
  returns 0 since 987d65d01356 (drm: debugfs: make drm_debugfs_create_files() never fail)
  so that people don't have to hunt in the git history for clues.
- Make all the changes into a series

With that, you can have my Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
