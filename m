Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C347C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431D32173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UzoCHcnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEHU7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgEHU7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:59:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689EC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 13:59:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b18so9632841oic.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JvQWomvjxRLudQWRCaB9megG2fXdC0dsqrE9wIO6QIg=;
        b=UzoCHcnW0VeddBNAXca5ePUWKDqO4F5IKcddt+7x2DPPr5wW20lpdInECrtT3H1iq4
         KchnkNi2mevHqKxSjitcQY6w/pz2vX/CqsvJ0y4w1UezxkAI4Gy4SCZS2mGwDFDEL33p
         9ej4GLctnLkeHfH7cseZZkPYJS/WcYjvU2k8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JvQWomvjxRLudQWRCaB9megG2fXdC0dsqrE9wIO6QIg=;
        b=VWcpZFQNq/ZIXa5tB1cWXiS8qSctyUOFyfesMmoQkAFEZ/qjQCW6+n1rSD3PVvQRFW
         FeEfE++S5aiJ4nan5RHVi+qzEgPy0aUMBe2jNfALKKQNYeMwDGSESOHzyLDQyvn4UxCc
         iJjoof2VcbvvOHAOCy5TArHBEdCSiU7aDEdbp1bVBOLmOU+BmUtOik2sN6Ls14XKTwNX
         5fh3qmbK8WZku4pHJdlIjvF09OWcFhhD7fffnMSeV7wxa5sXBJlFZK5m7LqSyv8XbvHM
         31AI+fIMYX6ZytmPFugG3G6+uwNbYViYifOqKUxvNMfqRgw+uQh1suRUTmq8UhEs63yl
         CsMw==
X-Gm-Message-State: AGi0PuYYdWNaoYJ9LpzaM+hUWrxUEcw/boXslcjU0osDcFO1XLsurRrY
        UnPmk4GZZGy5MFxyccuWzLDz7WROTQW1XITgA9vA+w==
X-Google-Smtp-Source: APiQypLAu0p1Krm7EdSF7szPOyo3xTBi08s9nDniaTs/XUU/hUlKs8JR8+zGu/R5I2zr21JRDg9KubXRs4AnLxBrUgg=
X-Received: by 2002:aca:2113:: with SMTP id 19mr3361674oiz.128.1588971554521;
 Fri, 08 May 2020 13:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200508204751.155488-1-lyude@redhat.com> <20200508204751.155488-4-lyude@redhat.com>
In-Reply-To: <20200508204751.155488-4-lyude@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 8 May 2020 22:59:03 +0200
Message-ID: <CAKMK7uGEssowz-9jX1LP4=eRNTuxN_k4MLfrGqG3szjQE=Gonw@mail.gmail.com>
Subject: Re: [RFC v4 03/12] drm/vblank: Register drmm cleanup action once per drm_vblank_crtc
To:     Lyude Paul <lyude@redhat.com>
Cc:     Nouveau Dev <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 10:48 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Since we'll be allocating resources for kthread_create_worker() in the
> next commit (which could fail and require us to clean up the mess),
> let's simplify the cleanup process a bit by registering a
> drm_vblank_init_release() action for each drm_vblank_crtc so they're
> still cleaned up if we fail to initialize one of them.
>
> Changes since v3:
> * Use drmm_add_action_or_reset() - Daniel Vetter
>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I think the other patches need a brain that's less in w/e mode :-)

Cheers, Daniel

> ---
>  drivers/gpu/drm/drm_vblank.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 758bf74e1cab..a4a9013584e2 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -491,16 +491,12 @@ static void vblank_disable_fn(struct timer_list *t)
>
>  static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
>  {
> -       unsigned int pipe;
> -
> -       for (pipe =3D 0; pipe < dev->num_crtcs; pipe++) {
> -               struct drm_vblank_crtc *vblank =3D &dev->vblank[pipe];
> +       struct drm_vblank_crtc *vblank =3D ptr;
>
> -               WARN_ON(READ_ONCE(vblank->enabled) &&
> -                       drm_core_check_feature(dev, DRIVER_MODESET));
> +       WARN_ON(READ_ONCE(vblank->enabled) &&
> +               drm_core_check_feature(dev, DRIVER_MODESET));
>
> -               del_timer_sync(&vblank->disable_timer);
> -       }
> +       del_timer_sync(&vblank->disable_timer);
>  }
>
>  /**
> @@ -510,7 +506,7 @@ static void drm_vblank_init_release(struct drm_device=
 *dev, void *ptr)
>   *
>   * This function initializes vblank support for @num_crtcs display pipel=
ines.
>   * Cleanup is handled automatically through a cleanup function added wit=
h
> - * drmm_add_action().
> + * drmm_add_action_or_reset().
>   *
>   * Returns:
>   * Zero on success or a negative error code on failure.
> @@ -529,10 +525,6 @@ int drm_vblank_init(struct drm_device *dev, unsigned=
 int num_crtcs)
>
>         dev->num_crtcs =3D num_crtcs;
>
> -       ret =3D drmm_add_action(dev, drm_vblank_init_release, NULL);
> -       if (ret)
> -               return ret;
> -
>         for (i =3D 0; i < num_crtcs; i++) {
>                 struct drm_vblank_crtc *vblank =3D &dev->vblank[i];
>
> @@ -541,6 +533,11 @@ int drm_vblank_init(struct drm_device *dev, unsigned=
 int num_crtcs)
>                 init_waitqueue_head(&vblank->queue);
>                 timer_setup(&vblank->disable_timer, vblank_disable_fn, 0)=
;
>                 seqlock_init(&vblank->seqlock);
> +
> +               ret =3D drmm_add_action_or_reset(dev, drm_vblank_init_rel=
ease,
> +                                              vblank);
> +               if (ret)
> +                       return ret;
>         }
>
>         DRM_INFO("Supports vblank timestamp caching Rev 2 (21.10.2013).\n=
");
> --
> 2.25.4
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
