Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB56FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857162065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="upQ6p+oV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGXNTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:19:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5604DC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hV7yNN+HIVpH67GhHx4rv4s5Nvwo1UdxPBs4kWty9VU=; b=upQ6p+oVRyWuc7uspFOtdpHaoy
        RGqj0tezBnNnMiLSKlP0AjZXahJKXNIwd/0d844+/5FdMypFo8MfE5MP/4KOdmS40EI/NQqrlREDV
        Bgqwz1ubL7uuPAKbl0kSO7wfN+MzBPbP5/s5DKLoAHZV+ai6e7FUcyMv3ORE8/0l+QNmwqXJrQXOv
        6HE627bqa7+qVvyfDY0J1As5KvTcNuelcJ9rnbYs5d/MBbZ59v/Dr7uLkcQ9VXOj4iLY5JFaDhbpE
        ZZG4pvGHNYw1wXtoU/vRE5T7jQLyoDK1UISgFqRD5MNP+Fxyqi9TlO8qhHxSJtq0pzYDh6B8ot/vJ
        ZJTRU/9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyxbR-0000G0-Eq; Fri, 24 Jul 2020 13:19:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 725E13003E5;
        Fri, 24 Jul 2020 15:19:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 617EA2855F279; Fri, 24 Jul 2020 15:19:06 +0200 (CEST)
Date:   Fri, 24 Jul 2020 15:19:06 +0200
From:   peterz@infradead.org
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 08/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
Message-ID: <20200724131906.GW119549@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-9-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723171117.9918-9-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:11:11AM -0700, kan.liang@linux.intel.com wrote:
> @@ -3375,6 +3428,72 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  	if (event->attr.type != PERF_TYPE_RAW)
>  		return 0;
>  
> +	/*
> +	 * Config Topdown slots and metric events
> +	 *
> +	 * The slots event on Fixed Counter 3 can support sampling,
> +	 * which will be handled normally in x86_perf_event_update().
> +	 *
> +	 * The metric events don't support sampling.
> +	 *
> +	 * For counting, topdown slots and metric events will be
> +	 * handled specially for event update.
> +	 * A flag PERF_X86_EVENT_TOPDOWN is applied for the case.
> +	 */
> +	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
> +		if (is_metric_event(event)) {
> +			struct perf_event *leader = event->group_leader;
> +			struct perf_event *sibling;
> +
> +			/* The metric events don't support sampling. */
> +			if (is_sampling_event(event))
> +				return -EINVAL;
> +
> +			/* The metric events cannot be a group leader. */
> +			if (leader == event)
> +				return -EINVAL;
> +
> +			/*
> +			 * The slots event cannot be the leader of a topdown
> +			 * sample-read group, e.g., {slots, topdown-retiring}:S
> +			 */
> +			if (is_slots_event(leader) && is_sampling_event(leader))
> +				return -EINVAL;

This has nothing to do with sample-read; SLOTS cannot be sampling when
coupled with the METRIC stuff because hardware is daft.

And you can have SAMPLE_READ on non-leader events just fine.

> +
> +			/*
> +			 * The slots event must be before the metric events,
> +			 * because we only update the values of a topdown
> +			 * group once with the slots event.
> +			 */
> +			if (!is_slots_event(leader)) {
> +				for_each_sibling_event(sibling, leader) {
> +					if (is_slots_event(sibling))
> +						break;
> +					if (is_metric_event(sibling))
> +						return -EINVAL;
> +				}
> +			}

Per the SIBLING patch this then wants to be:

			if (!is_slots_event(leader))
				return -EINVAL;

			event->event_caps |= PERF_EV_CAP_SIBLING.
			/*
			 * Only once we have a METRICs sibling to we
			 * need TopDown magic.
			 */
			leader->hw.flags |= PERF_X86_EVENT_TOPDOWN;
> +		}
> +
> +		if (!is_sampling_event(event)) {
> +			if (event->attr.config1 != 0)
> +				return -EINVAL;

How does this depend on sampling?

> +			/*
> +			 * The TopDown metrics events and slots event don't
> +			 * support any filters.
> +			 */
> +			if (event->attr.config & X86_ALL_EVENT_FLAGS)
> +				return -EINVAL;

That seems independent of sampling too. Even a sampling SLOTS shouldn't
be having any of those afaict.

> +
> +			event->hw.flags |= PERF_X86_EVENT_TOPDOWN;

This is confusing too, a !sampling SLOTS event without METRIC siblings
shouldn't have this set, right? So arguably, this should be like above.

> +
> +			event->event_caps |= PERF_EV_CAP_COEXIST;
> +
> +			if (is_metric_event(event))
> +				event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;

This too seems like something that should be in the is_metric_event()
branch above.

> +		}
> +	}
> +
>  	if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
>  		return 0;
>  
