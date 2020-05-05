Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF672C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F762075E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbUX3wWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgEEFzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 01:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEFzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 01:55:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE4CC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 22:55:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so317114ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 22:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Jl8Jj64ibC9mIAmg/Ap6Jj3w1BwlRCCyo3VEMK9xNk=;
        b=FbUX3wWMmYHcjwSRdlYy4lardgWzwLOqBHDjy5LpkkW7NILuTjeFJDm7A0mXyFjQtl
         mJaT9TDGvIrE0jOMLX1wAb46VKaVkhOgkC5EIEjx1kn9oqwJgqTAvIbQOyLSgsLsEc+F
         7weYeDrINH1T4d+ACbCVO7LNc6Hc1Rfn7EgCAQA984az1ORolPCpoqSHmZQlUwMj3pj6
         CMDwsyuCZ3adwDcLuulIypamK2ZpO7tHjw99oP9lKpiLHVMNtlfvB4ogz51E3YH+iN/x
         cD38T+UMnnCjlVepELQrpDcAXzuipkQVgpFKC8VrUNoQTRFlC5oCBoyQsMatAVHw7eJm
         v5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Jl8Jj64ibC9mIAmg/Ap6Jj3w1BwlRCCyo3VEMK9xNk=;
        b=TdwNPODi8yEomU3r0DEWd18jfPBOVaIQVmQeF56PEyL2t0YzIE0zZqhzyOHxmYaj5t
         5HlBRK3aZhdprBHXLLW6HEAvR3MHoAuMSFGr2xMiGh1c9kdARjy3hqGQh71n7zjzu6Lj
         rtA+7G3qtg+gjGx9XYpzd1kn/02uMRjDjz9hleBe8M0W7Ot3ox15dq7Wr/dhNkvYcnYE
         pQXGn3r06Zt1FY/oEPbBgzst4KKXdS1F/qRwSZMssTeB2Yo13dARzZCy8KL755PDYvuk
         fI93/1tT2fHYH5UGsb7hZ/7HKXsDOcBAs7Fa8hE3pxmSCYxdZJZ+xxn4PYaNI/qah9A+
         xR5A==
X-Gm-Message-State: AGi0PuYab6fwAg0NJRFCpkWIUR70R0dM3TGsY10coTqI216HIPOsR4AE
        jMMyQZv9DqFGJ6fIM0+wKDc=
X-Google-Smtp-Source: APiQypKj427kpn++lsVAknyegPhtGV744X0rKkRsUjaI13o2Clu5IZP2HJNkrcmtGSp5f2+iUyb7eA==
X-Received: by 2002:a2e:9791:: with SMTP id y17mr757567lji.174.1588658107094;
        Mon, 04 May 2020 22:55:07 -0700 (PDT)
