Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFCEC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D2D20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQEJM834"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgEEMge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728268AbgEEMge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:36:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 05:36:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q124so956603pgq.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w/fEb7wmLYkDbxMDezSBCU4Ren9d50vG/iM9aaRpbS0=;
        b=oQEJM834BwogYUc9rhkI95I0/motbe5R05CesRoSG6cYarzznuFgvfrg6YWn5YoS+K
         FFLsCInQDta1vhW7ibZduKm5rAJ3JuCZRHhkSP8K3EZDBOgD92GVraUIpjGZm/j1ZqNx
         ir2ec8SQKdLoXViB1isdvybaj9jkSaEfAPjCtVidkhyPj98w7jDapGDawhZtkx2pfDhu
         Bf6Ol459nYLV1ClZvU310TEdq1zVrqH9MJMlFwRNJRqQs2dUICyKkeoI9m8ZllFfe4XK
         1915DX/7dD1mRjn1Xzxu+0bG0eWvB4m9p3vncqNeYCx4ZSlrxJG4DNVp9F3v7dFAWQwC
         VOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w/fEb7wmLYkDbxMDezSBCU4Ren9d50vG/iM9aaRpbS0=;
        b=ZMLAve6CRUWcdyGw8xBDl9ztw/PXk5lBBFODs/zyNDqsXpY/sf87jfOSc8WAH5IbHD
         muYx7GU85ZdKjJGJ6c9gfg3Q0op8Hsg4k1R0lXfq1q+ZtOutUFxPWH+khn/OtsDqHMlz
         B5B6VDCF+jp7/32pzoxDz1kXsu6IGlbGrkGtFUvnNkCHfpfdzEHZHvXm7JJ6V2TTGija
         Rbg5w/cJGHz7pty6w2v8NycXsGADBlCEpn4+wJa1nJSDkB4LymilLjLgsCas7BtuD356
         Gig8lpRr61aNb2SCjOJ58PRZu75YxvU51M3KzareOimeyOKGWT5uKTB0HwF723zbCj4u
         rygA==
X-Gm-Message-State: AGi0PuZ+HHhcpghovY8Hk540hqZDDlD9rnMq+c9CPvOjJiVjDBMv09zi
        3MLOw7f1O1GCQyU5IWDtQvM=
X-Google-Smtp-Source: APiQypIvc3Jn4/QjZKCUJ+luWkMQucl1FOobVOTJnKE/y9R8h5evtBi29Cb1nFQzRJqPnyMBEa5Ckg==
X-Received: by 2002:a63:353:: with SMTP id 80mr601616pgd.371.1588682193482;
        Tue, 05 May 2020 05:36:33 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id g74sm1963978pfb.69.2020.05.05.05.36.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 05:36:32 -0700 (PDT)
Date:   Tue, 5 May 2020 20:36:28 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        iwtbavbm@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
Message-ID: <20200505123628.GA31542@iZj6chx1xj0e0buvshuecpZ>
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <jhjwo5sd0ft.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjwo5sd0ft.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 01:10:46AM +0100, Valentin Schneider wrote:
> 
> Hi,
> 
> On 03/05/20 09:34, Peng Liu wrote:
> > commit c5afb6a87f23 ("sched/fair: Fix nohz.next_balance update")
> 
> I got confused because this has the same topic as your patch, but that's a
> genuine commit from 2015. Is this meant to be a "Fixes:" reference?
> 

Ah, it was careless of me, that's a sane patch from Vincent, which I
referred when tracking the issue, but finally forgot to remove it from
changelog, not related to this patch.

