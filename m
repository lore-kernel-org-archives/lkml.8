Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75331C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1DE2063A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dugK3r3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgEDLxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDLxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:53:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 04:53:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so10236043wrt.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5qnwIYGk3+7csMDGhDfT78y1tC0I7zaU/dNEhm/Gdrw=;
        b=dugK3r3ZitE29ERypoY8YadxZqPS0Z+2R4hMbiT7dJ25vLFnA6kxaL+ncVer9maN7O
         2gqsaoqR2kWjRjaJt8EqT7v11TIRWMyAZJvYbv0juk18RmDrJCFIt0iB8gIGIosYlgV3
         fGfpeQ0X8InFpU6T6j4q1RJZG2w8qCaKA0Vxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=5qnwIYGk3+7csMDGhDfT78y1tC0I7zaU/dNEhm/Gdrw=;
        b=FueqYiN5hyLF5XQ6H6V2KFwjvfGEz0nfRAqHbaPQJM1em5qSCOTFIAodJzhe8Lt7po
         jC81l60U4ypnU0DnVk2/LGxvJUT6dMSEwbvJDiPNxy+jT9lJzE+eyID08o9TwL8x5N9v
         5M1kcQCswiS775Q1xXM4+Sa/MdL1VIiZZhN6tux0jZvbFeTcDPVSpzYlAZHmcvlSyaPV
         9AHSWf8PFu3oyPfZ6ZsdmQPOyNEeCdTg8AM7OIBjx0mben9P1fWwqAt3otnduF6nr3Qx
         s8HLKjsms8I+A1ki7OyeF6PAKRf2g51vUCtrS3lVf50Erpx+kRl8ouyitVaV/6BvUPL9
         hmhA==
X-Gm-Message-State: AGi0PuZTuZHv5GqDGrOoa7GMN8xK1RvYWhgTWe++NeYp5aJeQLp5HykC
        fH8JLg5aiDRxnhBon9UPMlhT7w==
X-Google-Smtp-Source: APiQypJKrPt1EEj1YrXlvddxBnrFJ498AdAVqWgFS3O09/aRctH1Z/cFuyy4O+/CRgLba4NfdGW58g==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr18909418wrx.168.1588593192240;
        Mon, 04 May 2020 04:53:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g10sm6178750wrx.4.2020.05.04.04.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 04:53:11 -0700 (PDT)
Date:   Mon, 4 May 2020 13:53:09 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?utf-8?B?TWljaGHFgiBPcnplxYI=?= <michalorzel.eng@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: Replace drm_modeset_lock/unlock_all with
 DRM_MODESET_LOCK_ALL_* helpers
Message-ID: <20200504115309.GJ10381@phenom.ffwll.local>
Mail-Followup-To: =?utf-8?B?TWljaGHFgiBPcnplxYI=?= <michalorzel.eng@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <520d517e-5e8f-a6c7-1c8a-38d1a368a79f@gmail.com>
X-Operating-System: Linux phenom 5.4.0-4-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 05:49:33PM +0200, Michał Orzeł wrote:
> 
> 
> On 30.04.2020 20:30, Daniel Vetter wrote:
> > On Thu, Apr 30, 2020 at 5:38 PM Sean Paul <seanpaul@chromium.org> wrote:
> >>
> >> On Wed, Apr 29, 2020 at 4:57 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >>>
> >>> On Tue, 28 Apr 2020, Michal Orzel <michalorzel.eng@gmail.com> wrote:
> >>>> As suggested by the TODO list for the kernel DRM subsystem, replace
> >>>> the deprecated functions that take/drop modeset locks with new helpers.
> >>>>
> >>>> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
> >>>> ---
> >>>>  drivers/gpu/drm/drm_mode_object.c | 10 ++++++----
> >>>>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> >>>> index 35c2719..901b078 100644
> >>>> --- a/drivers/gpu/drm/drm_mode_object.c
> >>>> +++ b/drivers/gpu/drm/drm_mode_object.c
> >>>> @@ -402,12 +402,13 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
> >>>>  {
> >>>>       struct drm_mode_obj_get_properties *arg = data;
> >>>>       struct drm_mode_object *obj;
> >>>> +     struct drm_modeset_acquire_ctx ctx;
> >>>>       int ret = 0;
> >>>>
> >>>>       if (!drm_core_check_feature(dev, DRIVER_MODESET))
> >>>>               return -EOPNOTSUPP;
> >>>>
> >>>> -     drm_modeset_lock_all(dev);
> >>>> +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> >>>
> >>> I cry a little every time I look at the DRM_MODESET_LOCK_ALL_BEGIN and
> >>> DRM_MODESET_LOCK_ALL_END macros. :(
> >>>
> >>> Currently only six users... but there are ~60 calls to
> >>> drm_modeset_lock_all{,_ctx} that I presume are to be replaced. I wonder
> >>> if this will come back and haunt us.
> >>>
> >>
> >> What's the alternative? Seems like the options without the macros is
> >> to use incorrect scope or have a bunch of retry/backoff cargo-cult
> >> everywhere (and hope the copy source is done correctly).
> > 
> > Yeah Sean & me had a bunch of bikesheds and this is the least worst
> > option we could come up with. You can't make it a function because of
> > the control flow. You don't want to open code this because it's tricky
> > to get right, if all you want is to just grab all locks. But it is
> > magic hidden behind a macro, which occasionally ends up hurting.
> > -Daniel
> So what are we doing with this problem? Should we replace at once approx. 60 calls?

I'm confused by your question - dradual conversion is entirely orthogonal
to what exactly we're converting too. All I added here is that we've
discussed this at length, and the macro is the best thing we've come up
with. I still think it's the best compromise.

Flag-day conversion for over 60 calls doesn't work, no matter what.
-Daniel

> 
> Michal
> > 
> >> Sean
> >>
> >>> BR,
> >>> Jani.
> >>>
> >>>
> >>>>
> >>>>       obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
> >>>>       if (!obj) {
> >>>> @@ -427,7 +428,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
> >>>>  out_unref:
> >>>>       drm_mode_object_put(obj);
> >>>>  out:
> >>>> -     drm_modeset_unlock_all(dev);
> >>>> +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
> >>>>       return ret;
> >>>>  }
> >>>>
> >>>> @@ -449,12 +450,13 @@ static int set_property_legacy(struct drm_mode_object *obj,
> >>>>  {
> >>>>       struct drm_device *dev = prop->dev;
> >>>>       struct drm_mode_object *ref;
> >>>> +     struct drm_modeset_acquire_ctx ctx;
> >>>>       int ret = -EINVAL;
> >>>>
> >>>>       if (!drm_property_change_valid_get(prop, prop_value, &ref))
> >>>>               return -EINVAL;
> >>>>
> >>>> -     drm_modeset_lock_all(dev);
> >>>> +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> >>>>       switch (obj->type) {
> >>>>       case DRM_MODE_OBJECT_CONNECTOR:
> >>>>               ret = drm_connector_set_obj_prop(obj, prop, prop_value);
> >>>> @@ -468,7 +470,7 @@ static int set_property_legacy(struct drm_mode_object *obj,
> >>>>               break;
> >>>>       }
> >>>>       drm_property_change_valid_put(prop, ref);
> >>>> -     drm_modeset_unlock_all(dev);
> >>>> +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
> >>>>
> >>>>       return ret;
> >>>>  }
> >>>
> >>> --
> >>> Jani Nikula, Intel Open Source Graphics Center
> > 
> > 
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
