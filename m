Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65FFC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 12:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85019206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 12:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgAXMHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 07:07:40 -0500
Received: from foss.arm.com ([217.140.110.172]:51040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbgAXMHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 07:07:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C46B71FB;
        Fri, 24 Jan 2020 04:00:28 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00763F68E;
        Fri, 24 Jan 2020 04:00:26 -0800 (PST)
Subject: Re: [PATCH v2 1/6] arm64: add support for the AMU extension v1
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        ggherdovich@suse.cz, vincent.guittot@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-2-ionela.voinescu@arm.com>
 <05b1981b-cf4d-d990-5155-6ed3fadcca92@arm.com>
 <20200123183207.GB20475@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <00d852b0-d456-efc3-5bfa-31524168344b@arm.com>
Date:   Fri, 24 Jan 2020 12:00:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123183207.GB20475@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2020 18:32, Ionela Voinescu wrote:
[...]
> and later we can use information in
> AMCGCR_EL0 to get the number of architected counters (n) and
> AMEVTYPER0<n>_EL0 to find out the type. The same logic would apply to
> the auxiliary counters.
> 

Good, I think that's all we'll really need. I've not gone through the whole
series (yet!) so I might've missed AMCGCR being used.

>>> @@ -1150,6 +1152,59 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
>>>  
>>>  #endif
>>>  
>>> +#ifdef CONFIG_ARM64_AMU_EXTN
>>> +
>>> +/*
>>> + * This per cpu variable only signals that the CPU implementation supports
>>> + * the Activity Monitors Unit (AMU) but does not provide information
>>> + * regarding all the events that it supports.
>>> + * When this amu_feat per CPU variable is true, the user of this feature
>>> + * can only rely on the presence of the 4 fixed counters. But this does
>>> + * not guarantee that the counters are enabled or access to these counters
>>> + * is provided by code executed at higher exception levels.
>>> + *
>>> + * Also, to ensure the safe use of this per_cpu variable, the following
>>> + * accessor is defined to allow a read of amu_feat for the current cpu only
>>> + * from the current cpu.
>>> + *  - cpu_has_amu_feat()
>>> + */
>>> +static DEFINE_PER_CPU_READ_MOSTLY(u8, amu_feat);
>>> +
>>
>> Why not bool?
>>
> 
> I've changed it from bool after a sparse warning about expression using
> sizeof(bool) and found this is due to sizeof(bool) being compiler
> dependent. It does not change anything but I thought it might be a good
> idea to define it as 8-bit unsigned and rely on fixed size.
> 

I believe conveying the intent (a truth value) is more important than the
underlying storage size in this case. It mostly matters when dealing with
aggregates, but here it's just a free-standing variable.

We already have a few per-CPU boolean variables in arm64/kernel/fpsimd.c
and the commits aren't even a year old, so I'd go for ignoring sparse this
time around.

> Thank you for the review,
> Ionela.
> 
>>> +inline bool cpu_has_amu_feat(void)
>>> +{
>>> +	return !!this_cpu_read(amu_feat);
>>> +}
>>> +
>>> +static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
>>> +{
>>> +	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
>>> +		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
>>> +			smp_processor_id());
>>> +		this_cpu_write(amu_feat, 1);
>>> +	}
>>> +}