> > During idle load balance, this_cpu(ilb) do load balance for the other
> > idle CPUs, also gather the earliest (nohz.)next_balance.
> >
> > Since commit:
> >   'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
> >
> > We update nohz.next_balance like this:
> >
> >   _nohz_idle_balance() {
> >       for_each_cpu(nohz.idle_cpus_mask) {
> >         rebalance_domains() {
> >                     update nohz.next_balance <-- compare and update
> >         }
> >       }
> >       rebalance_domains(this_cpu) {
> >         update nohz.next_balance <-- compare and update
> >       }
> >       update nohz.next_balance <-- unconditionally update
> >   }
> >
> > For instance, nohz.idle_cpus_mask spans {cpu2,3,5,8}, and this_cpu is
> > cpu5. After the above loop we could gather the earliest *next_balance*
> > among {cpu2,3,8}, then rebalance_domains(this_cpu) update
> > nohz.next_balance with this_rq->next_balance, but finally overwrite
> > nohz.next_balance with the earliest *next_balance* among {cpu2,3,8},
> > we may end up with not getting the earliest next_balance.
> >
> 
> That does look like it, nice catch!
> 
> > Since we can gather all the updated rq->next_balance, including this_cpu,
> > in _nohz_idle_balance(), it's safe to remove the extra lines in
> > rebalance_domains() which are originally intended for this_cpu. And
> > finally the updating only happen in _nohz_idle_balance().
> >
> 
> One added benefit of this is that we get rid of extra writes to
> nohz.next_balance, since that special case in rebalance_domains() could be
> hit by all NOHZ CPUs, not just the ILB.
> 
> With the below comment taken into account:
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> > Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > ---
> >  kernel/sched/fair.c | 24 ++++++++----------------
> >  1 file changed, 8 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 02f323b85b6d..1d0cf33fefad 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9943,22 +9943,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
> >        * When the cpu is attached to null domain for ex, it will not be
> >        * updated.
> >        */
> > -	if (likely(update_next_balance)) {
> > +	if (likely(update_next_balance))
> >               rq->next_balance = next_balance;
> > -
> > -#ifdef CONFIG_NO_HZ_COMMON
> > -		/*
> > -		 * If this CPU has been elected to perform the nohz idle
> > -		 * balance. Other idle CPUs have already rebalanced with
> > -		 * nohz_idle_balance() and nohz.next_balance has been
> > -		 * updated accordingly. This CPU is now running the idle load
> > -		 * balance for itself and we need to update the
> > -		 * nohz.next_balance accordingly.
> > -		 */
> > -		if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
> > -			nohz.next_balance = rq->next_balance;
> > -#endif
> > -	}
> >  }
> >
> >  static inline int on_null_domain(struct rq *rq)
> > @@ -10321,9 +10307,15 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >               has_blocked_load |= this_rq->has_blocked_load;
> >       }
> >
> > -	if (flags & NOHZ_BALANCE_KICK)
> > +	if (flags & NOHZ_BALANCE_KICK) {
> >               rebalance_domains(this_rq, CPU_IDLE);
> >
> > +		if (time_after(next_balance, this_rq->next_balance)) {
> > +			next_balance = this_rq->next_balance;
> > +			update_next_balance = 1;
> > +		}
> > +	}
> 
> To align with what we do for the other NOHZ CPUs, shouldn't this update
> be outside of the NOHZ_BALANCE_KICK condition? That way we can update
> nohz.next_balance with just NOHZ_STATS_KICK, which IMO is the expected
> course of action.
> 

I think I got your meaning, in _nohz_idle_balance():

  for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
      if (time_after_eq(jiffies, rq->next_balance)) {
	  if (flags & NOHZ_BALANCE_KICK)
	      rebalance_domains(rq, CPU_IDLE);
      }

      if (time_after(next_balance, rq->next_balance)) {
	  next_balance = rq->next_balance;
	  update_next_balance = 1;
      }
  }

nohz.next_balance is the earliest next_balance, so some rqs'
next_balance may be not due, some are due and updated, so we need
take all of them into consideration.

In NOHZ_STAT_KICK case, all rq don't go through rebalance_domains(),
their next_balance are supposed to be unchanged, including this_rq,
so we can safely left nohz.next_balance unchanged.

Thanks for your time!

> > +
> >       WRITE_ONCE(nohz.next_blocked,
> >               now + msecs_to_jiffies(LOAD_AVG_PERIOD));
