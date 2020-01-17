Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CE1C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371F02073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgAQKAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:00:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:50436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgAQKAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:00:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E0F2CB49D;
        Fri, 17 Jan 2020 10:00:38 +0000 (UTC)
Date:   Fri, 17 Jan 2020 11:00:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog/softlockup: Report the overall time of
 softlockups
Message-ID: <20200117100037.6aahy7gwmrxb5ybg@pathway.suse.cz>
References: <20191024114928.15377-1-pmladek@suse.com>
 <20191024114928.15377-3-pmladek@suse.com>
 <8736cfwmek.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736cfwmek.fsf@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-01-16 14:39:31, Thomas Gleixner wrote:
> Petr,
> 
> Petr Mladek <pmladek@suse.com> writes:
> > -	if (touch_ts == 0) {
> > +	/* Was the watchdog touched externally by a known slow code? */
> > +	if (period_ts == 0) {
> >  		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
> >  			/*
> >  			 * If the time stamp was touched atomically
> > @@ -394,7 +405,12 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >  
> >  		/* Clear the guest paused flag on watchdog reset */
> >  		kvm_check_and_clear_guest_paused();
> > -		__touch_watchdog();
> > +		/*
> > +		 * The above kvm*() function could touch the watchdog.
> > +		 * Set the real timestamp later to avoid an infinite
> >  		loop.
> 
> This comment makes no sense whatsoever. If period_ts is 0,
> i.e. something invoked touch_softlockup_watchdog*() then it does not
> make any difference whether the kvm function invokes one of those
> functions once more. The result is the same. The per cpu period_ts is
> still 0.
>
> The point is that _AFTER_ a intentional watchdog reset, the reporting
> base time needs to be set to now() in order to make it functional again.

Exactly. I think that my comment is just confusing. I wanted to say
that the order was important.

It was not obvious to me that kvm_check_and_clear_guest_paused() cleared
perior_ts and must be called before update_report_period_ts(). I spent
some time with debugging why the reshufled code stopped working ;-)

What about the following?

		/*
		 * Clear the guest paused flag on watchdog. Might clear
		 *  report_period_ts.
		 */
		kvm_check_and_clear_guest_paused();

		update_report_period_ts();


> > +		 */
> > +		reset_report_period_ts();
> 
> Btw, the function name is misleading. I got confused several times
> because I expected the reset to set the timestamp to 0, which is not the
> case. update_report_period_ts() is far more intuitive.

Sounds good.


> > @@ -404,8 +420,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >  	 * indicate it is getting cpu time.  If it hasn't then
> >  	 * this is a good indication some task is hogging the cpu
> >  	 */
> > -	duration = is_softlockup(touch_ts);
> > +	duration = is_softlockup(touch_ts, period_ts);
> >  	if (unlikely(duration)) {
> 
> This lacks a comment. Your changelog paragraph:
> 
>  > Also the timestamp should get reset explicitly. It is done also by the code
>  > printing the backtrace. But it is just a side effect and far from
>  > obvious.
> 
> is probably referring to this, but it confused me more than it helped
> simply because the update of the timestamp happens unconditionally even
> when the backtrace code is not reached due to the KVM check

Where is the timestamp updated unconditionaly, please?

I found that it happens, for example, in printk_stack_address() that
is hidden "deep" in show_stack().

> So this is a change vs. the current implementation which is not
> documented and explained.

To me, it looks obvious to reset/update the period when the current
period ended and we are about to report softlockup.

OK, it might create wrong assumtion that the updated timestamp will
really get used. It is not true because it will get reset inside
the above mentioned show_stack(). But is it really guaranteed
that the watchdog will be touched there?

IMHO, the explicit call makes the code more reliable and easier
to understand. The hidden touch() might get re(moved) at any time.


> > +		reset_report_period_ts();
> >  		/*
> >  		 * If a virtual machine is stopped by the host it can look to
> >  		 * the watchdog like a soft lockup, check to see if the host

Thanks a lot for review.

Best Regards,
Petr

PS: I will have only limited internet connection the following week.
