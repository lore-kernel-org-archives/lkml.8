Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F97C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03D120639
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599483822;
	bh=+pILBlL+qvW8t9m+2yqxQjz7hk2Cac+f3h0EtCSwsw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EKPoF9Utht9oufPLDzMsdBBU4lAG2bGF+0/1CMHulVWdNUgwXfopoJazll0Xb6n//
	 vw5DaQSiE0lQ0HQ2Ez9YEGt5E1nOAEnJYAXOtXAMZeDvoo0cJ+aXyMLo0FYo2n1JKF
	 vS5esStkenFrlFQjgHxhyVoKHaSwan/oxQTbQQOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgIGNDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgIGMvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:51:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D7F021481;
        Mon,  7 Sep 2020 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599483094;
        bh=+pILBlL+qvW8t9m+2yqxQjz7hk2Cac+f3h0EtCSwsw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yXd8D9yvwLAV3JiVgZt48RvM3+jny8Jln4gWNJGhHt1AqKTU2GuOS+eLnuq8CHyim
         wdHv3aTn6VF6o9IZl4AehQxCN2QsDAhFOseYUtTQerZgT8VVC0ncggbZ4XO5iuRZkn
         ffzjUGL+sMs/1+a5GHH0DrQI+1Bs2E/BLV7TzH2A=
Date:   Mon, 7 Sep 2020 13:51:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, guohanjun@huawei.com
Subject: Re: [PATCH 1/4] drivers/perf: Add support for ARMv8.3-SPE
Message-ID: <20200907125128.GB12237@willie-the-truck>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-2-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724091607.41903-2-liwei391@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 05:16:04PM +0800, Wei Li wrote:
> Armv8.3 extends the SPE by adding:
> - Alignment field in the Events packet, and filtering on this event
>   using PMSEVFR_EL1.
> - Support for the Scalable Vector Extension (SVE).
> 
> The main additions for SVE are:
> - Recording the vector length for SVE operations in the Operation Type
>   packet. It is not possible to filter on vector length.
> - Incomplete predicate and empty predicate fields in the Events packet,
>   and filtering on these events using PMSEVFR_EL1.
> 
> Update the check of pmsevfr for empty/partial predicated SVE and
> alignment event in kernel driver.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  arch/arm64/include/asm/sysreg.h |  4 +++-
>  drivers/perf/arm_spe_pmu.c      | 18 ++++++++++++++----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 463175f80341..be4c44ccdb56 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -281,7 +281,6 @@
>  #define SYS_PMSFCR_EL1_ST_SHIFT		18
>  
>  #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
> -#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL

I think we can just update this mask unconditionally to allow the new bits.

>  #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
>  #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
> @@ -769,6 +768,9 @@
>  #define ID_AA64DFR0_PMUVER_8_5		0x6
>  #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
>  
> +#define ID_AA64DFR0_PMSVER_8_2		0x1
> +#define ID_AA64DFR0_PMSVER_8_3		0x2
> +
>  #define ID_DFR0_PERFMON_SHIFT		24
>  
>  #define ID_DFR0_PERFMON_8_1		0x4
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index e51ddb6d63ed..5ec7ee0c8fa1 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -54,7 +54,7 @@ struct arm_spe_pmu {
>  	struct hlist_node			hotplug_node;
>  
>  	int					irq; /* PPI */
> -
> +	int					pmuver;

nit: please call this "pmsver" to align with the architecture (where
"pmuver" means something else).

>  	u16					min_period;
>  	u16					counter_sz;
>  
> @@ -80,6 +80,15 @@ struct arm_spe_pmu {
>  /* Keep track of our dynamic hotplug state */
>  static enum cpuhp_state arm_spe_pmu_online;
>  
> +static u64 sys_pmsevfr_el1_mask[] = {
> +	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> +		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
> +		BIT_ULL(1),
> +	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> +		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
> +		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
> +};

As I said above, you can drop this and just update the #define.

> +
>  enum arm_spe_pmu_buf_fault_action {
>  	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
>  	SPE_PMU_BUF_FAULT_ACT_FATAL,
> @@ -670,7 +679,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
>  		return -ENOENT;
>  
> -	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
> +	if (arm_spe_event_to_pmsevfr(event) & ~sys_pmsevfr_el1_mask[spe_pmu->pmuver])
>  		return -EOPNOTSUPP;

Same here.

>  
>  	if (attr->exclude_idle)
> @@ -937,6 +946,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
>  			fld, smp_processor_id());
>  		return;
>  	}
> +	spe_pmu->pmuver = fld;
>  
>  	/* Read PMBIDR first to determine whether or not we have access */
>  	reg = read_sysreg_s(SYS_PMBIDR_EL1);
> @@ -1027,8 +1037,8 @@ static void __arm_spe_pmu_dev_probe(void *info)
>  	}
>  
>  	dev_info(dev,
> -		 "probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
> -		 cpumask_pr_args(&spe_pmu->supported_cpus),
> +		 "v%d probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
> +		 spe_pmu->pmuver, cpumask_pr_args(&spe_pmu->supported_cpus),

There's no need for this. If userspace finds this information useful, then
we should expose it in sysfs, like we do for other PMU paramaters. If
userspace doesn't find it useful, then there's no need to expose it at all.

So I would suggest adding something like SPE_PMU_CAP_PMSVER and exposing the
field on a per-SPE-PMU basis in sysfs.

big.LITTLE should work as before, where we expose a completely separate PMU
instance for each CPU type.

Will
> 
