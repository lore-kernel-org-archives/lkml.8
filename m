Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E03CC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A6320661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EBCfRCyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgD3Pic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD3Pib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:38:31 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D9C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 08:38:31 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so5307129qts.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9HhjXHjgQ2uRdTOdCGFRzrISVJUe9hHihb1s6U+pG0=;
        b=EBCfRCyNsTlDJFaRQRt4ZOByXKwsez2d0WVoOUVj0uyzY2FQjjUArA4Cdr92cMp5yy
         00zTxOzpBt6C0OXx4Ubu0BX+XEnhoymU29QAZiSeYC1TaiquQ6Guo8m/i8tGqEPIt2Yt
         upoTJJeeNPy2dAk4ETUD4kl9Dplk18J7ntJnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9HhjXHjgQ2uRdTOdCGFRzrISVJUe9hHihb1s6U+pG0=;
        b=T4HkOpwyeUhAL+zOhor/b8cbkyQBUHtgTDClDdMRvLjlx3uByi87iFkd9pI3Tagnqo
         yecjY2Lb2ozsh6um0vrcq/puzB0plL5bhe4YVt9A7zl0oSgcJvJniwiuVgiyOyBhnQE6
         N+VvBjdeXh0xJ3UZ8uigKXFLcFtMz6CjWbtPyFeJ8volN7X6C7B6AOLbN3FxZ4ee8e95
         P7wCdrFl76cjE0fot7kwpwZyyS0DTBSWkkw5QtjPYShTY/XLXUDuI5OgirzD4TBabs9d
         aJ7YBn+FNwUr6skTYTLjtFx2UJTH3q417UJ5HEslT2tYDrlICQrFk/rBd3ot+QPRoH0P
         KrQw==
X-Gm-Message-State: AGi0PuawiKRClGwvDDklcYVGP816Kfh/4CRGM6OI8waT+B64PJh2Uf9f
        rXgfbXjysLV9itHG0JPvAoYx4PPwPgI=
X-Google-Smtp-Source: APiQypJ5ArB8+NKHRnssmuj19aGbmgYBPRM4Bd7f0g9wK2xkVNqsL1j2JoYDtt7zn2EIAaTKVkyq+g==
X-Received: by 2002:ac8:66d8:: with SMTP id m24mr4296291qtp.175.1588261109694;
        Thu, 30 Apr 2020 08:38:29 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id o13sm277866qke.77.2020.04.30.08.38.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 08:38:28 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id v10so3427262ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 08:38:27 -0700 (PDT)
X-Received: by 2002:a5b:483:: with SMTP id n3mr6464401ybp.519.1588261107424;
 Thu, 30 Apr 2020 08:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <1588093804-30446-1-git-send-email-michalorzel.eng@gmail.com> <875zdiacv2.fsf@intel.com>
In-Reply-To: <875zdiacv2.fsf@intel.com>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Thu, 30 Apr 2020 11:37:49 -0400
X-Gmail-Original-Message-ID: <CAOw6vbK69aWzti9a7MXNmAfVfJXzzC5g74p4ukSE49MhaV_b3g@mail.gmail.com>
Message-ID: <CAOw6vbK69aWzti9a7MXNmAfVfJXzzC5g74p4ukSE49MhaV_b3g@mail.gmail.com>
Subject: Re: [PATCH] drm: Replace drm_modeset_lock/unlock_all with
 DRM_MODESET_LOCK_ALL_* helpers
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        mripard@kernel.org, tzimmermann@suse.de,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 4:57 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Tue, 28 Apr 2020, Michal Orzel <michalorzel.eng@gmail.com> wrote:
> > As suggested by the TODO list for the kernel DRM subsystem, replace
> > the deprecated functions that take/drop modeset locks with new helpers.
> >
> > Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_mode_object.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> > index 35c2719..901b078 100644
> > --- a/drivers/gpu/drm/drm_mode_object.c
> > +++ b/drivers/gpu/drm/drm_mode_object.c
> > @@ -402,12 +402,13 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
> >  {
> >       struct drm_mode_obj_get_properties *arg = data;
> >       struct drm_mode_object *obj;
> > +     struct drm_modeset_acquire_ctx ctx;
> >       int ret = 0;
> >
> >       if (!drm_core_check_feature(dev, DRIVER_MODESET))
> >               return -EOPNOTSUPP;
> >
> > -     drm_modeset_lock_all(dev);
> > +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>
> I cry a little every time I look at the DRM_MODESET_LOCK_ALL_BEGIN and
> DRM_MODESET_LOCK_ALL_END macros. :(
>
> Currently only six users... but there are ~60 calls to
> drm_modeset_lock_all{,_ctx} that I presume are to be replaced. I wonder
> if this will come back and haunt us.
>

What's the alternative? Seems like the options without the macros is
to use incorrect scope or have a bunch of retry/backoff cargo-cult
everywhere (and hope the copy source is done correctly).

Sean

> BR,
> Jani.
>
>
> >
> >       obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
> >       if (!obj) {
> > @@ -427,7 +428,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
> >  out_unref:
> >       drm_mode_object_put(obj);
> >  out:
> > -     drm_modeset_unlock_all(dev);
> > +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
> >       return ret;
> >  }
> >
> > @@ -449,12 +450,13 @@ static int set_property_legacy(struct drm_mode_object *obj,
> >  {
> >       struct drm_device *dev = prop->dev;
> >       struct drm_mode_object *ref;
> > +     struct drm_modeset_acquire_ctx ctx;
> >       int ret = -EINVAL;
> >
> >       if (!drm_property_change_valid_get(prop, prop_value, &ref))
> >               return -EINVAL;
> >
> > -     drm_modeset_lock_all(dev);
> > +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> >       switch (obj->type) {
> >       case DRM_MODE_OBJECT_CONNECTOR:
> >               ret = drm_connector_set_obj_prop(obj, prop, prop_value);
> > @@ -468,7 +470,7 @@ static int set_property_legacy(struct drm_mode_object *obj,
> >               break;
> >       }
> >       drm_property_change_valid_put(prop, ref);
> > -     drm_modeset_unlock_all(dev);
> > +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
> >
> >       return ret;
> >  }
>
> --
> Jani Nikula, Intel Open Source Graphics Center
