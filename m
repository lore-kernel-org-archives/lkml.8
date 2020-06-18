Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1280AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A86206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgFRKuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:50:25 -0400
Received: from foss.arm.com ([217.140.110.172]:47904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729369AbgFRKuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:50:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 143BE31B;
        Thu, 18 Jun 2020 03:50:23 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23EE53F71F;
        Thu, 18 Jun 2020 03:50:21 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] arm64: perf: Avoid PMXEV* indirection
To:     Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, maz@kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com>
 <20200617113851.607706-3-alexandru.elisei@arm.com>
 <159242468708.62212.1739215996563155762@swboyd.mtv.corp.google.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <bca9a873-3e69-f68d-2266-5f82704580d1@arm.com>
Date:   Thu, 18 Jun 2020 11:51:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159242468708.62212.1739215996563155762@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 6/17/20 9:11 PM, Stephen Boyd wrote:
> Quoting Alexandru Elisei (2020-06-17 04:38:46)
>> From: Mark Rutland <mark.rutland@arm.com>
>>
>> Currently we access the counter registers and their respective type
>> registers indirectly. This requires us to write to PMSELR, issue an ISB,
>> then access the relevant PMXEV* registers.
>>
>> This is unfortunate, because:
>>
>> * Under virtualization, accessing one registers requires two traps to
> one register? Not plural presumably.

That's another typo, will fix it.

