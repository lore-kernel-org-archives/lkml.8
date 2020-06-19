Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8C2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A09E206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbgFSTk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:40:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:5489 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389754AbgFSTk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:40:59 -0400
IronPort-SDR: sGbDhK0mdSq2n1IRyeAZlH9h7/WcfBavljg5lQFS6/ck5nZ2S1jd0xGje63K7H9jtRO7wFp9Mi
 tdkWLnHiYzXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="122803455"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="122803455"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 12:40:58 -0700
IronPort-SDR: u5yDurmMPH9Uw7WrfUn4lkWgdcvB/6TZIcBhQg5IseWS6u2agKLKyZryZpc5N9GjnE1fKoDXV/
 Dfe4WbAAnNvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="278106180"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2020 12:40:58 -0700
Received: from [10.251.1.53] (kliang2-mobl.ccr.corp.intel.com [10.251.1.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 248ED580279;
        Fri, 19 Jun 2020 12:40:56 -0700 (PDT)
Subject: Re: [PATCH 12/21] perf/x86/intel/lbr: Support Architectural LBR
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-13-git-send-email-kan.liang@linux.intel.com>
 <20200619190823.GG576888@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e026c2c7-0187-e2c8-8a1a-58b4b1a66134@linux.intel.com>
Date:   Fri, 19 Jun 2020 15:40:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619190823.GG576888@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2020 3:08 PM, Peter Zijlstra wrote:
> On Fri, Jun 19, 2020 at 07:04:00AM -0700, kan.liang@linux.intel.com wrote:
> 
>> +static void intel_pmu_arch_lbr_enable(bool pmi)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	u64 debugctl, lbr_ctl = 0, orig_debugctl;
>> +
>> +	if (pmi)
>> +		return;
>> +
>> +	if (cpuc->lbr_ctl)
>> +		lbr_ctl = cpuc->lbr_ctl->config & x86_pmu.lbr_ctl_mask;
>> +	/*
>> +	 * LBR callstack does not work well with FREEZE_LBRS_ON_PMI.
>> +	 * If FREEZE_LBRS_ON_PMI is set, PMI near call/return instructions
>> +	 * may be missed, that can lead to confusing results.
>> +	 */
>> +	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
>> +	orig_debugctl = debugctl;
>> +	if (lbr_ctl & ARCH_LBR_CALL_STACK)
>> +		debugctl &= ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
>> +	else
>> +		debugctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
>> +	if (orig_debugctl != debugctl)
>> +		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
>> +
>> +	wrmsrl(MSR_ARCH_LBR_CTL, lbr_ctl | ARCH_LBR_CTL_LBREN);
>> +}
> 
> This is nearly a duplicate of the old one, surely we can do better?

It's similar, but we have to deal with different MSRs and bits.

> 
>> +static void intel_pmu_arch_lbr_restore(void *ctx)
>> +{
>> +	struct x86_perf_task_context_arch_lbr *task_ctx = ctx;
>> +	struct x86_perf_arch_lbr_entry *entries = task_ctx->entries;
>> +	int i;
>> +
>> +	/* Fast reset the LBRs before restore if the call stack is not full. */
>> +	if (!entries[x86_pmu.lbr_nr - 1].lbr_from)
>> +		intel_pmu_arch_lbr_reset();
>> +
>> +	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>> +		if (!entries[i].lbr_from)
>> +			break;
>> +		wrlbr_from(i, entries[i].lbr_from);
>> +		wrlbr_to(i, entries[i].lbr_to);
>> +		wrmsrl(MSR_ARCH_LBR_INFO_0 + i, entries[i].lbr_info);
>> +	}
>> +}
> 
> This too looks very much like the old one.

The difference is the reset part.
For the previous platforms, we restore the saved LBRs first, then reset 
the unsaved LBR MSRs one by one.
Now, for Arch LBR, we have a fast reset method. We reset all LBRs (if we 
know there are unsaved items) first, then restore the saved LBRs.
That would improve the performance for the application with short call 
stack.

