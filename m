Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB14C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF0421919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SyOv/Pje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgIIRCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:02:45 -0400
Received: from crapouillou.net ([89.234.176.41]:40794 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730514AbgIIPrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599658022; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8lnoKhsCUY5CvSXbytb5xAOyRFedc3onw2Z1ZZ1SPc=;
        b=SyOv/PjepyWhbP/JwnQqHSaMVGCmaWeKb2UO2G0F8Ce3rgx+3tVPnUfEV2SqgW1eoaimK1
        htJzuC8vX2cDbF/mayd7tm9Osolvh2ZWeK36kJoo47VQNhc5D7XAKqCD9hhwEyBZPUStad
        G0Ly+P12ZqM1bRI9g1R6c8OWBZZfbgo=
Date:   Wed, 09 Sep 2020 15:26:52 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4] gpu/drm: ingenic: Add option to mmap GEM buffers
 cached
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-Id: <S08EGQ.NOF31L8HCYTS1@crapouillou.net>
In-Reply-To: <20200822164233.71583-1-paul@crapouillou.net>
References: <20200822164233.71583-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any love for my patch? I have more pending :)

Thanks,
-Paul


Le sam. 22 ao=FBt 2020 =E0 18:42, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> Ingenic SoCs are most notably used in cheap chinese handheld gaming
> consoles. There, the games and applications generally render in=20
> software
> directly into GEM buffers.
>=20
> Traditionally, GEM buffers are mapped write-combine. Writes to the
> buffer are accelerated, and reads are slow. Application doing lots of
> alpha-blending paint inside shadow buffers, which is then memcpy'd=20
> into
> the final GEM buffer.
>=20
> On recent Ingenic SoCs however, it is much faster to have a fully=20
> cached
> GEM buffer, in which applications paint directly, and whose data is
> invalidated before scanout, than having a write-combine GEM buffer,=20
> even
> when alpha blending is not used.
>=20
> Add an optional 'cached_gem_buffers' parameter to the ingenic-drm=20
> driver
> to allow GEM buffers to be mapped fully-cached, in order to speed up
> software rendering.
>=20
> v2: Use standard noncoherent DMA APIs
>=20
> v3: Use damage clips instead of invalidating full frames
>=20
> v4: Avoid dma_pgprot() which is not exported. Using vm_get_page_prot()
>     is enough in this case.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 107=20
> +++++++++++++++++++++-
>  drivers/gpu/drm/ingenic/ingenic-drm.h     |   4 +
>  drivers/gpu/drm/ingenic/ingenic-ipu.c     |  12 ++-
>  3 files changed, 119 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c=20
> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 5dab9c3d0a52..bf571411b73f 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -9,6 +9,8 @@
>  #include <linux/component.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma-noncoherent.h>
> +#include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -19,6 +21,7 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_damage_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_fb_cma_helper.h>
> @@ -76,6 +79,11 @@ static const u32 ingenic_drm_primary_formats[] =3D {
>  	DRM_FORMAT_XRGB8888,
>  };
>=20
> +static bool ingenic_drm_cached_gem_buf;
> +module_param_named(cached_gem_buffers, ingenic_drm_cached_gem_buf,=20
> bool, 0400);
> +MODULE_PARM_DESC(cached_gem_buffers,
> +		 "Enable fully cached GEM buffers [default=3Dfalse]");
> +
>  static bool ingenic_drm_writeable_reg(struct device *dev, unsigned=20
> int reg)
>  {
>  	switch (reg) {
> @@ -338,6 +346,8 @@ static int ingenic_drm_plane_atomic_check(struct=20
> drm_plane *plane,
>  	     plane->state->fb->format->format !=3D state->fb->format->format))
>  		crtc_state->mode_changed =3D true;
>=20
> +	drm_atomic_helper_check_plane_damage(state->state, state);
> +
>  	return 0;
>  }
>=20
> @@ -440,6 +450,38 @@ void ingenic_drm_plane_config(struct device *dev,
>  	}
>  }
>=20
> +void ingenic_drm_sync_data(struct device *dev,
> +			   struct drm_plane_state *old_state,
> +			   struct drm_plane_state *state)
> +{
> +	const struct drm_format_info *finfo =3D state->fb->format;
> +	struct ingenic_drm *priv =3D dev_get_drvdata(dev);
> +	struct drm_atomic_helper_damage_iter iter;
> +	unsigned int offset, i;
> +	struct drm_rect clip;
> +	dma_addr_t paddr;
> +	void *addr;
> +
> +	if (!ingenic_drm_cached_gem_buf)
> +		return;
> +
> +	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
> +
> +	drm_atomic_for_each_plane_damage(&iter, &clip) {
> +		for (i =3D 0; i < finfo->num_planes; i++) {
> +			paddr =3D drm_fb_cma_get_gem_addr(state->fb, state, i);
> +			addr =3D phys_to_virt(paddr);
> +
> +			/* Ignore x1/x2 values, invalidate complete lines */
> +			offset =3D clip.y1 * state->fb->pitches[i];
> +
> +			dma_cache_sync(priv->dev, addr + offset,
> +				       (clip.y2 - clip.y1) * state->fb->pitches[i],
> +				       DMA_TO_DEVICE);
> +		}
> +	}
> +}
> +
>  static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
>  					    struct drm_plane_state *oldstate)
>  {
> @@ -450,6 +492,8 @@ static void=20
> ingenic_drm_plane_atomic_update(struct drm_plane *plane,
>  	dma_addr_t addr;
>=20
>  	if (state && state->fb) {
> +		ingenic_drm_sync_data(priv->dev, oldstate, state);
> +
>  		addr =3D drm_fb_cma_get_gem_addr(state->fb, state, 0);
>  		width =3D state->src_w >> 16;
>  		height =3D state->src_h >> 16;
> @@ -605,7 +649,62 @@ static void ingenic_drm_disable_vblank(struct=20
> drm_crtc *crtc)
>  	regmap_update_bits(priv->map, JZ_REG_LCD_CTRL, JZ_LCD_CTRL_EOF_IRQ,=20
> 0);
>  }
>=20
> -DEFINE_DRM_GEM_CMA_FOPS(ingenic_drm_fops);
> +static struct drm_framebuffer *
> +ingenic_drm_gem_fb_create(struct drm_device *dev, struct drm_file=20
> *file,
> +			  const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	if (ingenic_drm_cached_gem_buf)
> +		return drm_gem_fb_create_with_dirty(dev, file, mode_cmd);
> +
> +	return drm_gem_fb_create(dev, file, mode_cmd);
> +}
> +
> +static int ingenic_drm_gem_mmap(struct drm_gem_object *obj,
> +				struct vm_area_struct *vma)
> +{
> +	struct drm_gem_cma_object *cma_obj =3D to_drm_gem_cma_obj(obj);
> +	struct device *dev =3D cma_obj->base.dev->dev;
> +
> +	if (!ingenic_drm_cached_gem_buf)
> +		return drm_gem_cma_prime_mmap(obj, vma);
> +
> +	/*
> +	 * Clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set=20
> the
> +	 * vm_pgoff (used as a fake buffer offset by DRM) to 0 as we want=20
> to map
> +	 * the whole buffer.
> +	 */
> +	vma->vm_flags &=3D ~VM_PFNMAP;
> +	vma->vm_pgoff =3D 0;
> +	vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
> +
> +	return dma_mmap_attrs(dev, vma, cma_obj->vaddr, cma_obj->paddr,
> +			      vma->vm_end - vma->vm_start,
> +			      DMA_ATTR_NON_CONSISTENT);
> +}
> +
> +static int ingenic_drm_gem_cma_mmap(struct file *filp,
> +				    struct vm_area_struct *vma)
> +{
> +	int ret;
> +
> +	ret =3D drm_gem_mmap(filp, vma);
> +	if (ret)
> +		return ret;
> +
> +	return ingenic_drm_gem_mmap(vma->vm_private_data, vma);
> +}
> +
> +static const struct file_operations ingenic_drm_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D drm_open,
> +	.release	=3D drm_release,
> +	.unlocked_ioctl	=3D drm_ioctl,
> +	.compat_ioctl	=3D drm_compat_ioctl,
> +	.poll		=3D drm_poll,
> +	.read		=3D drm_read,
> +	.llseek		=3D noop_llseek,
> +	.mmap		=3D ingenic_drm_gem_cma_mmap,
> +};
>=20
>  static struct drm_driver ingenic_drm_driver_data =3D {
>  	.driver_features	=3D DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
> @@ -669,7 +768,7 @@ static const struct drm_encoder_helper_funcs=20
> ingenic_drm_encoder_helper_funcs =3D
>  };
>=20
>  static const struct drm_mode_config_funcs=20
> ingenic_drm_mode_config_funcs =3D {
> -	.fb_create		=3D drm_gem_fb_create,
> +	.fb_create		=3D ingenic_drm_gem_fb_create,
>  	.output_poll_changed	=3D drm_fb_helper_output_poll_changed,
>  	.atomic_check		=3D drm_atomic_helper_check,
>  	.atomic_commit		=3D drm_atomic_helper_commit,
> @@ -796,6 +895,8 @@ static int ingenic_drm_bind(struct device *dev)
>  		return ret;
>  	}
>=20
> +	drm_plane_enable_fb_damage_clips(&priv->f1);
> +
>  	drm_crtc_helper_add(&priv->crtc, &ingenic_drm_crtc_helper_funcs);
>=20
>  	ret =3D drm_crtc_init_with_planes(drm, &priv->crtc, &priv->f1,
> @@ -821,6 +922,8 @@ static int ingenic_drm_bind(struct device *dev)
>  			return ret;
>  		}
>=20
> +		drm_plane_enable_fb_damage_clips(&priv->f0);
> +
>  		if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU)) {
>  			ret =3D component_bind_all(dev, drm);
>  			if (ret) {
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.h=20
> b/drivers/gpu/drm/ingenic/ingenic-drm.h
> index 43f7d959cff7..df99f0f75d39 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.h
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.h
> @@ -168,6 +168,10 @@ void ingenic_drm_plane_config(struct device *dev,
>  			      struct drm_plane *plane, u32 fourcc);
>  void ingenic_drm_plane_disable(struct device *dev, struct drm_plane=20
> *plane);
>=20
> +void ingenic_drm_sync_data(struct device *dev,
> +			   struct drm_plane_state *old_state,
> +			   struct drm_plane_state *state);
> +
>  extern struct platform_driver *ingenic_ipu_driver_ptr;
>=20
>  #endif /* DRIVERS_GPU_DRM_INGENIC_INGENIC_DRM_H */
> diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c=20
> b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> index fc8c6e970ee3..38c83e8cc6a5 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> @@ -20,6 +20,7 @@
>=20
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_damage_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_fourcc.h>
> @@ -316,6 +317,8 @@ static void=20
> ingenic_ipu_plane_atomic_update(struct drm_plane *plane,
>  				JZ_IPU_CTRL_CHIP_EN | JZ_IPU_CTRL_LCDC_SEL);
>  	}
>=20
> +	ingenic_drm_sync_data(ipu->master, oldstate, state);
> +
>  	/* New addresses will be committed in vblank handler... */
>  	ipu->addr_y =3D drm_fb_cma_get_gem_addr(state->fb, state, 0);
>  	if (finfo->num_planes > 1)
> @@ -534,7 +537,7 @@ static int ingenic_ipu_plane_atomic_check(struct=20
> drm_plane *plane,
>=20
>  	if (!state->crtc ||
>  	    !crtc_state->mode.hdisplay || !crtc_state->mode.vdisplay)
> -		return 0;
> +		goto out_check_damage;
>=20
>  	/* Plane must be fully visible */
>  	if (state->crtc_x < 0 || state->crtc_y < 0 ||
> @@ -551,7 +554,7 @@ static int ingenic_ipu_plane_atomic_check(struct=20
> drm_plane *plane,
>  		return -EINVAL;
>=20
>  	if (!osd_changed(state, plane->state))
> -		return 0;
> +		goto out_check_damage;
>=20
>  	crtc_state->mode_changed =3D true;
>=20
> @@ -578,6 +581,9 @@ static int ingenic_ipu_plane_atomic_check(struct=20
> drm_plane *plane,
>  	ipu->denom_w =3D denom_w;
>  	ipu->denom_h =3D denom_h;
>=20
> +out_check_damage:
> +	drm_atomic_helper_check_plane_damage(state->state, state);
> +
>  	return 0;
>  }
>=20
> @@ -759,6 +765,8 @@ static int ingenic_ipu_bind(struct device *dev,=20
> struct device *master, void *d)
>  		return err;
>  	}
>=20
> +	drm_plane_enable_fb_damage_clips(plane);
> +
>  	/*
>  	 * Sharpness settings range is [0,32]
>  	 * 0       : nearest-neighbor
> --
> 2.28.0
>=20


