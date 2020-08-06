Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C23C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A532A221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eVUIpkTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgHFR2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbgHFRBX (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:01:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E7BC0617A2
        for <Linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uPvg2X3v/p/lXfd6jcp/t8NGbBzcgZV+OIEIyK+LKHM=; b=eVUIpkThwVZu3ji7f/oUjKFYso
        3gtqKsitPC1QmRkSe4U3nEPyNmPEnefLRMCo5sTMIhMmsAo7rrouRruRScmwOfc/xgh6AMdGsyF5Q
        AzkzS8Lh8wzUsycVR2vCmpIuie+z4tWJE3edoxbGVCPwoK4+GnvvTPVgQOlDVYOzBu5hxCjRskzbt
        bsz2bfskqSKPvaS8MoSFxcqund85paa9509EvdrYenlcCkrrykeY9Kbb9a/RR8hbXFGs830bPiguB
        0PmI8z+W3NGLjtEyGEx+YT3z++rWpHN0ohih1lJBfFVSFbs/38lgX5y582Qj4/HSRiPasAV2A/TuO
        S7QxncBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3ddg-0004n2-EA; Thu, 06 Aug 2020 11:00:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E638301A66;
        Thu,  6 Aug 2020 13:00:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D3E22123A1E7; Thu,  6 Aug 2020 13:00:46 +0200 (CEST)
Date:   Thu, 6 Aug 2020 13:00:46 +0200
From:   peterz@infradead.org
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
Message-ID: <20200806110046.GF35926@hirez.programming.kicks-ass.net>
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200731025617.16243-2-yao.jin@linux.intel.com>
 <20200804114900.GI2657@hirez.programming.kicks-ass.net>
 <4c958d61-11a7-9f3e-9e7d-d733270144a1@linux.intel.com>
 <20200805124454.GP2657@hirez.programming.kicks-ass.net>
 <797aa4de-c618-f340-ad7b-cef38c96b035@linux.intel.com>
 <20200806091827.GY2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806091827.GY2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 11:18:27AM +0200, peterz@infradead.org wrote:

> Suppose we have nested virt:
> 
> 	L0-hv
> 	|
> 	G0/L1-hv
> 	   |
> 	   G1
> 
> And we're running in G0, then:
> 
>  - 'exclude_hv' would exclude L0 events
>  - 'exclude_host' would ... exclude L1-hv events?
>  - 'exclude_guest' would ... exclude G1 events?

So in arch/x86/events/intel/core.c we have:

static inline void intel_set_masks(struct perf_event *event, int idx)
{
	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);

	if (event->attr.exclude_host)
		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
	if (event->attr.exclude_guest)
		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
	if (event_is_checkpointed(event))
		__set_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
}

which is, afaict, just plain wrong. Should that not be something like:

	if (!event->attr.exclude_host)
		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
	if (!event->attr.exclude_guest)
		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);


Also, ARM64 seems to also implement this stuff, Mark, do you have any
insight on how all this is 'supposed' to work?
