Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4098C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D152074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zIBWk+4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgG1NoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbgG1NoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:44:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA3FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mUjI21PfdGbJqznXKz6eDDRzmbMl77dKG/X1NGmjf5k=; b=zIBWk+4gHAK/rpRWW0yzYbaO6y
        slsNV2S7ol+vTIKyRrEXQhlC+KWibRmDBKqAeTssNl0IrjqIPH0MFfs7CQG8bA6HtXhv/Jx0oSWYX
        44TDAZTJawUbVCCKvzZt5qC+J0wmVkq72beLCgpY2fdV2l261fzcX28sZrbBU04RgfUhg0mPkDbS/
        yyJaFQe6hhq9erqDYE4mK1oeylCqWUXR96cHguRh8wIa9O5m0aAKRYyxNAbQhktL3S43+U6/Xrdqx
        tiWjGoXqxQFxbmZ+FfpD1wy7QJ3IjWQyb/l2Ow8L5Vwom0vrI415prN1DQYsxYmTVzCPMBveh/owL
        O3YaKcpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0Ptw-0001U8-LC; Tue, 28 Jul 2020 13:44:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08B3C3013E5;
        Tue, 28 Jul 2020 15:44:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4EBB2B7AB914; Tue, 28 Jul 2020 15:44:12 +0200 (CEST)
Date:   Tue, 28 Jul 2020 15:44:12 +0200
From:   peterz@infradead.org
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 08/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
Message-ID: <20200728134412.GX119549@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-9-kan.liang@linux.intel.com>
 <20200724131906.GW119549@hirez.programming.kicks-ass.net>
 <20200724152755.GK43129@hirez.programming.kicks-ass.net>
 <d7ae2272-52ea-c5a9-2937-9a51c544ade8@linux.intel.com>
 <ddeae082-c38d-a961-4d90-1fbc1c9f2726@linux.intel.com>
 <20200728130956.GK10769@hirez.programming.kicks-ass.net>
 <25a630c6-2fa2-5dfd-bcd3-92e809c51d61@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a630c6-2fa2-5dfd-bcd3-92e809c51d61@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 09:28:39AM -0400, Liang, Kan wrote:
> 
> 
> On 7/28/2020 9:09 AM, Peter Zijlstra wrote:
> > On Fri, Jul 24, 2020 at 03:10:52PM -0400, Liang, Kan wrote:
> > 
> > > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > > index 6cb079e0c9d9..010ac74afc09 100644
> > > --- a/arch/x86/events/intel/core.c
> > > +++ b/arch/x86/events/intel/core.c
> > > @@ -2405,27 +2405,18 @@ static u64 icl_update_topdown_event(struct
> > > perf_event *event)
> > >   	return slots;
> > >   }
> > > 
> > > -static void intel_pmu_read_topdown_event(struct perf_event *event)
> > > +static void intel_pmu_read_event(struct perf_event *event)
> > >   {
> > > -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > > -
> > > -	/* Only need to call update_topdown_event() once for group read. */
> > > -	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
> > > -	    !is_slots_event(event))
> > >   		return;
> > > 
> > > -	perf_pmu_disable(event->pmu);
> > > -	x86_pmu.update_topdown_event(event);
> > > -	perf_pmu_enable(event->pmu);
> > > -}
> > > -
> > > -static void intel_pmu_read_event(struct perf_event *event)
> > > -{
> > >   	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
> > >   		intel_pmu_auto_reload_read(event);
> > > -	else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
> > > -		intel_pmu_read_topdown_event(event);
> > > -	else
> > > +	else if (is_slots_count(event) && x86_pmu.update_topdown_event) {
> > > +		perf_pmu_disable(event->pmu);
> > > +		x86_pmu.update_topdown_event(event);
> > > +		perf_pmu_enable(event->pmu);
> > > +	} else
> > >   		x86_perf_event_update(event);
> > >   }
> > 
> > I'm a little puzzled by this; what happens if you:
> > 
> > 	fd = sys_perf_event_open(&attr_slots);
> > 	fd1 = sys_perf_event_open(&attr_metric, .group_fd=fd);
> > 
> > 	read(fd1);
> > 
> > ?
> > 
> 
> I did a quick test. It depends on the .read_format of attr_metric.
> If PERF_FORMAT_GROUP is applied for attr_metric, perf_read_group() will be
> invoked. The value of fd1 is updated correctly.
> If the flag is not applied, 0 will be returned.

Exactly :-), was that intentional? Because prior to this change that
would've worked just fine.

Now, I agree it's a daft thing, because that value is pretty useless
without also having the slots value, but I feel we should be explicit in
our choices here.

If for example, we would've had hardware provide us the raw metric
counters, instead of us having to reconstruct them, this would've been a
semi useful thing.

So I'm tempted to leave things as it, and keep this 'working'.
