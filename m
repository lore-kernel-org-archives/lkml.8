Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FACDC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D00A2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOnN1OjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgD0Uu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0Uu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:50:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A27C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:50:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so442227wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ke3+hwxZH8KWd+Y95XrVqtv4RteQ5LEwpZtFDcG+Atk=;
        b=IOnN1OjOuDh9zOLjkGKkxsWJVoil08Ujky/Lp+q3R+5dst+fZCkQCr8Iz41c6FxUbW
         /8ZTZ6BhfoqHsPl+GDk5ZnSQypcdqiHxXgo5xY5Iaji7tgaYWt5PCLQTuhV7XsLSyEGr
         /nZUn6NR5cwG1Ort6Pb/z4adgQTjENylMKjyqShQ2HxoH3ag0IrZY0fIRqC1/JoePpCr
         0e5Fp0yRWpzh7+5d84N9P+zOY2BJgPm7HQ3EHB3XO0dCwHtKlDUdpyzGtiPmsqN5qieE
         tfSY0l1fXMD18/F5qQwX+iBiKLXDUu8iaFiH4Cy7O4rT1EPLmYZ0MZ7KulvuCu+5QS/B
         ansQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ke3+hwxZH8KWd+Y95XrVqtv4RteQ5LEwpZtFDcG+Atk=;
        b=Uwz3tfBKBnZMLm7UWZCprQH4MvxPEJsD6ozKVIw+LlLmk09VpFsstISrOjtAIkZV/r
         td2JSIgPcrQKAwa+G2JBi4+XYSoDs8lyI35Kv+/T4cJEVZr4EG/Q25XyOYyiRASTqg4o
         dixmOsc4cvBRICNSFUzApf4eTLumzjiBxvJ8LZOSlSEPWXTukNC5fkuQl73Sdrl+DyDw
         Q6iUV5LRxGPU1nbEm8nm/sMYHUEDpRq0e80gX191Nji2ID/wxjUPS/hxNoAfBm8cY3Uf
         xA+yKw/FmCIZI7If54phcsi9On8hc17RH5gXur4K7ana1XPoUJ5sGIz4IP/tU7tAIz/A
         qQGw==
X-Gm-Message-State: AGi0PubiEAxTNBD167VoSKpeSdppHNWhz7f9PNCWS83UNM8s63WNOFP9
        3J9m0Eil2kECCgNcEJ/w1ZBurQ==
X-Google-Smtp-Source: APiQypJEKMvI0WHo2n+3lpSes1k1Br9sMhkkcFEC+gs/5niMwjK6zkoK7ccECDRgMUXJ7QXASV7h6w==
X-Received: by 2002:a1c:a9d3:: with SMTP id s202mr586496wme.160.1588020626330;
        Mon, 27 Apr 2020 13:50:26 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id j10sm471455wmi.18.2020.04.27.13.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 13:50:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
To:     Saravana Kannan <saravanak@google.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <573b7d9e-fb5d-5c81-a981-6d965db933f3@linaro.org>
Date:   Mon, 27 Apr 2020 22:50:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx9sc6oWSPK=aWJ+39i9eHAyg6iOf+Xf2oVECO+g1pFjtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2020 22:12, Saravana Kannan wrote:
> On Mon, Apr 27, 2020 at 1:09 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 27/04/2020 21:04, Saravana Kannan wrote:
>>> On Mon, Apr 27, 2020 at 10:13 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 13/04/2020 04:55, Baolin Wang wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> On Tue, Mar 24, 2020 at 1:59 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>>>>>>
>>>>>> From: Saravana Kannan <saravanak@google.com>
>>>>>>
>>>>>> This allows timer drivers to be compiled as modules.
>>>>>>
>>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>>> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
>>>>>
>>>>> Do you have any comments for this patch set? Thanks.
>>>>
>>>> If my understanding is correct, this patch is part of the GKI picture
>>>> where hardware drivers are converted to modules.
>>>>
>>>> But do we really want to convert timer drivers to modules ?
>>>>
>>>> Is the core time framework able to support that (eg. load + unload )
>>>
>>> So this will mainly be used for secondary timers that the system
>>> supports. Not for the main one that's set up during early boot for
>>> sched timer to work. For the primary timer during boot up, we still
>>> expect that to be the default ARM timer and don't want/expect that to
>>> be a module (it can't be).
>>
>> My question is about clockevents_config_and_register() for instance, is
>> there a function to unregister in the core framework ?
> 
> We can just have these modules be "permanent" modules that can't be
> unloaded. They just need to not implement module_exit().

You are right.

I can understand the goal of making everything as much modular as possible.

But TBH, I have a bad feeling about this. Sounds like GKI will give the
opportunity to companies to stop upstreaming their drivers and favoring
fragmentation like what we had several years ago. Not sure it is a good
thing, especially for upstream SoC support.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