Received: from [192.168.0.103] (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id a12sm816405ljj.64.2020.05.04.22.55.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 22:55:06 -0700 (PDT)
Subject: Re: [PATCH] drm: Replace drm_modeset_lock/unlock_all with
 DRM_MODESET_LOCK_ALL_* helpers
To:     Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <1588093804-30446-1-git-send-email-michalorzel.eng@gmail.com>
 <875zdiacv2.fsf@intel.com>
 <CAOw6vbK69aWzti9a7MXNmAfVfJXzzC5g74p4ukSE49MhaV_b3g@mail.gmail.com>
 <CAKMK7uEzTn2nKyEaxMcd6602tprwkdnBrmrFYO+_Hi7FY39jAw@mail.gmail.com>
 <520d517e-5e8f-a6c7-1c8a-38d1a368a79f@gmail.com>
 <20200504115309.GJ10381@phenom.ffwll.local>
From:   =?UTF-8?B?TWljaGHFgiBPcnplxYI=?= <michalorzel.eng@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Message-ID: <9cd2487b-c6a8-b057-e53c-b3dd1e7141aa@gmail.com>
Date:   Tue, 5 May 2020 07:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200504115309.GJ10381@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.05.2020 13:53, Daniel Vetter wrote:
> On Fri, May 01, 2020 at 05:49:33PM +0200, Michał Orzeł wrote:
>>
>>
>> On 30.04.2020 20:30, Daniel Vetter wrote:
>>> On Thu, Apr 30, 2020 at 5:38 PM Sean Paul <seanpaul@chromium.org> wrote:
>>>>
>>>> On Wed, Apr 29, 2020 at 4:57 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>>>>
>>>>> On Tue, 28 Apr 2020, Michal Orzel <michalorzel.eng@gmail.com> wrote:
>>>>>> As suggested by the TODO list for the kernel DRM subsystem, replace
>>>>>> the deprecated functions that take/drop modeset locks with new helpers.
>>>>>>
>>>>>> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/drm_mode_object.c | 10 ++++++----
>>>>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
>>>>>> index 35c2719..901b078 100644
>>>>>> --- a/drivers/gpu/drm/drm_mode_object.c
>>>>>> +++ b/drivers/gpu/drm/drm_mode_object.c
>>>>>> @@ -402,12 +402,13 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
>>>>>>  {
>>>>>>       struct drm_mode_obj_get_properties *arg = data;
>>>>>>       struct drm_mode_object *obj;
>>>>>> +     struct drm_modeset_acquire_ctx ctx;
>>>>>>       int ret = 0;
>>>>>>
>>>>>>       if (!drm_core_check_feature(dev, DRIVER_MODESET))
>>>>>>               return -EOPNOTSUPP;
>>>>>>
>>>>>> -     drm_modeset_lock_all(dev);
>>>>>> +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>>>>>
>>>>> I cry a little every time I look at the DRM_MODESET_LOCK_ALL_BEGIN and
>>>>> DRM_MODESET_LOCK_ALL_END macros. :(
>>>>>
>>>>> Currently only six users... but there are ~60 calls to
>>>>> drm_modeset_lock_all{,_ctx} that I presume are to be replaced. I wonder
>>>>> if this will come back and haunt us.
>>>>>
>>>>
>>>> What's the alternative? Seems like the options without the macros is
>>>> to use incorrect scope or have a bunch of retry/backoff cargo-cult
>>>> everywhere (and hope the copy source is done correctly).
>>>
>>> Yeah Sean & me had a bunch of bikesheds and this is the least worst
>>> option we could come up with. You can't make it a function because of
>>> the control flow. You don't want to open code this because it's tricky
>>> to get right, if all you want is to just grab all locks. But it is
>>> magic hidden behind a macro, which occasionally ends up hurting.
>>> -Daniel
>> So what are we doing with this problem? Should we replace at once approx. 60 calls?
> 
> I'm confused by your question - dradual conversion is entirely orthogonal
> to what exactly we're converting too. All I added here is that we've
> discussed this at length, and the macro is the best thing we've come up
> with. I still think it's the best compromise.
> 
> Flag-day conversion for over 60 calls doesn't work, no matter what.
> -Daniel
> 
I agree with that. All I wanted to ask was whether I should add something additional to this patch or not.

Thanks,
Michal
>>
>> Michal
>>>
>>>> Sean
>>>>
>>>>> BR,
>>>>> Jani.
>>>>>
>>>>>
>>>>>>
>>>>>>       obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
>>>>>>       if (!obj) {
>>>>>> @@ -427,7 +428,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
>>>>>>  out_unref:
>>>>>>       drm_mode_object_put(obj);
>>>>>>  out:
>>>>>> -     drm_modeset_unlock_all(dev);
>>>>>> +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
>>>>>>       return ret;
>>>>>>  }
>>>>>>
>>>>>> @@ -449,12 +450,13 @@ static int set_property_legacy(struct drm_mode_object *obj,
>>>>>>  {
>>>>>>       struct drm_device *dev = prop->dev;
>>>>>>       struct drm_mode_object *ref;
>>>>>> +     struct drm_modeset_acquire_ctx ctx;
>>>>>>       int ret = -EINVAL;
>>>>>>
>>>>>>       if (!drm_property_change_valid_get(prop, prop_value, &ref))
>>>>>>               return -EINVAL;
>>>>>>
>>>>>> -     drm_modeset_lock_all(dev);
>>>>>> +     DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>>>>>>       switch (obj->type) {
>>>>>>       case DRM_MODE_OBJECT_CONNECTOR:
>>>>>>               ret = drm_connector_set_obj_prop(obj, prop, prop_value);
>>>>>> @@ -468,7 +470,7 @@ static int set_property_legacy(struct drm_mode_object *obj,
>>>>>>               break;
>>>>>>       }
>>>>>>       drm_property_change_valid_put(prop, ref);
>>>>>> -     drm_modeset_unlock_all(dev);
>>>>>> +     DRM_MODESET_LOCK_ALL_END(ctx, ret);
>>>>>>
>>>>>>       return ret;
>>>>>>  }
>>>>>
>>>>> --
>>>>> Jani Nikula, Intel Open Source Graphics Center
>>>
>>>
>>>
> 
