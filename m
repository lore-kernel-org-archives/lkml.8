Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A14C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EB720873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588260567;
	bh=dgQA/4On+n7VHC1DGfgnLp05UUwbTrTUYS65MyEuRns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HhgfeZFZxNtnfFsr+7bJgS979BNHOgtFp0zDUpJy3XQHhWBEovA3RPwfQlid3V3ef
	 HfNoGQKvwZJMGrQh3gNEa8u8tNzbKP+t8AAmL2mh8ObzjWk3cJSfvF5Ab5YcYHtcLa
	 lTPsjoX/J3sDL8eK0nQMyZVQB+dcKDF5OZs5y7EM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgD3P30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgD3P30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:29:26 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B842076D;
        Thu, 30 Apr 2020 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588260565;
        bh=dgQA/4On+n7VHC1DGfgnLp05UUwbTrTUYS65MyEuRns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u8+pQxBqZB9tBYafiEXKENzsUMN/05IUeilOMCwXlBIvnMiDBeMDwO0o9zWaJFZL1
         Z3C2o0pVPeIe+gei6XloGdqKyMtmgezSxLk8HyTVv/bcIdJ6xTsK6tkdLZCTzmc8AT
         1rvwSojiSdXVRVtDJmzhgp3N7wgRjQqm5CXKhtYI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jUB7r-0085xF-RK; Thu, 30 Apr 2020 16:29:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Apr 2020 16:29:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <20200430145823.GA25258@willie-the-truck>
References: <20200320093545.28227-1-leo.yan@linaro.org>
 <20200430145823.GA25258@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <4d924f705245c797a19d3a73eb0c1ba0@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, leo.yan@linaro.org, mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, mike.leach@linaro.org, Al.Grant@arm.com, James.Clark@arm.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-30 15:58, Will Deacon wrote:
> Hi Leo,
> 
> [+Maz and tglx in case I'm barking up the wrong tree]
> 
> On Fri, Mar 20, 2020 at 05:35:45PM +0800, Leo Yan wrote:
>> Between the system powering on and kernel's sched clock registration,
>> the arch timer usually has been enabled at the early time and its
>> counter is incremented during the period of the booting up.  Thus the
>> arch timer's counter is not completely accounted into the sched clock,
>> and has a delta between the arch timer's counter and sched clock.  
>> This
>> delta value should be stored into userpg->time_offset, which later can
>> be retrieved by Perf tool in the user space for sample timestamp
>> calculation.
>> 
>> Now userpg->time_offset is assigned to the negative sched clock with
>> '-now', this value cannot reflect the delta between arch timer's 
>> counter
>> and sched clock, so Perf cannot use it to calculate the sample time.
>> 
>> To fix this issue, this patch calculate the delta between the arch
>> timer's and sched clock and assign the delta to userpg->time_offset.
>> The detailed steps are firstly to convert counter to nanoseconds 'ns',
>> then the offset is calculated as 'now' minus 'ns'.
>> 
>>         |<------------------- 'ns' ---------------------->|
>>                                 |<-------- 'now' -------->|
>>         |<---- time_offset ---->|
>>         |-----------------------|-------------------------|
>>         ^                       ^                         ^
>>   Power on system     sched clock registration      Perf starts
> 
> FWIW, I'm /really/ struggling to understand the problem here.
> 
> If I've grokked it correctly (big 'if'), then you can't just factor in
> what you call "time_offset" in the diagram above, because there isn't
> a guarantee that the counter is zero-initialised at the start.

Even if it was, we have no idea of *when* that was. Think kexec, for a
start. Or spending some variable in firmware because of $REASON.

> 
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> ---
>>  arch/arm64/kernel/perf_event.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/kernel/perf_event.c 
>> b/arch/arm64/kernel/perf_event.c
>> index e40b65645c86..226d25d77072 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -1143,6 +1143,7 @@ void arch_perf_update_userpage(struct perf_event 
>> *event,
>>  {
>>  	u32 freq;
>>  	u32 shift;
>> +	u64 count, ns, quot, rem;
>> 
>>  	/*
>>  	 * Internal timekeeping for enabled/running/stopped times
>> @@ -1164,5 +1165,21 @@ void arch_perf_update_userpage(struct 
>> perf_event *event,
>>  		userpg->time_mult >>= 1;
>>  	}
>>  	userpg->time_shift = (u16)shift;
>> -	userpg->time_offset = -now;
>> +
>> +	/*
>> +	 * Since arch timer is enabled ealier than sched clock registration,
>> +	 * compuate the delta (in nanosecond unit) between the arch timer
>> +	 * counter and sched clock, assign the delta to time_offset and
>> +	 * perf tool can use it for timestamp calculation.
>> +	 *
>> +	 * The formula for conversion arch timer cycle to ns is:
>> +	 *   quot = (cyc >> time_shift);
>> +	 *   rem  = cyc & ((1 << time_shift) - 1);
>> +	 *   ns   = quot * time_mult + ((rem * time_mult) >> time_shift);
>> +	 */
>> +	count = arch_timer_read_counter();
>> +	quot = count >> shift;
>> +	rem = count & ((1 << shift) - 1);
>> +	ns = quot * userpg->time_mult + ((rem * userpg->time_mult) >> 
>> shift);
>> +	userpg->time_offset = now - ns;
> 
> Hmm, reading the counter and calculating the delta feels horribly
> approximate to me. It would be much better if we could get hold of the
> initial epoch cycles from the point at which sched_clock was 
> initialised
> using the counter. This represents the true cycle delta between the 
> counter
> and what sched_clock uses for 0 ns.

I think this is a sensible solution if you want an epoch that starts at 
0 with
sched_clock being initialized. The other question is whether it is 
possible to
use a different timestamping source for perf that wouldn't need to be 
offset.

> Unfortunately, I can't see a straightforward way to grab that 
> information.
> It looks like x86 pulls this directly from the TSC driver.

I wonder if we could/should make __sched_clock_offset available even 
when
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK isn't defined. It feels like it would
help with this particular can or worm...

         M.
-- 
Jazz is not dead. It just smells funny...
