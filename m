Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8EBC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7823921D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSuwaLtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgBRO53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:57:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34380 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgBRO52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:57:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id c20so19755512qkm.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 06:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LOLKrSIHs5n1Ao8qBTTrL6G5TDCm7BgBfgPgBCGeuVQ=;
        b=oSuwaLtHZ9tYkLJx/zDk3PMwMqEuVX8ycYIhJaN+AieL6BxKaLAIdHoJb7XT9m0XMt
         pP4B7wd4VCGURTcNymwsAuVEm3TDtK7ACKhrFHPBACUHEsnuLQODDrIVKPWHiY8PoeF6
         RFgqDh8KrpeKwjkypegLQIrHCTdPlHd3oYCieww8osTI4waNOpAzDmBf05qWw6MstWiR
         gOOWdavRldx4f0Lb9ssxXxXHtAjb2/khCREiL7KivohvZECX+908fih+btO2Bfh4G63o
         FTV0gbg8fCv1Mh8VIVlf/qFbTL74g9K0a69oBk3Q35cbAO4f6xeUuVELMmREVNgFCZiL
         qMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOLKrSIHs5n1Ao8qBTTrL6G5TDCm7BgBfgPgBCGeuVQ=;
        b=YVJsYIxHRwVQFDGl2fprA83OofYwUHtgIIPkAxeD6QeHFEpCTVPCeJeOPDU7ioJCmV
         i7eK2WfylfcjMyqIMzx77uY1YOQdzGKodFKuiCV9/QKH9BB4huRrmhoIiCjBTx3Cf5xk
         1qDj/xKaA0lY+suvnofhyRtmhvgDK6zm1r2yX66z3Janj+TmtCd8NMSxklNIaQZeMQvI
         5o/oQGll11Id7BLsOworj1DoXLQZrRaoy5cZMY0++s81u8UsYfNhmIknsBu3EbqNCGDZ
         a/924WrHXIR06/kbnwozocake2sRyVk54V5KQtGt4ah9VDq9RAx/fHtV+MbW21rZ/iX7
         WTww==
X-Gm-Message-State: APjAAAUUllbMLXDpwsB81ncK/9VQfiQL/pRuml5TUKaVuW0ssro0qyJb
        gA3cbnB5QdOlBJU9BXt9NkKt2w==
X-Google-Smtp-Source: APXvYqx4fjTNmXoxSKjOMlr9yMPxjslNaBoYWNfgfejBegzvIhdUVXEYLNVCYDKG11cQ1L4K2bIS5Q==
X-Received: by 2002:a05:620a:78f:: with SMTP id 15mr18655840qka.295.1582037847432;
        Tue, 18 Feb 2020 06:57:27 -0800 (PST)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id j127sm1607916qkc.36.2020.02.18.06.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 06:57:26 -0800 (PST)
Subject: Re: [Patch v9 7/8] sched/fair: Enable tuning of decay period
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-8-git-send-email-thara.gopinath@linaro.org>
 <4eb10687-1a62-cee3-7285-3f50cc023071@infradead.org>
 <5E380D1D.7020500@linaro.org>
 <20200203155549.GL14914@hirez.programming.kicks-ass.net>
 <cc83634f-b3af-6024-7f89-9b231b153070@arm.com> <5E3DE7CC.3060300@linaro.org>
 <c7f299bb-5302-9bfb-2356-61b4c856bd2e@arm.com> <5E455533.3000600@linaro.org>
 <549ab3ab-f344-a915-7c6a-b0ffa808c354@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <a821cf3f-7a79-85f7-2c88-33a42e600aa4@linaro.org>
Date:   Tue, 18 Feb 2020 09:57:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <549ab3ab-f344-a915-7c6a-b0ffa808c354@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/20 5:26 AM, Dietmar Eggemann wrote:
> On 13/02/2020 14:54, Thara Gopinath wrote:
>> On 02/10/2020 06:59 AM, Dietmar Eggemann wrote:
>>> On 07/02/2020 23:42, Thara Gopinath wrote:
>>>> On 02/04/2020 03:39 AM, Dietmar Eggemann wrote:
>>>>> On 03/02/2020 16:55, Peter Zijlstra wrote:
>>>>>> On Mon, Feb 03, 2020 at 07:07:57AM -0500, Thara Gopinath wrote:
>>>>>>> On 01/28/2020 06:56 PM, Randy Dunlap wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 1/28/20 2:36 PM, Thara Gopinath wrote:
> 
> [...]
> 
>>> is really not saying from which review comment the individual changes in
>>> the function name are coming from. And I don't see an answer to Ionela's
>>> email saying that her proposal will manifest in a particular part of
>>> this change.
>> Hi Dietmar,
>>
>> Like I said, don't want to argue on name. It is trivial for me. I have
>> v10 prepped with the name change. Will send it out shortly.
> 
> Thanks.
> 
> [...]
> 
>>> Cpu-invariant accounting can't be guarded with a kernel CONFIG switch.
>>> Frequency-invariant accounting could be with CONFIG_CPU_FREQ but this is
>>> enabled by default by Arm64 defconfig.
>>> Thermal pressure (accounting) (CONFIG_HAVE_SCHED_THERMAL_PRESSURE) is
>>> disabled by default so why should a per-cpu thermal_pressure be
>>> maintained on such a system (CONFIG_CPU_THERMAL=y by default)?
>>
>> I agree that there is no need for per-cpu thermal pressure to be
>> maintained if no averaging is happening in the scheduler, today. I don't
>> know if there will ever be an use for it.
> 
> All arch_scale_FOO() functions follow the approach to force the arch
> (currently x86, arm, arm64) to do
> 
> #define arch_scale_FOO BAR
> 
> to enable the FOO functionality.
> 
> There is no direct link between consumer and provider here.
> 
>   consumer (sched) -> arch <- provider (arch, counters, CPUfreq, CPU
>                                         cooling, etc.)
> 
> So IMHO, FOO=thermal_pressure should follow this design pattern too.
> 
> 'thermal_pressure' would be the only one which can be disabled by a
> kernel config switch at the consumer side.
> IMHO, it doesn't make sense to have the provider operating in this case.
> 
>> My issue has to do with using a config option meant for internal
>> scheduler code being used else where. To me, once this happens, the
>> entire work done to separate out reading and writing of instantaneous
>> thermal pressure to arch_topology makes no sense. We could have kept it
>> in scheduler itself.
> 
> You might see thermal_pressure more on the level of irq_load or
> [rt/dl]_rq_load and that could be why we have a different opinion here?
> 
> Now rt_rq_load and dl_rq_load are scheduler internal providers and
> irq_load is driven by 'irq_delta + steal' time (which is much closer to
> the scheduler than thermal for instance).

In this case, thermal pressure is quite close to scheduler as it reduces 
the maximum capacity available per cpu and hence affects scheduler 
placement of tasks

> 
> My assumption is that we don't want a direct link between the scheduler
> and e.g. a provider 'thermal'.

Exactly. Which is why the same CONFIG option should not be used between 
the provider and consumer.

> 
>> Another way I think about this whole thermal pressure framework  is that
>> it is the job of cooling device or cpufreq or any other entity to update
>> a throttle in maximum pressure to the scheduler. It should be
>> independent of what scheduler does with it. Scheduler can choose to
>> ignore it

-- 
Warm Regards
Thara
