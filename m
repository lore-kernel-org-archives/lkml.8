Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C19CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6F920756
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyS2adH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgESQ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:26:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0CAC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:26:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so52881wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K6T9ygmhh8EhbslL3sJRcc4x716+9VUP4WUa0BI/g7k=;
        b=KyS2adH6J20IkVkDzWeskLntpio/aiFWAT54p7fge0aGwq3syL00BvBetJl0+S1Gnw
         GXiik1Xnty5KjvC6I1Vav4WpmOS/PB7uow2Fow8lo/ak63ln61UKwoJO7dUjyRTuBvQj
         iqtvoW2rtsrfYUcOjK6uAiQl78R/CjYrHy7zZmAu3PafwnKivwYvG99IgImSE7twVEpv
         tNPInTEymxi7rKYnrKdyfChxrF6eDnUB0Q5HEoi1jdAzWmIpLSBXQQXraFWjPc+v50W2
         bNFNzqRChTJfsBt+A6gsbE4+bqe4jx+RIQxQb49wiOalqqwsK9LQYmQTy6stJrsAhD/z
         b83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6T9ygmhh8EhbslL3sJRcc4x716+9VUP4WUa0BI/g7k=;
        b=F3Mqt0DCO+O8sv6gI0r9FrW2r+NTHE+FzY2JxIMfCbYynUDpFfcoy5Jbf/gujdlTZB
         o18URuHiXiAVZz3qaR5R6o2/zfXzDhdWa5OQZHd2iKTf1LrN+wuG49C+iCHMB+q6eC/j
         eYCzuNyPulD+Xg8Yxeci9jUiTrC06FQTkA36oDiNTDlCFbe4CymUnO7TUKkqTbOvH9Tp
         5i/fYElxRFtricasdyaNR/Qdf81fcaM716zE/OOLmoE6Jse+Ojd+tDbtv7lt6jjG8EAe
         WDKbhxM9x56N1BNtVhDpqyjUqdOSiIjSiluHGw31MsgfGrOiyYXID/tYwgMZLE2nWAdI
         xiEQ==
X-Gm-Message-State: AOAM533vD4rdoQchLJX1LY1Hki0WkzDku1SKMCkDPjrDKH6t+zU+Ku3p
        jIG+z66Hfabgru9QA0Mb/S7Mhg==
X-Google-Smtp-Source: ABdhPJwRjXPCt4dLaDXXZQvKwEnH3bzcKxN3nJxJp0U7JlJ1qTXlZcQj1Ebi+46WU21NIvSpo2QqKQ==
X-Received: by 2002:a5d:4806:: with SMTP id l6mr27114609wrq.121.1589905593900;
        Tue, 19 May 2020 09:26:33 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e504:4297:986:ffb0? ([2a01:e34:ed2f:f020:e504:4297:986:ffb0])
        by smtp.googlemail.com with ESMTPSA id x22sm203518wmi.32.2020.05.19.09.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:26:33 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Fix warning for set but
 not used
To:     Tony Lindgren <tony@atomide.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kbuild test robot <lkp@intel.com>
References: <20200519155157.12804-1-tony@atomide.com>
 <2f67a110-e52f-94fc-fae2-c3171a67bb8a@linaro.org>
 <20200519160630.GV37466@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <552325fe-e759-6b22-ceee-2d0a4b3b4b2f@linaro.org>
Date:   Tue, 19 May 2020 18:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519160630.GV37466@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2020 18:06, Tony Lindgren wrote:
> * Daniel Lezcano <daniel.lezcano@linaro.org> [200519 16:01]:
>> On 19/05/2020 17:51, Tony Lindgren wrote:
>>> We can get a warning for dmtimer_clocksource_init() with 'pa' set but
>>> not used. This was used in the earlier revisions of the code but no
>>> longer needed, so let's remove the unused pa and of_translate_address().
>>> Let's also do it for dmtimer_clockevent_init() that has a similar issue.
>>>
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>> ---
>>
>> Applied, thanks
> 
> Thanks! Do you already have some immutable commit I can use
> as the base for the SoC and dts changes? Or do you want to
> wait a bit for that?

Hi Tony,

https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=timers/drivers/timer-ti

it contains the two patches + the warning fix

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
