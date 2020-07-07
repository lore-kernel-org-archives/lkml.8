Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4A9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E0420708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgGGCbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgGGCby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 22:31:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CBAC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 19:31:54 -0700 (PDT)
Received: from kevin (unknown [IPv6:2600:1700:4540:6a60::14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5FE532A4B80;
        Tue,  7 Jul 2020 03:31:51 +0100 (BST)
Date:   Mon, 6 Jul 2020 22:31:47 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu
Subject: Re: [PATCH] drm/panfrost: perfcnt: fix ref count leak in
 panfrost_perfcnt_enable_locked
Message-ID: <20200707023147.GB16527@kevin>
References: <20200614063619.44944-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614063619.44944-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

On Sun, Jun 14, 2020 at 01:36:19AM -0500, Navid Emamdoost wrote:
> in panfrost_perfcnt_enable_locked, pm_runtime_get_sync is called which
> increments the counter even in case of failure, leading to incorrect
> ref count. In case of failure, decrement the ref count before returning.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index 6913578d5aa7..92c64b20eb29 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -83,11 +83,13 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  
>  	ret = pm_runtime_get_sync(pfdev->dev);
>  	if (ret < 0)
> -		return ret;
> +		goto err_put_pm;
>  
>  	bo = drm_gem_shmem_create(pfdev->ddev, perfcnt->bosize);
> -	if (IS_ERR(bo))
> -		return PTR_ERR(bo);
> +	if (IS_ERR(bo)) {
> +		ret = PTR_ERR(bo);
> +		goto err_put_pm;
> +	}
>  
>  	/* Map the perfcnt buf in the address space attached to file_priv. */
>  	ret = panfrost_gem_open(&bo->base, file_priv);
> @@ -168,6 +170,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  	panfrost_gem_close(&bo->base, file_priv);
>  err_put_bo:
>  	drm_gem_object_put_unlocked(&bo->base);
> +err_put_pm:
> +	pm_runtime_put(pfdev->dev);
>  	return ret;
>  }
>  
> -- 
> 2.17.1
> 
