Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3F7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFF620848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="inZ6m6SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgCaKSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:18:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbgCaKSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F/W9yss1Jz9mFb8aYjHkISw9gGu7WYHlzp/SX5ejA/A=; b=inZ6m6SFKNvWDq6GKpNt/PQecz
        qHNqggptuwLzrChJzpkBYF5ebukuT4Huroqh4A6bDaZrXTC7hq1EmoYK15OT7EBr6/kZQUhuHU57v
        vtnNat2aO1BA5edVyFZkIep5WpYTrdnna+Xq0VXlz+3YEJc7dDsZEXnrJqM9WJ8SgKMIWdilG+/nO
        f6v9KezEJZGgqfMvDYJhE7XUHiLZEwIPvLZmdQ+k86VIxtKY6AxqcnW84ZWa5uL4BIEAcHIEy4S2U
        M6U9CRRLbMZS5BeuRfSjP+teTfc4iiMqf75Wf/3zoz3BBTQl+eT+N3G0j3NsJXKpJey8OyP/FnaAO
        YE3p6uSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJDyh-0005ka-8y; Tue, 31 Mar 2020 10:18:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFBDE30477A;
        Tue, 31 Mar 2020 12:18:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8EFE29D84C3B; Tue, 31 Mar 2020 12:18:34 +0200 (CEST)
Date:   Tue, 31 Mar 2020 12:18:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     CodyYao-oc <CodyYao-oc@zhaoxin.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        cooperyan@zhaoxin.com
Subject: Re: [PATCH] x86/perf: Add hardware performance events support for
 Zhaoxin CPU.
Message-ID: <20200331101834.GP20730@hirez.programming.kicks-ass.net>
References: <1585647599-6649-1-git-send-email-CodyYao-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585647599-6649-1-git-send-email-CodyYao-oc@zhaoxin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 05:39:59PM +0800, CodyYao-oc wrote:
> Zhaoxin CPU has provided facilities for monitoring performance
> via PMU(Performance Monitor Unit), but the functionality is unused so far.
> Therefore, add support for zhaoxin pmu to make performance related
> hardware events available.

This looks like an Intel Architectural PMU v2 or so, is that correct? Do
you have a link to documentation for your CPU?

> +static void zhaoxin_pmu_disable_all(void)
> +{
> +	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> +}
> +
> +static void zhaoxin_pmu_enable_all(int added)
> +{
> +	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, x86_pmu.intel_ctrl);
> +}
> +
> +static inline u64 zhaoxin_pmu_get_status(void)
> +{
> +	u64 status;
> +
> +	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
> +
> +	return status;
> +}
> +
> +static inline void zhaoxin_pmu_ack_status(u64 ack)
> +{
> +	wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
> +}

> +static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
> +{
> +	struct perf_sample_data data;
> +	struct cpu_hw_events *cpuc;
> +	int bit;
> +	u64 status;
> +	bool is_zxc;
> +	int handled = 0;
> +
> +	cpuc = this_cpu_ptr(&cpu_hw_events);
> +	apic_write(APIC_LVTPC, APIC_DM_NMI);
> +	zhaoxin_pmu_disable_all();
> +	status = zhaoxin_pmu_get_status();
> +	if (!status)
> +		goto done;
> +
> +	if (boot_cpu_data.x86 == 0x06 &&
> +		(boot_cpu_data.x86_model == 0x0f ||
> +			boot_cpu_data.x86_model == 0x19))
> +		is_zxc = true;
> +again:
> +
> +	/*Clearing status works only if the global control is enable on zxc.*/
> +	if (is_zxc)
> +		wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, x86_pmu.intel_ctrl);
> +
> +	zhaoxin_pmu_ack_status(status);
> +
> +	if (is_zxc)
> +		wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);

That's an unfortunate errata; perhaps write it like so:

static inline void zxc_pmu_ack_status(u64 status)
{
	/*
	 * ZXC needs global control enabled in order to clear status bits.
	 */
	zhaoxin_pmu_enable_all(0);
	zhaoxin_pmu_ack_status(status);
	zhaoxin_pmu_disable_all();
}

	if (is_zxc)
		zxc_pmu_ack_status(status);
	else
		zhaoxin_pmu_ack_status(status);

Alternatively; you can do a whole zxc specific handle_irq() and move the
get/ack status before disable_all(). If you do that, then factor this:

> +	/*
> +	 * CondChgd bit 63 doesn't mean any overflow status. Ignore
> +	 * and clear the bit.
> +	 */
> +	if (__test_and_clear_bit(63, (unsigned long *)&status)) {
> +		if (!status)
> +			goto done;
> +	}
> +
> +	for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
> +		struct perf_event *event = cpuc->events[bit];
> +
> +		handled++;
> +
> +		if (!test_bit(bit, cpuc->active_mask))
> +			continue;
> +
> +		x86_perf_event_update(event);
> +		perf_sample_data_init(&data, 0, event->hw.last_period);
> +
> +		if (!x86_perf_event_set_period(event))
> +			continue;
> +
> +		if (perf_event_overflow(event, &data, regs))
> +			x86_pmu_stop(event, 0);
> +	}

bit into it's own function so you don't have to duplicate it. Then the
two handle_irq() functions only differ in the status handling.

> +
> +	/*
> +	 * Repeat if there is more work to be done:
> +	 */
> +	status = zhaoxin_pmu_get_status();
> +	if (status)
> +		goto again;
> +
> +done:
> +	zhaoxin_pmu_enable_all(0);
> +	return handled;
> +}
