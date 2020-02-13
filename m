Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855EDC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9A22073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHZXwNG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgBMOFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:05:41 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44091 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbgBMOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:05:41 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so5700693qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 06:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=e3wRTgvk02uCy2v25XexwNKM7D58K0egP1Sx1tRmF34=;
        b=lHZXwNG4ZfccO66nOK2XyEU2r8yLtlzDT3WQeb6T4vVbUGzQB78yqnGZrJTPJkTgqa
         CBVH6Am+oiTxzyrH4axzBKFTmUI+Olr74AkY5TRpgvBfh5ICeAxFnZ2LbYVpb2yntpmk
         e3SYLqPBOxboFV8s8L7FJL5x4kSB2jwNLlPO6Zh+eUglB9CQuNuoLifW76EMyZwuGicB
         sE7k2qz5uEoC5IGU8LB7Gb+2JK6azyHUtLAIutBKnYtkdyry4BOdAAovLwKVmTwXsx+c
         posOmmgTgQPnzvwqaqqgVJP3Lub/lr4JpvDpq0QKpOaZe2JLhSZZQbpxOw3G1hSDHlQg
         PoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=e3wRTgvk02uCy2v25XexwNKM7D58K0egP1Sx1tRmF34=;
        b=eBEXjLnUc6tO4BIFSl7XrPJvLRsrAGNKJtFlPUk+bTVfNBaldOxwPJ4KOoYTLSELy6
         iQUty4/yyXTL7SnrKzWh1hlncYTqMy1f0xTHrlfyj6fDMcoqdsBmYliWFVChDvxTkihI
         snKRTg1Ch13+eiOam0x4cZa+SU2tfN/g2wk6NjhmPM0UBRU1XGwWQOKWnZlhAH7nOd63
         mD4rnBCy2RQC3w2nFLq1uVUbR1PXmdT2NDpQHx3ejlThxqo1IGR0QYmj+HnO83ghzzUJ
         Rw32yvBQMbmgRq7iq8D5Qk+IllQTyFACqIdBRLi1QsERwcfaDwW3btAxd4zELc7QAHPa
         3cbw==
X-Gm-Message-State: APjAAAUYtmykRw+QLWEk/axJn5XFvvy2GEHp3ktnvPVGtGe/OCaEhj1U
        0uBqMDFC4SAJxgLEt2ggCiNVjQ==
X-Google-Smtp-Source: APXvYqwaKJNgSxdTbbZj3ciU6yde0A/cvzQejV8/1YxjeRD8V2wbbNS+pXi3tqwD84Rd0AA4l0BV4A==
X-Received: by 2002:a05:620a:7f4:: with SMTP id k20mr5624979qkk.3.1581602739636;
        Thu, 13 Feb 2020 06:05:39 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id u22sm1327743qkj.97.2020.02.13.06.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 06:05:38 -0800 (PST)
Subject: Re: [Patch v9 3/8] arm,arm64,drivers:Add infrastructure to store and
 update instantaneous thermal pressure
To:     Amit Kucheria <amit.kucheria@verdurent.com>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-4-git-send-email-thara.gopinath@linaro.org>
 <CAHLCerMEieWMyk8RcM-y8c3Usq_e5CTYJ4AqhCQOzihRTUWbTg@mail.gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, qperret@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, corbet@lwn.net,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E4557B1.8020809@linaro.org>
Date:   Thu, 13 Feb 2020 09:05:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerMEieWMyk8RcM-y8c3Usq_e5CTYJ4AqhCQOzihRTUWbTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2020 07:25 AM, Amit Kucheria wrote:
> On Wed, Jan 29, 2020 at 4:06 AM Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
>>
>> Add architecture specific APIs to update and track thermal pressure on a
>> per cpu basis. A per cpu variable thermal_pressure is introduced to keep
>> track of instantaneous per cpu thermal pressure. Thermal pressure is the
>> delta between maximum capacity and capped capacity due to a thermal event.
> 
> s/capped/decreased to have consistent use throughout the series e.g. in patch 1.
> 
> Though personally, I like "capped capacity"  in which case
> s/decreased/capped in patch 1 and elsewhere.

I will fix this
> 
>>
>> topology_get_thermal_pressure can be hooked into the scheduler specified
>> arch_cpu_thermal_capacity to retrieve instantaneous thermal pressure of a
>> cpu.
>>
>> arch_set_thermal_pressure can be used to update the thermal pressure.
>>
>> Considering topology_get_thermal_pressure reads thermal_pressure and
>> arch_set_thermal_pressure writes into thermal_pressure, one can argue for
>> some sort of locking mechanism to avoid a stale value.  But considering
>> topology_get_thermal_pressure can be called from a system critical path
>> like scheduler tick function, a locking mechanism is not ideal. This means
>> that it is possible the thermal_pressure value used to calculate average
>> thermal pressure for a cpu can be stale for upto 1 tick period.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v6->v7:
>>         - Changed the input argument in arch_set_thermal_pressure from
>>           capped capacity to delta capacity(thermal pressure) as per
>>           Ionela's review comments.
>>
>>  arch/arm/include/asm/topology.h   |  3 +++
>>  arch/arm64/include/asm/topology.h |  3 +++
> 
> Any particular reason to enable this for arm/arm64 in this patch
> itself? I'd have enabled them in two separate patches after this one.

No reason. No reason not to as well as arch_topology is "Arm specific
cpu topology file" and changes are one-liners.

> 
>>  drivers/base/arch_topology.c      | 11 +++++++++++
>>  include/linux/arch_topology.h     | 10 ++++++++++
>>  4 files changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
>> index 8a0fae9..3a50a19 100644
>> --- a/arch/arm/include/asm/topology.h
>> +++ b/arch/arm/include/asm/topology.h
>> @@ -16,6 +16,9 @@
>>  /* Enable topology flag updates */
>>  #define arch_update_cpu_topology topology_update_cpu_topology
>>
>> +/* Replace task scheduler's default thermal pressure retrieve API */
>> +#define arch_cpu_thermal_pressure topology_get_thermal_pressure
>> +
>>  #else
>>
>>  static inline void init_cpu_topology(void) { }
>> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
>> index a4d945d..a70896f 100644
>> --- a/arch/arm64/include/asm/topology.h
>> +++ b/arch/arm64/include/asm/topology.h
>> @@ -25,6 +25,9 @@ int pcibus_to_node(struct pci_bus *bus);
>>  /* Enable topology flag updates */
>>  #define arch_update_cpu_topology topology_update_cpu_topology
>>
>> +/* Replace task scheduler's default thermal pressure retrieve API */
>> +#define arch_cpu_thermal_pressure topology_get_thermal_pressure
>> +
>>  #include <asm-generic/topology.h>
>>
>>  #endif /* _ASM_ARM_TOPOLOGY_H */
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 6119e11..68dfa49 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -42,6 +42,17 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>>         per_cpu(cpu_scale, cpu) = capacity;
>>  }
>>
>> +DEFINE_PER_CPU(unsigned long, thermal_pressure);
>> +
>> +void arch_set_thermal_pressure(struct cpumask *cpus,
>> +                              unsigned long th_pressure)
>> +{
>> +       int cpu;
> 
> <snip>
> 


-- 
Warm Regards
Thara
