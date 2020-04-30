Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B565CC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924BF2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588265121;
	bh=8Ei3F4eOoRqpaa7fs/fC4JcNYYhRrZ7GhNIqqYVS8hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lFw6Hag6e2OWoKHR1vJpsxrwtBz0Dq4ZSAyVrGwcTb7P7NL5vKpYO07ETzUjH8D1s
	 lSmyG8VCurCMlSB2bmc2ke9uiX/hdpYFWhHMM89tqpCww0fjrZpegqIkYHSy1Y7wBn
	 6HP1uGbznY7cuhGWEz+CkC5b4y3mh8tudNN6Rtbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgD3QpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgD3QpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:45:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C4092070B;
        Thu, 30 Apr 2020 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588265120;
        bh=8Ei3F4eOoRqpaa7fs/fC4JcNYYhRrZ7GhNIqqYVS8hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=liXRB4Ez5/7mwCxGidfN1vCb/UYI28M67EfS64G5GcjqtN5CEcAZ6uS0PKnMRBhO/
         cwiQXgViU+P+1Cfosg7/pAqtWIBbj2VOueaq9p33lZ6bORmHC4o7GR4xeOQraeH/bo
         1/Zgh5ToR19V2SwKj18fE+/mTf6+oKw5CcQggp64=
Date:   Thu, 30 Apr 2020 17:45:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20200430164513.GG25258@willie-the-truck>
References: <20200320093545.28227-1-leo.yan@linaro.org>
 <20200430145823.GA25258@willie-the-truck>
 <20200430162750.GD13575@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430162750.GD13575@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 06:27:50PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 30, 2020 at 03:58:24PM +0100, Will Deacon wrote:
> > On Fri, Mar 20, 2020 at 05:35:45PM +0800, Leo Yan wrote:
> > > +	/*
> > > +	 * Since arch timer is enabled ealier than sched clock registration,
> > > +	 * compuate the delta (in nanosecond unit) between the arch timer
> > > +	 * counter and sched clock, assign the delta to time_offset and
> > > +	 * perf tool can use it for timestamp calculation.
> > > +	 *
> > > +	 * The formula for conversion arch timer cycle to ns is:
> > > +	 *   quot = (cyc >> time_shift);
> > > +	 *   rem  = cyc & ((1 << time_shift) - 1);
> > > +	 *   ns   = quot * time_mult + ((rem * time_mult) >> time_shift);
> > > +	 */
> > > +	count = arch_timer_read_counter();
> > > +	quot = count >> shift;
> > > +	rem = count & ((1 << shift) - 1);
> > > +	ns = quot * userpg->time_mult + ((rem * userpg->time_mult) >> shift);
> > > +	userpg->time_offset = now - ns;
> > 
> > Hmm, reading the counter and calculating the delta feels horribly
> > approximate to me. It would be much better if we could get hold of the
> > initial epoch cycles from the point at which sched_clock was initialised
> > using the counter. This represents the true cycle delta between the counter
> > and what sched_clock uses for 0 ns.
> > 
> > Unfortunately, I can't see a straightforward way to grab that information.
> > It looks like x86 pulls this directly from the TSC driver.
> 
> Yeah, and I'm thinking you should do the same. IIRC ARM uses this
> kernel/time/sched_clock.c thing, and if I read that right, the struct
> clock_data there has all the bits you need here.
> 
> So I'm thinking that you might want to add a helper function here to get
> you the good stuff.

Thanks, Peter.

Leo -- do you think you could look at implementing this as part of a v2,
please?

Will
