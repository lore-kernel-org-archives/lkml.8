Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DFBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069F820722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbgF3QSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:18:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:1834 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgF3QSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:18:02 -0400
IronPort-SDR: p1fjrHjUEILZKJM3VAhUt/rBWjYAJMVgH8bWl6vbYZ9mZ+SE1Ca1vYvgtTviZ0IU44CmrV8zvk
 FhkhBa3V2PKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144464824"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="144464824"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 09:18:01 -0700
IronPort-SDR: rsdsEW4xNs2ptlqOCyhlF5PLoyaTZkdjMLaTMzBMnQZSHZSk6xyv4T894ezX4YOtli+gGKjNuT
 vIg/retb0HqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="303512975"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jun 2020 09:18:00 -0700
Received: from [10.252.132.55] (kliang2-mobl.ccr.corp.intel.com [10.252.132.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D4A08580107;
        Tue, 30 Jun 2020 09:17:58 -0700 (PDT)
Subject: Re: [PATCH V2 14/23] perf/x86/intel/lbr: Support Architectural LBR
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
 <1593195620-116988-15-git-send-email-kan.liang@linux.intel.com>
 <20200630154954.GU4781@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c597c040-57d5-ca9a-9acf-3dfc2debcf0e@linux.intel.com>
Date:   Tue, 30 Jun 2020 12:17:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630154954.GU4781@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2020 11:49 AM, Peter Zijlstra wrote:
> On Fri, Jun 26, 2020 at 11:20:11AM -0700, kan.liang@linux.intel.com wrote:
> 
>> +	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
>> +		intel_pmu_arch_lbr_init();
> 
>> +static inline bool is_lbr_call_stack_bit_set(u64 config)
>> +{
>> +	if (x86_pmu.arch_lbr)
>> +		return !!(config & ARCH_LBR_CALL_STACK);
>> +
>> +	return !!(config & LBR_CALL_STACK);
>> +}
> 
>> +	if (!x86_pmu.arch_lbr && !pmi && cpuc->lbr_sel)
>>   		wrmsrl(MSR_LBR_SELECT, lbr_select);
> 
>> +	if (!x86_pmu.arch_lbr)
>> +		debugctl |= DEBUGCTLMSR_LBR;
> 
>> +	if (x86_pmu.arch_lbr)
>> +		wrmsrl(MSR_ARCH_LBR_CTL, lbr_select | ARCH_LBR_CTL_LBREN);
>>   }
> 
> etc...
> 
>> +void __init intel_pmu_arch_lbr_init(void)
>> +{
>> +	unsigned int unused_edx;
>> +	u64 lbr_nr;
>> +
>> +	/* Arch LBR Capabilities */
>> +	cpuid(28, &x86_pmu.lbr_eax.full, &x86_pmu.lbr_ebx.full,
>> +		  &x86_pmu.lbr_ecx.full, &unused_edx);
>> +
>> +	lbr_nr = x86_pmu_get_max_arch_lbr_nr();
>> +	if (!lbr_nr)
>> +		return;
>> +
>> +	/* Apply the max depth of Arch LBR */
>> +	if (wrmsrl_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
>> +		return;
>> +
>> +	x86_pmu.lbr_nr = lbr_nr;
>> +	x86_get_pmu()->task_ctx_size = sizeof(struct x86_perf_task_context_arch_lbr) +
>> +				       lbr_nr * sizeof(struct lbr_entry);
>> +
>> +	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
>> +	x86_pmu.lbr_to = MSR_ARCH_LBR_TO_0;
>> +	x86_pmu.lbr_info = MSR_ARCH_LBR_INFO_0;
>> +
>> +	/* LBR callstack requires both CPL and Branch Filtering support */
>> +	if (!x86_pmu.lbr_ebx.split.lbr_cpl ||
>> +	    !x86_pmu.lbr_ebx.split.lbr_filter ||
>> +	    !x86_pmu.lbr_ebx.split.lbr_call_stack)
>> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT] = LBR_NOT_SUPP;
>> +
>> +	if (!x86_pmu.lbr_ebx.split.lbr_cpl) {
>> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_USER_SHIFT] = LBR_NOT_SUPP;
>> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_KERNEL_SHIFT] = LBR_NOT_SUPP;
>> +	} else if (!x86_pmu.lbr_ebx.split.lbr_filter) {
>> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_ANY_SHIFT] = LBR_NOT_SUPP;
>> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT] = LBR_NOT_SUPP;
>> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT] = LBR_NOT_SUPP;
>> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_IND_CALL_SHIFT] = LBR_NOT_SUPP;
>> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_COND_SHIFT] = LBR_NOT_SUPP;
>> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT] = LBR_NOT_SUPP;
>> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_CALL_SHIFT] = LBR_NOT_SUPP;
>> +	}
>> +
>> +	x86_pmu.lbr_ctl_mask = ARCH_LBR_CTL_MASK;
>> +	x86_pmu.lbr_ctl_map  = arch_lbr_ctl_map;
>> +
>> +	if (!x86_pmu.lbr_ebx.split.lbr_cpl && !x86_pmu.lbr_ebx.split.lbr_filter)
>> +		x86_pmu.lbr_ctl_map = NULL;
>> +
>> +	x86_pmu.lbr_reset = intel_pmu_arch_lbr_reset;
>> +	x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
>> +	x86_pmu.lbr_save = intel_pmu_arch_lbr_save;
>> +	x86_pmu.lbr_restore = intel_pmu_arch_lbr_restore;
>> +
>> +	x86_pmu.arch_lbr = true;
>> +	pr_cont("Architectural LBR, ");
>> +}
> 
> How about we make this here clear FEATURE_ARCH_LBR if it fails and then
> do away with x86_pmu.arch_lbr and use
> static_cpu_has(X86_FEATURE_ARCH_LBR) a lot more?

Yes, it's doable. So we can save a bit for arch_lbr in structure x86_pmu.

I will clear the FEATURE_ARCH_LBR via clear_cpu_cap(&boot_cpu_data, 
X86_FEATURE_ARCH_LBR);, if the check fails.
I will replace x86_pmu.arch_lbr with 
static_cpu_has(X86_FEATURE_ARCH_LBR) everywhere.

Thanks,
Kan
