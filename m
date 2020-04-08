Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16E7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3E320747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kJEFQeSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgDHMHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:07:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40507 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDHMHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:07:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id s8so7499390wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=04au/APisT4u3ZJd0QGSjFIKoPfTw5pesO0fdtrLymc=;
        b=kJEFQeSnI1uVfFX6eyEXnFmr59bbMNp9Kq8p6qdur6HnMwJfRykaYZqrKCOyxIqS4l
         gRa1TLDbpgRZVEwdO1gwW5zCoMcHogN3Rrrmy4HM7ZRH6tsX8NvFbTCYnwpwy6ZlLWGt
         0PSS5z8Q+MJtPOKTk/V0DC4gdkje1IzxCxzSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=04au/APisT4u3ZJd0QGSjFIKoPfTw5pesO0fdtrLymc=;
        b=ss+uZbGJkIitiIl41BEsu0pAMqNKUq8Ri1eQDYKq/lFqlK+ifdO2Y9D7pOCDC+8Q/C
         Lu35bKn3qj/vusEpgRdrGq9Ym/v427NllLCUA0DBinmyGyIkhcVDkUp3tH+SS+hsMmRe
         RsdBKBhRC0AEZZBmMlwapcJxoPbdkYay6s1tkqlek+H3wdrIk448+gCvN9E7cJQYpv9m
         /qn9/cyUecrucfvLFuNxa+jpy/KMXnsuY/7s681HOqlpiFZzPlYMyRd/hNGJRmLoh8UJ
         dEXOJApNJ1rUWAgv3785r5wLl3qSFb6n/RsC1csWLRwHxvessroNp2yT0uPVjjc19ifG
         aOWA==
X-Gm-Message-State: AGi0PuZIpGwFEQ54fGlFv4oy0/h6G8RbcVOPei0RImXHkCYTgcQ0TO3i
        RmWVsjqv7cQah1OBcmQkk9bHNw==
X-Google-Smtp-Source: APiQypIw1uVDCJzq54weB3MKg/1sOyfu5lDNKgL29rpnZAQ1e/t2RVvpNhAWEBamcNKLB2zMkKbiqw==
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr8031430wru.35.1586347621345;
        Wed, 08 Apr 2020 05:07:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 91sm30402064wrf.79.2020.04.08.05.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 05:07:00 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:06:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] gpu/drm: ingenic: Add option to mmap GEM buffers
 cached
Message-ID: <20200408120658.GK3456981@phenom.ffwll.local>
Mail-Followup-To: Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200226043041.289764-1-paul@crapouillou.net>
 <20200226043041.289764-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226043041.289764-3-paul@crapouillou.net>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:30:41AM -0300, Paul Cercueil wrote:
> Ingenic SoCs are most notably used in cheap chinese handheld gaming
> consoles. There, the games and applications generally render in software
> directly in the emulated framebuffer using SDL1.
> 
> Since the emulated framebuffer is mapped as write-combine by default,
> these applications start to run really slow as soon as alpha-blending is
> used.
> 
> Add a 'cached_gem_buffers' option to the ingenic-drm driver to mmap the
> GEM buffers as fully cached to address this issue.
> 
> v2: Use standard noncoherent DMA APIs
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Dumb buffers don't have any cache flushing controls, so without a ->dirty
callback I'm not sure how this exactly works. I think you need a pile more
here.

Also there's a prefere_shadow bit that you're supposed to set in this
case, and which userspace is supposed to obey.

Also kinda surprised that fbdev userspace is this bad, since generally all
of fbdev is wc. Traditionally at least.
-Daniel

> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 35 +++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index 3f8cc98d41fe..e51ac8d62d27 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -6,6 +6,8 @@
>  
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma-noncoherent.h>
> +#include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -30,6 +32,11 @@
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
>  
> +static bool ingenic_drm_cached_gem_buf;
> +module_param_named(cached_gem_buffers, ingenic_drm_cached_gem_buf, bool, 0400);
> +MODULE_PARM_DESC(cached_gem_buffers,
> +		 "Enable fully cached GEM buffers [default=false]");
> +
>  #define JZ_REG_LCD_CFG				0x00
>  #define JZ_REG_LCD_VSYNC			0x04
>  #define JZ_REG_LCD_HSYNC			0x08
> @@ -379,15 +386,23 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
>  	struct drm_plane_state *state = plane->state;
>  	unsigned int width, height, cpp;
>  	dma_addr_t addr;
> +	uint32_t len;
>  
>  	if (state && state->fb) {
>  		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
> +
>  		width = state->src_w >> 16;
>  		height = state->src_h >> 16;
>  		cpp = state->fb->format->cpp[plane->index];
> +		len = width * height * cpp;
> +
> +		if (ingenic_drm_cached_gem_buf) {
> +			dma_cache_sync(priv->dev, phys_to_virt(addr),
> +				       len, DMA_TO_DEVICE);
> +		}
>  
>  		priv->dma_hwdesc->addr = addr;
> -		priv->dma_hwdesc->cmd = width * height * cpp / 4;
> +		priv->dma_hwdesc->cmd = len / 4;
>  		priv->dma_hwdesc->cmd |= JZ_LCD_CMD_EOF_IRQ;
>  	}
>  }
> @@ -532,6 +547,22 @@ static void ingenic_drm_disable_vblank(struct drm_crtc *crtc)
>  
>  DEFINE_DRM_GEM_CMA_FOPS(ingenic_drm_fops);
>  
> +static int ingenic_drm_gem_mmap(struct drm_gem_object *obj,
> +				struct vm_area_struct *vma)
> +{
> +	struct drm_gem_cma_object *cma_obj = to_drm_gem_cma_obj(obj);
> +	struct ingenic_drm *priv = drm_device_get_priv(obj->dev);
> +	unsigned long attrs = DMA_ATTR_NON_CONSISTENT;
> +
> +	if (!ingenic_drm_cached_gem_buf)
> +		return drm_gem_cma_prime_mmap(obj, vma);
> +
> +	vma->vm_page_prot = dma_pgprot(priv->dev, vma->vm_page_prot, attrs);
> +
> +	return dma_mmap_attrs(priv->dev, vma, cma_obj->vaddr, cma_obj->paddr,
> +			      vma->vm_end - vma->vm_start, attrs);
> +}
> +
>  static struct drm_driver ingenic_drm_driver_data = {
>  	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
>  	.name			= "ingenic-drm",
> @@ -553,7 +584,7 @@ static struct drm_driver ingenic_drm_driver_data = {
>  	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
>  	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
>  	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
> -	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
> +	.gem_prime_mmap		= ingenic_drm_gem_mmap,
>  
>  	.irq_handler		= ingenic_drm_irq_handler,
>  	.release		= ingenic_drm_release,
> -- 
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
