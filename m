Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EA1C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA58216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7I8d6z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgEAPth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgEAPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:49:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2FBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 08:49:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u10so4160182lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TEYpigawvqRYekmUHvTBKHyude1zy4qSIDermmjofq0=;
        b=B7I8d6z5k0VlDhv1Kdr65KEMHXtSyT/AHFpcRWdkyTvAFgsBD11TfkMC3yWAaGLZ9X
         i7Z0TD2Vhv8saU0IY1dGRnTTspHWp7+Kz8YfPAvC4pxTb3Q1iall4h51wdNSVPyr9GfN
         GQWYET+blUdtoF32TkRUuhrPQ7hsskkm7n7Ru36w4LFo+Xd7r2T7Ot0joKv2l/QNl8g0
         g0JV3jLNc7lMRHNMFl/e8XgUiMNNfz8hzc1Eq+zLiLXjLhpW0LyxOeqeA0ZnrwpQKunS
         NQhmDh0nh24hPl0EHrzK1Ql+ErSLMONcvWOVwxu78CmZkzawibjlJJcX+u95iCfjMGKy
         tMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TEYpigawvqRYekmUHvTBKHyude1zy4qSIDermmjofq0=;
        b=qbn9AJJJqHz9idxtTZ9rfasT6VZrcCe4ERiEz2gwkE57yxHpE0d/P+xvR8mv4h1Zrv
         IY71PHQ3fo47iXSAmltkIjb9llPsyhnGmrBBP3diRSYCEADbJElehQxoNaArbpmoTd+4
         iLcCPQJ4WA0orUI7ozOfYNH4tUFEvE8Ln67kA0bKB4xH0p1BtwY3pFDT5BPO8rXjCOiv
         2Mmbd1mZOjPtDgYPiXjx8RtHaVepUw3tgo13KPDqGFFMMrsBEp7f+ArI0XXld8w/rTDl
         4afmWeQ5sAAAvDse2G8I08tdiTj6DiIfKCbnUi/W08wBd7YdZYDa1HwQJObTW43ltEvE
         v1vQ==
X-Gm-Message-State: AGi0PuaJE+GdxgNu7yH+ENFDt3NHixk2rhGfpaedUSBXCO9JXHznyIsD
        K3mVP7xarxmEO5B02qXvbb8=
X-Google-Smtp-Source: APiQypIZ9brl9YvCAyvNpfXP3blb2AxsEk1bMk0LDNkDxAVqgKXWBmsmCcmZ/9gq0DB7VQKWOjEZZA==
X-Received: by 2002:a19:7909:: with SMTP id u9mr2927273lfc.130.1588348174592;
        Fri, 01 May 2020 08:49:34 -0700 (PDT)
Received: from [192.168.0.103] (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id w27sm2917041lfn.45.2020.05.01.08.49.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 08:49:34 -0700 (PDT)
Subject: Re: [PATCH] drm: Replace drm_modeset_lock/unlock_all with
 DRM_MODESET_LOCK_ALL_* helpers
To:     Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
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
From:   =?UTF-8?B?TWljaGHFgiBPcnplxYI=?= <michalorzel.eng@gmail.com>
Message-ID: <520d517e-5e8f-a6c7-1c8a-38d1a368a79f@gmail.com>
Date:   Fri, 1 May 2020 17:49:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uEzTn2nKyEaxMcd6602tprwkdnBrmrFYO+_Hi7FY39jAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.04.2020 20:30, Daniel Vetter wrote:
> On Thu, Apr 30, 2020 at 5:38 PM Sean Paul <seanpaul@chromium.org> wrote:
>>
>> On Wed, Apr 29, 2020 at 4:57 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>>
>>> On Tue, 28 Apr 2020, Michal Orzel <michalorzel.eng@gmail.com> wrote:
>>>> As suggested by the TODO list for the kernel DRM subsystem, replace
>>>> the deprecated functions that take/drop modeset locks with new helpers.
>>>>
>>>> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
>>>> ---
>>>>  drivers/gpu/drm/drm_mode_object.c | 10 ++++++----
>>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
>>>> index 35c2719..901b078 100644
>>>> --- a/drivers/gpu/drm/drm_mode_object.c
>>>> +++ b/drivers/gpu/drm/drm_mode_object.c
>>>> @@ -402,12 +402,13 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
>>>>  {
>>>>       struct drm_mode_obj_get_properties *arg = data;
>>>>       struct drm_mode_object *obj;
>>>> +     struct drm_modeset_acquire_ctx ctx;
>>>>       int ret = 0;
>>>>
>>>>       if (!drm_core_check_feature(dev, DRIVER_MODESET))
>>>>               return -EOPNOTSUPP;
>>>>
>>>> -     drm_modeset_lock_all(dev);
>>>> +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>>>
>>> I cry a little every time I look at the DRM_MODESET_LOCK_ALL_BEGIN and
>>> DRM_MODESET_LOCK_ALL_END macros. :(
>>>
>>> Currently only six users... but there are ~60 calls to
>>> drm_modeset_lock_all{,_ctx} that I presume are to be replaced. I wonder
>>> if this will come back and haunt us.
>>>
>>
>> What's the alternative? Seems like the options without the macros is
>> to use incorrect scope or have a bunch of retry/backoff cargo-cult
>> everywhere (and hope the copy source is done correctly).
> 
> Yeah Sean & me had a bunch of bikesheds and this is the least worst
> option we could come up with. You can't make it a function because of
> the control flow. You don't want to open code this because it's tricky
> to get right, if all you want is to just grab all locks. But it is
> magic hidden behind a macro, which occasionally ends up hurting.
> -Daniel
So what are we doing with this problem? Should we replace at once approx. 60 calls?

Michal
> 
>> Sean
>>
>>> BR,
>>> Jani.
>>>
>>>
>>>>
>>>>       obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
>>>>       if (!obj) {
>>>> @@ -427,7 +428,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
>>>>  out_unref:
>>>>       drm_mode_object_put(obj);
>>>>  out:
>>>> -     drm_modeset_unlock_all(dev);
>>>> +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
>>>>       return ret;
>>>>  }
>>>>
>>>> @@ -449,12 +450,13 @@ static int set_property_legacy(struct drm_mode_object *obj,
>>>>  {
>>>>       struct drm_device *dev = prop->dev;
>>>>       struct drm_mode_object *ref;
>>>> +     struct drm_modeset_acquire_ctx ctx;
>>>>       int ret = -EINVAL;
>>>>
>>>>       if (!drm_property_change_valid_get(prop, prop_value, &ref))
>>>>               return -EINVAL;
>>>>
>>>> -     drm_modeset_lock_all(dev);
>>>> +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>>>>       switch (obj->type) {
>>>>       case DRM_MODE_OBJECT_CONNECTOR:
>>>>               ret = drm_connector_set_obj_prop(obj, prop, prop_value);
>>>> @@ -468,7 +470,7 @@ static int set_property_legacy(struct drm_mode_object *obj,
>>>>               break;
>>>>       }
>>>>       drm_property_change_valid_put(prop, ref);
>>>> -     drm_modeset_unlock_all(dev);
>>>> +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
>>>>
>>>>       return ret;
>>>>  }
>>>
>>> --
>>> Jani Nikula, Intel Open Source Graphics Center
> 
> 
> 
