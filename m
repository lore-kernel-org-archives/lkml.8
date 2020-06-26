Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55167C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADF2207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PLVdSe4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgFZUrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZUrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:47:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C98AC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:47:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t194so10543275wmt.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/Ea+qLyapMjkqF8q416MXgoOYTiC3N65am0udhxrn5A=;
        b=PLVdSe4ayKx1lUKmV+XUNx1u98xGglABLuz4wQg8gbgePDgVEzPvvRx6iWpSgLOJGz
         iNZarICH6/QVOj61k0JQ/CaTq2MSRlaop7/7wINfjGIAuVYde5+gvWQjVGJKpjXB+Kmk
         0NuwsSwMIflanz+zYC/qPWqdm/G8PoQj3YVsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=/Ea+qLyapMjkqF8q416MXgoOYTiC3N65am0udhxrn5A=;
        b=TN3pwougcnhvnWbvCGuwuOwCi9h+cqMkWo0dn+tbgpyme/6MlA5Z3ajN8BWdQ7+Y1m
         hsSuWRU0hiGj4Qcmq4YPkbPr56IjnTExhL+4ri67bHlJqQdozuFMgZrHUL34Kf2uC7Hm
         yJkAtEzxwre+5WTswvTYvNHN3E/lw+qJyfRbW7INfIvIZEPL0Ujzdq3i/am49gVlic0t
         dJ9RYM/SCLnQQrxhx8n91yJBSEovHnEaa0t8OU+wWzZOVs6CVLciENe94uyBoixv48fu
         1M+xyeJMHAUNraquZxgYhvz2E8BjMajLZYtktkqH4EPeiZFUkDTEw9ar2sjiGKS50/0W
         qvWw==
X-Gm-Message-State: AOAM532HJemYMQHTgaCDG3nyH0NylNR54pwBqDv3rawvu07DwlttGh/q
        HOabeRoBE79/NtXEzhGTapQQdw==
X-Google-Smtp-Source: ABdhPJx8Tto1cF8Id9IgyfYaYlK3h5do6M2mcNRScvbhep9L5XRc9KXOUP4W/mClPzUVKJO+DGwVaQ==
X-Received: by 2002:a7b:c403:: with SMTP id k3mr1452065wmi.35.1593204435910;
        Fri, 26 Jun 2020 13:47:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i17sm31758331wrc.34.2020.06.26.13.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:47:15 -0700 (PDT)
Date:   Fri, 26 Jun 2020 22:47:13 +0200
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
Subject: Re: [RFC v7 02/11] drm/vblank: Use spin_(un)lock_irq() in
 drm_crtc_vblank_off()
Message-ID: <20200626204713.GG3278063@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20200624230318.126256-1-lyude@redhat.com>
 <20200624230318.126256-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624230318.126256-3-lyude@redhat.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:03:09PM -0400, Lyude Paul wrote:
> This got me confused for a bit while looking over this code: I had been
> planning on adding some blocking function calls into this function, but
> seeing the irqsave/irqrestore variants of spin_(un)lock() didn't make it
> very clear whether or not that would actually be safe.
> 
> So I went ahead and reviewed every single driver in the kernel that uses
> this function, and they all fall into three categories:
> 
> * Driver probe code
> * ->atomic_disable() callbacks
> * Legacy modesetting callbacks
> 
> All of these will be guaranteed to have IRQs enabled, which means it's
> perfectly safe to block here. Just to make things a little less
> confusing to others in the future, let's switch over to
> spin_lock_irq()/spin_unlock_irq() to make that fact a little more
> obvious.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>

I think the patch is correct, but now we're having a bit a inconsistency,
since all other functions where the same applies still use _irqsave. I
looked through the file and I think drm_vblank_get, drm_crtc_vblank_reset,
drm_crtc_vblank_on and drm_legacy_vblank_post_modeset,
drm_queue_vblank_event and drm_crtc_queue_sequence_ioctl are all candiates
for the same cleanup.

Maybe follow up patches for less confusion?

On this:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_vblank.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index ce5c1e1d29963..e895f5331fdb4 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1283,13 +1283,12 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
>  	struct drm_pending_vblank_event *e, *t;
>  
>  	ktime_t now;
> -	unsigned long irqflags;
>  	u64 seq;
>  
>  	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>  		return;
>  
> -	spin_lock_irqsave(&dev->event_lock, irqflags);
> +	spin_lock_irq(&dev->event_lock);
>  
>  	spin_lock(&dev->vbl_lock);
>  	drm_dbg_vbl(dev, "crtc %d, vblank enabled %d, inmodeset %d\n",
> @@ -1325,7 +1324,7 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
>  		drm_vblank_put(dev, pipe);
>  		send_vblank_event(dev, e, seq, now);
>  	}
> -	spin_unlock_irqrestore(&dev->event_lock, irqflags);
> +	spin_unlock_irq(&dev->event_lock);
>  
>  	/* Will be reset by the modeset helpers when re-enabling the crtc by
>  	 * calling drm_calc_timestamping_constants(). */
> -- 
> 2.26.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
