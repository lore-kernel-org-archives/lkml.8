Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EA4C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4A12173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588346971;
	bh=BiaWkAPgA0GLt1tEbeDkv1hr7hG/llksm5RVX/awIaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wopGdRRdi5mOdxInHYKQZaG8DXnbYrXWl7Oz5NnRm8kRCgOTsjsdM/ecio/gCshh4
	 Efd56QSMVAPBZFhYQjYPpqsUXgcC7S6LqmYjNi9tY9BM6ysyu4RfsUa/7nyd2MHraA
	 jbxSaCr9AnoJiAUUOooMlQNiWY3bmhHorNqZJb7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgEAP3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbgEAP3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:29:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E0F2208DB;
        Fri,  1 May 2020 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588346969;
        bh=BiaWkAPgA0GLt1tEbeDkv1hr7hG/llksm5RVX/awIaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fTopjtskcJ+65zpfrHDcfgi3/QGj3Rt+Vu3Un2/YqHQ0FUWBf7bpEH7FHr5m/8bb6
         KtC+R40FsjCuySsq694mUXVehB08JHPAEP9kXeGWlge4BHVPfWdpCMCLJFWjiPalK2
         CJ6OoILoqbIPGMTsrXmIWpEK7KLIIUvPZlZWtCis=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jUXbT-008P6M-VA; Fri, 01 May 2020 16:29:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 May 2020 16:29:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <20200501151448.GA9650@leoy-ThinkPad-X240s>
References: <20200320093545.28227-1-leo.yan@linaro.org>
 <20200430145823.GA25258@willie-the-truck>
 <4d924f705245c797a19d3a73eb0c1ba0@kernel.org>
 <20200430160436.GC13575@hirez.programming.kicks-ass.net>
 <20200430161815.GE25258@willie-the-truck>
 <20200501151448.GA9650@leoy-ThinkPad-X240s>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <0a74ba5e82a41dca0a4156f2039e6be6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: leo.yan@linaro.org, will@kernel.org, peterz@infradead.org, mark.rutland@arm.com, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, mike.leach@linaro.org, Al.Grant@arm.com, James.Clark@arm.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-01 16:14, Leo Yan wrote:
> Hi all,
> 
> On Thu, Apr 30, 2020 at 05:18:15PM +0100, Will Deacon wrote:
>> On Thu, Apr 30, 2020 at 06:04:36PM +0200, Peter Zijlstra wrote:
>> > On Thu, Apr 30, 2020 at 04:29:23PM +0100, Marc Zyngier wrote:
>> >
>> > > I wonder if we could/should make __sched_clock_offset available even when
>> > > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK isn't defined. It feels like it would
>> > > help with this particular can or worm...
>> >
>> > Errrgh. __sched_clock_offset is only needed on x86 because we transition
>> > from one clock device to another on boot. It really shouldn't exist on
>> > anything sane.
>> 
>> I think we still transition from jiffies on arm64, because we don't 
>> register
>> with sched_clock until the timer driver probes. Marc, is that right?
>> 
>> > Let me try and understand your particular problem better.
>> 
>> I think the long and short of it is that userspace needs a way to 
>> convert
>> the raw counter cycles into a ns value that can be compared against 
>> values
>> coming out of sched_clock. To do this accurately, I think it needs the
>> cycles value at the point when sched_clock was initialised.
> 
> Will's understanding is exactly what I want to resolve in this patch.
> 
> The background info is for the ARM SPE [1] decoding with perf tool, if
> the timestamp is enabled, it uses the generic timer's counter as
> timestamp source.  SPE trace data only contains the raw counter cycles,
> as Will mentioned, the perf tool needs to convert it to a coordinate
> value with sched_clock.  This is why this patch tries to calculate the
> offset between the raw counter's ns value and sched_clock, eventually
> this offset value will be used by SPE's decoding code in Perf tool to
> calibrate a 'correct' timestamp.
> 
> Based on your suggestions, I will use __sched_clock_offset to resolve
> the accuracy issue in patch v2.  (I noticed Peter suggested to use a
> new API for wrapping clock_data structure, IIUC, __sched_clock_offset
> is more straightforward for this case).

I think Peter's point was *not* to use __sched_clock_offset which
appears to be only there for the purpose of an x86 workaround (and not
available to other architecture), but to instead expose the relevant
field (epoch_cyc) to the perf subsystem.

I feel it makes sense to make this a generic API, and see whether x86
can move over to it rather than the other way around.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
