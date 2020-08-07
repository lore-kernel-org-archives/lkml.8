Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD799C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A4F2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DUBsOSFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHGJCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgHGJCm (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:02:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8AC061574
        for <Linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nfuR7h4BdrYTNwZ8exemfWhn1G8l1pg1R8rsohtYXAc=; b=DUBsOSFtwBsOrNANpC8WMiM1oU
        4jKuWxDwLylGposCFoqmk3EWtqMA+Vdr7HXGi6rrteBP9NWRyfm4sPZtltxku2JOXtn6aGPLufdNF
        /3iOo2cmQy7jzHHcYEKpLJyWdmNHtG5GeVx7CxfBklExVmS1Ux8sXc1DwE0Ac0WznVlpVIVQXqlgj
        sJ+kcVTJKIL1FOpMt2FukLMr3JUnVY0JPMA61YM8NUar6IGffF2PXCuQqGlW1WncmAgfkw2W0JqxK
        eLGVQ5Vr3wyinB3CZnDimrB7WtBtbvG8h4A3gx5lCPru7uS2bocRVfqu4nIpSVDyNVHMbTPJ4+OmD
        yonjmmGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3yGn-000813-Qc; Fri, 07 Aug 2020 09:02:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 440EA300446;
        Fri,  7 Aug 2020 11:02:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1248B213C48A5; Fri,  7 Aug 2020 11:02:32 +0200 (CEST)
Date:   Fri, 7 Aug 2020 11:02:32 +0200
From:   peterz@infradead.org
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
Message-ID: <20200807090232.GE2674@hirez.programming.kicks-ass.net>
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200731025617.16243-2-yao.jin@linux.intel.com>
 <20200804114900.GI2657@hirez.programming.kicks-ass.net>
 <4c958d61-11a7-9f3e-9e7d-d733270144a1@linux.intel.com>
 <20200805124454.GP2657@hirez.programming.kicks-ass.net>
 <797aa4de-c618-f340-ad7b-cef38c96b035@linux.intel.com>
 <20200806091827.GY2674@hirez.programming.kicks-ass.net>
 <20200806110046.GF35926@hirez.programming.kicks-ass.net>
 <1d03d443-b187-bc1f-2601-a54037a64eff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d03d443-b187-bc1f-2601-a54037a64eff@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 02:24:30PM +0800, Jin, Yao wrote:
> Hi Peter,
> 
> On 8/6/2020 7:00 PM, peterz@infradead.org wrote:
> > On Thu, Aug 06, 2020 at 11:18:27AM +0200, peterz@infradead.org wrote:
> > 
> > > Suppose we have nested virt:
> > > 
> > > 	L0-hv
> > > 	|
> > > 	G0/L1-hv
> > > 	   |
> > > 	   G1
> > > 
> > > And we're running in G0, then:
> > > 
> > >   - 'exclude_hv' would exclude L0 events
> > >   - 'exclude_host' would ... exclude L1-hv events?
> > >   - 'exclude_guest' would ... exclude G1 events?
> > 
> > So in arch/x86/events/intel/core.c we have:
> > 
> > static inline void intel_set_masks(struct perf_event *event, int idx)
> > {
> > 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > 
> > 	if (event->attr.exclude_host)
> > 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
> > 	if (event->attr.exclude_guest)
> > 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
> > 	if (event_is_checkpointed(event))
> > 		__set_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
> > }
> > 
> 
> exclude_host is now set by guest (pmc_reprogram_counter,
> arch/x86/kvm/pmu.c). When enabling the event, we can check exclude_host to
> know if it's a guest.
> 
> Otherwise we may need more flags in event->attr to indicate the status.
> 
> > which is, afaict, just plain wrong. Should that not be something like:
> > 
> > 	if (!event->attr.exclude_host)
> > 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
> > 	if (!event->attr.exclude_guest)
> > 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
> > 
> > 
> 
> How can we know it's guest or host even if exclude_host is set in guest?

I'm not following you, consider:

	xh	xg	h	g	h'	g'
	0	0	0	0	1	1
	0	1	1	0	1	0
	1	0	0	1	0	1
	1	1	1	1	0	0


So the 0,0 and 1,1 cases get flipped. I have a suspicion, but this
_really_ should have fat comments all over :-(

What a sodding trainwreck..
