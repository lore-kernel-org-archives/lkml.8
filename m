Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E33C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1219206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GT3MqCeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgEEIvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgEEIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:51:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32729C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 01:51:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j5so932499wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T87EAHnU6d/aEcc9kDIRejNNG+CQtK0nds65OFUdB2k=;
        b=GT3MqCeICZy9CIyFOHqZX6Yg1scVFmfTnRXXaIbRCeHkJi27McjD5e/cKji1EmM1KG
         LgWFDNXuxeo0Jwy/n2dN9jf0QvEjkOjdMv9zxxr0aQzAJCISnc19CL1lbe/noiLO+hMm
         nU1cRCbxcD5mB2F8u6iC2iItkHLL101ca+G1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=T87EAHnU6d/aEcc9kDIRejNNG+CQtK0nds65OFUdB2k=;
        b=RONAHjFufhvh9hXl+G66nOn13I07GcIaqnN4SJ2kKqwruh/RrIqqOIpVAH7PeyImlp
         xa+tLLghGY2xruuKnS19x7c7mIojni8ABGetkOqL4mbgAKvjVoFPT+IVGTwSN5FPv+4A
         HWfKXgz3EkX+V3Hr4Swqdi+Cm8x1XyndmXPmGE/6inJGumekAoOxQhWSKkdXdwFYsLm0
         ov+BQQFQBCEAHM9XKU4AcxSGkewuWM5sHYTr16j/G1k2egmCnLsN/7dDHV49STyJ/E7w
         nqngzQg+HeBnsUyWwxl7e9uapXu/WQHnJTQlnRfpgp+Ah+KQVObuhsqQDqU3S21lMsxm
         lroA==
X-Gm-Message-State: AGi0PuYnsUDNd2e40fv2w+tFLUi0RmWlwmIS5CSXaK5MzaZWnIhdA/oM
        UW1uq/pDM3Hgox1t4NoKwV3s2g==
X-Google-Smtp-Source: APiQypJ/7dWmhTleTJb1e+uEQs+IDM+5Y28bUPpZv6ui0LiLo5rBrMnqYRgGLsaow0hto3La+k2gVg==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr2300695wrs.136.1588668709915;
        Tue, 05 May 2020 01:51:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q184sm2623921wma.25.2020.05.05.01.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 01:51:48 -0700 (PDT)
Date:   Tue, 5 May 2020 10:51:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?utf-8?B?TWljaGHFgiBPcnplxYI=?= <michalorzel.eng@gmail.com>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: Replace drm_modeset_lock/unlock_all with
 DRM_MODESET_LOCK_ALL_* helpers
Message-ID: <20200505085147.GO10381@phenom.ffwll.local>
Mail-Followup-To: =?utf-8?B?TWljaGHFgiBPcnplxYI=?= <michalorzel.eng@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <1588093804-30446-1-git-send-email-michalorzel.eng@gmail.com>
 <875zdiacv2.fsf@intel.com>
 <CAOw6vbK69aWzti9a7MXNmAfVfJXzzC5g74p4ukSE49MhaV_b3g@mail.gmail.com>
 <CAKMK7uEzTn2nKyEaxMcd6602tprwkdnBrmrFYO+_Hi7FY39jAw@mail.gmail.com>
 <520d517e-5e8f-a6c7-1c8a-38d1a368a79f@gmail.com>
 <20200504115309.GJ10381@phenom.ffwll.local>
 <9cd2487b-c6a8-b057-e53c-b3dd1e7141aa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cd2487b-c6a8-b057-e53c-b3dd1e7141aa@gmail.com>
