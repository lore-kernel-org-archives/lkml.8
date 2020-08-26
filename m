Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2B720707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Re5YAll6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgHZJTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgHZJTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:19:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4888AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:19:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so1020011wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aQcWyWsk38YmTkWkQQedY4JUFqd5lel0GI59fGELsZY=;
        b=Re5YAll6kM+/qHPCwaFGTdAnaHmZFyhlrOR8z0SsaMrpkbz9oS7+ticj73RwOxcTDi
         RsOCnIs8KaS/IqFMdZfnjdweWuO9R3Kjcx64KRlceaGgkhy31LEhdxX+uTl+lAGRafEc
         lGLwqWRl4u6I3+rFr+hEryjlZXhDFSEBtpmFVAPd4BS+gsjT9cgbd6KOSLWBZldrMFfc
         pkezhSnTJ7ARy9H55SYkJoxVM+NfD0V45Q9cQd48Ci1O5Okj8A3qS1GRxFwlFFagJzPE
         DzYfsQtpLWJdpIIZ6tBHIlw6PejlOz+cejV8SeLwemZ4xXVghtUvtTa0XWwqYC5fPXGj
         lkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aQcWyWsk38YmTkWkQQedY4JUFqd5lel0GI59fGELsZY=;
        b=gUdEbjr1PfxC2qzS2d0iFsT9cHTA5e733sPz1KI0qjEIRHoPFJqNnAUhw+kqMUAHc3
         OoOtjjtA9w5e0t4cWV569+kNl5vgTwj+anuUAbLxzCBpzC5SRbhdcaolBVqyyy3eIQ7l
         w3NW/1m/OwvPyef+cZeL/AfZgo3B9dUsQcbM3/r2ET1vHaIIzCrmanqklAhoFgLlwZWl
         gRi/5akcCpLGI4AzVB7vuZVagyxLL8ufHfXWUsakGVvYW6OZEw+IMeBFVAAcrlrfMvwR
         22RicBd5qw3GEgS5sEfJSHNgy3Bop3pXjVAtnNY/UdC12qOJCojEXuRrMV2bKrTv/e8I
         JpeA==
X-Gm-Message-State: AOAM5315sK5gBxtpPiNubDkRNd94yNRbVMz+0kZp0hqrjvwA+oExwrZC
        SuAmxsEZ+/6+AGsUUIalc/mwAw==
X-Google-Smtp-Source: ABdhPJx/tuIFtWZKSy7AJh6YwPDzBe15yli6WSJ1VCxEeq3keSaGzRbAVGb3KLflm17pbZnrvz1zbA==
X-Received: by 2002:a1c:b143:: with SMTP id a64mr5924451wmf.43.1598433543749;
        Wed, 26 Aug 2020 02:19:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5838:da98:5a96:aea3? ([2a01:e34:ed2f:f020:5838:da98:5a96:aea3])
        by smtp.googlemail.com with ESMTPSA id a85sm4581111wmd.26.2020.08.26.02.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 02:19:03 -0700 (PDT)
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling device's
 statistics
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
References: <20200818063005.13828-1-zbestahu@gmail.com>
 <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
 <20200826101319.00003048.zbestahu@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c3fd7949-b33a-aca3-8dd5-1c2df35fb63d@linaro.org>
Date:   Wed, 26 Aug 2020 11:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826101319.00003048.zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yue,

On 26/08/2020 04:13, Yue Hu wrote:
> On Mon, 24 Aug 2020 12:40:35 +0200
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
>> On 18/08/2020 08:30, Yue Hu wrote:
>>> From: Yue Hu <huyue2@yulong.com>
>>>
>>> We observed warning about kzalloc() when register thermal cooling device
>>> in backlight_device_register(). backlight display can be a cooling device
>>> since reducing screen brightness will can help reduce temperature.
>>>
>>> However, ->get_max_state of backlight will assign max brightness of 1024
>>> to states. The memory size can be getting 1MB+ due to states * states.  
>>
>> What are the benefits of a 1024 states cooling device ? Is the
>> difference noticeable with a such small step ?
> 
> Okay, this issue is happened under MSM/Android platform. QCOM spmi wled driver
> will define the max brightness. We needs to fix the issue to get thermal statistics.

Let me rephrase my questions:

Don't you think there is something wrong in creating a 1024 x 1024
matrix to show transitions ?

What is the benefit of such stats ?

What is the benefit of having a 1024 states cooling device ?




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
