Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B090C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E0A2100A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lcNnZdJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406597AbgFSTIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406369AbgFSTIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:08:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FFFC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=89M0eb1Q2wYkscNdDVzci6FjwvHSDf4oMNkvTwFNxtI=; b=lcNnZdJuKV/2bIzDdZ89aRthfa
        Oun+NZ6ca1ZKliyrwDjg6bDEctpZZPJ/gVlefcivGMg/vQD5ldnmYARMZFgn/OMPwrwOEhTQiA+Ew
        bdqgC5zqHa2rJGq62Tdmnt6oo/t20kJjpi7zjVU5jiQ2fV8Oki2TTv1Trz5uZ6i0BqCSJo9/JkgWD
        QJzf2rfkVMRNO4w3qLaglRT/6QjxEWUpt+uZI8AGdZy8cmz9ZrMnO0gB+EddEMQ/WGlS09Bj/efKE
        9HgQeGTe6Bs8siT23RuUCJoOqjJNc+369B1jPYl5T7njwy1N/THO6AXBba1kX+Ta5fEQ1gs8lSkeH
        7bYNtdXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmMNG-0006Yy-Sj; Fri, 19 Jun 2020 19:08:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBE35301A32;
        Fri, 19 Jun 2020 21:08:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5A162C28E840; Fri, 19 Jun 2020 21:08:23 +0200 (CEST)
Date:   Fri, 19 Jun 2020 21:08:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH 12/21] perf/x86/intel/lbr: Support Architectural LBR
Message-ID: <20200619190823.GG576888@hirez.programming.kicks-ass.net>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-13-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592575449-64278-13-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 07:04:00AM -0700, kan.liang@linux.intel.com wrote:

> +static void intel_pmu_arch_lbr_enable(bool pmi)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	u64 debugctl, lbr_ctl = 0, orig_debugctl;
> +
> +	if (pmi)
> +		return;
> +
> +	if (cpuc->lbr_ctl)
> +		lbr_ctl = cpuc->lbr_ctl->config & x86_pmu.lbr_ctl_mask;
> +	/*
> +	 * LBR callstack does not work well with FREEZE_LBRS_ON_PMI.
> +	 * If FREEZE_LBRS_ON_PMI is set, PMI near call/return instructions
> +	 * may be missed, that can lead to confusing results.
> +	 */
> +	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> +	orig_debugctl = debugctl;
> +	if (lbr_ctl & ARCH_LBR_CALL_STACK)
> +		debugctl &= ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +	else
> +		debugctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +	if (orig_debugctl != debugctl)
> +		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> +
> +	wrmsrl(MSR_ARCH_LBR_CTL, lbr_ctl | ARCH_LBR_CTL_LBREN);
> +}

This is nearly a duplicate of the old one, surely we can do better?

> +static void intel_pmu_arch_lbr_restore(void *ctx)
> +{
> +	struct x86_perf_task_context_arch_lbr *task_ctx = ctx;
> +	struct x86_perf_arch_lbr_entry *entries = task_ctx->entries;
> +	int i;
> +
> +	/* Fast reset the LBRs before restore if the call stack is not full. */
> +	if (!entries[x86_pmu.lbr_nr - 1].lbr_from)
> +		intel_pmu_arch_lbr_reset();
> +
> +	for (i = 0; i < x86_pmu.lbr_nr; i++) {
> +		if (!entries[i].lbr_from)
> +			break;
> +		wrlbr_from(i, entries[i].lbr_from);
> +		wrlbr_to(i, entries[i].lbr_to);
> +		wrmsrl(MSR_ARCH_LBR_INFO_0 + i, entries[i].lbr_info);
> +	}
> +}

This too looks very much like the old one.

