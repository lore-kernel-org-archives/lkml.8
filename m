Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A1EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819E42070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWNJYxiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCSM2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:28:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52835 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgCSM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:28:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so2073787wmo.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=A9SGNay6V5AK51JymycAKfsjcnHxWtXDcTFCmT1Vk+E=;
        b=rWNJYxiRGxQPNJ0vJ1Hjn39bP0NuYfEf0w9eCCOSFBbW/sR8X1EFAiE6O254aP4Ixe
         L7MD8WjBigyHc4soKokx0mhvOKKcjHY/Tw4QX7eK1MibVaNsHMWU6cI3oTfIwW+5pe1o
         U9CTwcxKCVhYuUxbnfM24442Zj7K7kYk3CWsdxf0LXFUUwRHpMtrcuKOunQ+BoHLSGVf
         kXodDeNl44EuXRVB/pgfNykVP/TvEpim6P1SaEK1hVlrNMRE6/g2I3e9rtzFf20071kk
         KNCZMmH5m9m/S8sPgBBLdJ5lByOqjlqeAl58Yb924o+xaQKHT01k8jpmbLZYQ4NHbfJ+
         CcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=A9SGNay6V5AK51JymycAKfsjcnHxWtXDcTFCmT1Vk+E=;
        b=JJhSbN0yIpaotcKfNmz17e4yAeWWhlrMY4NuLnhyXA68jkZldsH3WoNLjcjt7EhBmQ
         BFYdBW2s7QmSyL44mgSz3YOUQyme88IV237+kyey5sdegwz76nWfxPJLO1mpxkJel/5w
         hmnW1f8rpFESM6CNoT8KPExVc+Hfq/EzEaJLCE5pXc43sNmI96QGNI01SUbxzpFSWGPp
         fek872ifrQrHEtp1vEnKve1YLWx3ty/ljjMhpLOh/YmtZpgrWTAi3EYon/hxIrfLKhHk
         UArb17wN2qP3kzE/lvrnAjMlLf3QToR5n7/K9Ro2nyk2HIfAc9V0RjBvZEIoX5jZUF8y
         /VzA==
X-Gm-Message-State: ANhLgQ1KzqAnVNIuCHxY4xNhSCqXpuyQHjlzWQtYwOMbvXsFQAkeyt40
        EHl/kJQ05Cyn4Ve+DLxI9XQ=
X-Google-Smtp-Source: ADFU+vt9CrOL32fzju0rsgW6b2+is1jo4E9mLrZ14oElkWNUmIMnH4/u4Z397A0CwFhXELH0EzqcQA==
X-Received: by 2002:a1c:bd82:: with SMTP id n124mr3468131wmf.162.1584620879035;
        Thu, 19 Mar 2020 05:27:59 -0700 (PDT)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id c124sm3022493wma.10.2020.03.19.05.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 05:27:58 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Thu, 19 Mar 2020 15:27:29 +0300 (EAT)
To:     Daniel Vetter <daniel@ffwll.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/17] drm/vram-helper: make drm_vram_mm_debugfs_init()
 return 0
In-Reply-To: <20200319101830.GB2363188@phenom.ffwll.local>
Message-ID: <alpine.LNX.2.21.99999.375.2003191522020.89327@wambui>
References: <20200310133121.27913-1-wambui.karugax@gmail.com> <20200310133121.27913-11-wambui.karugax@gmail.com> <20200318152627.GY2363188@phenom.ffwll.local> <alpine.LNX.2.21.99999.375.2003181857010.54051@wambui> <CAKMK7uGwJ6nzLPzwtfUY79e1fSFxkrSgTfJuDeM4px6c0v13qg@mail.gmail.com>
 <20200318165846.GC3090655@kroah.com> <CAKMK7uGbg5Lax+eXJda4k9LNd7JBb+LRtRw4S+bZ4GbNGT--ZA@mail.gmail.com> <20200319075524.GB3445010@kroah.com> <20200319101830.GB2363188@phenom.ffwll.local>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Mar 2020, Daniel Vetter wrote:

