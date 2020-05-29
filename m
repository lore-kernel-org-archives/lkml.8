Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04E6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822BB206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgE2MrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:47:20 -0400
Received: from foss.arm.com ([217.140.110.172]:36042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgE2MrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:47:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9113A55D;
        Fri, 29 May 2020 05:47:19 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B2F93F305;
        Fri, 29 May 2020 05:47:17 -0700 (PDT)
Subject: Re: [PATCH 05/15] drm/panfrost: use spinlock instead of atomic
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20200510165538.19720-1-peron.clem@gmail.com>
 <20200510165538.19720-6-peron.clem@gmail.com>
 <788ac664-e426-d307-f81e-9632de09887c@arm.com>
 <CAJiuCcemwM-11ZT5+-4JfyTgTRD-_JjWz=HDCme8743M5Epf0g@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <33b045d6-deb9-2c09-3f74-5ca13f4d2e46@arm.com>
Date:   Fri, 29 May 2020 13:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcemwM-11ZT5+-4JfyTgTRD-_JjWz=HDCme8743M5Epf0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2020 13:35, Clément Péron wrote:
> Hi Robin,
> 
> On Fri, 29 May 2020 at 14:20, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2020-05-10 17:55, Clément Péron wrote:
>>> Convert busy_count to a simple int protected by spinlock.
>>
>> A little more reasoning might be nice.
> 
> I have follow the modification requested for lima devfreq and clearly
> don't have any argument to switch to spinlock.
> 
> The Lima Maintainer asked to change witht the following reason :
> "Better make this count a normal int which is also protected by the spinlock,
> because current implementation can't protect atomic ops for state change
> and busy idle check and we are using spinlock already"
> 
>>
>>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
>>> ---
>> [...]
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
>>> index 0697f8d5aa34..e6629900a618 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
>>> @@ -4,6 +4,7 @@
>>>    #ifndef __PANFROST_DEVFREQ_H__
>>>    #define __PANFROST_DEVFREQ_H__
>>>
>>> +#include <linux/spinlock.h>
>>>    #include <linux/ktime.h>
>>>
>>>    struct devfreq;
>>> @@ -14,10 +15,17 @@ struct panfrost_device;
>>>    struct panfrost_devfreq {
>>>        struct devfreq *devfreq;
>>>        struct thermal_cooling_device *cooling;
>>> +
>>>        ktime_t busy_time;
>>>        ktime_t idle_time;
>>>        ktime_t time_last_update;
>>> -     atomic_t busy_count;
>>> +     int busy_count;
>>> +     /*
>>> +      * Protect busy_time, idle_time, time_last_update and busy_count
>>> +      * because these can be updated concurrently, for example by the GP
>>> +      * and PP interrupts.
>>> +      */
>>
>> Nit: this comment is clearly wrong, since we only have Job, GPU and MMU
>> interrupts here. I guess if there is a race it would be between
>> submission/completion/timeout on different job slots.
> 
> It's copy/paste from lima I will update it,

Lima ('Utgard') has separate units for geometry and pixel processing 
(GP/PP). For Panfrost ('Midgard'/'Bifrost') we don't have that 
separation, however there are multiple job slots. which are implemented 
as multiple DRM schedulers. So the same fix is appropriate, but clearly 
I missed this comment because it's referring to GP/PP which don't exist 
for Midgard/Bifrost.

>>
>> Given that, should this actually be considered a fix for 9e62b885f715
>> ("drm/panfrost: Simplify devfreq utilisation tracking")?
> 
> I can't say if it can be considered as a fix, I didn't see any
> improvement on my board before and after this patch.
> I'm still facing some issue and didn't have time to fully investigate it.

Technically this is a fix - there's a small race which could cause the 
devfreq information to become corrupted. However it would resolve itself 
on the next devfreq interval when panfrost_devfreq_reset() is called. So 
the impact is very minor (devfreq gets some bogus figures). The 
important variable (busy_count) was already an atomic so won't be affected.

Steve

> Thanks for you review,
> 
> 
>>
>> Robin.

