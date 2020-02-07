Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435FFC352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E6A21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Q6ayxrGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGNmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:42:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53214 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGNmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:42:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so2640893wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=TyPPRLKeipDPd+u8tqRuMDYkhQE0y3JFQkWBFGYN/N8=;
        b=Q6ayxrGsTc4a7zvF4JrnE8pm2eVELARdVSK6Pfhkt5GjlpNQouAG/N05fastzNDYtV
         0s/3GOaVVtss8j7chaZqG7vGZQRceoD5tg/UC5OVWooSkOcqvpqBBdeYlbu8DDxfb+oM
         BOI3HVjzmrTIXfiK6zcpxNhHPSzQPSjhdF8vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=TyPPRLKeipDPd+u8tqRuMDYkhQE0y3JFQkWBFGYN/N8=;
        b=NFCh3nt+IyGZ29PcDnkOw6/0raTLlSGkNEmL8ot7ks4pAi2/D4kSYyBLM3qIg427ar
         cocvJamC6VJbATp9wPSTWUjZt3o2dWqOh3vdJQTKYH426dTypx2whimscbl3f14gAJ2y
         LFe9wcVZLo13GhNIGp+bH3fQ22k8/IlPUgaC+LKDthMh1cfASh80IwTOjijBNkcDNm/w
         BGppMkb6ASxshmbGW/H38ActX0hr6KzuTcDyEOAVAZme5Wa9EhCogqbWnDM/TxxjoNNK
         wTSPSUr5RACksLu44HGYIsNhhjpCTZRMeb1FVa3d32LVSGzAUlsktnnHPCv/+rKXQLoN
         cKUg==
X-Gm-Message-State: APjAAAWI+C919tDxD2sa4LBKL6ej7AFwPB9kPy2qVLhG66CJEURvBVgi
        QfWpow+mkfyWFDglKGtXVmdYag==
X-Google-Smtp-Source: APXvYqxhatD4Js1NKtiy3XyO7Te5rVWuR1uUeZlh84mCoY9NL3oeMACk2iagMiLuPOki+LjjhnCnBA==
X-Received: by 2002:a1c:9a84:: with SMTP id c126mr4594084wme.111.1581082948462;
        Fri, 07 Feb 2020 05:42:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i16sm3175338wrr.71.2020.02.07.05.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:42:27 -0800 (PST)
Date:   Fri, 7 Feb 2020 14:42:25 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bochs: add drm_driver.release callback.
Message-ID: <20200207134225.GA43062@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200207121312.25296-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207121312.25296-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 01:13:12PM +0100, Gerd Hoffmann wrote:
> From: Gurchetan Singh <gurchetansingh@chromium.org>
> 
> Move bochs_unload call from bochs_remove() to the new bochs_release()
> callback.  Also call drm_dev_unregister() first in bochs_remove().
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index 10460878414e..87ee1eb21a4d 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -60,6 +60,11 @@ static int bochs_load(struct drm_device *dev)
>  
>  DEFINE_DRM_GEM_FOPS(bochs_fops);
>  
> +static void bochs_release(struct drm_device *dev)
> +{
> +	bochs_unload(dev);

Hm I think this needs to be split, and bochs_hw_fini needs to stay in
bochs_pci_remove. Otherwise we again release the iommu mappings too late
(there was just a discussion about that on the fbdev side of things
getting this wrong). Good to fix the lifetime fun here, but let's not move
too far :-)

Ideally we'd move the iomapping to devm_, that would remove it at the
right time I think.

Slight annoyance might be that we then need to shoot down the varios
mmaps, which I frankly don't know how to do. But keeping them pointing at
wrong stuff also isn't that great :-/

Cheers, Daniel

> +}
> +
>  static struct drm_driver bochs_driver = {
>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>  	.fops			= &bochs_fops,
> @@ -69,6 +74,7 @@ static struct drm_driver bochs_driver = {
>  	.major			= 1,
>  	.minor			= 0,
>  	DRM_GEM_VRAM_DRIVER,
> +	.release                = bochs_release,
>  };
>  
>  /* ---------------------------------------------------------------------- */
> @@ -148,9 +154,8 @@ static void bochs_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  
> -	drm_atomic_helper_shutdown(dev);
>  	drm_dev_unregister(dev);
> -	bochs_unload(dev);
> +	drm_atomic_helper_shutdown(dev);
>  	drm_dev_put(dev);
>  }
>  
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
