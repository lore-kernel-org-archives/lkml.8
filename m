Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF92C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941CC20679
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyY7nq32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgFDAsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgFDAsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:48:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C92C03E96D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 17:48:04 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q14so3837647qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 17:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tT4t0JzH39OrnKK9caJU9HYd7fkm+atyXcS3vmwuuRs=;
        b=WyY7nq32FkjzUGjd9leWWY8GDQykItSr3XomQSV74eFpCRfOwDwzhBB8vzLhd3KThI
         MhZDYA6FRqhmD/6vgnpbfYlQylHd0SGPGu3RaZ24i1jj45MUzTcIKWc8VEVC9rLrbGOk
         Rpqg7EEryoWt90JkFM8BCtMzxLsc4/d9vE+bBQumI48eDhJ+HHJqR8c/L+TOOsDoafNg
         mVWkTQZYzzXcjYHTXyml1nniZjHLO/WsGctg0UQLY0CwgKkiLkKFkvqDuxBmpA4AAhqg
         aWnKvHhCvcKRXQb3mW33+kg1HTaQd56RwRT0DbTxSptp+CtNe8wiCAkpGmyYo0haAUk6
         x2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tT4t0JzH39OrnKK9caJU9HYd7fkm+atyXcS3vmwuuRs=;
        b=bvwmcRU2c+Y+LgLTjDz3mgEL++aNGdk3/PKdxV/8LN9KndvSgVd+sjz/GoTw2IOhv/
         dnei/KR0lyXwHsJaFTnIAZoooYbloyFSLhvdNoz7N1iBvw5JME7DDGbdm8zRhXk6R7hK
         +B0jl1tf3aOa1/D0froM8osjtTn+5krMySdwpyGaq6vZPtKSk6pOA9GG0A7nIJjPpxLf
         eiTIoJB1c9tuRdmT6QWNgPmAM4SA4OWprFI2OgcdQGRbEaBkuRA75rpoLOLuHMargQ7s
         UZMwJM+Q5IlPBIpLSLNt5/dqV/a/ie9Oo3E/IMfnpaMnPgDnpVb+HxrCLv9NoUFY6q8/
         QOQA==
X-Gm-Message-State: AOAM5308anoy4wvnuKthpLtITtJ9fU3wBBLssb7IeJNySPNuqUqTtQ6M
        RAcyoE9bgROXBe+0Pv7yA05gl9dEu3NGug==
X-Google-Smtp-Source: ABdhPJwwHi77HOr8fe7/uc/I38ZJRi/oTRXf1uWFBiwmN4esk+9KBHJ1w7aXe3HrEAcV6Wd9Qs7YDg==
X-Received: by 2002:ac8:969:: with SMTP id z38mr2106509qth.77.1591231682997;
        Wed, 03 Jun 2020 17:48:02 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id p63sm3011332qkf.50.2020.06.03.17.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 17:48:02 -0700 (PDT)
Subject: Re: v5.7: new core kernel option missing help text
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200603173150.GB1551@shell.armlinux.org.uk>
 <jhjh7vshvwl.mognet@arm.com> <20200603184500.GC1551@shell.armlinux.org.uk>
 <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com>
 <20200603195853.GD1551@shell.armlinux.org.uk> <jhjftbbj3qi.mognet@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <a34fcb9a-ba4b-0c9e-328f-1244c2720ed2@linaro.org>
Date:   Wed, 3 Jun 2020 20:48:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <jhjftbbj3qi.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/20 4:25 PM, Valentin Schneider wrote:
> 
> On 03/06/20 20:58, Russell King - ARM Linux admin wrote:
>> On Wed, Jun 03, 2020 at 09:24:56PM +0200, Vincent Guittot wrote:
>>> On Wed, 3 Jun 2020 at 20:45, Russell King - ARM Linux admin
>>> <linux@armlinux.org.uk> wrote:
>>>> It's a start.  I'm still wondering whether I should answer yes or no
>>>> for the platforms I'm building for.
>>>>
>>>> So far, all I've found is:
>>>>
>>>> arch/arm/include/asm/topology.h:#define arch_scale_thermal_pressure topology_get_thermal_pressure
>>>>
>>>> which really doesn't tell me anything about this.  So I'm still in
>>>> the dark.
>>>>
>>>> I guess topology_get_thermal_pressure is provided by something in
>>>> drivers/ which will be conditional on some driver or something.
>>>
>>> You need cpufreq_cooling device to make it useful and only for SMP
>>> I don't think that this should not be user configurable because even
>>> with the description above, it is not easy to choose.
>>> This should be set by the driver that implement the feature which is
>>> only cpufreq cooling device for now it
>>
>> As I have CONFIG_CPU_FREQ_THERMAL=y in my config, I'm guessing (and it's
>> only a guess) that I should say y to SCHED_THERMAL_PRESSURE ?
>>
> 
> arm and arm64 implement arch_scale_thermal_pressure(); the actual
> implementation is in the arch_topology "driver" (GENERIC_ARCH_TOPOLOGY).
> 
> Then, the caller of arch_set_thermal_pressure() is cpufreq_cooling (see
> below); that'll only get called if you have thermal zones using CPU
> cooling devices.
> 
> AFAICT the current state of things imply we should have something like
> 
>          depends on (ARM || ARM64) && GENERIC_ARCH_TOPOLOGY
> 
> for that option.

Hi Russel/Valentin

The feature itself like Valentin explained below allows scheduler to be 
aware of cpu capacity reduced due to thermal throttling. 
arch_set_thermal_pressure feeds the capped capacity to the scheduler and 
hence the feature makes sense only if arch_set_thermal_pressure is 
implemented. Having said that arch_set_thermal_pressure is implemented 
in arch_topology driver for arm and arm64 platforms. But the feature 
itself is not bound to arm/arm64 platforms. So it would make it wrong to 
add a "depends on (ARM || ARM64) option."

I agree with Vincent that allowing user to choose this option is 
probably not the best. IMO, this should be enabled by default in arm64 
defconfig considering both GENERIC_ARCH_TOPOLOGY and CPU_FREQ_THERMAL 
are enabled by default.
So if it is acceptable three things to be done are:
1. Add the help text.
2. Don't allow SCHED_THERMAL_PRESSURE configurable by user
3. Enable it by default in arm64 defconfig

> 
>>>>> +     help
>>>>> +       This option allows the scheduler to be aware of CPU thermal throttling
>>>>> +       (i.e. thermal pressure), providing arch_scale_thermal_pressure() is
>>>>> +       implemented.
>>
>> Is this feature documented in terms of what it does?  Do I assume that
>> as the thermal trip points start tripping, that has an influence on
>> the scheduler?  Or is it the case that the scheduler is wanting to
>> know when the cpu frequency changes?
>>
>> Grepping for "thermal" in Documentation/scheduler brings up nothing.
> 
> The former; changing a CPU cooling device's state (IOW changing its max
> allowed frequency for thermal reasons) leads to a call to
> arch_set_thermal_pressure() (see
> cpufreq_cooling.c::cpufreq_set_cur_state()).
> 
> It's somewhat interesting to have, at least in theory. On plain SMP that
> would let the scheduler see if some CPUs are more throttled that others,
> which would be leveraged when doing load balancing. It's more
> interesting for big.LITTLE & co, where in the worst cases we can have
> things like capacity inversion, i.e. the bigs are so thermally throttled
> that they give less oomf than a LITTLE.
> 

-- 
Warm Regards
Thara
