Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A239C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577D620730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgAPNjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:39:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51742 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAPNjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:39:41 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is5Mx-0008HQ-E0; Thu, 16 Jan 2020 14:39:31 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 18EF5101B66; Thu, 16 Jan 2020 14:39:31 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/3] watchdog/softlockup: Report the overall time of softlockups
In-Reply-To: <20191024114928.15377-3-pmladek@suse.com>
References: <20191024114928.15377-1-pmladek@suse.com> <20191024114928.15377-3-pmladek@suse.com>
Date:   Thu, 16 Jan 2020 14:39:31 +0100
Message-ID: <8736cfwmek.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr,

Petr Mladek <pmladek@suse.com> writes:
> -	if (touch_ts == 0) {
> +	/* Was the watchdog touched externally by a known slow code? */
> +	if (period_ts == 0) {
>  		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
>  			/*
>  			 * If the time stamp was touched atomically
> @@ -394,7 +405,12 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  
>  		/* Clear the guest paused flag on watchdog reset */
>  		kvm_check_and_clear_guest_paused();
> -		__touch_watchdog();
> +		/*
> +		 * The above kvm*() function could touch the watchdog.
> +		 * Set the real timestamp later to avoid an infinite
>  		loop.

This comment makes no sense whatsoever. If period_ts is 0,
i.e. something invoked touch_softlockup_watchdog*() then it does not
make any difference whether the kvm function invokes one of those
functions once more. The result is the same. The per cpu period_ts is
still 0.

The point is that _AFTER_ a intentional watchdog reset, the reporting
base time needs to be set to now() in order to make it functional again.

> +		 */
> +		reset_report_period_ts();

Btw, the function name is misleading. I got confused several times
because I expected the reset to set the timestamp to 0, which is not the
case. update_report_period_ts() is far more intuitive.

> @@ -404,8 +420,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  	 * indicate it is getting cpu time.  If it hasn't then
>  	 * this is a good indication some task is hogging the cpu
>  	 */
> -	duration = is_softlockup(touch_ts);
> +	duration = is_softlockup(touch_ts, period_ts);
>  	if (unlikely(duration)) {

This lacks a comment. Your changelog paragraph:

 > Also the timestamp should get reset explicitly. It is done also by the code
 > printing the backtrace. But it is just a side effect and far from
 > obvious.

is probably referring to this, but it confused me more than it helped
simply because the update of the timestamp happens unconditionally even
when the backtrace code is not reached due to the KVM check

So this is a change vs. the current implementation which is not
documented and explained.

> +		reset_report_period_ts();
>  		/*
>  		 * If a virtual machine is stopped by the host it can look to
>  		 * the watchdog like a soft lockup, check to see if the host

Thanks,

        tglx
