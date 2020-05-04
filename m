Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBBEC4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D9F20661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrJGfQ5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbgEDSOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730930AbgEDSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:00:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E5C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:00:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so533825wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qbmRVkJVnDjRqhdFY+l/ig1wTrc758l+/8RY3n4wjFc=;
        b=PrJGfQ5M+WmbbFqCXZZjiflyl42zUUO4bLQu04MZySO3vfwbQdagYqYvMO3ZIrSDhJ
         sAN7Jsw5y4Mza7k/s9JBHHJSP2HPGKEH2TetQbSDCpiBPhTD6wk2+F9hXVZBP9RVntHX
         AW+BB6OaY2nEIZ0A4HTMAHB5Embv9TjRxxTo5Rh8NUgzPcL8owogcYqYQGer8s5ff1vX
         KdAmLsOiE5kSh36ooaNRl3L8gIi3GTtH4wn5CesKc255fvNyK37iyO00+PR/Z/Iss5xX
         m32segT/SepHrM+2ty1btGlebX9G3wH2nCvorA4B1gQwxr4Pt8V/KBw3cYw3545uKHQm
         JkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qbmRVkJVnDjRqhdFY+l/ig1wTrc758l+/8RY3n4wjFc=;
        b=NJ6og/QDd9YydqBF9T3UnaTHqDmmaAJGBFkVfkTH6AKattomVs2orooApjCJTXyF0u
         zV3DE4y27AzcDbGk2fQp7YgWiGLRS5bMCeBMPUHdPN5+ZDoB5bNSMPs+2MsWC9lz5+9N
         mGpjCtnQcikaXnynb6N+TctxLKbNZEeQpMdK0FcBkviy5ltbpzYm8VDqFvxnpuj67/mg
         KvIi6pmtqtVwn0WsvwFnxrHZpiTqJ0fgBNyKCwEIwFr0Hhk52P5lrJg1tIGfUacVhbU9
         8Q8OHczi+aCKz2fnKgiKPK/UKA+UcP8iNxl9vx4JZPrXLz17xYspWjfwzuNlLEHxMM0o
         hQRw==
X-Gm-Message-State: AGi0PubdkAOUG8klet0tD3hZfB+MJ5ayDOt7xSCTGrL77baKzhqdc+pL
        GFZHXKV0Emq8OHMpPglGv8Nhdw==
X-Google-Smtp-Source: APiQypIIewN+KD0rmmmMDEFgyICcmHYy6pzcXOsTGiaXb7cTDdxUe2Z9XD2ayjd0GNyIyyvA4SuvFA==
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr15239758wmc.14.1588615203806;
        Mon, 04 May 2020 11:00:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1938:2e25:c14c:a06e? ([2a01:e34:ed2f:f020:1938:2e25:c14c:a06e])
        by smtp.googlemail.com with ESMTPSA id w83sm267860wmb.37.2020.05.04.11.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 11:00:02 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
 <20200429103644.5492-4-daniel.lezcano@linaro.org>
 <99b3bc79-f48a-3d51-a8ae-8b9ca4856d36@arm.com>
 <04b5da25-d591-b08a-e554-6e084d7ea908@linaro.org>
Message-ID: <f3cee834-4946-10bd-a504-df6cf62d9e90@linaro.org>
Date:   Mon, 4 May 2020 20:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <04b5da25-d591-b08a-e554-6e084d7ea908@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 29/04/2020 23:01, Daniel Lezcano wrote:
> On 29/04/2020 22:02, Lukasz Luba wrote:
>>
>>
>> On 4/29/20 11:36 AM, Daniel Lezcano wrote:
>>> The cpuidle driver can be used as a cooling device by injecting idle
>>> cycles. The DT binding for the idle state added an optional
>>>
>>> When the property is set, register the cpuidle driver with the idle
>>> state node pointer as a cooling device. The thermal framework will do
>>> the association automatically with the thermal zone via the
>>> cooling-device defined in the device tree cooling-maps section.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>   - V4:
>>>     - Do not check the return value as the function does no longer
>>> return one
>>> ---
> 
> [ ... ]
> 
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Thanks Lukasz for the review.
> 
> Rafael, as Lorenzo and Sudeep are not responsive, could you consider ack
> this patch so I can merge the series through the thermal tree ?

Gentle ping ... Sudeep, Lorenzo or Rafael ?

Thanks

  -- Danie



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
