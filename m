Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FADC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7BA20708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGGCbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGGCbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 22:31:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C19FC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 19:31:36 -0700 (PDT)
Received: from kevin (unknown [IPv6:2600:1700:4540:6a60::14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A06422A481D;
        Tue,  7 Jul 2020 03:31:32 +0100 (BST)
Date:   Mon, 6 Jul 2020 22:31:28 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: Re: [PATCH] drm/panfrost: fix ref count leak in
 panfrost_job_hw_submit
Message-ID: <20200707023128.GA16527@kevin>
References: <20200614062730.46489-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614062730.46489-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

On Sun, Jun 14, 2020 at 01:27:30AM -0500, Navid Emamdoost wrote:
> in panfrost_job_hw_submit, pm_runtime_get_sync is called which
> increments the counter even in case of failure, leading to incorrect
> ref count. In case of failure, decrement the ref count before returning.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 7914b1570841..89ac84667eb1 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -147,11 +147,10 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  
>  	ret = pm_runtime_get_sync(pfdev->dev);
>  	if (ret < 0)
> -		return;
> +		goto out;
>  
>  	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
> -		pm_runtime_put_sync_autosuspend(pfdev->dev);
> -		return;
> +		goto out;
>  	}
>  
>  	cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
> @@ -184,6 +183,9 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  				job, js, jc_head);
>  
>  	job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
> +out:
> +	pm_runtime_put_sync_autosuspend(pfdev->dev);
> +	return;
>  }
>  
>  static void panfrost_acquire_object_fences(struct drm_gem_object **bos,
> -- 
> 2.17.1
> 
