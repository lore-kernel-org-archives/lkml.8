Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AA6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9C520717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="C2CLeA5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGUGvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGUGvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 02:51:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7C6C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 23:51:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so1655640wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uMFpsvsNNP6MKesBssmiMnuweAD24fW+1O/tLheu5Zg=;
        b=C2CLeA5To3e4BloeLaJunQeYGBKz2AvkS38RTnDVix5hHZ53zV06BFfemlXZHTokT+
         qNwNMA/jwqGGq76e3kzbWqBGBeZMTHksyT8ZCE7fDoPBRnJaULKrawpvJwgxCpW7O6v+
         yX0YO8xY6OWBdjzcqdKospdhBVh8EUOefn8Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uMFpsvsNNP6MKesBssmiMnuweAD24fW+1O/tLheu5Zg=;
        b=e6v39xT9aHLtfTCgVOVftOzuXM2Re5gLRd0cH2fd1CocbPILwJ+8claauRSZIAdHSD
         FfINvIXrd3lB821jhOicw1J8ZwyoBnWhiA/LtS10hyEPUDv2gcyZXIfg93hs3rw18R6K
         BhD1EqISarNNC2aRsVdaajZ3qeGA93LEEGfkl8U6ASeB89FM9xfcqLBICqj88q8WdyRF
         ujrJpq3bs2jXxyCMF1Tn3wgQjdpYQfSZHLekK6I+EQs+Vudz5OuLDpOgtQH9mVWBLl7X
         1kMT0B0Ja6m7VR09gPaLsYTup09ordNhLOgaSHROXJx5xwMOsaYD0Lg6AI7bHK5pznGh
         sd3A==
X-Gm-Message-State: AOAM532Z1XCbtsT3XzrowQSDRET1FhEBgWqyCC4QvnbGs/v1JsJ0agAu
        djRKOkEPJaFplQ2CRh/hjzqRNA==
X-Google-Smtp-Source: ABdhPJwR2BSBICyGOtkpsVgNaBsnRWKDYhtYUDAraFMDIKTsjTTEKffnZSGzwig3Qiscu1XI79d80w==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr2431121wmh.96.1595314260655;
        Mon, 20 Jul 2020 23:51:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y6sm36462880wrr.74.2020.07.20.23.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 23:51:00 -0700 (PDT)
Date:   Tue, 21 Jul 2020 08:50:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] drm/vblank: Use spin_(un)lock_irq() in
 drm_queue_vblank_event()
Message-ID: <20200721065058.GA3278063@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20200720190736.180297-1-lyude@redhat.com>
 <20200720190736.180297-5-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720190736.180297-5-lyude@redhat.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 03:07:35PM -0400, Lyude Paul wrote:
> This one's easy - we're already calling kzalloc() in this function, so

Nit: "kzalloc(GFP_KERNEL)", since kzalloc(GFP_ATOMIC) is perfectly fine in
interrupt context. With that clarified for the entire series:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> we must already be guaranteed to have IRQs enabled when calling this.
> So, use the plain _irq() variants of spin_(un)lock() to make this more
> obvious.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_vblank.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 51f2e988205e7..64610070ba473 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1611,7 +1611,6 @@ static int drm_queue_vblank_event(struct drm_device *dev, unsigned int pipe,
>  	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
>  	struct drm_pending_vblank_event *e;
>  	ktime_t now;
> -	unsigned long flags;
>  	u64 seq;
>  	int ret;
>  
> @@ -1633,7 +1632,7 @@ static int drm_queue_vblank_event(struct drm_device *dev, unsigned int pipe,
>  			e->event.vbl.crtc_id = crtc->base.id;
>  	}
>  
> -	spin_lock_irqsave(&dev->event_lock, flags);
> +	spin_lock_irq(&dev->event_lock);
>  
>  	/*
>  	 * drm_crtc_vblank_off() might have been called after we called
> @@ -1670,12 +1669,12 @@ static int drm_queue_vblank_event(struct drm_device *dev, unsigned int pipe,
>  		vblwait->reply.sequence = req_seq;
>  	}
>  
> -	spin_unlock_irqrestore(&dev->event_lock, flags);
> +	spin_unlock_irq(&dev->event_lock);
>  
>  	return 0;
>  
>  err_unlock:
> -	spin_unlock_irqrestore(&dev->event_lock, flags);
> +	spin_unlock_irq(&dev->event_lock);
>  	kfree(e);
>  err_put:
>  	drm_vblank_put(dev, pipe);
> -- 
> 2.26.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