> 
>> +static void intel_pmu_arch_lbr_save(void *ctx)
>> +{
>> +	struct x86_perf_task_context_arch_lbr *task_ctx = ctx;
>> +	struct x86_perf_arch_lbr_entry *entries = task_ctx->entries;
>> +	int i;
>> +
>> +	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>> +		entries[i].lbr_from = rdlbr_from(i);
>> +		/* Only save valid branches. */
>> +		if (!entries[i].lbr_from)
>> +			break;
>> +		entries[i].lbr_to = rdlbr_to(i);
>> +		rdmsrl(MSR_ARCH_LBR_INFO_0 + i, entries[i].lbr_info);
>> +	}
>> +
>> +	/* LBR call stack is not full. Reset is required in restore. */
>> +	if (i < x86_pmu.lbr_nr)
>> +		entries[x86_pmu.lbr_nr - 1].lbr_from = 0;
>> +}
> 
> And again..
> 
>> +static void __intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc, int index,
>> +				      u64 from, u64 to, u64 info)
>> +{
>> +	u64 mis = 0, pred = 0, in_tx = 0, abort = 0, type = 0;
>> +	u32 br_type, to_plm;
>> +	u16 cycles = 0;
>> +
>> +	if (x86_pmu.arch_lbr_mispred) {
>> +		mis = !!(info & ARCH_LBR_INFO_MISPRED);
>> +		pred = !mis;
>> +	}
>> +	in_tx = !!(info & ARCH_LBR_INFO_IN_TSX);
>> +	abort = !!(info & ARCH_LBR_INFO_TSX_ABORT);
>> +	if (x86_pmu.arch_lbr_timed_lbr &&
>> +	    (info & ARCH_LBR_INFO_CYC_CNT_VALID))
>> +		cycles = (info & ARCH_LBR_INFO_CYC_CNT);
>> +
>> +	/*
>> +	 * Parse the branch type recorded in LBR_x_INFO MSR.
>> +	 * Doesn't support OTHER_BRANCH decoding for now.
>> +	 * OTHER_BRANCH branch type still rely on software decoding.
>> +	 */
>> +	if (x86_pmu.arch_lbr_br_type) {
>> +		br_type = (info & ARCH_LBR_INFO_BR_TYPE) >> ARCH_LBR_INFO_BR_TYPE_OFFSET;
>> +
>> +		if (br_type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>> +			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>> +			type = arch_lbr_br_type_map[br_type] | to_plm;
>> +		}
>> +	}
>> +
>> +	cpuc->lbr_entries[index].from		 = from;
>> +	cpuc->lbr_entries[index].to		 = to;
>> +	cpuc->lbr_entries[index].mispred	 = mis;
>> +	cpuc->lbr_entries[index].predicted	 = pred;
>> +	cpuc->lbr_entries[index].in_tx		 = in_tx;
>> +	cpuc->lbr_entries[index].abort		 = abort;
>> +	cpuc->lbr_entries[index].cycles		 = cycles;
>> +	cpuc->lbr_entries[index].type		 = type;
>> +	cpuc->lbr_entries[index].reserved	 = 0;
>> +}
>> +
>> +static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
>> +{
>> +	u64 from, to, info;
>> +	int i;
>> +
>> +	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>> +		from = rdlbr_from(i);
>> +		to   = rdlbr_to(i);
>> +
>> +		/*
>> +		 * Read LBR entries until invalid entry (0s) is detected.
>> +		 */
>> +		if (!from)
>> +			break;
>> +
>> +		rdmsrl(MSR_ARCH_LBR_INFO_0 + i, info);
>> +
>> +		__intel_pmu_arch_lbr_read(cpuc, i, from, to, info);
>> +	}
>> +
>> +	cpuc->lbr_stack.nr = i;
>> +}
> 
>> +static void intel_pmu_store_pebs_arch_lbrs(struct pebs_lbr *pebs_lbr,
>> +					   struct cpu_hw_events *cpuc)
>> +{
>> +	struct pebs_lbr_entry *lbr;
>> +	int i;
>> +
>> +	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>> +		lbr = &pebs_lbr->lbr[i];
>> +
>> +		/*
>> +		 * Read LBR entries until invalid entry (0s) is detected.
>> +		 */
>> +		if (!lbr->from)
>> +			break;
>> +
>> +		__intel_pmu_arch_lbr_read(cpuc, i, lbr->from,
>> +					  lbr->to, lbr->info);
>> +	}
>> +
>> +	cpuc->lbr_stack.nr = i;
>> +	intel_pmu_lbr_filter(cpuc);
>> +}
> 
> Unless I'm reading cross-eyed again, that too is very similar to what we
> already had.
> 

I will try to factor out the common codes for thses functions as many as 
possible.


Thanks,
Kan
