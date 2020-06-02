Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B38F20678
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5UFb2x7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFBMSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:18:03 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3630C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:18:01 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id c9so1146403uao.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 05:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQd65JdrIuZXHebA6USGvqPn3CMVEk7jUwm6XZRDHjM=;
        b=u5UFb2x7dOFvmbn54KARGcHKlOYMT19j0xlf6X5jRYfQNkt6PgwFEMkhjduczOuKUQ
         3vo73JZvAtJ/lPsZx4DWk7FLqk1+pZ9cjldVGZ7HBkYwt6ClzgC2lFsd9ArRe0HxnTrA
         1DNlNYhpU3n39O+yz/VtXsguV4j8mR9x0bgUfAWhKUQnKmRyMcOFEgsiQJ0ny0AHT6qs
         vO95Nz3Ea1CaXvU9MtvuWiHyWkLScHhvP/MVxFys1t3669g3u4wxlikyfLv4hS2S3/3T
         wNeorMFFKl5nosHbJR5Iw5V6SZ+S+5+RzI95n+aiY76dy2crl5gvZ3aEUQviQJECWM1c
         36jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQd65JdrIuZXHebA6USGvqPn3CMVEk7jUwm6XZRDHjM=;
        b=Wg99y92TV95ZwqXY65y/3qm5a91FS/6PC+zcbyTugoJcg06EhSGGR6dTVFB4wxQVdS
         z2cm1N6cyKhNDb0ykXn4bSK2QjsjyECip8NdFfEN71ju4lY1wMEiXhLK3nI6FKxwEOkS
         TVSwA04yZWzZ90l3Jixj9fMtUiGwEfMu15B1IinfVCGr1IINH+Z9qB/WdylcRUPBWzvF
         ZbQQG39fezwKqikD2C+b7aNIxRAlo2UoPzezbKTHWa9iKtRBjkN5KT2VJ4oDedcWPSWF
         1yGvr8hO241d/CLbvrqMDEHX0/YKGVnn7Bt0ZMIAl9stsqZk3h0Em9moKYxsJgrWpaB6
         uhIg==
X-Gm-Message-State: AOAM5336xEzMF6keT7wrJHgJWQrCDDsL6cfgRECgTcY3v7IQk4kNnMe3
        VUqbR/QtYHd2ZnDnBeyaYiyyUDT8/JrrY6kB4us=
X-Google-Smtp-Source: ABdhPJz2cJ7CEK2QU8d4MvwWTRwIYLa89bAXoHcs0pj+zLGRas+wTtW9xsAw0qFtf/blSc+unw0ABlJZ1RchbM6qsiU=
X-Received: by 2002:ab0:2758:: with SMTP id c24mr4351437uap.64.1591100280930;
 Tue, 02 Jun 2020 05:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200511115524.22602-1-Rodrigo.Siqueira@amd.com> <20200511115524.22602-4-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20200511115524.22602-4-Rodrigo.Siqueira@amd.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 2 Jun 2020 13:14:43 +0100
Message-ID: <CACvgo538kFaXq3jkwHb1DHvgd95Ss6ZcYVwYRQ7CX53PkB411g@mail.gmail.com>
Subject: Re: [PATCH V4 3/3] drm/vkms: Add support for writeback
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 at 12:55, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:

>  # SPDX-License-Identifier: GPL-2.0-only
> -vkms-y := vkms_drv.o vkms_plane.o vkms_output.o vkms_crtc.o vkms_gem.o vkms_composer.o
> +vkms-y := \
> +       vkms_drv.o \
> +       vkms_plane.o \
> +       vkms_output.o \
> +       vkms_crtc.o \
> +       vkms_gem.o \
> +       vkms_composer.o \
> +       vkms_writeback.o
>
Nit: sort alphabetically


> @@ -191,9 +192,12 @@ void vkms_composer_worker(struct work_struct *work)
>         if (!primary_composer)
>                 return;
>
> +       if (wb_pending)
> +               vaddr_out = crtc_state->active_writeback;
> +
>         ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
Forgot to mention earlier - with the allocation happening in the
caller, compose_planes() can take void *vaddr_out.

>         if (ret) {
> -               if (ret == -EINVAL)
> +               if (ret == -EINVAL && !wb_pending)
>                         kfree(vaddr_out);
>                 return;
>         }
> @@ -206,6 +210,14 @@ void vkms_composer_worker(struct work_struct *work)
>         while (frame_start <= frame_end)
>                 drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
>
> +       if (wb_pending) {
> +               drm_writeback_signal_completion(&out->wb_connector, 0);
> +               spin_lock_irq(&out->composer_lock);
> +               crtc_state->wb_pending = false;
> +               spin_unlock_irq(&out->composer_lock);
> +               return;
> +       }
> +
Just like the free() move this above the drm_crtc_add_crc_entry()

if (wb_pending) {
  signal()
  ...
} else {
  free()
}

> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 1e8b2169d834..34dd74dc8eb0 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -39,6 +39,10 @@ bool enable_cursor = true;
>  module_param_named(enable_cursor, enable_cursor, bool, 0444);
>  MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
>
> +bool enable_writeback;
> +module_param_named(enable_writeback, enable_writeback, bool, 0444);
> +MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector");
> +
Why is this a module parameter? Let's always enable it and leave it to
userspace whether to use the wb or not.

