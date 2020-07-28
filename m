Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11B4C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EDA206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgG1NZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:25:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8845 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729991AbgG1NZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:25:10 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 54E0D1848A8AC4BCBBAC;
        Tue, 28 Jul 2020 21:24:51 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 21:24:43 +0800
Subject: Re: [PATCH 1/4] drivers/perf: Add support for ARMv8.3-SPE
To:     Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, <guohanjun@huawei.com>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-2-liwei391@huawei.com>
 <20200728122742.GB4343@leoy-ThinkPad-X240s>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <c2ce17a9-bd3a-e828-fe76-769c9feabece@huawei.com>
Date:   Tue, 28 Jul 2020 21:24:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200728122742.GB4343@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 2020/7/28 20:27, Leo Yan wrote:
> Hi Wei,
> 
> On Fri, Jul 24, 2020 at 05:16:04PM +0800, Wei Li wrote:
>> Armv8.3 extends the SPE by adding:
>> - Alignment field in the Events packet, and filtering on this event
>>   using PMSEVFR_EL1.
>> - Support for the Scalable Vector Extension (SVE).
>>
>> The main additions for SVE are:
>> - Recording the vector length for SVE operations in the Operation Type
>>   packet. It is not possible to filter on vector length.
>> - Incomplete predicate and empty predicate fields in the Events packet,
>>   and filtering on these events using PMSEVFR_EL1.
>>
>> Update the check of pmsevfr for empty/partial predicated SVE and
>> alignment event in kernel driver.
>>
>> Signed-off-by: Wei Li <liwei391@huawei.com>
>> ---
>>  arch/arm64/include/asm/sysreg.h |  4 +++-
>>  drivers/perf/arm_spe_pmu.c      | 18 ++++++++++++++----
>>  2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 463175f80341..be4c44ccdb56 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -281,7 +281,6 @@
>>  #define SYS_PMSFCR_EL1_ST_SHIFT		18
>>  
>>  #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
>> -#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
>>  
>>  #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
>>  #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
>> @@ -769,6 +768,9 @@
>>  #define ID_AA64DFR0_PMUVER_8_5		0x6
>>  #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
>>  
>> +#define ID_AA64DFR0_PMSVER_8_2		0x1
>> +#define ID_AA64DFR0_PMSVER_8_3		0x2
>> +
>>  #define ID_DFR0_PERFMON_SHIFT		24
>>  
>>  #define ID_DFR0_PERFMON_8_1		0x4
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index e51ddb6d63ed..5ec7ee0c8fa1 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -54,7 +54,7 @@ struct arm_spe_pmu {
>>  	struct hlist_node			hotplug_node;
>>  
>>  	int					irq; /* PPI */
>> -
>> +	int					pmuver;
> 
> Since the version number is only 4 bits width, 'u16' would be enough
> to record SPE version number.

Sounds reasonable, i can change it to 'u16' if you insist.

>>  	u16					min_period;
>>  	u16					counter_sz;
>>  
>> @@ -80,6 +80,15 @@ struct arm_spe_pmu {
>>  /* Keep track of our dynamic hotplug state */
>>  static enum cpuhp_state arm_spe_pmu_online;
>>  
>> +static u64 sys_pmsevfr_el1_mask[] = {
>> +	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
>> +		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
>> +		BIT_ULL(1),
>> +	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
>> +		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
>> +		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
>> +};
> 
> Seems to me, the definitions for Aarch64 system registers should be
> placed into the file 'arch/arm64/include/asm/sysreg.h'.  Like below
> two macros:
> 
>   #define SYS_PMSEVFR_EL1_RES0_8_2		0x0000ffff00ff0f55UL
>   #define SYS_PMSEVFR_EL1_RES0_8_3		...

I really think using GENMASK_ULL() to generate the mask is better than a definition
with magic number. It is beneficial to be reviewed and extended later.

> Let's wait for Will or Mark Rutland's comments for this, in case I
> mislead for this.
>> +
>>  enum arm_spe_pmu_buf_fault_action {
>>  	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
>>  	SPE_PMU_BUF_FAULT_ACT_FATAL,
>> @@ -670,7 +679,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>>  	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
>>  		return -ENOENT;
>>  
>> -	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
>> +	if (arm_spe_event_to_pmsevfr(event) & ~sys_pmsevfr_el1_mask[spe_pmu->pmuver])
>>  		return -EOPNOTSUPP;
>>  
>>  	if (attr->exclude_idle)
>> @@ -937,6 +946,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
>>  			fld, smp_processor_id());
>>  		return;
>>  	}
>> +	spe_pmu->pmuver = fld;
>>  
>>  	/* Read PMBIDR first to determine whether or not we have access */
>>  	reg = read_sysreg_s(SYS_PMBIDR_EL1);
>> @@ -1027,8 +1037,8 @@ static void __arm_spe_pmu_dev_probe(void *info)
>>  	}
>>  
>>  	dev_info(dev,
>> -		 "probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
>> -		 cpumask_pr_args(&spe_pmu->supported_cpus),
>> +		 "v%d probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
> 
> Let's output explict info, like:
> 
>   "probed for CPUs %*pbl [pmuver %d, max_record_sz %u, align %u, features 0x%llx]\n",
> 

Agree, and i have a little question here:
Currently, the of_compatible of SPE PMU is "arm,statistical-profiling-extension-v1", and
the platform_device name is "arm,spe-v1". So this message looks weird when supporting
ARMv8.3-SPE because the pmuver is 2.

As the version of SPE can be probed by reading 'ID_AA64DFR0_EL1.PMSVer', can we remove
the version hint in of_compatible and platform_device name?

> 
>> +		 spe_pmu->pmuver, cpumask_pr_args(&spe_pmu->supported_cpus),
>>  		 spe_pmu->max_record_sz, spe_pmu->align, spe_pmu->features);
>>  
>>  	spe_pmu->features |= SPE_PMU_FEAT_DEV_PROBED;
>> -- 
>> 2.17.1
>>

Thanks,
Wei
