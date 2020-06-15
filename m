Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFD620739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592261892;
	bh=3RZxhMnl4EirW5H1xWg330yp9hvzqyIsffDCw/WB4YE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=b95mls2WAxCvQ66YDzhJ9NRkZ7DwPulvdNwpu7v53ptEPD7d5j7Zvi96q2XDLNhTp
	 Nn/JLMynNewV21+t6pu5fdaLSyVFz6ijCDOPYtcy0vK5MHLEuEJK8fa4NBGZuYZFjC
	 MM4MWA3kfH5PNfTLLQ03C+iUmQBgAzZZYPuS+xEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFOW6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOW6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:58:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D889206B7;
        Mon, 15 Jun 2020 22:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592261890;
        bh=3RZxhMnl4EirW5H1xWg330yp9hvzqyIsffDCw/WB4YE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fg3pyw4IELe9u4nyPspGTlYUn/jR2Bkgyz0cO7TLnrjJj+fpU9Wd2xQFWXLMGiA7y
         khsVF2WAEFgyzNuGc/19pTNoamwxSW+3FFKz6TXHXlQ4ja39Nbn5FtbhiV+bWa/Z3A
         UK6Wx9tpd9b07Of64C8zH0nVB8eWRVFW6jsVCmcI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 33F3035218F0; Mon, 15 Jun 2020 15:58:10 -0700 (PDT)
Date:   Mon, 15 Jun 2020 15:58:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org
Subject: Re: [PATCH 1/6] sched: Fix ttwu_queue_cond()
Message-ID: <20200615225810.GA8492@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200615125654.678940605@infradead.org>
 <20200615131143.130326165@infradead.org>
 <20200615133409.GS2531@hirez.programming.kicks-ass.net>
 <20200615164541.GH2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615164541.GH2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 09:45:41AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 15, 2020 at 03:34:09PM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 15, 2020 at 02:56:55PM +0200, Peter Zijlstra wrote:
> > > Where the condition:
> > > 
> > >   !cpus_share_cache(smp_processor_id(), cpu)
> > > 
> > > already implies 'cpu != smp_processor_id()', because a CPU always
> > > shares cache with itself, the secondary condition added in commit:
> > > 
> > >   2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> > > 
> > > voids that implication, resulting in attempting to do local wake-ups
> > > through the queue mechanism.
> > > 
> > > Fixes: 2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> > > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/sched/core.c |   13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > 
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -2356,11 +2356,22 @@ bool cpus_share_cache(int this_cpu, int
> > >  
> > >  static inline bool ttwu_queue_cond(int cpu, int wake_flags)
> > >  {
> > > +	int this_cpu = smp_processor_id();
> > > +
> > > +	/*
> > > +	 * Only ever queue for remote wakeups. The on_cpu case can only ever
> > > +	 * happen remotely, and for the normal case it makes no sense to
> > 
> > The 'funny' thing here is, that this must be false for this patch to
> > make any difference.. I just cannot see how.
> > 
> > Also, if this is false, and p->on_cpu == 1 and p->cpu == this_cpu, then
> > p _should_ be current, in which case we should never get here either,
> > due to the 'p == current' special case in try_to_wake_up().
> > 
> > The only other option is that 'p == next', but then we'd be doing
> > wakeups from the middle of __schedule() and seems 'unlikely' too, esp.
> > so since none of the actual stack-traces we have shows that.
> > 
> > So colour me terribly confused.
> 
> I am rerunning with your patch 2 on the last bisection point that
> resulted in scheduler NULL dereferences despite having your patch.
> Hopefully some illumination will result...

No, Mr. Murphy is out in force.  I saw only the NULL pointer
dereferences without any WARN()s.  :-/

						Thanx, Paul

> > > +	 * involve IPIs here, and would be broken, as many architectures cannot
> > > +	 * trivially IPI self in any case.
> > > +	 */
> > > +	if (cpu == this_cpu)
> > > +		return false;