> +static void intel_pmu_arch_lbr_save(void *ctx)
> +{
> +	struct x86_perf_task_context_arch_lbr *task_ctx = ctx;
> +	struct x86_perf_arch_lbr_entry *entries = task_ctx->entries;
> +	int i;
> +
> +	for (i = 0; i < x86_pmu.lbr_nr; i++) {
> +		entries[i].lbr_from = rdlbr_from(i);
> +		/* Only save valid branches. */
> +		if (!entries[i].lbr_from)
> +			break;
> +		entries[i].lbr_to = rdlbr_to(i);
> +		rdmsrl(MSR_ARCH_LBR_INFO_0 + i, entries[i].lbr_info);
> +	}
> +
> +	/* LBR call stack is not full. Reset is required in restore. */
> +	if (i < x86_pmu.lbr_nr)
> +		entries[x86_pmu.lbr_nr - 1].lbr_from = 0;
> +}

And again..

> +static void __intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc, int index,
> +				      u64 from, u64 to, u64 info)
> +{
> +	u64 mis = 0, pred = 0, in_tx = 0, abort = 0, type = 0;
> +	u32 br_type, to_plm;
> +	u16 cycles = 0;
> +
> +	if (x86_pmu.arch_lbr_mispred) {
> +		mis = !!(info & ARCH_LBR_INFO_MISPRED);
> +		pred = !mis;
> +	}
> +	in_tx = !!(info & ARCH_LBR_INFO_IN_TSX);
> +	abort = !!(info & ARCH_LBR_INFO_TSX_ABORT);
> +	if (x86_pmu.arch_lbr_timed_lbr &&
> +	    (info & ARCH_LBR_INFO_CYC_CNT_VALID))
> +		cycles = (info & ARCH_LBR_INFO_CYC_CNT);
> +
> +	/*
> +	 * Parse the branch type recorded in LBR_x_INFO MSR.
> +	 * Doesn't support OTHER_BRANCH decoding for now.
> +	 * OTHER_BRANCH branch type still rely on software decoding.
> +	 */
> +	if (x86_pmu.arch_lbr_br_type) {
> +		br_type = (info & ARCH_LBR_INFO_BR_TYPE) >> ARCH_LBR_INFO_BR_TYPE_OFFSET;
> +
> +		if (br_type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
> +			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
> +			type = arch_lbr_br_type_map[br_type] | to_plm;
> +		}
> +	}
> +
> +	cpuc->lbr_entries[index].from		 = from;
> +	cpuc->lbr_entries[index].to		 = to;
> +	cpuc->lbr_entries[index].mispred	 = mis;
> +	cpuc->lbr_entries[index].predicted	 = pred;
> +	cpuc->lbr_entries[index].in_tx		 = in_tx;
> +	cpuc->lbr_entries[index].abort		 = abort;
> +	cpuc->lbr_entries[index].cycles		 = cycles;
> +	cpuc->lbr_entries[index].type		 = type;
> +	cpuc->lbr_entries[index].reserved	 = 0;
> +}
> +
> +static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
> +{
> +	u64 from, to, info;
> +	int i;
> +
> +	for (i = 0; i < x86_pmu.lbr_nr; i++) {
> +		from = rdlbr_from(i);
> +		to   = rdlbr_to(i);
> +
> +		/*
> +		 * Read LBR entries until invalid entry (0s) is detected.
> +		 */
> +		if (!from)
> +			break;
> +
> +		rdmsrl(MSR_ARCH_LBR_INFO_0 + i, info);
> +
> +		__intel_pmu_arch_lbr_read(cpuc, i, from, to, info);
> +	}
> +
> +	cpuc->lbr_stack.nr = i;
> +}

> +static void intel_pmu_store_pebs_arch_lbrs(struct pebs_lbr *pebs_lbr,
> +					   struct cpu_hw_events *cpuc)
> +{
> +	struct pebs_lbr_entry *lbr;
> +	int i;
> +
> +	for (i = 0; i < x86_pmu.lbr_nr; i++) {
> +		lbr = &pebs_lbr->lbr[i];
> +
> +		/*
> +		 * Read LBR entries until invalid entry (0s) is detected.
> +		 */
> +		if (!lbr->from)
> +			break;
> +
> +		__intel_pmu_arch_lbr_read(cpuc, i, lbr->from,
> +					  lbr->to, lbr->info);
> +	}
> +
> +	cpuc->lbr_stack.nr = i;
> +	intel_pmu_lbr_filter(cpuc);
> +}

Unless I'm reading cross-eyed again, that too is very similar to what we
already had.

