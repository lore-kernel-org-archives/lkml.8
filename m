Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9041C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D4420663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyC/SPwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGAHI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGAHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:08:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C587DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:08:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so21250166wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZOhd+w6SRKJEtTQwBcpU/qkykA7+rmhMgIFWkoBoqBM=;
        b=tyC/SPwyySO5z/5I0YJreE3FQ/N/tCdN5ADeXWsIlFmmjXevaHmibS3duzGAVdrw2L
         ChQp2jRb9DoruG/c701GDmp8wamXB/CNx7ju2Ks+y4k1rp+nDeRzkitBBBPNjQuiWrAL
         PlIE1maNz/kFMXnBVpNaOiQtk6yxIOzU3xYVi0Wa0g0NLsQhecBTJx4aiAXf4wPzU30j
         Aj641V1sLhpNLIphnY3o1EjaQR+kb6QfH2UhBjzkg/fDxbyMv2JlJnhiiSKg5jIPY7vJ
         bGXdxwujUVOoWpM52uyDyWMHoNhgS9JbN4UUSOKReYUT7UTgEltC3aXh7WsN0FBCXfQ8
         8FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZOhd+w6SRKJEtTQwBcpU/qkykA7+rmhMgIFWkoBoqBM=;
        b=UQUi9X0qq6KXJvjGQvJRixSHFII4rm2vO0GktuBWn5yhYdAUbv07aTc+WUrzichowG
         9iikWwbBP9qfUThOPbwz0cGN0YS1q42Mix+bfy01cfV2kHWlGu6AhztAwFF5Kih1ZjEU
         Xw3+fmoF6lZsTa8O4qz7Opc4HJP2GcyiUYSE5GbV/S/+uJJmAkhPbaFMAh4eRd2iiFrW
         CNjwEzMWfzJY7CM3r9UkNuq6zh4zdQhDUp6igfKy72ZR3TJlKCwDlywyY05Z0ThZh0mC
         vMQUKKYsHz5CVCRjqylYXKZFYoS2KeDhbgeAzObeGDP4/2AOUieWN7fR5N03PEaV+Dqa
         he4A==
X-Gm-Message-State: AOAM531xsvZTew42+skJny/e3oK+IFsEII9YPkcuSSEGSgha28v9EMZM
        Xdf+QgdzGLRkG44Lju/dNBdDxRWqm0s=
X-Google-Smtp-Source: ABdhPJyxdhdgwjDTQ6JTrHC5bb+v1AeiEFDODOglCR8BsxQIJXxEvlAvKZTfLRRChqD7K6fYfGl0pA==
X-Received: by 2002:a1c:2d0d:: with SMTP id t13mr9880641wmt.43.1593587305273;
        Wed, 01 Jul 2020 00:08:25 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id j24sm6882055wrd.43.2020.07.01.00.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 00:08:24 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] thermal: core: Add helpers to browse the cdev, tz
 and governor list
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <CAP245DVy+Z9D+6=-cX4TaGFoK-e2N+mWwOvNYOe_E9Fh=7vnaA@mail.gmail.com>
 <bed1d41f81f369e7123a2eab7fde3e81a3b063aa.camel@intel.com>
 <CAP245DW4ntkK9rWCZT8KX07tBJoHaUkXPVRH4Vp2yRHi=m6JCg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7f4f9a0a-404c-79ff-4aa8-8629e3e9e76b@linaro.org>
Date:   Wed, 1 Jul 2020 09:08:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAP245DW4ntkK9rWCZT8KX07tBJoHaUkXPVRH4Vp2yRHi=m6JCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2020 20:46, Amit Kucheria wrote:
> On Tue, Jun 30, 2020 at 8:40 PM Zhang Rui <rui.zhang@intel.com> wrote:
>>
>> Hi, Daniel,
>>
>> seems that you forgot to cc linux-pm mailing list.
>>
>> On Tue, 2020-06-30 at 17:16 +0530, Amit Kucheria wrote:
>>> On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> The cdev, tz and governor list, as well as their respective locks
>>>> are
>>>> statically defined in the thermal_core.c file.
>>>>
>>>> In order to give a sane access to these list, like browsing all the
>>>> thermal zones or all the cooling devices, let's define a set of
>>>> helpers where we pass a callback as a parameter to be called for
>>>> each
>>>> thermal entity.
>>>>
>>>> We keep the self-encapsulation and ensure the locks are correctly
>>>> taken when looking at the list.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>  drivers/thermal/thermal_core.c | 51
>>>> ++++++++++++++++++++++++++++++++++
>>>
>>> Is the idea to not use thermal_helpers.c from now on? It fits
>>> perfectly with a patch I have to merge all its contents to
>>> thermal_core.c :-)
>>
>> I agree these changes should be in thermal_helper.c
> 
> I was actually serious about killing thermal_helper.c :-)
> 
> What is the reason for those 5-6 functions to live outside
> thermal_core.c? Functions in thermal_helper.c are called by governors
> and drivers, just like the functions in thermal_core.c. I couldn't
> find a pattern.

I propose to move these functions in the thermal_helper.c for now as
requested by Rui. Then you can send a patch to merge thermal_helper.c to
thermal_core.c after and we can comment the move.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
