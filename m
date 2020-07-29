Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA70C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693D22076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqLsZu9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgG2IkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2IkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:40:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07208C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:40:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so20780737wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YJUVSZqIXAUcxRK135uPMY26TWenUYdXUZWwq11zSBY=;
        b=MqLsZu9YbOlKS6mFOepKH+8KAfFJ/mtQQ0W+tGHPTucR2LdBY1Q2npnk0CTYTUS82h
         v9DXVj08hSt0kgyjKdoOiFBiDeVm3mN0e0cH5SF2aXtwwKbqUGuWParVuF+FOIY6B9gu
         nKIxdcOP6Qlhvc8mKlcrghAM9VRsEDDMlPJbPBRZYj7C0flFcABs9hdykujWP/lbuoDA
         lfMZx4bKXqnfr1p7MTXunNw5H7vnkDZX9KMEyp+HYWB9k7PyO/yV1VClXzcCBBG3M0Yj
         WIMP2O9oXMJ4hwdq2iOJPGyCsPgyKU9TDPYTjek/WVV1BVvvemro+FkmjnfDBs26YF4I
         PyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YJUVSZqIXAUcxRK135uPMY26TWenUYdXUZWwq11zSBY=;
        b=KthcIB06w4NHgNjEx6e3hRvgfUsd/gjfq6tYY5E3Ch+gyoo0rCWcgSOlscVrC6FFr9
         DeRM3vUWivJgJt976w9c9t/hu3vGEv0qVX4KPVvRF+85a5HEK15GU4F5iUZmKZtjpdsP
         IRiPTpQ5QfPutQ6YH3MfN031S/X070InYcomh5BeJPUqRXl4mbcH+UG1yPLlBJEnNi6T
         WbhNnVnMmt7mGtvTaIvNlwwHI0HQkNSfJ9jHeNI9eur+eXJHXLp0S7Ps8wY5JE9RT6Ch
         vRIIF+ygeNAYRtT+8zy1wmdzfh51praHElmgerrWPNDpuxh6W8CvJMFASG0vWVETVKJ3
         dH7g==
X-Gm-Message-State: AOAM5313zhT8zVNbRdl/2cjKupXv7NKz0aXbUUu9UMTXh7IgqsGDXQ1c
        dCx4SG+An8oQeKc8WJFTiwn5M8GdGmAmiQ==
X-Google-Smtp-Source: ABdhPJw5yvp3nWT258bEQHmRZ9EmQ9SNB++YPU6N3KfBaR1N4H9HAOwkeizVkcJsFE7XH06WG/cGTA==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr30692686wrs.124.1596012009544;
        Wed, 29 Jul 2020 01:40:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:812d:95b8:6384:6e20? ([2a01:e34:ed2f:f020:812d:95b8:6384:6e20])
        by smtp.googlemail.com with ESMTPSA id x9sm3752135wmk.45.2020.07.29.01.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 01:40:08 -0700 (PDT)
Subject: Re: [PATCH] thermal: core: Add thermal zone enable/disable
 notification
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20200727231033.26512-1-daniel.lezcano@linaro.org>
 <CAHLCerO=KPUR-2qEuFpNV9UUV_O7GoXY-EPhyefOFfL_jZ_0gA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <90f14da8-a197-08cb-cf55-5c88fa8eed58@linaro.org>
Date:   Wed, 29 Jul 2020 10:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerO=KPUR-2qEuFpNV9UUV_O7GoXY-EPhyefOFfL_jZ_0gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2020 07:36, Amit Kucheria wrote:
> On Tue, Jul 28, 2020 at 4:40 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Now the calls to enable/disable a thermal zone are centralized in a
>> call to a function, we can add in these the corresponding netlink
>> notifications.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

I've applied the changes, thanks for the review.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
