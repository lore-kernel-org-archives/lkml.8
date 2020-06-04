Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A471DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0C7207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591280248;
	bh=I/yRg+bsP+cNSTc4qUwZLr6xT+q1LIQeHuYrZkUYQDQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=LZPGwcEVrn9ro5I7II2mKkt7mzoTUIR8r/nFXN2MPEfH1mkMEIX49ZShLTFGGtmDj
	 At6ltBGP6oTb35pZcBnBGf0MeXUxnoaf4RWUmhI3GNmkkzKQfJxwee1MD8WUlb69Ka
	 AtNiQGVSJmZdBCiKTGayenYPe8EaxKuHeYn3TyqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgFDOR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgFDOR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:17:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D86920663;
        Thu,  4 Jun 2020 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591280246;
        bh=I/yRg+bsP+cNSTc4qUwZLr6xT+q1LIQeHuYrZkUYQDQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EdPxM+570FQebvv1nWIopmvMhUQ4lvRtII1Q8pz8N/VDyiE8nwtwY15/MsZc1X0C0
         1tSNOiD11PO573Bg0Eg7gMeTRurC7YP5yq4OsNb8oJMBPwnzkt2W8sYWdKf0F2GZad
         tfayAewJuV4uWfDfPDLfVgvKKoaUoPe2sDzurJXY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8558935228BC; Thu,  4 Jun 2020 07:17:26 -0700 (PDT)
Date:   Thu, 4 Jun 2020 07:17:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200604141726.GZ29598@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200603164600.GQ29598@paulmck-ThinkPad-P72>
 <20200603171320.GE2570@hirez.programming.kicks-ass.net>
 <20200604033409.GX29598@paulmck-ThinkPad-P72>
 <20200604080512.GA2587@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604080512.GA2587@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 10:05:12AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 03, 2020 at 08:34:09PM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 03, 2020 at 07:13:20PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 03, 2020 at 09:46:00AM -0700, Paul E. McKenney wrote:
> 
> > > > > @@ -313,7 +313,7 @@ static __always_inline bool rcu_dynticks
> > > > >  {
> > > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > > >  
> > > > > -	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> > > > > +	return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> > > 
> > > The above is actually instrumented by KCSAN, due to arch_atomic_read()
> > > being a READ_ONCE() and it now understanding volatile.
> > > 
> > > > Also instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks)) as
> > 
> > Right, this should instead be instrument_read(...).
> > 
> > Though if KCSAN is unconditionally instrumenting volatile, how does
> > this help?  Or does KCSAN's instrumentation of volatile somehow avoid
> > causing trouble?
> 
> As Marco already explained, when used inside noinstr no instrumentation
> will be emitted, when used outside noinstr it will emit the right
> instrumentation.
> 
> > > > o	In theory in rcu_irq_exit_preempt(), but as this generates code
> > > > 	only in lockdep builds, it might not be worth worrying about.
> > > > 
> > > > o	Ditto for rcu_irq_exit_check_preempt().
> > > > 
> > > > o	Ditto for __rcu_irq_enter_check_tick().
> > > 
> > > Not these, afaict they're all the above arch_atomic_read(), which is
> > > instrumented due to volatile in these cases.
> 
> I this case, the above call-sites are all not noinstr (double negative!)
> and will thus cause instrumentation to be emitted.
> 
> This is all a 'special' case for arch_atomic_read() (and _set()),
> because they're basically READ_ONCE() (and WRITE_ONCE() resp.). The
> normal atomics are asm() and it doesn't do anything for those (although
> I suppose clang could, since it has this internal assembler to parse the
> inline asm, but afaiu that's not something GCC ever wants to do).

Got it, and I had missed the inlining.

Again, commenting this will be interesting.  And your earlier comment
about the compiler refusing to inline now makes sense...

							Thanx, Paul
