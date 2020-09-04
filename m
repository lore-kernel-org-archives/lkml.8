Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432F5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7CD2083B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR7D9m7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgIDWZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 18:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgIDWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 18:25:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B0C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 15:25:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c19so8356370wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zrLMKNTk6DlVsGytrkOjXJuP9EZ+uCfXucuurHA8Ico=;
        b=pR7D9m7fwwnrGzLwdJ8SEXX1U3knoHlUsyXXJk/Vpbch67upO4xGNjK495qiSuCx1K
         tDtYwPT8Ci6WkuMzo0SUV8yGa3Rsj40iwhKK+QjQepkmHYYSWNHl8pkXJghNnblQh7du
         5VtqU6rMRbhrP+18V9FOTuYSomjr/fszmrHU7VGfy4Wtxm4ypWckvQnx282/unvwA4zn
         cKfUpj3NVloXsx6XOxsjSF1tz9wkj7k706t0gmTa5xN41881qcTPp7Dzybykm8VBjFom
         rg+nZ6TC+4eUO2xpr9A2LVZuiADcTyCEqx1O091JUm5eHdKvW36FZDFECvQcSOvMY+5N
         xVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zrLMKNTk6DlVsGytrkOjXJuP9EZ+uCfXucuurHA8Ico=;
        b=n104GwtTGNg5pN78GJNLvaiLdFzlr6EJ08vo8FqK/5VT/clYtsSsUq/HNvsK0E/egt
         5BKerNa0P1/4yQ1PVBmoVzKqXHCAHlobb12pv0JncYwIECQPG/pWh3LcXez/IldSmOA6
         s2YWKdL69Fz6TfY0MkqRpdhD0BWelSIxgjVWBLNwHNZOamFWOsU0x2H7GVu9RtIHSu+p
         T+lwMwHWmJG5E6fixOWlFkDpQY87cyeYtwIwP/P6NP4bE9YxkFT7kWFtMqv4Wiqsw+oN
         k3xPw6vdnmNl1HQcuCm88f2fwYRaa2pkaW6RPKJJJcaeydJYko+Dfa97tuhBD7ynR66r
         /eGw==
X-Gm-Message-State: AOAM5323qh33FA9iJZ2e+/cWmQkL3DPgnBI3iCX0YIEssc6BaN2jdjPT
        8EgD5V4J7adrcW7XemkRDyk=
X-Google-Smtp-Source: ABdhPJzqTEJ2dOzXpptUIAPmtvjGH9As3Cd1GrZ5RQU/T1NYe3VjZyD5W9jKJiN2faepRfGh/02mEA==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr10132668wmb.13.1599258343096;
        Fri, 04 Sep 2020 15:25:43 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id a15sm15481367wrn.3.2020.09.04.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 15:25:42 -0700 (PDT)
Date:   Fri, 4 Sep 2020 19:25:35 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        daniels@collabora.com, Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v6 1/3] drm/vkms: Decouple crc operations from composer
Message-ID: <20200904222535.j6ggfxyrlosrva6u@smtp.gmail.com>
References: <20200830142000.146706-1-rodrigosiqueiramelo@gmail.com>
 <20200830142000.146706-2-rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200830142000.146706-2-rodrigosiqueiramelo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/30, Rodrigo Siqueira wrote:
> In the vkms_composer.c, some of the functions related to CRC and compose
> have interdependence between each other. This patch reworks some
> functions inside vkms_composer to make crc and composer computation
> decoupled.
> 
> This patch is preparation work for making vkms able to support new
> features.
> 
> Tested-by: Melissa Wen <melissa.srw@gmail.com>
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 49 ++++++++++++++++------------
>  1 file changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index eaecc5a6c5db..f67d1baf1942 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -131,35 +131,31 @@ static void compose_cursor(struct vkms_composer *cursor_composer,
>  	      primary_composer, cursor_composer);
>  }
>  
> -static uint32_t _vkms_get_crc(struct vkms_composer *primary_composer,
> -			      struct vkms_composer *cursor_composer)
> +static int compose_planes(void **vaddr_out,
> +			  struct vkms_composer *primary_composer,
> +			  struct vkms_composer *cursor_composer)
>  {
>  	struct drm_framebuffer *fb = &primary_composer->fb;
>  	struct drm_gem_object *gem_obj = drm_gem_fb_get_obj(fb, 0);
>  	struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(gem_obj);
> -	void *vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
> -	u32 crc = 0;
>  
> -	if (!vaddr_out) {
> -		DRM_ERROR("Failed to allocate memory for output frame.");
> -		return 0;
> +	if (!*vaddr_out) {
> +		*vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
> +		if (!*vaddr_out) {
> +			DRM_ERROR("Cannot allocate memory for output frame.");
> +			return -ENOMEM;
> +		}
>  	}
>  
> -	if (WARN_ON(!vkms_obj->vaddr)) {
> -		kfree(vaddr_out);
> -		return crc;
> -	}
> +	if (WARN_ON(!vkms_obj->vaddr))
> +		return -EINVAL;
>  
> -	memcpy(vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
> +	memcpy(*vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
>  
>  	if (cursor_composer)
> -		compose_cursor(cursor_composer, primary_composer, vaddr_out);
> +		compose_cursor(cursor_composer, primary_composer, *vaddr_out);
>  
> -	crc = compute_crc(vaddr_out, primary_composer);
> -
> -	kfree(vaddr_out);
> -
> -	return crc;
> +	return 0;
>  }
>  
>  /**
> @@ -180,9 +176,11 @@ void vkms_composer_worker(struct work_struct *work)
>  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
>  	struct vkms_composer *primary_composer = NULL;
>  	struct vkms_composer *cursor_composer = NULL;
> +	void *vaddr_out = NULL;
>  	u32 crc32 = 0;
>  	u64 frame_start, frame_end;
>  	bool crc_pending;
> +	int ret;
>  
>  	spin_lock_irq(&out->composer_lock);
>  	frame_start = crtc_state->frame_start;
> @@ -206,14 +204,25 @@ void vkms_composer_worker(struct work_struct *work)
>  	if (crtc_state->num_active_planes == 2)
>  		cursor_composer = crtc_state->active_planes[1]->composer;
>  
> -	if (primary_composer)
> -		crc32 = _vkms_get_crc(primary_composer, cursor_composer);
> +	if (!primary_composer)
> +		return;
> +
> +	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
> +	if (ret) {
> +		if (ret == -EINVAL)
> +			kfree(vaddr_out);
> +		return;
> +	}
> +
> +	crc32 = compute_crc(vaddr_out, primary_composer);
>  
>  	/*
>  	 * The worker can fall behind the vblank hrtimer, make sure we catch up.
>  	 */
>  	while (frame_start <= frame_end)
>  		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
> +
> +	kfree(vaddr_out);
>  }
>  
>  static const char * const pipe_crc_sources[] = {"auto"};
> -- 
> 2.28.0
>

I noticed two improvements: for a pre-existing op (alloc), but that
could affect the logic of the next patch; and another one (kfree -
release vaddr_out earlier, when it’s no longer needed) that you also
adjusted in the next one and is harmless here.

So, looking as a preparation for the writeback patch, I tested and
consider that this rework keeps operations stable here.

Reviewed-by: Melissa Wen <melissa.srw@gmail.com>
