Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0895C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB0322BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595466200;
	bh=hXwgOBRjwb6BauXj6qmh6y/MrRxjelEw1obb/ALt/rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z0cHJFVcl4dGapqso8MndWkmBn6wI11BmGADA/F6TyvC73QqG8gglSAFkLMNItg0Z
	 DtcT1fcIkp4oUTZv0344sNeKEvdn76j8gYyqUs2LTLKNpPnnDcWFMMnL8NC/vHZkj/
	 R373D6HpuLxCeIjJdEwcGRbCbjbE7ml0urrnFpDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbgGWBDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729401AbgGWBDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:03:18 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CB620888;
        Thu, 23 Jul 2020 01:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595466198;
        bh=hXwgOBRjwb6BauXj6qmh6y/MrRxjelEw1obb/ALt/rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r52q+CULBRQ1RtJQSEAtFwJaVMS0IYIj5BGW0Q+RNRXpVt3u2PMmW7EqCMXeOvSmV
         xfBB9aRiZk1Oc7SqX9aGHIxSlzr26nFKi3RzXp1fWedYLE+2243pX5cH0hS9vV3mlV
         mJVdjrQkbjALQar3n4urt0K2qyqX8gjVrc3inHOU=
Date:   Thu, 23 Jul 2020 03:03:15 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer
 timer handling to task_work
Message-ID: <20200723010314.GA28401@lenoir>
References: <20200716201923.228696399@linutronix.de>
 <20200716202044.734067877@linutronix.de>
 <20200716225034.GK5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716225034.GK5523@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:50:34AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 16, 2020 at 10:19:26PM +0200, Thomas Gleixner wrote:
> > +static void __run_posix_cpu_timers(struct task_struct *tsk)
> > +{
> > +	struct posix_cputimers *pct = &tsk->posix_cputimers;
> > +
> > +	if (!test_and_set_bit(CPUTIMERS_WORK_SCHEDULED, &pct->flags))
> > +		task_work_add(tsk, &pct->task_work, true);
> > +}
> > +
> > +static inline void posix_cpu_timers_enable_work(struct task_struct *tsk)
> > +{
> > +	clear_bit(CPUTIMERS_WORK_SCHEDULED, &tsk->posix_cputimers.flags);
> 	/*
> 	 * Ensure we observe everything before a failing test_and_set()
> 	 * in __run_posix_cpu_timers().
> 	 */
> 	smp_mb__after_atomic();
> > +}
> 
> Such that when another timer interrupt happens while we run this, we're
> guaranteed to either see it, or get re-queued and thus re-run the
> function.

But each thread in the process enqueues its own task work and flips its
own flags. So if task A runs the task work and task B runs __run_posix_cpu_timers(),
they wouldn't be ordering against the same flags.
