Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D5DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C5C206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FM7U1nx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgD1HCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgD1HCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:02:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83355C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:02:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so1551971wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G6N4yhymXWw02MnYWh1RN32cSvRi2zEAbucISOfq9jw=;
        b=FM7U1nx8DLUt8iXFnYRZeEmE5PBB81CXDZcjIhnu3C9pEIQDH1sYmmW4CKAumw6woD
         0PFg3KtqCTTSA4joplvdQZQiVTk25lFNbGhWErY0NO8dYXVZJC1x7fQjk6fy7IDZOK5w
         zVYTYMNZ+chlDowzIHoeHtB1tqjclqdzcKft/Ncpm1n6EbLcRYLU3u+GbEzolqfomtu5
         Qu5c0PUF2e8pp2RPZFN2mLjLK4sWkwJ5MGNNWE1YcFX9s5m4n0+BeNVKfLoT1FEgpUlL
         K5+m59hlxZ/MewfAqqxrdlKb+uwiywJkTY+sAgVc4LaQrfwM7hZA7Gpw2MMivwCl/SZE
         2Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6N4yhymXWw02MnYWh1RN32cSvRi2zEAbucISOfq9jw=;
        b=obsx3/1UoMPleGbzuxxCHRFmpjUHqZZXg0qKaVCe8ZLDgFJdw9fMSlAJkhgx+6SY7Y
         uoEpHmGQDDQclHbtA2Djqu3FWI8OyhvdQyD1f3WVQaW8yU4Erc5LwF5YwmNA7OdQt4D2
         0gsH9KabcRVV8UXi7un9MOlCHbHNyFRsWgDG9hnxB3ehHhOoBjsc78u+VrG/EX1y2JJ9
         tvISNIJ2up/NrlgavOAsnUy2EJNIQEV1pri+fNZa9fPdGQq/FuVRoht4G1yQkfTkbo3g
         YU1R/egceX8C519Jobu59YWlYFbcNh/is+IWBeNigCa4oZFm4WhMhsa4d8MRQbHHE9+A
         jMkA==
X-Gm-Message-State: AGi0PuY5C1ou3ouU6ZEzAfiST3Chn+e+gBLTFE82+SeAoT9ae/4EZ+e8
        pNRFg2avBAcQDDI+M8Bosv3hvw==
X-Google-Smtp-Source: APiQypKOqN9eqQ1TCIbD4j1N0SaPD3W9JaN0qL0TWatS7LyvrpQ3sQ7rgHWwlqO73ULwPDekoNrKrA==
X-Received: by 2002:a1c:a4c2:: with SMTP id n185mr3071256wme.104.1588057360678;
        Tue, 28 Apr 2020 00:02:40 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id p6sm24029339wrt.3.2020.04.28.00.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 00:02:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
To:     Sandeep Patil <sspatil@android.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
 <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com>
 <bd800f7b-05fd-b393-fba6-1965ba89e1b3@linaro.org>
 <CAGETcx9da-U+dXA6sreTKJQiS3brYh3Hfh_qVYt06=3UOSmT_g@mail.gmail.com>
 <429da47b-ad51-30eb-ff36-b05780c941ba@linaro.org>
 <CAGETcx9sc6oWSPK=aWJ+39i9eHAyg6iOf+Xf2oVECO+g1pFjtQ@mail.gmail.com>
 <573b7d9e-fb5d-5c81-a981-6d965db933f3@linaro.org>
 <20200427221752.GA166576@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7c508403-3b53-8285-5724-c2bca221b77a@linaro.org>
Date:   Tue, 28 Apr 2020 09:02:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427221752.GA166576@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Saravana,