X-Operating-System: Linux phenom 5.4.0-4-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 07:55:00AM +0200, Michał Orzeł wrote:
> 
> 
> On 04.05.2020 13:53, Daniel Vetter wrote:
> > On Fri, May 01, 2020 at 05:49:33PM +0200, Michał Orzeł wrote:
> >>
> >>
> >> On 30.04.2020 20:30, Daniel Vetter wrote:
> >>> On Thu, Apr 30, 2020 at 5:38 PM Sean Paul <seanpaul@chromium.org> wrote:
> >>>>
> >>>> On Wed, Apr 29, 2020 at 4:57 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >>>>>
> >>>>> On Tue, 28 Apr 2020, Michal Orzel <michalorzel.eng@gmail.com> wrote:
> >>>>>> As suggested by the TODO list for the kernel DRM subsystem, replace
> >>>>>> the deprecated functions that take/drop modeset locks with new helpers.
> >>>>>>
> >>>>>> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/drm_mode_object.c | 10 ++++++----
> >>>>>>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> >>>>>> index 35c2719..901b078 100644
> >>>>>> --- a/drivers/gpu/drm/drm_mode_object.c
> >>>>>> +++ b/drivers/gpu/drm/drm_mode_object.c
> >>>>>> @@ -402,12 +402,13 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
> >>>>>>  {
> >>>>>>       struct drm_mode_obj_get_properties *arg = data;
> >>>>>>       struct drm_mode_object *obj;
> >>>>>> +     struct drm_modeset_acquire_ctx ctx;
> >>>>>>       int ret = 0;
> >>>>>>
> >>>>>>       if (!drm_core_check_feature(dev, DRIVER_MODESET))
> >>>>>>               return -EOPNOTSUPP;
> >>>>>>
> >>>>>> -     drm_modeset_lock_all(dev);
> >>>>>> +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> >>>>>
> >>>>> I cry a little every time I look at the DRM_MODESET_LOCK_ALL_BEGIN and
> >>>>> DRM_MODESET_LOCK_ALL_END macros. :(
> >>>>>
> >>>>> Currently only six users... but there are ~60 calls to
> >>>>> drm_modeset_lock_all{,_ctx} that I presume are to be replaced. I wonder
> >>>>> if this will come back and haunt us.
> >>>>>
> >>>>
> >>>> What's the alternative? Seems like the options without the macros is
> >>>> to use incorrect scope or have a bunch of retry/backoff cargo-cult
> >>>> everywhere (and hope the copy source is done correctly).
> >>>
> >>> Yeah Sean & me had a bunch of bikesheds and this is the least worst
> >>> option we could come up with. You can't make it a function because of
> >>> the control flow. You don't want to open code this because it's tricky
> >>> to get right, if all you want is to just grab all locks. But it is
> >>> magic hidden behind a macro, which occasionally ends up hurting.
> >>> -Daniel
> >> So what are we doing with this problem? Should we replace at once approx. 60 calls?
> > 
> > I'm confused by your question - dradual conversion is entirely orthogonal
> > to what exactly we're converting too. All I added here is that we've
> > discussed this at length, and the macro is the best thing we've come up
> > with. I still think it's the best compromise.
> > 
> > Flag-day conversion for over 60 calls doesn't work, no matter what.
> > -Daniel
> > 
> I agree with that. All I wanted to ask was whether I should add something additional to this patch or not.

Patch looks good and passed CI, so I went ahead and applied it.

Thanks, Daniel

> 
> Thanks,
> Michal
> >>
> >> Michal
> >>>
> >>>> Sean
> >>>>
> >>>>> BR,
> >>>>> Jani.
> >>>>>
> >>>>>
> >>>>>>
> >>>>>>       obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
> >>>>>>       if (!obj) {
> >>>>>> @@ -427,7 +428,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
> >>>>>>  out_unref:
> >>>>>>       drm_mode_object_put(obj);
> >>>>>>  out:
> >>>>>> -     drm_modeset_unlock_all(dev);
> >>>>>> +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
> >>>>>>       return ret;
> >>>>>>  }
> >>>>>>
> >>>>>> @@ -449,12 +450,13 @@ static int set_property_legacy(struct drm_mode_object *obj,
> >>>>>>  {
> >>>>>>       struct drm_device *dev = prop->dev;
> >>>>>>       struct drm_mode_object *ref;
> >>>>>> +     struct drm_modeset_acquire_ctx ctx;
> >>>>>>       int ret = -EINVAL;
> >>>>>>
> >>>>>>       if (!drm_property_change_valid_get(prop, prop_value, &ref))
> >>>>>>               return -EINVAL;
> >>>>>>
> >>>>>> -     drm_modeset_lock_all(dev);
> >>>>>> +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> >>>>>>       switch (obj->type) {
> >>>>>>       case DRM_MODE_OBJECT_CONNECTOR:
> >>>>>>               ret = drm_connector_set_obj_prop(obj, prop, prop_value);
> >>>>>> @@ -468,7 +470,7 @@ static int set_property_legacy(struct drm_mode_object *obj,
> >>>>>>               break;
> >>>>>>       }
> >>>>>>       drm_property_change_valid_put(prop, ref);
> >>>>>> -     drm_modeset_unlock_all(dev);
> >>>>>> +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
> >>>>>>
> >>>>>>       return ret;
> >>>>>>  }
> >>>>>
> >>>>> --
> >>>>> Jani Nikula, Intel Open Source Graphics Center
> >>>
> >>>
> >>>
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
