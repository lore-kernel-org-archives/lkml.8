Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF87C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBFD20679
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnD6MIXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFBLXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgFBLXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:23:01 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B668C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 04:23:01 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id d8so1090423uam.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+DNdm4OSXj+ZbBSFAclEqfXcnxIti3qQTr4JFZ9dtc=;
        b=lnD6MIXyEj5uecvyfaXox7g810NP8Ibk2/joJWKyDDRPfm3DDKj1mmwutnK8eZAgvv
         izrSuehMkKmZ17ShLYiUxI/c/NX6yCBTsze7Z6QLSjRTt77h/QAbHMrE8K1mbss3kRVF
         XmQ/NdlpU2PJp+Xw3FPgxtZpn/NS1ZkmHk4k3WXL1J9RVAQkDlL1ZnV6LJEVTO6QaCsO
         Dx5an036CMyZqV7xlEA5DhUb6Kd3D1jTSeVCb0nHpz8opyYh2XNR/brlP6n/C8qZ6Fkj
         gPANDbfdblL2Czrxg9LQqdBCOdazHgbshh+xLjD4brVfLTPVXc8ckcxDiB67VPlS/c6R
         XtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+DNdm4OSXj+ZbBSFAclEqfXcnxIti3qQTr4JFZ9dtc=;
        b=FZnhd7zNVNuXtq/o3wkPMaG/uXGmC8hU1eyVbMm4L16BoEC0q7PtkPrQqSk+sNBPaW
         uXSzgcgM6bm6IVtuOhIr+5S3lKyhRh7vONQG5JJ886yGSRqHY16RM4ubAv0WdersXZEO
         TZbFZY05LtCk4GtM0JR8GBUOyLy/haUzqBISX8kXTDaY37+rVXJTtRI8IW82BqjwYzZN
         jJAjiJgzSbK81EEGg2iQwoun6HtyCFf0pNXw7KyXCuxnQHLTfyEs0kGn/g9CNGmgJO7n
         LFM4SFAKQIN4rwDcttuHbpKjvfhC1laTYaiUhEudCffkJHw09eByatRaKIhtPwYh5P1F
         fK5A==
X-Gm-Message-State: AOAM5303oKPwGolpTHlV8mzJ44+Yp0R40RK8o2HDNuba3bta4jYIQ7w3
        6HH3LMDS682v67BNlH+ETu7k4tq77cRbYx0GUbfKN3yK
X-Google-Smtp-Source: ABdhPJzgunA1N5yaYNWOEvkLV8aY3KUQWScXsEgM4P7MMV+4QxZfoN3c4emUPiX+0ovH8mnEnlAJ16bm8arKmmGWxBk=
X-Received: by 2002:ab0:6012:: with SMTP id j18mr1209769ual.69.1591096980386;
 Tue, 02 Jun 2020 04:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200511115524.22602-1-Rodrigo.Siqueira@amd.com> <20200511115524.22602-2-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20200511115524.22602-2-Rodrigo.Siqueira@amd.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 2 Jun 2020 12:19:42 +0100
Message-ID: <CACvgo53qkPb+3xVcUQJosnq0fSzG9kBEet2tCeLNXkkAQLSrUA@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] drm/vkms: Decouple crc operations from composer
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

Hi Rodrigo,

On Mon, 11 May 2020 at 12:55, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:

> -static uint32_t _vkms_get_crc(struct vkms_composer *primary_composer,
> -                             struct vkms_composer *cursor_composer)
> +static int compose_planes(void **vaddr_out,
> +                         struct vkms_composer *primary_composer,
> +                         struct vkms_composer *cursor_composer)
>  {
>         struct drm_framebuffer *fb = &primary_composer->fb;
>         struct drm_gem_object *gem_obj = drm_gem_fb_get_obj(fb, 0);
>         struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(gem_obj);
> -       void *vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
> -       u32 crc = 0;
>
> -       if (!vaddr_out) {
> -               DRM_ERROR("Failed to allocate memory for output frame.");
> -               return 0;
> +       if (!*vaddr_out) {
> +               *vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
It would be clearer if you keep the to alloc (or not for wb) in the
caller. As-is it's very subtle and error prone.

> +               if (!*vaddr_out) {
> +                       DRM_ERROR("Cannot allocate memory for output frame.");
> +                       return -ENOMEM;
> +               }
>         }
>
> -       if (WARN_ON(!vkms_obj->vaddr)) {
> -               kfree(vaddr_out);
> -               return crc;
> -       }
> +       if (WARN_ON(!vkms_obj->vaddr))
> +               return -EINVAL;
>
> -       memcpy(vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
> +       memcpy(*vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
>
>         if (cursor_composer)
> -               compose_cursor(cursor_composer, primary_composer, vaddr_out);
> +               compose_cursor(cursor_composer, primary_composer, *vaddr_out);
>
> -       crc = compute_crc(vaddr_out, primary_composer);
> -
> -       kfree(vaddr_out);
> -
> -       return crc;
> +       return 0;
>  }
>
>  /**
> @@ -157,9 +153,11 @@ void vkms_composer_worker(struct work_struct *work)
>         struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
>         struct vkms_composer *primary_composer = NULL;
>         struct vkms_composer *cursor_composer = NULL;
> +       void *vaddr_out = NULL;
>         u32 crc32 = 0;
>         u64 frame_start, frame_end;
>         bool crc_pending;
> +       int ret;
>
>         spin_lock_irq(&out->composer_lock);
>         frame_start = crtc_state->frame_start;
> @@ -183,14 +181,25 @@ void vkms_composer_worker(struct work_struct *work)
>         if (crtc_state->num_active_planes == 2)
>                 cursor_composer = crtc_state->active_planes[1]->composer;
>
> -       if (primary_composer)
> -               crc32 = _vkms_get_crc(primary_composer, cursor_composer);
> +       if (!primary_composer)
> +               return;
> +
This early return changes the functionality. Namely the
drm_crtc_add_crc_entry(.... 0) is now missing. I don't recall much
about the crc to judge if that's a genuine bugfix, or newly introduced
bug.

In the former case, it should be a separate patch.

> +       ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
> +       if (ret) {
> +               if (ret == -EINVAL)
> +                       kfree(vaddr_out);
> +               return;
> +       }
> +
> +       crc32 = compute_crc(vaddr_out, primary_composer);
>
>         /*
>          * The worker can fall behind the vblank hrtimer, make sure we catch up.
>          */
>         while (frame_start <= frame_end)
>                 drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
> +
> +       kfree(vaddr_out);
Nit: move the free() just after compute_crc() - it's not needed for
the drm_crtc_add_crc_entry().

-Emil
