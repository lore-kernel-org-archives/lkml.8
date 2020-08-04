Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783E82086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LVS9izSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgHDLxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgHDLtN (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:49:13 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E73BC06174A
        for <Linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 04:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R1BpYLpY9SppDsEqsOomEhp8dPWGGoK9Ld+yLP0ESbw=; b=LVS9izSi8A2kiEYk7U8ynr0ABC
        D7e+g3UqysEvd+4IaEwceeZr2Ht8YdHWzxX7yBZboNpe65/d8MLykxgbyrfoinHZfCUMvHoPTS53O
        imeCwhytPSKHa1lDoVBlD8IZjHwuiPax9HMUfB7yyBF4BudMqrtKscJfVbNfa+G/YsOOhmLDrAwIG
        aWHY/7YniodHTySFsOO0hRg0e/WIbsdtkQoV8OrO3W+atkq7VC/VOF4Dt8XlcbQghVCGNt3DPdLIs
        FTQKboyrbCH+48oBttt0E2gybVQUqY4ZlB2Uknfg6pq9LH3XNifP1OkcbACj2O63dFBUwKiET52CW
        0LDLdvgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2vRF-000858-W1; Tue, 04 Aug 2020 11:49:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 649E5301E02;
        Tue,  4 Aug 2020 13:49:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 408DA2BDB8C9E; Tue,  4 Aug 2020 13:49:00 +0200 (CEST)
Date:   Tue, 4 Aug 2020 13:49:00 +0200
From:   peterz@infradead.org
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
Message-ID: <20200804114900.GI2657@hirez.programming.kicks-ass.net>
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200731025617.16243-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731025617.16243-2-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:56:17AM +0800, Jin Yao wrote:
> @@ -6973,7 +6973,8 @@ static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
>  struct perf_callchain_entry *
>  perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  {
> -	bool kernel = !event->attr.exclude_callchain_kernel;
> +	bool kernel = !event->attr.exclude_callchain_kernel &&
> +		      !event->attr.exclude_kernel;

This seems weird; how can we get there. Also it seems to me that if you
have !exclude_callchain_kernel you already have permission for kernel
bits, so who cares.

>  	bool user   = !event->attr.exclude_callchain_user;
>  	/* Disallow cross-task user callchains. */
>  	bool crosstask = event->ctx->task && event->ctx->task != current;
> @@ -6988,12 +6989,39 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  	return callchain ?: &__empty_callchain;
>  }
>  
> +static struct pt_regs *leak_check(struct perf_event_header *header,
> +				  struct perf_event *event,
> +				  struct pt_regs *regs)
> +{
> +	struct pt_regs *regs_fake = NULL;
> +
> +	if (event->attr.exclude_kernel && !user_mode(regs)) {
> +		if (!(current->flags & PF_KTHREAD)) {
> +			regs_fake = task_pt_regs(current);
> +			if (!user_mode(regs_fake)) {
> +				regs_fake = NULL;
> +				instruction_pointer_set(regs, -1L);
> +			}
> +		} else
> +			instruction_pointer_set(regs, -1L);

That violates coding style, also:

		if (!(current->flags & PF_KTHREAD)) {
			regs_fake = task_pt_regs(current);
			if (!user_mode(regs_fake)) /* is this not a BUG?  */
				regs_fake = NULL;
		}

		if (!regs_fake)
			instruction_pointer_set(regs, -1L);

Seems simpler to me.

> +		if ((header->misc & PERF_RECORD_MISC_CPUMODE_MASK) ==
> +		     PERF_RECORD_MISC_KERNEL) {
> +			header->misc &= ~PERF_RECORD_MISC_CPUMODE_MASK;
> +			header->misc |= PERF_RECORD_MISC_USER;
> +		}

Why the conditional? At this point it had better be unconditionally
user, no?

		headers->misc &= ~PERF_RECORD_MISC_CPUMODE_MASK;
		headers->misc |= PERF_RECORD_MISC_USER;

> +	}
> +
> +	return regs_fake;
> +}
