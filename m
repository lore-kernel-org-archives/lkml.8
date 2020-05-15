Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDA1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF29220709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+wYi/xB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgEOPZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726241AbgEOPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:25:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726DAC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:25:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so3129892wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YFhUWh3rqYQ5lYOCD1pUDd9xSXvV5hD7qu9U6/eGHK8=;
        b=u+wYi/xB7RG7dW9P//tCKce7JU27PuS4/ZEaQtTv/6A9bKF5AKlZUI4Ea2o+fuoUsD
         TYrrzV3tdNVH3TW8F+e0jman9omN7kjFyd2zEo2y0/Io8nUD7ENLB0oduoA9zTLnWJni
         UB1ky4C+gENKTORSOp5+6osP3oZiQyv2sS20GHf3dnAQ7D8xZr6VkWGdZpyWb25LvaTn
         BjZckcxWYsLcU7ESIEbw7J5bt31IzvwMENVE8PzoT84XHq3rvFGpEyCJ9TBzwGByr1yp
         KBea4JqUP9/UYZ80wYNCIdYpHHoQVw12Gc4Reks3GjzIVHXFJZIiSCyA0Dl7rJAU1xtF
         EIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YFhUWh3rqYQ5lYOCD1pUDd9xSXvV5hD7qu9U6/eGHK8=;
        b=Dr+N0W4ODWV12xsDpaR66uTa9QAqpfqoXqrXzCNAlwhREyiUcpq+W79SAGpzYRdj+/
         vLxwdGUwm26smAZJiitYAJkhZyH3q5Kf1K3Z568lESAA0w13cp/DzkFKB3pLkTVcsgQ0
         MOd6pMDtOeRxgBg5qFm1514jWmLrROQrwKuJPG4eE4RyQvxcXLpoDG2EDDlv1f1iEAJE
         6py/FgGLQzWMeaitdHZ/XcNtH9pxs0A46SrfITByWYCqDA9iUzyjJlmrRZsThc2l87Ei
         N8T4YbnNzTAJ+WE+tN5e4odZI1VF8wU0fP2L1s2KzziAmAsIXoF45j7zpoeYzNF50bog
         5+lQ==
X-Gm-Message-State: AOAM530/Wgm1ORa+zlHRUp37oYw5Y8Yibf/2Jyf340JkEr53s3Xww7/Q
        kll0aydpLk7/yTyR5/nBbag0KQ==
X-Google-Smtp-Source: ABdhPJxJfjd9pQ/+v6j1z3nSlQv5vEd9TC1ju+/BM0f9fa47cxr7bzT/h/QNmZPQGNKf8QPtcqxPFg==
X-Received: by 2002:a05:600c:14c6:: with SMTP id i6mr4518549wmh.58.1589556336049;
        Fri, 15 May 2020 08:25:36 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5450:281:8a7d:dd9a? ([2a01:e34:ed2f:f020:5450:281:8a7d:dd9a])
        by smtp.googlemail.com with ESMTPSA id b20sm4282178wme.9.2020.05.15.08.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:25:35 -0700 (PDT)
Subject: Re: [Linux-stm32] [PATCH v7 5/6] clocksource: Add Low Power STM32
 timers driver
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200420121620.2099-1-benjamin.gaignard@st.com>
 <20200420121620.2099-6-benjamin.gaignard@st.com>
 <bbac5aa5-1c95-456e-3141-006d4fa86095@st.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <103c5558-4dc9-63c9-4994-5c8f97646eee@linaro.org>
Date:   Fri, 15 May 2020 17:25:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bbac5aa5-1c95-456e-3141-006d4fa86095@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 05/05/2020 09:26, Benjamin GAIGNARD wrote:
> 
> 
> On 4/20/20 2:16 PM, Benjamin Gaignard wrote:
>> From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>
>> Implement clock event driver using low power STM32 timers.
>> Low power timer counters running even when CPUs are stopped.
>> It could be used as clock event broadcaster to wake up CPUs but not like
>> a clocksource because each it rise an interrupt the counter restart from 0.
>>
>> Low power timers have a 16 bits counter and a prescaler which allow to
>> divide the clock per power of 2 to up 128 to target a 32KHz rate.
> Gentle ping to reviewers on this driver part of the series.
> The bindings and the MFD have been reviewed so I hope I can progress
> on the driver part too.

[ ... ]

sorry for the delay.

How do you want these patches to be merged?

Shall I pick patch 6/7 ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