On 28/04/2020 00:17, Sandeep Patil wrote:
> Hi Daniel,
> 
> On Mon, Apr 27, 2020 at 10:50:24PM +0200, Daniel Lezcano wrote:
>> On 27/04/2020 22:12, Saravana Kannan wrote:
>>> On Mon, Apr 27, 2020 at 1:09 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 27/04/2020 21:04, Saravana Kannan wrote:
>>>>> On Mon, Apr 27, 2020 at 10:13 AM Daniel Lezcano
>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>>
>>>>>> On 13/04/2020 04:55, Baolin Wang wrote:
>>>>>>> Hi Daniel,
>>>>>>>
>>>>>>> On Tue, Mar 24, 2020 at 1:59 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>>>>>>>>
>>>>>>>> From: Saravana Kannan <saravanak@google.com>
>>>>>>>>
>>>>>>>> This allows timer drivers to be compiled as modules.
>>>>>>>>
>>>>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>>>>> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
>>>>>>>
>>>>>>> Do you have any comments for this patch set? Thanks.
>>>>>>
>>>>>> If my understanding is correct, this patch is part of the GKI picture
>>>>>> where hardware drivers are converted to modules.
>>>>>>
>>>>>> But do we really want to convert timer drivers to modules ?
>>>>>>
>>>>>> Is the core time framework able to support that (eg. load + unload )
>>>>>
>>>>> So this will mainly be used for secondary timers that the system
>>>>> supports. Not for the main one that's set up during early boot for
>>>>> sched timer to work. For the primary timer during boot up, we still
>>>>> expect that to be the default ARM timer and don't want/expect that to
>>>>> be a module (it can't be).
>>>>
>>>> My question is about clockevents_config_and_register() for instance, is
>>>> there a function to unregister in the core framework ?
>>>
>>> We can just have these modules be "permanent" modules that can't be
>>> unloaded. They just need to not implement module_exit().
>>
>> You are right.
>>
>> I can understand the goal of making everything as much modular as possible.
>>
>> But TBH, I have a bad feeling about this. Sounds like GKI will give the
>> opportunity to companies to stop upstreaming their drivers and favoring
>> fragmentation like what we had several years ago. Not sure it is a good
>> thing, especially for upstream SoC support.
> 
> ... and that is a very valid concern too IMO.
> 
> However, the way we see it, as things stand today, we don't even know what
> goes into Linux on all android phones out there. We know what we add, as part
> of the AOSP kernel, however, what actually runs on the device is normally
> about a million lines of code changes on top of what we do.
> 
> So, for the GKI parts, we are doing the following
> 
> 1. Making the peripheral drivers modules also means the GKI must have all the
> core framework changes built-in. This gets us the list of core kernel changes
> that ship on Android devices so we can work on upstreaming them OR find the
> appropriate alternative. For Android, that answers the canonical
> - "Where is the use case?" question coming from anyone.
> 
> You can see the list of these out-of-tree changes is growing by the day in
> AOSP right now[1]. Its there for everyone to find in exactly *one place*.
> Note that, almost all of those patches have been posted on the list already.
> That's the first pre-requisite for any change that goes into AOSP kernel[2].
> 
> 2. Once we have a core kernel that *truly* works on all Android devices, we
> will have built up list of changes we want to upstream (or anyone can pick
> them from our public tree). Android will still continue to move to newer
> kernel versions easily (may be at a difference cadence ..)
> 
> 3. About the incentive for upstream SoC support: As part of GKI, we are not
> promising a forever stable kernel<->module interface. We still change it each
> year. The *best way* for anyone to have their SoC / peripheral supported is
> _still_ "going upstream". In fact, we advertise it as such[2]. The modularity
> aspect just brings a much needed flexibility for execution.  The flexibility
> is needed given the number of stakeholders involved just in the kernel as of
> today. (Its a mix of Upstream, Google, SoC manufacturer, device maker and
> many other small parts).
> 
> 
> 4. We also haven't been so keen on the "unloading" of a module. We know there
> were subsystems where unloading may not work as expected. Then again, to my
> knowledge, nobody has been stress testing with 500+ different modules that
> register to all core frameworks being loaded and unloaded at random times.
> Even if someone did, we just didn't think its worth the hassle or time at
> this moment. Unloading the module didn't buy us anything. (Although, I do get
> the point about "correctness"  -- so it shouldn't also be obviously broken)

That was my understanding of the GKI, thanks for confirming.

Putting apart the non-technical aspect of these changes, the benefit I
see is the memory usage optimization regarding the single kernel image.

With the ARM64 defconfig, multiple platforms and their corresponding
drivers are compiled-in. It results in a big kernel image which fails to
load because of overlapping on DT load address (or something else). When
that is detected, it is fine to adjust the load addresses, otherwise it
is painful to narrow down the root cause.

In order to prevent this, we have to customize the defconfig each
version release.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
