Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C1CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F6422522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gi1j1Ic6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgA1Nci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:32:38 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45064 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgA1Nci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:32:38 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so13257197qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 05:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Qrz7foT4+zP/9eENWD8MNY8N2LpxKt83XObpwKGVWl4=;
        b=Gi1j1Ic6SuHQMM2iNTF76z1ZLpimzm0H5x9odHPtBwtBKfftPx8IbXCRW97AzOsHH9
         lqMHpJPZNAp/YMQW+GGg2l88A8UBkEynowQhHkrQIZAhoUhie2si0UAEGvsoPJlhHZkX
         +T8a2MO46RT7oLVbMOhvQ+e/h/RW46bYrLcExTvXtfbpT2odKk1MsoRFFvsS2US6JEd6
         /HFMKvP28KscsrHLAp69NG9zSB/nufN44fqIUFdrSPqVQKvYuD2TfYzzeWIQGi3rlPbW
         vyDKoC/19Pyi2uLtvoQpYby+LT7ITF03ut9MtxbQIwPCiN0mAhmpW3ld6NT9lyUdmjh+
         gT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Qrz7foT4+zP/9eENWD8MNY8N2LpxKt83XObpwKGVWl4=;
        b=mUet3gjDDBDIHy4BrL8I6637RLWXvyLm23/CLJXjrBtI5HLj41r+Fg/ddF1kOo3M1t
         12RwrjMJ3t6Z/cAxIm7ec9yy+GdMzPeFcItbT1yKG37jk0otvjps14aH+1jUtCMBUKvD
         fp9NjrVoRLoF8YtgCIMDliDTpJmY+YGkCWQ4AP05O3t6qu18RTMboHKZRVgforw1B+fW
         voO4kDRy+AU70N/SFiQZ0Xs06VnIVIIPYl/5tXUlGMH7tiC8RAiRCPxy97m4lstWbJ+W
         W82Xdgtx3AujC3GH1ewRDuq7uaDOWExQZHzDyAAMxSNb9NbUe0apvVJx7mMKLE7vya/l
         PhNw==
X-Gm-Message-State: APjAAAW07McOsaZy5B9ZVOmjzYdvfEMYLSpqp5CXamw5WPP3sMtEkcxL
        SSZCxkyMOX/0GJoSXXPHV7Lmbg==
X-Google-Smtp-Source: APXvYqyhf5amTvugVcinuxzy/+yn81dMUeFA5cLaIuUPa6acAOMc/FB0OFXlJ/U72qrbL5zkC6jfoQ==
X-Received: by 2002:a05:620a:7f4:: with SMTP id k20mr21587314qkk.483.1580218357301;
        Tue, 28 Jan 2020 05:32:37 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id f4sm12061877qka.89.2020.01.28.05.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 05:32:36 -0800 (PST)
Subject: Re: [Patch v8 1/7] sched/pelt: Add support to track thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-2-git-send-email-thara.gopinath@linaro.org>
 <20200116151724.GR2827@hirez.programming.kicks-ass.net>
 <e5ecad29-11d8-e7ff-27ff-b63ca44fdcd3@arm.com> <5E2B405A.7040405@linaro.org>
 <6232d91d-2603-06ca-0e7c-66ec2a137759@arm.com>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E3037F3.30507@linaro.org>
Date:   Tue, 28 Jan 2020 08:32:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <6232d91d-2603-06ca-0e7c-66ec2a137759@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/27/2020 04:28 AM, Dietmar Eggemann wrote:
> On 24/01/2020 20:07, Thara Gopinath wrote:
>> On 01/23/2020 02:15 PM, Dietmar Eggemann wrote:
>>> On 16/01/2020 16:17, Peter Zijlstra wrote:
>>>> On Tue, Jan 14, 2020 at 02:57:33PM -0500, Thara Gopinath wrote:
> 
> [...]
> 
>>>>> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
>>>
>>> I assume your plan is to enable this for Arm and Arm64? Otherwise the
>>> code in 3/7 should also be guarded by this.
>>
>> Yes. I think it should be enabled for arm and arm64. I can submit a
>> patch after this series is accepted to enable it.
>> Nevertheless , I don't understand why is patch 3/7 tied with this.
>> This portion is the averaging of thermal pressure. Patch 3/7 is to store
>> and retrieve the instantaneous value.
> 
> 3/7 is the code which overwrites the scheduler default
> arch_cpu_thermal_pressure() [include/linux/sched/topology.h]. I see it
> more of the engine to drive  thermal pressure tracking in the scheduler.
> 
> So all the code in 3/7 only makes sense if HAVE_SCHED_THERMAL_PRESSURE
> is selected by the arch. IMHO, 3/7 and enabling it for Arm/Arm64 should
> go in together.
Hi Dietmar,
I will have to respectfully disagree here. We explicitly separated out
this stuff (updating and reading of instantaneous thermal pressure)from
scheduler. To me putting all this under HAVE_SCHED_THERMAL_PRESSURE is
equivalent to keeping this stuff in scheduler specific code. But I will
provide a patch enabling the option HAVE_SCHED_THERMAL_PRESSURE in
arm64/defconfig. arm is trickier though as it has a bunch of SoC
defconfigs. I will leave it out for now .



-- 
Warm Regards
Thara
