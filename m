Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5811CC47255
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6E020787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aua11ZHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgD3SbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgD3SbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 14:31:09 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68EC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:31:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g14so358462otg.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMCD+Jo7E8IZbBxHKMYz3Qb/9HJIoY2bae742xpPUjY=;
        b=aua11ZHUyJrWxfH/6aP8CrbZcJDCWjioXF2XxEBLB2ngHWepZw1xBuSZfnzrNfwzta
         xUjumh+rBT00oWNzWYG66IRDKD4J8zWQqYylpHeFPUpc9QvQbSsyHakHoEu+dyjLRUc4
         SFxbpETHruDT3zVej0CEUaXZc0FXxgtLEXrYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMCD+Jo7E8IZbBxHKMYz3Qb/9HJIoY2bae742xpPUjY=;
        b=s5K+5D4UPb1mxxTiKqVRfh4WcvOH6i06ugSFk2h6csMcyR1uCYBJEMoyTdgVYJpymh
         4MJTyq/iN8tILG12uV0iRmxKvAKLdln6R1tRFfsKfFHsx0wW7L8YcqVo3074a5fMNDjh
         tRCStF2sm0mIZweYlfXooHcImeEvoMJKlEnniuTm4kop7/iAXcbpEf/u1nKWravGKE4L
         2RfgoxXqNPAUMBXwK3y/MGLd+86qce26/hffHdBgz6tq2ir3DToTOdVspVdtXEgSA0HT
         NOE+sXrr1Gr/ivMcV4XpzHT0sKZK5+CoElD9DuoGuvW2SJA+zo3cSmmRmM+Gpi17K8m1
         24Ag==
X-Gm-Message-State: AGi0PuY6EIfJIbGvw8HHm1ktHo+FLgPfXEDhoS5D9EX3KHA76dcGH/T4
        BuKqLQeo2kqdpwIYSMVV6TCyLAnTiIcZ/w7UAQIhCw==
X-Google-Smtp-Source: APiQypKyYOqC4tEmwwTS7QE+OtDLiAeWnwyyRNPl/roowM0owcKKaIbR2jDNbxulnsFh0+v9ggay3MC+vnWMcWGOKEk=
X-Received: by 2002:a9d:d06:: with SMTP id 6mr405884oti.188.1588271466950;
 Thu, 30 Apr 2020 11:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <1588093804-30446-1-git-send-email-michalorzel.eng@gmail.com>
 <875zdiacv2.fsf@intel.com> <CAOw6vbK69aWzti9a7MXNmAfVfJXzzC5g74p4ukSE49MhaV_b3g@mail.gmail.com>
In-Reply-To: <CAOw6vbK69aWzti9a7MXNmAfVfJXzzC5g74p4ukSE49MhaV_b3g@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 30 Apr 2020 20:30:53 +0200
Message-ID: <CAKMK7uEzTn2nKyEaxMcd6602tprwkdnBrmrFYO+_Hi7FY39jAw@mail.gmail.com>
Subject: Re: [PATCH] drm: Replace drm_modeset_lock/unlock_all with
 DRM_MODESET_LOCK_ALL_* helpers
To:     Sean Paul <seanpaul@chromium.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 5:38 PM Sean Paul <seanpaul@chromium.org> wrote:
>
> On Wed, Apr 29, 2020 at 4:57 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> > On Tue, 28 Apr 2020, Michal Orzel <michalorzel.eng@gmail.com> wrote:
> > > As suggested by the TODO list for the kernel DRM subsystem, replace
> > > the deprecated functions that take/drop modeset locks with new helpers.
> > >
> > > Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_mode_object.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> > > index 35c2719..901b078 100644
> > > --- a/drivers/gpu/drm/drm_mode_object.c
> > > +++ b/drivers/gpu/drm/drm_mode_object.c
> > > @@ -402,12 +402,13 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
> > >  {
> > >       struct drm_mode_obj_get_properties *arg = data;
> > >       struct drm_mode_object *obj;
> > > +     struct drm_modeset_acquire_ctx ctx;
> > >       int ret = 0;
> > >
> > >       if (!drm_core_check_feature(dev, DRIVER_MODESET))
> > >               return -EOPNOTSUPP;
> > >
> > > -     drm_modeset_lock_all(dev);
> > > +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> >
> > I cry a little every time I look at the DRM_MODESET_LOCK_ALL_BEGIN and
> > DRM_MODESET_LOCK_ALL_END macros. :(
> >
> > Currently only six users... but there are ~60 calls to
> > drm_modeset_lock_all{,_ctx} that I presume are to be replaced. I wonder
> > if this will come back and haunt us.
> >
>
> What's the alternative? Seems like the options without the macros is
> to use incorrect scope or have a bunch of retry/backoff cargo-cult
> everywhere (and hope the copy source is done correctly).

Yeah Sean & me had a bunch of bikesheds and this is the least worst
option we could come up with. You can't make it a function because of
the control flow. You don't want to open code this because it's tricky
to get right, if all you want is to just grab all locks. But it is
magic hidden behind a macro, which occasionally ends up hurting.
-Daniel

> Sean
>
> > BR,
> > Jani.
> >
> >
> > >
> > >       obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
> > >       if (!obj) {
> > > @@ -427,7 +428,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
> > >  out_unref:
> > >       drm_mode_object_put(obj);
> > >  out:
> > > -     drm_modeset_unlock_all(dev);
> > > +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
> > >       return ret;
> > >  }
> > >
> > > @@ -449,12 +450,13 @@ static int set_property_legacy(struct drm_mode_object *obj,
> > >  {
> > >       struct drm_device *dev = prop->dev;
> > >       struct drm_mode_object *ref;
> > > +     struct drm_modeset_acquire_ctx ctx;
> > >       int ret = -EINVAL;
> > >
> > >       if (!drm_property_change_valid_get(prop, prop_value, &ref))
> > >               return -EINVAL;
> > >
> > > -     drm_modeset_lock_all(dev);
> > > +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> > >       switch (obj->type) {
> > >       case DRM_MODE_OBJECT_CONNECTOR:
> > >               ret = drm_connector_set_obj_prop(obj, prop, prop_value);
> > > @@ -468,7 +470,7 @@ static int set_property_legacy(struct drm_mode_object *obj,
> > >               break;
> > >       }
> > >       drm_property_change_valid_put(prop, ref);
> > > -     drm_modeset_unlock_all(dev);
> > > +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
> > >
> > >       return ret;
> > >  }
> >
> > --
> > Jani Nikula, Intel Open Source Graphics Center



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
