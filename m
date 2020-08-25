Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7513C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377B620786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkjmavjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHYQM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgHYQMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:12:25 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E43BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:12:25 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 12so6727995lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=saPvfIvD3UMiUrJX+hEXlu7O1j8z2YbvbI+DUjiVJNM=;
        b=GkjmavjP3rFLPUh7ERkUiQ3MTbnPISTkkG3/G7ZjJ8OjE9Q516ySPQp2Y0XkyG1X+0
         rx/VYdPcmEOFf34RzKu6+ktfpd2LNq5Ar47qlRJ2Hf7/V5Elg5KgIEA45o+UyVieXt8d
         EctseRv55mfXHOecsBUyNGmnleWN00GvchD8HYxMAjLiJi3w1rLt4q/SuuTPgw3y+6Py
         GrHL9C8EQNJCP8Rq31pzab2+Mr6+5o1V7nh9NidGp03LP3eAJRb8UH6VkfJiCzOmvdIl
         zUlCYnl+LtFKGpYCEvjwQ0TsmyUiO1isxYmA1pSZzXRPmTgL7frBL5rH/UtEZKs9MTSK
         qZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saPvfIvD3UMiUrJX+hEXlu7O1j8z2YbvbI+DUjiVJNM=;
        b=aj28R1UNRV1F7C84vzcNuA4nQZjAG/aiKdA/5IsuWdPBtAYcTVsxPBzAdYadn23qbc
         JKVDu+UYFQ6Lct+ErHm1RU3/wREk+oCeSrhM72JRHbOT+9js1dsbvyjWcCtv79oIEb8O
         k9Junkj8vJGVuuxOOLTPdiHD5c4e6BuUD1Me2uQV6bWkwHW7FOmho9LOJef4ZFCaIHuP
         ohdPlA9q0YxoFwC6Z+eScpHmqr8ymtmmkpwgALrjIVa0c9tDMbJskE9MLRQlKZZF6Or7
         fQ9selvcfvyJXESW/FI4jnJpZSe8C3FaZdYGwwAWrV3S8WQ5U6GqDBu+/5AuUH32a5+A
         pgPA==
X-Gm-Message-State: AOAM531Qehea4VEmSBmyczht3yFmLbIAQjEbA29ps7bvMyYqIkTDPTD6
        KmQ0pGHbdFssSAipn4GJXgZw7YE4gjHVJv24Qgo=
X-Google-Smtp-Source: ABdhPJz5w0/dYWgaBX6h0ZClaS4JS+bVVK48jlQu9ByUSF25DFxdqr6XgPUeX/DuCxXZ34qdoElfHCF5QE5xKW7WQSQ=
X-Received: by 2002:a19:86c3:: with SMTP id i186mr5373441lfd.59.1598371943463;
 Tue, 25 Aug 2020 09:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200825023142.2561220-1-rodrigosiqueiramelo@gmail.com> <20200825023142.2561220-2-rodrigosiqueiramelo@gmail.com>
In-Reply-To: <20200825023142.2561220-2-rodrigosiqueiramelo@gmail.com>
From:   Melissa Wen <melissa.srw@gmail.com>
Date:   Tue, 25 Aug 2020 13:12:12 -0300
Message-ID: <CAJeY4oFtusegHafy8oSYE2Z3T8YCYE6TdMiOHr9gnxV8B=9V8w@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] drm/vkms: Decouple crc operations from composer
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        daniels@collabora.com, Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:31 PM Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
>
> In the vkms_composer.c, some of the functions related to CRC and compose
> have interdependence between each other. This patch reworks some
> functions inside vkms_composer to make crc and composer computation
> decoupled.
>
> This patch is preparation work for making vkms able to support new
> features.
>
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 49 ++++++++++++++++------------
>  1 file changed, 29 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 4f3b07a32b60..4d8bc04bb6ee 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -108,35 +108,31 @@ static void compose_cursor(struct vkms_composer *cursor_composer,
>               primary_composer, cursor_composer);
>  }
>
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
>  }
>
>  static const char * const pipe_crc_sources[] = {"auto"};
> --
> 2.28.0
>

Tested-by: Melissa Wen <melissa.srw@gmail.com>
