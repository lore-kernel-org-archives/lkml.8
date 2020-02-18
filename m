Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E392C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BE424125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="i+3xx54g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRTJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:09:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34340 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:09:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so23376363wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=SBqpDcTE6AMCvGrFbLWhx5wZFetN9vSApojWcAj4+aU=;
        b=i+3xx54gT+/cAZ6JrqaPpTCoBJz7XXOp7G7+r0gX9XNxgObwzrh1Wb1TTrZwkxfVCq
         gP6Ovp4ugJ15he6KKTnXKD/O3OzUUpbXWGEOqvTx2kNsQ1tDt6tmnLKU0x6cEoKvnhwm
         CBvzzEqLXY87c4kfGjiWVPdZeRBzpKkiDCxck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=SBqpDcTE6AMCvGrFbLWhx5wZFetN9vSApojWcAj4+aU=;
        b=SG1j5q/ebmw6H/w3f03/OEroyhf52L0JDAJeEUugNqrQmLMqvbeisDPFTqPLNEetyh
         vebAjla4s3/icaULXZYb+3tKgYb4najJOG+YJ88Z/ScENy5UMOpn61jDFa8WKSb59Dj/
         eD7bs4LoOJFTQZNUofeMNza3nDZ9dogsNHgWV3sZsb1zdzlFXTYeK6RzTQPORHtTRHO7
         /ivcJbqrFvJEofyWl+o/17twNDJejfyDBqXXzFSkmk7hz9zcs4IK6LqKoE6Dfjcg1dAB
         nRyjfkH49167aNiCFZOcHePVFiQxSuIeAFTKzJzj5bSwJindAFqnQ9oKbHFj/SiZfOlS
         l7/w==
X-Gm-Message-State: APjAAAV00fLklUxX0SofnKKuPGpLN/ljdZDRrFV4GOjG+OyBTkI54XO7
        wbxd7def72KuX9nVcQOPNYCckg==
X-Google-Smtp-Source: APXvYqw8JfZcZoALoGUrqXssK3WpI4YwooCYEW8v1nAWpuspWdhwXC/fZ0wbKeKdH3ckafrtkxSOqA==
X-Received: by 2002:adf:e80e:: with SMTP id o14mr30197494wrm.212.1582052983166;
        Tue, 18 Feb 2020 11:09:43 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d4sm7295827wra.14.2020.02.18.11.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 11:09:42 -0800 (PST)
Date:   Tue, 18 Feb 2020 20:09:40 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] drm/debugfs: remove checks for return value of
 drm_debugfs functions.
Message-ID: <20200218190940.GN2363188@phenom.ffwll.local>
Mail-Followup-To: Wambui Karuga <wambui.karugax@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
 <20200218172821.18378-3-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218172821.18378-3-wambui.karugax@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:28:14PM +0300, Wambui Karuga wrote:
> As there is no need to check the return value of
> drm_debugfs_create_files, remove unnecessary checks and error handling
> statement blocks.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

I'd split this up a bit differently, with a patch per function. But then
including in that patch the prototype change (at least for the
drm-internal ones that aren't used by drivers). This way reviewers don't
have to check the entire series to make sure that we drop the now
pointeless return value from the implementation of these functions.

I guess you could also just squash this function into the last one, it's a
fairly small patch still.
-Daniel

> ---
>  drivers/gpu/drm/drm_debugfs.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index 4e673d318503..6a2f141b6a38 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -215,35 +215,17 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>  	sprintf(name, "%d", minor_id);
>  	minor->debugfs_root = debugfs_create_dir(name, root);
>  
> -	ret = drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
> -				       minor->debugfs_root, minor);
> -	if (ret) {
> -		debugfs_remove(minor->debugfs_root);
> -		minor->debugfs_root = NULL;
> -		DRM_ERROR("Failed to create core drm debugfs files\n");
> -		return ret;
> -	}
> +	drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
> +				 minor->debugfs_root, minor);
>  
>  	if (drm_drv_uses_atomic_modeset(dev)) {
> -		ret = drm_atomic_debugfs_init(minor);
> -		if (ret) {
> -			DRM_ERROR("Failed to create atomic debugfs files\n");
> -			return ret;
> -		}
> +		drm_atomic_debugfs_init(minor);
>  	}
>  
>  	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
> -		ret = drm_framebuffer_debugfs_init(minor);
> -		if (ret) {
> -			DRM_ERROR("Failed to create framebuffer debugfs file\n");
> -			return ret;
> -		}
> +		drm_framebuffer_debugfs_init(minor);
>  
> -		ret = drm_client_debugfs_init(minor);
> -		if (ret) {
> -			DRM_ERROR("Failed to create client debugfs file\n");
> -			return ret;
> -		}
> +		drm_client_debugfs_init(minor);
>  	}
>  
>  	if (dev->driver->debugfs_init) {
> -- 
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
