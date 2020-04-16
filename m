Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0568FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1BA2078A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407985AbgDPG0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:26:16 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:35595 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2407774AbgDPG0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:26:12 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 16 Apr
 2020 14:26:03 +0800
Received: from [10.28.64.103] (10.28.64.103) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 16 Apr
 2020 14:26:02 +0800
Subject: Re: [PATCH] x86/perf: Add hardware performance events support for
 Zhaoxin CPU.
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <cooperyan@zhaoxin.com>, <codyyao@zhaoxin.com>
References: <1586747669-4827-1-git-send-email-CodyYao-oc@zhaoxin.com>
 <20200415102340.GB20730@hirez.programming.kicks-ass.net>
From:   CodyYao-oc <CodyYao-oc@zhaoxin.com>
Message-ID: <d7ef73fb-aa89-4f9c-d54a-7bd0562e9ea3@zhaoxin.com>
Date:   Thu, 16 Apr 2020 14:26:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415102340.GB20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.64.103]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/15 下午6:23, Peter Zijlstra wrote:
> On Mon, Apr 13, 2020 at 11:14:29AM +0800, CodyYao-oc wrote:
>> Zhaoxin CPU has provided facilities for monitoring performance
>> via PMU(Performance Monitor Unit), but the functionality is unused so far.
>> Therefore, add support for zhaoxin pmu to make performance related
>> hardware events available.
>>
>> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> What's that reported-by thing? Did the robot complain you didn't have a
> PMU implementation?
>
Hi Peter, it's a warning message about uninitialized variable, paste the 
log below, sorry for miss it. Futhermore, it will disappear base on your 
newly modified patch. Thanks!