>
>>   the hypervisor, even though we could access the register directly with
>>   a single trap.
>>
>> * We have to issue an ISB which we could otherwise avoid the cost of.
>>
>> * When we use NMIs, the NMI handler will have to save/restore the select
>>   register in case the code it preempted was attempting to access a
>>   counter or its type register.
>>
>> We can avoid these issues by directly accessing the relevant registers.
>> This patch adds helpers to do so.
>>
>> In armv8pmu_enable_event() we still need the ISB to prevent the PE from
>> reordering the write to PMINTENSET_EL1 register. If the interrupt is
>> enabled before we disable the counter and the new event is configured,
>> we might get an interrupt triggered by the previously programmed event
>> overflowing, but which we wrongly attribute to the event that we are
>> enabling.
>>
>> In the process, remove the comment that refers to the ARMv7 PMU.
>>
>> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> [Julien T.: Don't inline read/write functions to avoid big code-size
>>         increase, remove unused read_pmevtypern function,
>>         fix counter index issue.]
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> [Removed comment, removed trailing semicolons in macros, added ISB]
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> ---
>>  arch/arm64/kernel/perf_event.c | 95 +++++++++++++++++++++++++++++-----
>>  1 file changed, 81 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index ee180b2a5b39..e95b5ca70a53 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -323,6 +323,73 @@ static inline bool armv8pmu_event_is_chained(struct perf_event *event)
>>  #define        ARMV8_IDX_TO_COUNTER(x) \
>>         (((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
>>  
>> +/*
>> + * This code is really good
>> + */
> Superb!

Exactly! I thought so too, that's why I kept the comment.

>
>> +
>> +#define PMEVN_CASE(n, case_macro) \
>> +       case n: case_macro(n); break
>> +
>> +#define PMEVN_SWITCH(x, case_macro)                            \
>> +       do {                                                    \
>> +               switch (x) {                                    \
>> +               PMEVN_CASE(0,  case_macro);                     \
>> +               PMEVN_CASE(1,  case_macro);                     \
>> +               PMEVN_CASE(2,  case_macro);                     \
>> +               PMEVN_CASE(3,  case_macro);                     \
>> +               PMEVN_CASE(4,  case_macro);                     \
>> +               PMEVN_CASE(5,  case_macro);                     \
>> +               PMEVN_CASE(6,  case_macro);                     \
>> +               PMEVN_CASE(7,  case_macro);                     \
>> +               PMEVN_CASE(8,  case_macro);                     \
>> +               PMEVN_CASE(9,  case_macro);                     \
>> +               PMEVN_CASE(10, case_macro);                     \
>> +               PMEVN_CASE(11, case_macro);                     \
>> +               PMEVN_CASE(12, case_macro);                     \
>> +               PMEVN_CASE(13, case_macro);                     \
>> +               PMEVN_CASE(14, case_macro);                     \
>> +               PMEVN_CASE(15, case_macro);                     \
>> +               PMEVN_CASE(16, case_macro);                     \
>> +               PMEVN_CASE(17, case_macro);                     \
>> +               PMEVN_CASE(18, case_macro);                     \
>> +               PMEVN_CASE(19, case_macro);                     \
>> +               PMEVN_CASE(20, case_macro);                     \
>> +               PMEVN_CASE(21, case_macro);                     \
>> +               PMEVN_CASE(22, case_macro);                     \
>> +               PMEVN_CASE(23, case_macro);                     \
>> +               PMEVN_CASE(24, case_macro);                     \
>> +               PMEVN_CASE(25, case_macro);                     \
>> +               PMEVN_CASE(26, case_macro);                     \
>> +               PMEVN_CASE(27, case_macro);                     \
>> +               PMEVN_CASE(28, case_macro);                     \
>> +               PMEVN_CASE(29, case_macro);                     \
>> +               PMEVN_CASE(30, case_macro);                     \
>> +               default: WARN(1, "Invalid PMEV* index");        \
> Missing newline on that WARN message?

Indeed, will add it.

>
>> +               }                                               \
>> +       } while (0)
>> +
>> +#define RETURN_READ_PMEVCNTRN(n) \
>> +       return read_sysreg(pmevcntr##n##_el0)
>> +static unsigned long read_pmevcntrn(int n)
>> +{
>> +       PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
>> +       return 0;
>> +}
>> +
>> +#define WRITE_PMEVCNTRN(n) \
>> +       write_sysreg(val, pmevcntr##n##_el0)
>> +static void write_pmevcntrn(int n, unsigned long val)
>> +{
>> +       PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
>> +}
>> +
>> +#define WRITE_PMEVTYPERN(n) \
>> +       write_sysreg(val, pmevtyper##n##_el0)
>> +static void write_pmevtypern(int n, unsigned long val)
>> +{
>> +       PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
>> +}
>> +
>>  static inline u32 armv8pmu_pmcr_read(void)
>>  {
>>         return read_sysreg(pmcr_el0);
>> @@ -351,17 +418,11 @@ static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
>>         return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
>>  }
>>  
>> -static inline void armv8pmu_select_counter(int idx)
>> +static inline u32 armv8pmu_read_evcntr(int idx)
>>  {
>>         u32 counter = ARMV8_IDX_TO_COUNTER(idx);
>> -       write_sysreg(counter, pmselr_el0);
>> -       isb();
>> -}
>>  
>> -static inline u64 armv8pmu_read_evcntr(int idx)
>> -{
>> -       armv8pmu_select_counter(idx);
>> -       return read_sysreg(pmxevcntr_el0);
>> +       return read_pmevcntrn(counter);
>>  }
>>  
>>  static inline u64 armv8pmu_read_hw_counter(struct perf_event *event)
>> @@ -433,8 +494,9 @@ static u64 armv8pmu_read_counter(struct perf_event *event)
>>  
>>  static inline void armv8pmu_write_evcntr(int idx, u64 value)
>>  {
>> -       armv8pmu_select_counter(idx);
>> -       write_sysreg(value, pmxevcntr_el0);
>> +       u32 counter = ARMV8_IDX_TO_COUNTER(idx);
> Might be a good idea to make ARMV8_IDX_TO_COUNTER a static inline
> function that has a return type of u32. I had to go check the code to
> make sure it wasn't something larger.

Architecturally, there are at most 32 counter registers, which would fit in an s8,
so I don't think type checking would really help us here.

>
>> +
>> +       write_pmevcntrn(counter, value);
>>  }
>>  
>>  static inline void armv8pmu_write_hw_counter(struct perf_event *event,
>> @@ -469,9 +531,10 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
>>  
>>  static inline void armv8pmu_write_evtype(int idx, u32 val)
>>  {
>> -       armv8pmu_select_counter(idx);
>> +       u32 counter = ARMV8_IDX_TO_COUNTER(idx);
>> +
>>         val &= ARMV8_PMU_EVTYPE_MASK;
>> -       write_sysreg(val, pmxevtyper_el0);
>> +       write_pmevtypern(counter, val);
>>  }
>>  
>>  static inline void armv8pmu_write_event_type(struct perf_event *event)
>> @@ -491,7 +554,10 @@ static inline void armv8pmu_write_event_type(struct perf_event *event)
>>                 armv8pmu_write_evtype(idx - 1, hwc->config_base);
>>                 armv8pmu_write_evtype(idx, chain_evt);
>>         } else {
>> -               armv8pmu_write_evtype(idx, hwc->config_base);
>> +               if (idx == ARMV8_IDX_CYCLE_COUNTER)
>> +                       write_sysreg(hwc->config_base, pmccfiltr_el0);
>> +               else
>> +                       armv8pmu_write_evtype(idx, hwc->config_base);
>>         }
>>  }
>>  
>> @@ -595,9 +661,10 @@ static void armv8pmu_enable_event(struct perf_event *event)
>>          * Disable counter
>>          */
>>         armv8pmu_disable_event_counter(event);
>> +       isb();
> Same comment about uncommented isb().

Will add a comment explaining the ISB.

Thanks,
Alex
