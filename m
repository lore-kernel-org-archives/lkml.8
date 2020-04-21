Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1BCC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F672070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="R7MqcRa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgDUM37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUM36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:29:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A595AC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:29:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h2so3333526wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=xrAZS1nO5bjTBwhM2o+ERENfnqrRAvPah02F2/o2fss=;
        b=R7MqcRa+AKMzsCn3a2u67yrA7VVoS2hfpOs3FFcPeJ995lq0w1TmRsr+QQyigRSW97
         S6b2EutJ1oVJoS3FBW5Vwevz61TORAAVqGfX0368N4IrEVzkxYOYjKphBdwo/ImqI38x
         dKlHNQxrEtE2nrRS3uONXQq7skAAVq1fyu37g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=xrAZS1nO5bjTBwhM2o+ERENfnqrRAvPah02F2/o2fss=;
        b=QXQTxZUJjjTuCNcb7RUvXWjXrnjAI/rzgquq3MC4WMyxzbBYeE+OTARx4bZFETYHlT
         6+dju1SQuzrNptNmyw/3Jnem/eNsDfFc2cjM/4wEXJ00k5jQl95olQSxu/Bm84BZ44e3
         1bEQgIlJqgdnibFwXJz0gGxjhDOUJVZBWc9rTPRqb/XSgXP3N/2H+8c5xQq41iTyjVpM
         5oUo7tpU1p5VHYWtk6CXMrxsfDaMlc2K9n3hn2x7b/y30qJoovvSI2VlNv7pQpVGQzvf
         YB+xBYjj3d7qGrTfL7FjkTN+zMObInjq88avLjt2Svic0zlCvehkQcQ+PRA8wAhO+fr2
         vndQ==
X-Gm-Message-State: AGi0PuYd1Gb1WTb6azE16c7GnDyBbpsLhBMV9X9NPvyCCZlmn63UwtDj
        eicEQk5EadVYhO4Ke07E1kwdpw==
X-Google-Smtp-Source: APiQypJkgi7mb4hB7eQdKB38H51uXum0dmvB/gOW1e5Kl5ByipesokboMKiIw9H+fkPFvNkTvLGq6Q==
X-Received: by 2002:a1c:64c5:: with SMTP id y188mr4569354wmb.130.1587472195424;
        Tue, 21 Apr 2020 05:29:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m14sm3546680wrs.76.2020.04.21.05.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:29:54 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:29:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 01/11] drm/vblank: Register drmm cleanup action once per
 drm_vblank_crtc
Message-ID: <20200421122952.GX3456981@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20200417194145.36350-1-lyude@redhat.com>
 <20200417194145.36350-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417194145.36350-2-lyude@redhat.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 03:40:48PM -0400, Lyude Paul wrote:
> Since we'll be allocating resources for kthread_create_worker() in the
> next commit (which could fail and require us to clean up the mess),
> let's simplify the cleanup process a bit by registering a
> drm_vblank_init_release() action for each drm_vblank_crtc so they're
> still cleaned up if we fail to initialize one of them.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 758bf74e1cab..bf8de10c131f 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -491,16 +491,12 @@ static void vblank_disable_fn(struct timer_list *t)
>  
>  static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
>  {
> -	unsigned int pipe;
> -
> -	for (pipe = 0; pipe < dev->num_crtcs; pipe++) {
> -		struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
> +	struct drm_vblank_crtc *vblank = ptr;
>  
> -		WARN_ON(READ_ONCE(vblank->enabled) &&
> -			drm_core_check_feature(dev, DRIVER_MODESET));
> +	WARN_ON(READ_ONCE(vblank->enabled) &&
> +		drm_core_check_feature(dev, DRIVER_MODESET));
>  
> -		del_timer_sync(&vblank->disable_timer);
> -	}
> +	del_timer_sync(&vblank->disable_timer);
>  }
>  
>  /**
> @@ -529,10 +525,6 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
>  
>  	dev->num_crtcs = num_crtcs;
>  
> -	ret = drmm_add_action(dev, drm_vblank_init_release, NULL);
> -	if (ret)
> -		return ret;
> -
>  	for (i = 0; i < num_crtcs; i++) {
>  		struct drm_vblank_crtc *vblank = &dev->vblank[i];
>  
> @@ -541,6 +533,12 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
>  		init_waitqueue_head(&vblank->queue);
>  		timer_setup(&vblank->disable_timer, vblank_disable_fn, 0);
>  		seqlock_init(&vblank->seqlock);
> +
> +		ret = drmm_add_action(dev, drm_vblank_init_release, vblank);

drmm_add_action_or_reset probably what you want. I've gone so far an
unexport the plain variant.
-Daniel

> +		if (ret) {
> +			del_timer_sync(&vblank->disable_timer);
> +			return ret;
> +		}
>  	}
>  
>  	DRM_INFO("Supports vblank timestamp caching Rev 2 (21.10.2013).\n");
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
