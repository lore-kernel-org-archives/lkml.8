Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB338C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841D320848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ERJaH4Wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgBKLMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:12:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36462 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgBKLMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:12:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so3016044wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=O5X47mhFdBLYII+ovipBMRQxOXlboZKFhxKg7XFoN3o=;
        b=ERJaH4WdRW0ujkxGNpUmtUfj0rViDwqFLC9BL1MevFpQfOGkTANgOPHTSLMrZjO6rs
         BMayBrXbRGPDa0buloq70PFLyGYcCbrY0i6XcrAshig/nVydh2dMJz3LDv33DgLUjjHx
         lHW9A4kLs9UpNzmcgEFwcBL5c8Ryv2EWHwwXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=O5X47mhFdBLYII+ovipBMRQxOXlboZKFhxKg7XFoN3o=;
        b=M1pV+IO2xL1MLAJOq1OUjS/Huxrjsft7cOFPDD3B8pBuxOZNUU6JcwgtNtmPspw4Ga
         m5QbDKvTxllChxehTe4jTEa0NhVHfDEc9apsv2wOWMYap+de6eUI8PygzpDueAjh9slr
         PS2yGGbC7jlepcU1BYcHO70YBkKJEiFtkToustiiVlQ8ctZvYmdl5/386na6YpUYtIK1
         DSTT1bzdmadyQKNVCafbEa+ii52eNIYC5U4+e0/sW/L3cJ+xJApnnnlGL05tWIMYkwPv
         3YUyO6K62rUjyPjz4wm+QwZK0ewGMalGGCFZn5tGWctuRG5d1NrABZhyFpqk0JZB7zcG
         J2Cw==
X-Gm-Message-State: APjAAAUJDEhJtZAissv8X7bzYNGskRF6Yt+DxKiwWK/KrHCGvmyHwA7j
        8atgWfY2U9NCsgXeho+Egaza/g==
X-Google-Smtp-Source: APXvYqwyriEXRgirz1+pAvxW4hFmbaoVms/VDpWOOn1vdmA234bgCJnsmZ4O4rizOcVpaq1uLsrWXw==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr5437918wmi.152.1581419566111;
        Tue, 11 Feb 2020 03:12:46 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 18sm3378797wmf.1.2020.02.11.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 03:12:45 -0800 (PST)
Date:   Tue, 11 Feb 2020 12:12:43 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/bochs: add drm_driver.release callback.
Message-ID: <20200211111243.GX43062@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200211095529.30449-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211095529.30449-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:55:29AM +0100, Gerd Hoffmann wrote:
> Call bochs_unload via drm_driver.release to make sure we release stuff
> when it is safe to do so.  Use drm_dev_{enter,exit,unplug} to avoid
> touching hardware after device removal.  Tidy up here and there.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Still no changelog? I mean if we'd have merge request or something I can
easily check the discussions, but with mailing lists it's all over and I
have 0 memory, so every time I see a patch without history I get to
reconstruct the review history again and figure out where we've been. Gets
old real fast.
-Daniel

> ---
>  drivers/gpu/drm/bochs/bochs_drv.c |  6 +++---
>  drivers/gpu/drm/bochs/bochs_hw.c  | 24 +++++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index 10460878414e..addb0568c1af 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -23,7 +23,6 @@ static void bochs_unload(struct drm_device *dev)
>  
>  	bochs_kms_fini(bochs);
>  	bochs_mm_fini(bochs);
> -	bochs_hw_fini(dev);
>  	kfree(bochs);
>  	dev->dev_private = NULL;
>  }
> @@ -69,6 +68,7 @@ static struct drm_driver bochs_driver = {
>  	.major			= 1,
>  	.minor			= 0,
>  	DRM_GEM_VRAM_DRIVER,
> +	.release                = bochs_unload,
>  };
>  
>  /* ---------------------------------------------------------------------- */
> @@ -148,9 +148,9 @@ static void bochs_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  
> +	drm_dev_unplug(dev);
>  	drm_atomic_helper_shutdown(dev);
> -	drm_dev_unregister(dev);
> -	bochs_unload(dev);
> +	bochs_hw_fini(dev);
>  	drm_dev_put(dev);
>  }
>  
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index b615b7dfdd9d..952199cc0462 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -4,6 +4,7 @@
>  
>  #include <linux/pci.h>
>  
> +#include <drm/drm_drv.h>
>  #include <drm/drm_fourcc.h>
>  
>  #include "bochs.h"
> @@ -194,6 +195,8 @@ void bochs_hw_fini(struct drm_device *dev)
>  {
>  	struct bochs_device *bochs = dev->dev_private;
>  
> +	/* TODO: shot down existing vram mappings */
> +
>  	if (bochs->mmio)
>  		iounmap(bochs->mmio);
>  	if (bochs->ioports)
> @@ -207,6 +210,11 @@ void bochs_hw_fini(struct drm_device *dev)
>  void bochs_hw_setmode(struct bochs_device *bochs,
>  		      struct drm_display_mode *mode)
>  {
> +	int idx;
> +
> +	if (!drm_dev_enter(bochs->dev, &idx))
> +		return;
> +
>  	bochs->xres = mode->hdisplay;
>  	bochs->yres = mode->vdisplay;
>  	bochs->bpp = 32;
> @@ -232,11 +240,18 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>  
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,
>  			  VBE_DISPI_ENABLED | VBE_DISPI_LFB_ENABLED);
> +
> +	drm_dev_exit(idx);
>  }
>  
>  void bochs_hw_setformat(struct bochs_device *bochs,
>  			const struct drm_format_info *format)
>  {
> +	int idx;
> +
> +	if (!drm_dev_enter(bochs->dev, &idx))
> +		return;
> +
>  	DRM_DEBUG_DRIVER("format %c%c%c%c\n",
>  			 (format->format >>  0) & 0xff,
>  			 (format->format >>  8) & 0xff,
> @@ -256,13 +271,18 @@ void bochs_hw_setformat(struct bochs_device *bochs,
>  			  __func__, format->format);
>  		break;
>  	}
> +
> +	drm_dev_exit(idx);
>  }
>  
>  void bochs_hw_setbase(struct bochs_device *bochs,
>  		      int x, int y, int stride, u64 addr)
>  {
>  	unsigned long offset;
> -	unsigned int vx, vy, vwidth;
> +	unsigned int vx, vy, vwidth, idx;
> +
> +	if (!drm_dev_enter(bochs->dev, &idx))
> +		return;
>  
>  	bochs->stride = stride;
>  	offset = (unsigned long)addr +
> @@ -277,4 +297,6 @@ void bochs_hw_setbase(struct bochs_device *bochs,
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vwidth);
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
> +
> +	drm_dev_exit(idx);
>  }
> -- 
> 2.18.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
