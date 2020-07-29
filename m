Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D004BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3081206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgG2JIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:08:11 -0400
Received: from foss.arm.com ([217.140.110.172]:48256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgG2JIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:08:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 111D631B;
        Wed, 29 Jul 2020 02:08:10 -0700 (PDT)
Received: from [10.37.8.154] (unknown [10.37.8.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5768B3F718;
        Wed, 29 Jul 2020 02:08:06 -0700 (PDT)
Subject: Re: [PATCH 1/4] drivers/perf: Add support for ARMv8.3-SPE
To:     liwei391@huawei.com, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        catalin.marinas@arm.com, James.Clark@arm.com, jolsa@redhat.com,
        leo.yan@linaro.org, mark.rutland@arm.com, namhyung@kernel.org,
        will@kernel.org, zhangshaokun@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, guohanjun@huawei.com
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-2-liwei391@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a9c59cb6-80f7-1abe-cef4-33127f051488@arm.com>
Date:   Wed, 29 Jul 2020 10:12:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200724091607.41903-2-liwei391@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2020 10:16 AM, Wei Li wrote:
> Armv8.3 extends the SPE by adding:
> - Alignment field in the Events packet, and filtering on this event
>    using PMSEVFR_EL1.
> - Support for the Scalable Vector Extension (SVE).
> 
> The main additions for SVE are:
> - Recording the vector length for SVE operations in the Operation Type
>    packet. It is not possible to filter on vector length.
> - Incomplete predicate and empty predicate fields in the Events packet,
>    and filtering on these events using PMSEVFR_EL1.
> 
> Update the check of pmsevfr for empty/partial predicated SVE and
> alignment event in kernel driver.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>   arch/arm64/include/asm/sysreg.h |  4 +++-
>   drivers/perf/arm_spe_pmu.c      | 18 ++++++++++++++----
>   2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 463175f80341..be4c44ccdb56 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -281,7 +281,6 @@
>   #define SYS_PMSFCR_EL1_ST_SHIFT		18
>   
>   #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
> -#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
>   
>   #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
>   #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
> @@ -769,6 +768,9 @@
>   #define ID_AA64DFR0_PMUVER_8_5		0x6
>   #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
>   
> +#define ID_AA64DFR0_PMSVER_8_2		0x1
> +#define ID_AA64DFR0_PMSVER_8_3		0x2
> +
>   #define ID_DFR0_PERFMON_SHIFT		24
>   
>   #define ID_DFR0_PERFMON_8_1		0x4
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index e51ddb6d63ed..5ec7ee0c8fa1 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -54,7 +54,7 @@ struct arm_spe_pmu {
>   	struct hlist_node			hotplug_node;
>   
>   	int					irq; /* PPI */
> -
> +	int					pmuver;
>   	u16					min_period;
>   	u16					counter_sz;
>   
> @@ -80,6 +80,15 @@ struct arm_spe_pmu {
>   /* Keep track of our dynamic hotplug state */
>   static enum cpuhp_state arm_spe_pmu_online;
>   
> +static u64 sys_pmsevfr_el1_mask[] = {
> +	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> +		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
> +		BIT_ULL(1),
> +	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> +		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
> +		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
> +};
> +
>   enum arm_spe_pmu_buf_fault_action {
>   	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
>   	SPE_PMU_BUF_FAULT_ACT_FATAL,
> @@ -670,7 +679,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>   	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
>   		return -ENOENT;
>   
> -	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
> +	if (arm_spe_event_to_pmsevfr(event) & ~sys_pmsevfr_el1_mask[spe_pmu->pmuver])
>   		return -EOPNOTSUPP;
>   
>   	if (attr->exclude_idle)
> @@ -937,6 +946,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
>   			fld, smp_processor_id());
>   		return;
>   	}
> +	spe_pmu->pmuver = fld;

How do we deal with cases where we have big.LITTLE system with differing
SPE versions ?

Cheers
Suzuki