>  static const struct file_operations vkms_driver_fops = {
>         .owner          = THIS_MODULE,
>         .open           = drm_open,
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index f4036bb0b9a8..35f0b71413c9 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -8,6 +8,7 @@
>  #include <drm/drm.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_encoder.h>
> +#include <drm/drm_writeback.h>
>
>  #define XRES_MIN    20
>  #define YRES_MIN    20
> @@ -19,6 +20,7 @@
>  #define YRES_MAX  8192
>
>  extern bool enable_cursor;
> +extern bool enable_writeback;
>
>  struct vkms_composer {
>         struct drm_framebuffer fb;
> @@ -52,9 +54,11 @@ struct vkms_crtc_state {
>         int num_active_planes;
>         /* stack of active planes for crc computation, should be in z order */
>         struct vkms_plane_state **active_planes;
> +       void *active_writeback;
>
>         /* below three are protected by vkms_output.composer_lock */
Nit: s/below three/the following four/

>         bool crc_pending;
> +       bool wb_pending;
>         u64 frame_start;
>         u64 frame_end;
>  };
> @@ -63,6 +67,7 @@ struct vkms_output {
>         struct drm_crtc crtc;
>         struct drm_encoder encoder;
>         struct drm_connector connector;
> +       struct drm_writeback_connector wb_connector;
>         struct hrtimer vblank_hrtimer;
>         ktime_t period_ns;
>         struct drm_pending_vblank_event *event;
> @@ -144,4 +149,7 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
>  /* Composer Support */
>  void vkms_composer_worker(struct work_struct *work);
>
> +/* Writeback */
> +int enable_writeback_connector(struct vkms_device *vkmsdev);

Don't forget appropriate name spacing - prefix the function with vkms.

> +
>  #endif /* _VKMS_DRV_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 85afb77e97f0..19ffc67affec 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -80,6 +80,16 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>                 goto err_attach;
>         }
>
> +       if (enable_writeback) {
> +               ret = enable_writeback_connector(vkmsdev);

With wb connector always enabled, you can kill off the
vkms_output::composer_enabled all together. Plus the info/error
warnings (below) can go as well.

> +               if (!ret) {
> +                       output->composer_enabled = true;
> +                       DRM_INFO("Writeback connector enabled");
> +               } else {
> +                       DRM_ERROR("Failed to init writeback connector\n");
> +               }
> +       }
> +
>         drm_mode_config_reset(dev);
>
>         return 0;
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> new file mode 100644
> index 000000000000..868f0d15ca9f
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "vkms_drv.h"
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_writeback.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +
Nit: sort includes alphabetically.

> +static const u32 vkms_wb_formats[] = {
> +       DRM_FORMAT_XRGB8888,
> +};
> +
> +static const struct drm_connector_funcs vkms_wb_connector_funcs = {
> +       .fill_modes = drm_helper_probe_single_connector_modes,
> +       .destroy = drm_connector_cleanup,
> +       .reset = drm_atomic_helper_connector_reset,
> +       .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +       .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static int vkms_wb_encoder_atomic_check(struct drm_encoder *encoder,
> +                                       struct drm_crtc_state *crtc_state,
> +                                       struct drm_connector_state *conn_state)
> +{
> +       struct drm_framebuffer *fb;
> +       const struct drm_display_mode *mode = &crtc_state->mode;
> +
> +       if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
Drop the fb check.

> +               return 0;
> +
> +       fb = conn_state->writeback_job->fb;
> +       if (fb->width != mode->hdisplay || fb->height != mode->vdisplay) {
> +               DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
> +                             fb->width, fb->height);
> +               return -EINVAL;
> +       }
> +
> +       if (fb->format->format != DRM_FORMAT_XRGB8888) {
Use the vkms_wb_formats[], regardless if it's one entry or not.

> +               struct drm_format_name_buf format_name;
> +
> +               DRM_DEBUG_KMS("Invalid pixel format %s\n",
> +                             drm_get_format_name(fb->format->format,
> +                                                 &format_name));
> +               return -EINVAL;
> +       }
> +
> +       return 0;

Thinking out loud:
This function should be a helper that drivers can reuse and build
upon. The format might be tricky.
It's already in drm_writeback_connector::pixel_formats_blob_ptr, while
the function takes drm_writeback::encoder as argument.

But that for another patch series.


> +static void vkms_wb_atomic_commit(struct drm_connector *conn,
> +                                 struct drm_connector_state *state)
> +{
> +       struct vkms_device *vkmsdev = drm_device_to_vkms_device(conn->dev);
> +       struct vkms_output *output = &vkmsdev->output;
> +       struct drm_writeback_connector *wb_conn = &output->wb_connector;
> +       struct drm_connector_state *conn_state = wb_conn->base.state;
> +       struct vkms_crtc_state *crtc_state = output->composer_state;
> +
> +       if (!conn_state)
> +               return;
> +
> +       if (!conn_state->writeback_job || !conn_state->writeback_job->fb) {
Drop the fb check.

-Emil
