Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E14EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A69A2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Po4eTrKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCFLIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:08:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50617 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:08:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so1940946wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 03:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=7sHD6CjQ22ZwQRigFX726J4p2bWMAR4ljphlUJcoYAY=;
        b=Po4eTrKTy/hIT89j6SjWAKG3l7sTUwlpHMXmqtkp7pbCRmWtb4lPeWcxoj801ag9Ep
         fHDomNyvJH3mgX40pqhUqCbNwxt0fsj8lTv085lm/A8Ex981ERxWeUd/rMFLwvPwgKQl
         FdFaU5tzI/bMdYNhm7EZq1JnhHpniL+pxbrXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7sHD6CjQ22ZwQRigFX726J4p2bWMAR4ljphlUJcoYAY=;
        b=bane30A3By73PDGaz9PFoiSilQbGV/z46G6w03LEI4ogdLuvHQuq/yMoKnsaHERwgZ
         YuvQ/UVYtxAw3xndlfZSY/69n8NtCar/54SUpXOxE1RTz4FK+OzXSa5kaCREuKTLDo5P
         9+Q0os678rhmh4mz9BpuYOXPOXyC8GoaYeNAELtNbePhxUFBsNetYEdXUzsXUxbHnSZ7
         fzFewYUBzaWxw6kHLudgmvEfFctrsc4Lw/EvlLoZTrHSUb7ZnPbX9y6Wyq+EUs0/nIks
         rEHqc+q/yKVeCqDbYZZ1++mqBmSGfYhXwuy53Eu1/B/rkRjBNptkB23Gh3ME231+fjk2
         uNCg==
X-Gm-Message-State: ANhLgQ3U6NdoAfDmr9ysEcfW+33Q7Do0XJaJJ2WOrbN+Bwcne2108Gki
        nNcgpVyaUclbz/eV3gajXrWYAA==
X-Google-Smtp-Source: ADFU+vtrTfTU2MnfW7j+yGNHZz5hdcacHAa5j7Yz7XI/rd1ollajRTpBJ+5mTOX4x6dxHsunYT4lEw==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr3328009wmc.57.1583492900393;
        Fri, 06 Mar 2020 03:08:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j20sm13605554wmj.46.2020.03.06.03.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 03:08:19 -0800 (PST)
Date:   Fri, 6 Mar 2020 12:08:17 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        emil.l.velikov@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: context: Clean up documentation
Message-ID: <20200306110817.GZ2363188@phenom.ffwll.local>
Mail-Followup-To: Benjamin Gaignard <benjamin.gaignard@st.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, emil.l.velikov@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200306102937.4932-1-benjamin.gaignard@st.com>
 <20200306102937.4932-4-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306102937.4932-4-benjamin.gaignard@st.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 11:29:37AM +0100, Benjamin Gaignard wrote:
> Fix kernel doc comments to avoid warnings when compiling with W=1.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 2:
> - Since it is legacy interface do not fix the description but
>   replace /** by /* to remove kerneldoc validation warnings

On the entire series:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
>  drivers/gpu/drm/drm_context.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
> index 1f802d8e5681..c99be950bf17 100644
> --- a/drivers/gpu/drm/drm_context.c
> +++ b/drivers/gpu/drm/drm_context.c
> @@ -47,7 +47,7 @@ struct drm_ctx_list {
>  /** \name Context bitmap support */
>  /*@{*/
>  
> -/**
> +/*
>   * Free a handle from the context bitmap.
>   *
>   * \param dev DRM device.
> @@ -68,7 +68,7 @@ void drm_legacy_ctxbitmap_free(struct drm_device * dev, int ctx_handle)
>  	mutex_unlock(&dev->struct_mutex);
>  }
>  
> -/**
> +/*
>   * Context bitmap allocation.
>   *
>   * \param dev DRM device.
> @@ -88,7 +88,7 @@ static int drm_legacy_ctxbitmap_next(struct drm_device * dev)
>  	return ret;
>  }
>  
> -/**
> +/*
>   * Context bitmap initialization.
>   *
>   * \param dev DRM device.
> @@ -104,7 +104,7 @@ void drm_legacy_ctxbitmap_init(struct drm_device * dev)
>  	idr_init(&dev->ctx_idr);
>  }
>  
> -/**
> +/*
>   * Context bitmap cleanup.
>   *
>   * \param dev DRM device.
> @@ -163,7 +163,7 @@ void drm_legacy_ctxbitmap_flush(struct drm_device *dev, struct drm_file *file)
>  /** \name Per Context SAREA Support */
>  /*@{*/
>  
> -/**
> +/*
>   * Get per-context SAREA.
>   *
>   * \param inode device inode.
> @@ -211,7 +211,7 @@ int drm_legacy_getsareactx(struct drm_device *dev, void *data,
>  	return 0;
>  }
>  
> -/**
> +/*
>   * Set per-context SAREA.
>   *
>   * \param inode device inode.
> @@ -263,7 +263,7 @@ int drm_legacy_setsareactx(struct drm_device *dev, void *data,
>  /** \name The actual DRM context handling routines */
>  /*@{*/
>  
> -/**
> +/*
>   * Switch context.
>   *
>   * \param dev DRM device.
> @@ -290,7 +290,7 @@ static int drm_context_switch(struct drm_device * dev, int old, int new)
>  	return 0;
>  }
>  
> -/**
> +/*
>   * Complete context switch.
>   *
>   * \param dev DRM device.
> @@ -318,7 +318,7 @@ static int drm_context_switch_complete(struct drm_device *dev,
>  	return 0;
>  }
>  
> -/**
> +/*
>   * Reserve contexts.
>   *
>   * \param inode device inode.
> @@ -351,7 +351,7 @@ int drm_legacy_resctx(struct drm_device *dev, void *data,
>  	return 0;
>  }
>  
> -/**
> +/*
>   * Add context.
>   *
>   * \param inode device inode.
> @@ -404,7 +404,7 @@ int drm_legacy_addctx(struct drm_device *dev, void *data,
>  	return 0;
>  }
>  
> -/**
> +/*
>   * Get context.
>   *
>   * \param inode device inode.
> @@ -428,7 +428,7 @@ int drm_legacy_getctx(struct drm_device *dev, void *data,
>  	return 0;
>  }
>  
> -/**
> +/*
>   * Switch context.
>   *
>   * \param inode device inode.
> @@ -452,7 +452,7 @@ int drm_legacy_switchctx(struct drm_device *dev, void *data,
>  	return drm_context_switch(dev, dev->last_context, ctx->handle);
>  }
>  
> -/**
> +/*
>   * New context.
>   *
>   * \param inode device inode.
> @@ -478,7 +478,7 @@ int drm_legacy_newctx(struct drm_device *dev, void *data,
>  	return 0;
>  }
>  
> -/**
> +/*
>   * Remove context.
>   *
>   * \param inode device inode.
> -- 
> 2.15.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
