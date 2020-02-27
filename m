Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5FFC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2802224692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgB0Ngp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:36:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49365 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgB0Ngo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:36:44 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1j7JLF-0007aW-Ts; Thu, 27 Feb 2020 14:36:41 +0100
Message-ID: <a965d97ddf99d4a335582732dfac7b0948258632.camel@pengutronix.de>
Subject: Re: [PATCH 08/21] drm/etnaviv: remove check for return value of
 drm_debugfs function
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Wambui Karuga <wambui.karugax@gmail.com>, daniel@ffwll.ch,
        airlied@linux.ie, Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Date:   Thu, 27 Feb 2020 14:36:40 +0100
In-Reply-To: <20200227120232.19413-9-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
         <20200227120232.19413-9-wambui.karugax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2020-02-27 at 15:02 +0300, Wambui Karuga wrote:
> Since commit 987d65d01356 (drm: debugfs: make
> drm_debugfs_create_files() never fail), drm_debugfs_create_file only
> returns 0, and there is no need to check the return value.
> This change therefore removes the check and error handling in
> etnaviv_debugfs_init() and also makes the function return void.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 6b43c1c94e8f..a39735316ca5 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -231,21 +231,11 @@ static struct drm_info_list etnaviv_debugfs_list[] = {
>  		{"ring", show_each_gpu, 0, etnaviv_ring_show},
>  };
>  
> -static int etnaviv_debugfs_init(struct drm_minor *minor)
> +static void etnaviv_debugfs_init(struct drm_minor *minor)
>  {
> -	struct drm_device *dev = minor->dev;
> -	int ret;
> -
> -	ret = drm_debugfs_create_files(etnaviv_debugfs_list,
> -			ARRAY_SIZE(etnaviv_debugfs_list),
> -			minor->debugfs_root, minor);
> -
> -	if (ret) {
> -		dev_err(dev->dev, "could not install etnaviv_debugfs_list\n");
> -		return ret;
> -	}
> -
> -	return ret;
> +	drm_debugfs_create_files(etnaviv_debugfs_list,
> +				 ARRAY_SIZE(etnaviv_debugfs_list),
> +				 minor->debugfs_root, minor);
>  }
>  #endif
>  

