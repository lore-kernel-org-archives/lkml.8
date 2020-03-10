Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A553CC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B1E20675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCJPnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:43:32 -0400
Received: from foss.arm.com ([217.140.110.172]:38744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgCJPnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:43:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBB4B1FB;
        Tue, 10 Mar 2020 08:43:29 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7A353F534;
        Tue, 10 Mar 2020 08:43:29 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 5585B682F35; Tue, 10 Mar 2020 15:43:28 +0000 (GMT)
Date:   Tue, 10 Mar 2020 15:43:28 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        Brian Starkey <brian.starkey@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 06/17] drm/arm: make hdlcd_debugfs_init() return 0
Message-ID: <20200310154328.GO364558@e110455-lin.cambridge.arm.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
 <20200310133121.27913-7-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200310133121.27913-7-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 04:31:10PM +0300, Wambui Karuga wrote:
> Since commit 987d65d01356 (drm: debugfs: make
> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
> fails and should return void. Therefore, remove its use as the
> return value of hdlcd_debugfs_init() and have the latter function return
> 0 directly.
> 
> v2: make hdlcd_debugfs_init() return 0 instead of void to ensure that
> each patch compiles individually.
> 
> References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
> 2.25.1
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
