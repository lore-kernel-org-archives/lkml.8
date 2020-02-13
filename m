Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FA2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F99218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJ3aBK7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgBMNzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:55:03 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33981 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgBMNzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:55:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id c20so5723592qkm.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+3mv3to/fHwh461fSGpxG9+oD/Xobt954dTA/Spw8rM=;
        b=fJ3aBK7dHNFbg+Gb26hepJnaElzlMxYeeAkL1K/jNcdTAqEpDAJTgLI1SHN3AsMorW
         vQVzoky6ZEhl0BVgIPT/oIasLHQwKJb3/wqpa5ihVVn1F6yQg6qtnlQpf+TsJT87NBPo
         +3D2RgUZahtqzoSggIfFvB2hO1fkarnSyWA6fL87nR0GhzoX0zzFzBTrUhkbG2zcPwt9
         BDU79c5Pw74J772y4JOMDXNknvkLHHR/nXh1XFPKFD9kTOAVSYxHYCFmZpfdBtJEdKiA
         ZedxDmTWQCnEHy0t2YJXsVtpwQKf+hqZSqyFSKqc+R0hNBdbok22Y6iiMz4RO2m0mP3n
         gYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+3mv3to/fHwh461fSGpxG9+oD/Xobt954dTA/Spw8rM=;
        b=lSbO47/ddw8nRUoU2zcaabtr1eFN3uTBXzHUUXwQpAe+BazR7WzpqxijA6qhIJDYHt
         2iTwBtFDqnm04VPELxPcEvP+0Ij/oTqPH0HYz/solICA4xYwmd9MPxV2l+2n92HOZ8Rj
         NkJmK/N7RXfp9uMBpL1AF2K/qmhDsibWApkbDlra22EI6rkUWjPghTLXG6m5TLiF/r+x
         b1I/DICzB9KQ/EjuL1gu0KTxJAX7nOsmW+xE427fP3nQYYyGDd5ks+Yzrvd+NxWP/e7Y
         IPMZh76SRxyA+Bxgjqp0RrRa7VU9cP7gGhSHaTTVvMK0yx0/EnoV2W0f+m0SHnicltLl
         IPUg==
X-Gm-Message-State: APjAAAWWTrKjISGMpmtRiizqpiQXE2+OVDsTsK6UuI7H14Xyk7fwdVAq
        FjyTFR9dtKwQOyWKuMSusb2FSg==
X-Google-Smtp-Source: APXvYqw2Ym+v/HAo1cvpZpeVH6DUaDdLrxVTU3lOQz8gPk8DYMm0ZrTykwHef/05FVltMg+1YXoJfA==
X-Received: by 2002:a05:620a:1426:: with SMTP id k6mr13575444qkj.276.1581602101376;
        Thu, 13 Feb 2020 05:55:01 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id c14sm1335108qkj.80.2020.02.13.05.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 05:55:00 -0800 (PST)
Subject: Re: [Patch v9 7/8] sched/fair: Enable tuning of decay period
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-8-git-send-email-thara.gopinath@linaro.org>
 <4eb10687-1a62-cee3-7285-3f50cc023071@infradead.org>
 <5E380D1D.7020500@linaro.org>
 <20200203155549.GL14914@hirez.programming.kicks-ass.net>
 <cc83634f-b3af-6024-7f89-9b231b153070@arm.com> <5E3DE7CC.3060300@linaro.org>
 <c7f299bb-5302-9bfb-2356-61b4c856bd2e@arm.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E455533.3000600@linaro.org>
Date:   Thu, 13 Feb 2020 08:54:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <c7f299bb-5302-9bfb-2356-61b4c856bd2e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2020 06:59 AM, Dietmar Eggemann wrote:
> On 07/02/2020 23:42, Thara Gopinath wrote:
>> On 02/04/2020 03:39 AM, Dietmar Eggemann wrote:
>>> On 03/02/2020 16:55, Peter Zijlstra wrote:
>>>> On Mon, Feb 03, 2020 at 07:07:57AM -0500, Thara Gopinath wrote:
>>>>> On 01/28/2020 06:56 PM, Randy Dunlap wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 1/28/20 2:36 PM, Thara Gopinath wrote:
> 
> [...]
> 
>>> I do agree. IMHO, there are just two little things outstanding:
>>>
>>> (1) arch_scale_thermal_pressure() instead  of
>>>     arch_cpu_thermal_pressure() in v8 4/7
>>
>> The "scale_" part was discussed in v6. Ionela had suggested that having
>> "scale" is not suited for this function because "thermal pressure" is
>> not exactly scaled but subtracted. I actually agree with that.
>>
>> https://lore.kernel.org/lkml/20191223175005.GA31446@arm.com/
>>
>> Having said that if everyone feel the same about naming of this
>> function, I can change it one last time.
> 
> I'm still in favor for this. And Vincent seems to be OK as well:
> 
> https://lore.kernel.org/r/CAKfTPtBzoLnvAJ7sjPogMYS=WwBbdzWO07Kj=KDFVpO4=Su5ow@mail.gmail.com
> 
> The 'v6->v7' change note:
> 
> - Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
>   as per review comments from Peter, Dietmar and Ionela.
> 
> is really not saying from which review comment the individual changes in
> the function name are coming from. And I don't see an answer to Ionela's
> email saying that her proposal will manifest in a particular part of
> this change.
Hi Dietmar,

Like I said, don't want to argue on name. It is trivial for me. I have
v10 prepped with the name change. Will send it out shortly.

> 
>>> (2) guarding of thermal pressure code in Arm's arch_topology driver  w/
>>>     CONFIG_HAVE_SCHED_THERMAL_PRESSURE plus disabling it by default for
>>>     Arm64.
>> It was enabled by default as per your suggestion in v9.
>>
>> The patch can be dropped.
>>
>> I don't understand the need to guard arch_topology with
>> CONFIG_HAVE_SCHED_THERMAL_PRESSURE. CONFIG_HAVE_SCHED_THERMAL_PRESSURE
>> is for scheduler to enable/disable averaging of thermal pressure. We
>> wanted to separate updating and retrieving of instantaneous thermal
>> pressure from scheduler. Guarding it with
>> CONFIG_HAVE_SCHED_THERMAL_PRESSURE is to me equivalent to putting back
>> this whole code in the scheduler framework. I am against it. I also do
>> not see other arch_ functions guarded similarly.
> 
> Cpu-invariant accounting can't be guarded with a kernel CONFIG switch.
> Frequency-invariant accounting could be with CONFIG_CPU_FREQ but this is
> enabled by default by Arm64 defconfig.
> Thermal pressure (accounting) (CONFIG_HAVE_SCHED_THERMAL_PRESSURE) is
> disabled by default so why should a per-cpu thermal_pressure be
> maintained on such a system (CONFIG_CPU_THERMAL=y by default)?

I agree that there is no need for per-cpu thermal pressure to be
maintained if no averaging is happening in the scheduler, today. I don't
know if there will ever be an use for it.
My issue has to do with using a config option meant for internal
scheduler code being used else where. To me, once this happens, the
entire work done to separate out reading and writing of instantaneous
thermal pressure to arch_topology makes no sense. We could have kept it
in scheduler itself.
Another way I think about this whole thermal pressure framework  is that
it is the job of cooling device or cpufreq or any other entity to update
a throttle in maximum pressure to the scheduler. It should be
independent of what scheduler does with it. Scheduler can choose to
ignore it.

> 


-- 
Warm Regards
Thara
