Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF38C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C3520675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHfwOHAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389764AbgF3Pum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389713AbgF3Pul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:50:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E5C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v/jrtnOfvxmU6E2XWKXiaVm+SlXnKp+0/fe1boRMCVg=; b=jHfwOHAeugatzhfFuoUzA/sWVf
        qlFcQvPUmtvXVJdnjnTPGmFpJ+BUJIImuCkEGf6UgNB3bhJJ1+6VHEj3iGJdlVuFWL8vAg7muLJyY
        GRYrjE7vRVD/N6SCaPg9KN7ONwdoRjy3biugAy3bpaauPjk10Y1rP0vGj6SI4LawKku88NW3+Nepr
        46d+InjxfbHRXjwSCcZAmQMVZtffktPzwIEzHevLlTeV3Fz1xqt1qECBbj6q7whXsnqxMWh7Lzfy0
        T6qRCIuOe4cok36hlJs9mG5rKSnWQXxbfG4zNnxihR+45m+v1dTti1sAySLD571XelAofN7ylDKS/
        2NRwnt/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqIWC-0007iu-K5; Tue, 30 Jun 2020 15:49:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48C92302753;
        Tue, 30 Jun 2020 17:49:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3570D20CF3979; Tue, 30 Jun 2020 17:49:54 +0200 (CEST)
Date:   Tue, 30 Jun 2020 17:49:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH V2 14/23] perf/x86/intel/lbr: Support Architectural LBR
Message-ID: <20200630154954.GU4781@hirez.programming.kicks-ass.net>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
 <1593195620-116988-15-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593195620-116988-15-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:20:11AM -0700, kan.liang@linux.intel.com wrote:

> +	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
> +		intel_pmu_arch_lbr_init();

> +static inline bool is_lbr_call_stack_bit_set(u64 config)
> +{
> +	if (x86_pmu.arch_lbr)
> +		return !!(config & ARCH_LBR_CALL_STACK);
> +
> +	return !!(config & LBR_CALL_STACK);
> +}

> +	if (!x86_pmu.arch_lbr && !pmi && cpuc->lbr_sel)
>  		wrmsrl(MSR_LBR_SELECT, lbr_select);

> +	if (!x86_pmu.arch_lbr)
> +		debugctl |= DEBUGCTLMSR_LBR;

> +	if (x86_pmu.arch_lbr)
> +		wrmsrl(MSR_ARCH_LBR_CTL, lbr_select | ARCH_LBR_CTL_LBREN);
>  }

etc...

> +void __init intel_pmu_arch_lbr_init(void)
> +{
> +	unsigned int unused_edx;
> +	u64 lbr_nr;
> +
> +	/* Arch LBR Capabilities */
> +	cpuid(28, &x86_pmu.lbr_eax.full, &x86_pmu.lbr_ebx.full,
> +		  &x86_pmu.lbr_ecx.full, &unused_edx);
> +
> +	lbr_nr = x86_pmu_get_max_arch_lbr_nr();
> +	if (!lbr_nr)
> +		return;
> +
> +	/* Apply the max depth of Arch LBR */
> +	if (wrmsrl_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
> +		return;
> +
> +	x86_pmu.lbr_nr = lbr_nr;
> +	x86_get_pmu()->task_ctx_size = sizeof(struct x86_perf_task_context_arch_lbr) +
> +				       lbr_nr * sizeof(struct lbr_entry);
> +
> +	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
> +	x86_pmu.lbr_to = MSR_ARCH_LBR_TO_0;
> +	x86_pmu.lbr_info = MSR_ARCH_LBR_INFO_0;
> +
> +	/* LBR callstack requires both CPL and Branch Filtering support */
> +	if (!x86_pmu.lbr_ebx.split.lbr_cpl ||
> +	    !x86_pmu.lbr_ebx.split.lbr_filter ||
> +	    !x86_pmu.lbr_ebx.split.lbr_call_stack)
> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT] = LBR_NOT_SUPP;
> +
> +	if (!x86_pmu.lbr_ebx.split.lbr_cpl) {
> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_USER_SHIFT] = LBR_NOT_SUPP;
> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_KERNEL_SHIFT] = LBR_NOT_SUPP;
> +	} else if (!x86_pmu.lbr_ebx.split.lbr_filter) {
> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_ANY_SHIFT] = LBR_NOT_SUPP;
> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT] = LBR_NOT_SUPP;
> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT] = LBR_NOT_SUPP;
> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_IND_CALL_SHIFT] = LBR_NOT_SUPP;
> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_COND_SHIFT] = LBR_NOT_SUPP;
> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT] = LBR_NOT_SUPP;
> +		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_CALL_SHIFT] = LBR_NOT_SUPP;
> +	}
> +
> +	x86_pmu.lbr_ctl_mask = ARCH_LBR_CTL_MASK;
> +	x86_pmu.lbr_ctl_map  = arch_lbr_ctl_map;
> +
> +	if (!x86_pmu.lbr_ebx.split.lbr_cpl && !x86_pmu.lbr_ebx.split.lbr_filter)
> +		x86_pmu.lbr_ctl_map = NULL;
> +
> +	x86_pmu.lbr_reset = intel_pmu_arch_lbr_reset;
> +	x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
> +	x86_pmu.lbr_save = intel_pmu_arch_lbr_save;
> +	x86_pmu.lbr_restore = intel_pmu_arch_lbr_restore;
> +
> +	x86_pmu.arch_lbr = true;
> +	pr_cont("Architectural LBR, ");
> +}

How about we make this here clear FEATURE_ARCH_LBR if it fails and then
do away with x86_pmu.arch_lbr and use
static_cpu_has(X86_FEATURE_ARCH_LBR) a lot more?
