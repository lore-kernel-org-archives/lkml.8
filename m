Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE10EC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6B1208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZzX7LHCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgD3Q2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgD3Q2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:28:18 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35237C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Vw+wahdjvF1L9WwGFComL+FFo9pmOmCPd10LrNq9mc=; b=ZzX7LHCyyRLB8grDlh2YaL6iZX
        YDBbj8zLivla/97BDbCy04qYZQnWj1cmxAEC3C5X9RX0hawZAD1nFHaPqizwf3Cwoq3pC0JDd3SLt
        5D3pS2RmdrUP55DKtBpPl05B2W31iTk2zcWq2V0FD8vVnlSsosluA0M1X8Xj4+qOydqUvz/Brcq/b
        5uoPSbIhO/MqXH7xVtjD2Lcr2rmqjxjU9SOAnYAzFardJnARybbMe83TuMaohsOYjO7UkUMBejJ+P
        2DFITMArkRnJUGx/0qV5FsUxAH0wqLa0GDk/aM5ywB3twmCQk2BdS78P10dCMX8N2WYbtnIGwTRah
        7KcUMFxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUC2S-0005Av-Dh; Thu, 30 Apr 2020 16:27:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 960AF30275A;
        Thu, 30 Apr 2020 18:27:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C55D203B5613; Thu, 30 Apr 2020 18:27:50 +0200 (CEST)
Date:   Thu, 30 Apr 2020 18:27:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <Al.Grant@arm.com>, James Clark <James.Clark@arm.com>,
        maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] arm64: perf_event: Fix time_offset for arch timer
Message-ID: <20200430162750.GD13575@hirez.programming.kicks-ass.net>
References: <20200320093545.28227-1-leo.yan@linaro.org>
 <20200430145823.GA25258@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430145823.GA25258@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 03:58:24PM +0100, Will Deacon wrote:
> On Fri, Mar 20, 2020 at 05:35:45PM +0800, Leo Yan wrote:

> > @@ -1164,5 +1165,21 @@ void arch_perf_update_userpage(struct perf_event *event,
> >  		userpg->time_mult >>= 1;
> >  	}
> >  	userpg->time_shift = (u16)shift;
> > -	userpg->time_offset = -now;
> > +
> > +	/*
> > +	 * Since arch timer is enabled ealier than sched clock registration,
> > +	 * compuate the delta (in nanosecond unit) between the arch timer
> > +	 * counter and sched clock, assign the delta to time_offset and
> > +	 * perf tool can use it for timestamp calculation.
> > +	 *
> > +	 * The formula for conversion arch timer cycle to ns is:
> > +	 *   quot = (cyc >> time_shift);
> > +	 *   rem  = cyc & ((1 << time_shift) - 1);
> > +	 *   ns   = quot * time_mult + ((rem * time_mult) >> time_shift);
> > +	 */
> > +	count = arch_timer_read_counter();
> > +	quot = count >> shift;
> > +	rem = count & ((1 << shift) - 1);
> > +	ns = quot * userpg->time_mult + ((rem * userpg->time_mult) >> shift);
> > +	userpg->time_offset = now - ns;
> 
> Hmm, reading the counter and calculating the delta feels horribly
> approximate to me. It would be much better if we could get hold of the
> initial epoch cycles from the point at which sched_clock was initialised
> using the counter. This represents the true cycle delta between the counter
> and what sched_clock uses for 0 ns.
> 
> Unfortunately, I can't see a straightforward way to grab that information.
> It looks like x86 pulls this directly from the TSC driver.

Yeah, and I'm thinking you should do the same. IIRC ARM uses this
kernel/time/sched_clock.c thing, and if I read that right, the struct
clock_data there has all the bits you need here.

So I'm thinking that you might want to add a helper function here to get
you the good stuff.
