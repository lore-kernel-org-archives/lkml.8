Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD486C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718BC2137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588353241;
	bh=R0ki2wvkvI2qui/yAMaKz5ZcbVfyz67MBU2R+c/6MuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ns6qbWO5GAc9/t8LizOywkDetlUtRqHR0Hqih1NNvP6gcLwJE9sEq0DY5WfGmGxqH
	 Zd9FLJZ47/FSlQO3n83YCfj2lQk3oFO+G5lhw9Um6ckFOcgX/NByHdVyCVoDNw4+KI
	 f1gl9kC4Be3c3y2fDgF9Xt/ua2cR9RFahA3Vq79E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgEAROA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbgEAROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:14:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E11320857;
        Fri,  1 May 2020 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588353239;
        bh=R0ki2wvkvI2qui/yAMaKz5ZcbVfyz67MBU2R+c/6MuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ByLudkkNaIRn0Vwk82fzw+Xu8DhfezjKR4Vhj5u/163f7MwbSAWySSMaOWTZHAbx6
         Fto9cQbRjrZ7LL55Y5XUeJCtDZPWAX5Rb6gUwwFd2CLItjr4lxC+XztE+J1GVVx3o0
         prq1YS2q5dSif5OxN+aCai4P81kQ9B7wF3Urz1mQ=
Date:   Fri, 1 May 2020 18:13:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
        tglx@linutronix.de
Subject: Re: [PATCH] arm64: perf_event: Fix time_offset for arch timer
Message-ID: <20200501171353.GB19048@willie-the-truck>
References: <20200320093545.28227-1-leo.yan@linaro.org>
 <20200430145823.GA25258@willie-the-truck>
 <4d924f705245c797a19d3a73eb0c1ba0@kernel.org>
 <20200430160436.GC13575@hirez.programming.kicks-ass.net>
 <20200430161815.GE25258@willie-the-truck>
 <20200501151448.GA9650@leoy-ThinkPad-X240s>
 <20200501152609.GA17646@willie-the-truck>
 <20200501161050.GA16001@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501161050.GA16001@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 12:10:50AM +0800, Leo Yan wrote:
> On Fri, May 01, 2020 at 04:26:09PM +0100, Will Deacon wrote:
> 
> [...]
> 
> > > > > Let me try and understand your particular problem better.
> > > > 
> > > > I think the long and short of it is that userspace needs a way to convert
> > > > the raw counter cycles into a ns value that can be compared against values
> > > > coming out of sched_clock. To do this accurately, I think it needs the
> > > > cycles value at the point when sched_clock was initialised.
> > > 
> > > Will's understanding is exactly what I want to resolve in this patch.
> > > 
> > > The background info is for the ARM SPE [1] decoding with perf tool, if
> > > the timestamp is enabled, it uses the generic timer's counter as
> > > timestamp source.  SPE trace data only contains the raw counter cycles,
> > > as Will mentioned, the perf tool needs to convert it to a coordinate
> > > value with sched_clock.  This is why this patch tries to calculate the
> > > offset between the raw counter's ns value and sched_clock, eventually
> > > this offset value will be used by SPE's decoding code in Perf tool to
> > > calibrate a 'correct' timestamp.
> > > 
> > > Based on your suggestions, I will use __sched_clock_offset to resolve
> > > the accuracy issue in patch v2.  (I noticed Peter suggested to use a
> > > new API for wrapping clock_data structure, IIUC, __sched_clock_offset
> > > is more straightforward for this case).
> > > 
> > > Please correct if I miss anything.  Thank you for reviewing and
> > > suggestions!
> > 
> > I don't think you can use __sched_clock_offset without selecting
> > HAVE_UNSTABLE_SCHED_CLOCK, and we really don't want to do that just
> > for this. So Peter's idea about exposing what we need is better, although
> > you'll probably need to take care with the switch-over from jiffies.
> > 
> > It needs some thought, but one possibility would be to introduce a new
> > variant of sthe ched_clock_register() function that returns the cycle
> > offset, and then we could fish that out of the timer driver.
> 
> Thanks a lot for you and Marc for correction.
> 
> > If we're
> > crossing all the 'i's and dotting all the 't's then we'd want to disable the
> > perf userpage if sched_clock changes clocksource too (a bit like we do for
> > the vDSO).
> 
> To be honest, one thing is not clear for me is how the perf tool to
> update the arch timer's parameters in the middle of tracing after
> disable and re-enable per userpage.  I will note for this and look
> into detailed implementation for this part.

I don't fully understand the concern but, generally, the seqlock should
take care of any inconsistencies in the data page.

Will