[All warnings (new ones prefixed by >>):

 >> arch/x86/events/zhaoxin/core.c:362:6: warning: variable 'is_zxc' is 
used uninitialized whenever 'if' condition is false 
[-Wsometimes-uninitialized]
            if (boot_cpu_data.x86 == 0x06 &&
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    arch/x86/events/zhaoxin/core.c:369:6: note: uninitialized use occurs 
here
            if (is_zxc)
                ^~~~~~
    arch/x86/events/zhaoxin/core.c:362:2: note: remove the 'if' if its 
condition is always true
            if (boot_cpu_data.x86 == 0x06 &&
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 >> arch/x86/events/zhaoxin/core.c:362:6: warning: variable 'is_zxc' is 
used uninitialized whenever '&&' condition is false 
[-Wsometimes-uninitialized]
            if (boot_cpu_data.x86 == 0x06 &&
                ^~~~~~~~~~~~~~~~~~~~~~~~~
    arch/x86/events/zhaoxin/core.c:369:6: note: uninitialized use occurs 
here
            if (is_zxc)
                ^~~~~~
    arch/x86/events/zhaoxin/core.c:362:6: note: remove the '&&' if its 
condition is always true
            if (boot_cpu_data.x86 == 0x06 &&
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    arch/x86/events/zhaoxin/core.c:352:13: note: initialize the variable 
'is_zxc' to silence this warning
            bool is_zxc;
                       ^
                        = 0
    2 warnings generated.]

Reported-by: kbuild test rebot<lkp@intel.com>

> Anyway, I've made the below changes to the patch.
> 
> ---
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -618,6 +618,7 @@ struct x86_pmu {
>   
>   	/* PMI handler bits */
>   	unsigned int	late_ack		:1,
> +			enabled_ack		:1,
>   			counter_freezing	:1;
>   	/*
>   	 * sysfs attrs
> --- a/arch/x86/events/zhaoxin/core.c
> +++ b/arch/x86/events/zhaoxin/core.c
> @@ -357,10 +357,9 @@ static int zhaoxin_pmu_handle_irq(struct
>   {
>   	struct perf_sample_data data;
>   	struct cpu_hw_events *cpuc;
> -	int bit;
> -	u64 status;
> -	bool is_zxc = false;
>   	int handled = 0;
> +	u64 status;
> +	int bit;
>   
>   	cpuc = this_cpu_ptr(&cpu_hw_events);
>   	apic_write(APIC_LVTPC, APIC_DM_NMI);
> @@ -369,14 +368,8 @@ static int zhaoxin_pmu_handle_irq(struct
>   	if (!status)
>   		goto done;
>   
> -	if (boot_cpu_data.x86 == 0x06 &&
> -		(boot_cpu_data.x86_model == 0x0f ||
> -			boot_cpu_data.x86_model == 0x19))
> -		is_zxc = true;
>   again:
> -
> -	/*Clearing status works only if the global control is enable on zxc.*/
> -	if (is_zxc)
> +	if (x86_pmu.enabled_ack)
>   		zxc_pmu_ack_status(status);
>   	else
>   		zhaoxin_pmu_ack_status(status);
> @@ -504,12 +497,10 @@ static __init void zhaoxin_arch_events_q
>   	int bit;
>   
>   	/* disable event that reported as not presend by cpuid */
> -	for_each_set_bit(bit, x86_pmu.events_mask,
> -			ARRAY_SIZE(zx_arch_events_map)) {
> -
> +	for_each_set_bit(bit, x86_pmu.events_mask, ARRAY_SIZE(zx_arch_events_map)) {
>   		zx_pmon_event_map[zx_arch_events_map[bit].id] = 0;
>   		pr_warn("CPUID marked event: \'%s\' unavailable\n",
> -				zx_arch_events_map[bit].name);
> +			zx_arch_events_map[bit].name);
>   	}
>   }
>   
> @@ -534,12 +525,12 @@ __init int zhaoxin_pmu_init(void)
>   		return -ENODEV;
>   
>   	version = eax.split.version_id;
> -	if (version == 2) {
> -		x86_pmu = zhaoxin_pmu;
> -		pr_info("Version check pass!\n");
> -	} else
> +	if (version != 2)
>   		return -ENODEV;
>   
> +	x86_pmu = zhaoxin_pmu;
> +	pr_info("Version check pass!\n");
> +
>   	x86_pmu.version			= version;
>   	x86_pmu.num_counters		= eax.split.num_counters;
>   	x86_pmu.cntval_bits		= eax.split.bit_width;
> @@ -552,11 +543,13 @@ __init int zhaoxin_pmu_init(void)
>   
>   	switch (boot_cpu_data.x86) {
>   	case 0x06:
> -		if (boot_cpu_data.x86_model == 0x0f ||
> -			boot_cpu_data.x86_model == 0x19) {
> +		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
>   
>   			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
>   
> +			/* Clearing status works only if the global control is enable on zxc. */
> +			x86_pmu.enabled_ack = 1;
> +
>   			x86_pmu.event_constraints = zxc_event_constraints;
>   			zx_pmon_event_map[PERF_COUNT_HW_INSTRUCTIONS] = 0;
>   			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES] = 0;
> @@ -564,40 +557,37 @@ __init int zhaoxin_pmu_init(void)
>   			zx_pmon_event_map[PERF_COUNT_HW_BUS_CYCLES] = 0;
>   
>   			pr_cont("ZXC events, ");
> -		} else
> -			return -ENODEV;
> -		break;
> +			break;
> +		}
> +		return -ENODEV;
> +
>   	case 0x07:
>   		zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
> -		X86_CONFIG(.event = 0x01, .umask = 0x01, .inv = 0x01, .cmask = 0x01);
> +			X86_CONFIG(.event = 0x01, .umask = 0x01, .inv = 0x01, .cmask = 0x01);
>   
>   		zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =
> -		X86_CONFIG(.event = 0x0f, .umask = 0x04, .inv = 0, .cmask = 0);
> +			X86_CONFIG(.event = 0x0f, .umask = 0x04, .inv = 0, .cmask = 0);
>   
>   		switch (boot_cpu_data.x86_model) {
>   		case 0x1b:
>   			memcpy(hw_cache_event_ids, zxd_hw_cache_event_ids,
> -				sizeof(hw_cache_event_ids));
> +			       sizeof(hw_cache_event_ids));
>   
>   			x86_pmu.event_constraints = zxd_event_constraints;
>   
> -			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]
> -				= 0x0700;
> -			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES]
> -				= 0x0709;
> +			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0700;
> +			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0709;
>   
>   			pr_cont("ZXD events, ");
>   			break;
>   		case 0x3b:
>   			memcpy(hw_cache_event_ids, zxe_hw_cache_event_ids,
> -				sizeof(hw_cache_event_ids));
> +			       sizeof(hw_cache_event_ids));
>   
>   			x86_pmu.event_constraints = zxd_event_constraints;
>   
> -			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]
> -				= 0x0028;
> -			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES]
> -				= 0x0029;
> +			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x0028;
> +			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES] = 0x0029;
>   
>   			pr_cont("ZXE events, ");
>   			break;
> @@ -605,13 +595,13 @@ __init int zhaoxin_pmu_init(void)
>   			return -ENODEV;
>   		}
>   		break;
> +
>   	default:
>   		return -ENODEV;
>   	}
>   
>   	x86_pmu.intel_ctrl = (1 << (x86_pmu.num_counters)) - 1;
> -	x86_pmu.intel_ctrl |=
> -		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
> +	x86_pmu.intel_ctrl |= ((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
>   
>   	if (x86_pmu.event_constraints) {
>   		for_each_event_constraint(c, x86_pmu.event_constraints) {
> --- a/arch/x86/kernel/cpu/perfctr-watchdog.c
> +++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
> @@ -63,6 +63,7 @@ static inline unsigned int nmi_perfctr_m
>   		case 15:
>   			return msr - MSR_P4_BPU_PERFCTR0;
>   		}
> +		fallthrough;
>   	case X86_VENDOR_ZHAOXIN:
>   	case X86_VENDOR_CENTAUR:
>   		return msr - MSR_ARCH_PERFMON_PERFCTR0;
> @@ -95,6 +96,7 @@ static inline unsigned int nmi_evntsel_m
>   		case 15:
>   			return msr - MSR_P4_BSU_ESCR0;
>   		}
> +		fallthrough;
>   	case X86_VENDOR_ZHAOXIN:
>   	case X86_VENDOR_CENTAUR:
>   		return msr - MSR_ARCH_PERFMON_EVENTSEL0;
> .
> 