> On Thu, Mar 19, 2020 at 08:55:24AM +0100, Greg KH wrote:
>> On Wed, Mar 18, 2020 at 08:10:43PM +0100, Daniel Vetter wrote:
>>> On Wed, Mar 18, 2020 at 5:58 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Wed, Mar 18, 2020 at 05:31:47PM +0100, Daniel Vetter wrote:
>>>>> On Wed, Mar 18, 2020 at 5:03 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Wed, 18 Mar 2020, Daniel Vetter wrote:
>>>>>>
>>>>>>> On Tue, Mar 10, 2020 at 04:31:14PM +0300, Wambui Karuga wrote:
>>>>>>>> Since 987d65d01356 (drm: debugfs: make
>>>>>>>> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
>>>>>>>> fails and should return void. Therefore, remove its use as the
>>>>>>>> return value of drm_vram_mm_debugfs_init(), and have the function
>>>>>>>> return 0 directly.
>>>>>>>>
>>>>>>>> v2: have drm_vram_mm_debugfs_init() return 0 instead of void to avoid
>>>>>>>> introducing build issues and build breakage.
>>>>>>>>
>>>>>>>> References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
>>>>>>>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>>>>>>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>>>>>> ---
>>>>>>>>  drivers/gpu/drm/drm_gem_vram_helper.c | 10 ++++------
>>>>>>>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
>>>>>>>> index 92a11bb42365..c8bcc8609650 100644
>>>>>>>> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
>>>>>>>> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
>>>>>>>> @@ -1048,14 +1048,12 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
>>>>>>>>   */
>>>>>>>>  int drm_vram_mm_debugfs_init(struct drm_minor *minor)
>>>>>>>>  {
>>>>>>>> -    int ret = 0;
>>>>>>>> -
>>>>>>>>  #if defined(CONFIG_DEBUG_FS)
>>>>>>>
>>>>>>> Just noticed that this #if here is not needed, we already have a dummy
>>>>>>> function for that case. Care to write a quick patch to remove it? On top
>>>>>>> of this patch series here ofc, I'm in the processing of merging the entire
>>>>>>> pile.
>>>>>>>
>>>>>>> Thanks, Daniel
>>>>>> Hi Daniel,
>>>>>> Without this check here, and compiling without CONFIG_DEBUG_FS, this
>>>>>> function is run and the drm_debugfs_create_files() does not have access to
>>>>>> the parameters also protected by an #if above this function. So the change
>>>>>> throws an error for me. Is that correct?
>>>>>
>>>>> Hm right. Other drivers don't #ifdef out their debugfs file functions
>>>>> ... kinda a bit disappointing that we can't do this in the neatest way
>>>>> possible.
>>>>>
>>>>> Greg, has anyone ever suggested to convert the debugfs_create_file
>>>>> function (and similar things) to macros that don't use any of the
>>>>> arguments, and then also annotating all the static functions/tables as
>>>>> __maybe_unused and let the compiler garbage collect everything?
>>>>> Instead of explicit #ifdef in all the drivers ...
>>>>
>>>> No, no one has suggested that, having the functions be static inline
>>>> should make it all "just work" properly if debugfs is not enabled.  The
>>>> variables will not be used, so the compiler should just optimize them
>>>> away properly.
>>>>
>>>> No checks for CONFIG_DEBUG_FS should be needed anywhere in .c code.
>>>
>>> So the trouble with this one is that the static inline functions for
>>> the debugfs file are wrapped in a #if too, and hence if we drop the
>>> #if around the function call stuff won't compile. Should we drop all
>>> the #if in the .c file and assume the compiler will remove all the
>>> dead code and dead functions?
>>
>> Yes you should :)
>>
>> there should not be any need for #if in a .c file for debugfs stuff.
>
> Wambui, can you pls try that out? I.e. removing all the #if for
> CONFIG_DEBUG_FS from that file.

Removing them works with CONFIG_DEBUG_FS enabled or disabled.
I can send a patch for that.

wambui karuga
> -Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>
