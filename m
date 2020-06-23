Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19173C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F882076E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AgZt1w4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbgFWQRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgFWQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:17:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC0C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:17:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so21190806wru.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mtC3PJGWDMIcehgxPBpR+PLKV5Q1ssV6CDNH3+eOQLw=;
        b=AgZt1w4gGD2RpEAMlnkEkOstZUnDRyAAjz/EQMmp6yPl3Lis6UbhheQUte9x7A3Sl8
         INAAavAqBXoG8u813E9qRNezIwY3TA/qTfYzBEtibXtlJot3xHssjhseNF9Iko9zdxlZ
         gSBzxiH+ouRSdrfa366RTmwgZ2QRhz5Frxqn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=mtC3PJGWDMIcehgxPBpR+PLKV5Q1ssV6CDNH3+eOQLw=;
        b=BxkmvMW1+e76fwxIFzPdt2EqyUe42VmYhrAc12z4LiZQUjGTwSVqLOxnFyOOhwYV6r
         0dNdAdYHuWeY/kToOPvS3EyHMYfKjFqIoUxjJoAFGGOQIVKLqWhNhF7hW2SyNVaosQcu
         9gmX/28DC7Fr+hac938bDo6YNDrtepQmrHL8STnhgaq86q1ieLG5ENO4EX/Yn4E0DtDp
         l3eVsRvQpM2SgMwpI5ckoRZXYw1OiHxqmg04a+plYnjmUj/B97CCtnsTr7PN4GGgWRar
         RxDg8XnQu1n22DZoL/PSY1KX2JIR6HNR5koc+Gk+VyngqQO+7CGEvxwMBORsjpgWqZt/
         gASA==
X-Gm-Message-State: AOAM5338PLBoHT4WZVa1FO0cDa1rrKuwP5CgRbV3oBy+VvacyaO87hhN
        sF38xx115qJ0WQTB93/RJWYnaA==
X-Google-Smtp-Source: ABdhPJyWm7Jfm7MiyZs5D80QWQxf/J5hWl6QhbRvpHGCjtbEL/+fbiu5ejjrpoum+qf6AjPPBpCveg==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr5383859wrm.304.1592929064445;
        Tue, 23 Jun 2020 09:17:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y19sm4146273wmi.6.2020.06.23.09.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 09:17:43 -0700 (PDT)
Date:   Tue, 23 Jun 2020 18:17:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v5 01/10] drm/vblank: Register drmm cleanup action once per
 drm_vblank_crtc
Message-ID: <20200623161741.GN20149@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20200622200730.120716-1-lyude@redhat.com>
 <20200622200730.120716-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200622200730.120716-2-lyude@redhat.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 04:07:21PM -0400, Lyude Paul wrote:
> Since we'll be allocating resources for kthread_create_worker() in the
> next commit (which could fail and require us to clean up the mess),
> let's simplify the cleanup process a bit by registering a
> drm_vblank_init_release() action for each drm_vblank_crtc so they're
> still cleaned up if we fail to initialize one of them.
> 
> Changes since v3:
> * Use drmm_add_action_or_reset() - Daniel Vetter
> 
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 85e5f2db16085..ce5c1e1d29963 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -492,16 +492,12 @@ static void vblank_disable_fn(struct timer_list *t)
>  
>  static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
>  {
> -	unsigned int pipe;
> -
> -	for (pipe = 0; pipe < dev->num_crtcs; pipe++) {
> -		struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
> +	struct drm_vblank_crtc *vblank = ptr;
>  
> -		drm_WARN_ON(dev, READ_ONCE(vblank->enabled) &&
> -			    drm_core_check_feature(dev, DRIVER_MODESET));
> +	drm_WARN_ON(dev, READ_ONCE(vblank->enabled) &&
> +		    drm_core_check_feature(dev, DRIVER_MODESET));
>  
> -		del_timer_sync(&vblank->disable_timer);
> -	}
> +	del_timer_sync(&vblank->disable_timer);
>  }
>  
>  /**
> @@ -511,7 +507,7 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
>   *
>   * This function initializes vblank support for @num_crtcs display pipelines.
>   * Cleanup is handled automatically through a cleanup function added with
> - * drmm_add_action().
> + * drmm_add_action_or_reset().
>   *
>   * Returns:
>   * Zero on success or a negative error code on failure.
> @@ -530,10 +526,6 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
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
> @@ -542,6 +534,11 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
>  		init_waitqueue_head(&vblank->queue);
>  		timer_setup(&vblank->disable_timer, vblank_disable_fn, 0);
>  		seqlock_init(&vblank->seqlock);
> +
> +		ret = drmm_add_action_or_reset(dev, drm_vblank_init_release,
> +					       vblank);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> -- 
> 2.26.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
