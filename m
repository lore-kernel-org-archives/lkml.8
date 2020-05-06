Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EACC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE82D20575
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S4xNE+we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgEFPdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgEFPdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:33:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A9C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lme/OHCDKaTvQilYulAnBaa3XspyzQjK0vnc/3tR71k=; b=S4xNE+wem0lD8NUnLf5v06iI5m
        6hFl0NKoouPt2/SfRyEdGv1UlkCBWS+KXb7YGWv1i5VNiJSVJrf8mfsX0uUiKsbH+1s/HKYtRYztv
        f4UTw6/zZcEX6Opg0UH3wWv5Ck8kA0gzFNacltHTwFtNgSdDXyuz4X10WjJJvva1M4EztL8Htb+U3
        Zw1Zab/QL7R0cnVXq1yT8CwDwGBuE2EuTiWwhG6bn1hmn/0tcl2LObnrhOyni5Nb5NDsd7dU7HbnO
        wOSIzT07upN3HQQ1+h3yMkRXB8g2TP2X8jD84hrROAXf22n96gK7F5FUtjXIq7g8eLzOIpbXarWtI
        sJnU/u+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWM2h-0006PU-IO; Wed, 06 May 2020 15:33:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2509D301EE3;
        Wed,  6 May 2020 17:33:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBFA6203ECDC2; Wed,  6 May 2020 17:33:00 +0200 (CEST)
Date:   Wed, 6 May 2020 17:33:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 03/36] sched: Clean up scheduler_ipi()
Message-ID: <20200506153300.GB5281@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.361859938@linutronix.de>
 <f969427d-a151-2c69-a779-a2b602e39d9e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f969427d-a151-2c69-a779-a2b602e39d9e@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 02:37:19PM +0200, Alexandre Chartre wrote:
> On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> > @@ -650,6 +655,16 @@ static inline bool got_nohz_idle_kick(vo
> >   	return false;
> >   }
> > +static void nohz_csd_func(void *info)
> > +{
> > +	struct rq *rq = info;
> > +
> > +	if (got_nohz_idle_kick()) {
> > +		rq->idle_balance = 1;
> > +		raise_softirq_irqoff(SCHED_SOFTIRQ);
> > +	}
> > +}
> > +
> >   #else /* CONFIG_NO_HZ_COMMON */
> >   static inline bool got_nohz_idle_kick(void)

> >   #ifdef CONFIG_NO_HZ_COMMON
> >   		rq->last_blocked_load_update_tick = jiffies;
> >   		atomic_set(&rq->nohz_flags, 0);
> > +
> > +		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
> >   #endif
> >   #endif /* CONFIG_SMP */
> >   		hrtick_rq_init(rq);
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10009,12 +10009,11 @@ static void kick_ilb(unsigned int flags)
> >   		return;
> >   	/*
> > -	 * Use smp_send_reschedule() instead of resched_cpu().
> > -	 * This way we generate a sched IPI on the target CPU which
> > +	 * This way we generate an IPI on the target CPU which
> >   	 * is idle. And the softirq performing nohz idle load balance
> >   	 * will be run before returning from the IPI.
> >   	 */
> > -	smp_send_reschedule(ilb_cpu);
> > +	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->wake_csd);
> 
> This should be nohz_csd instead of wake_csd, no? I.e.:
> 
>        smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
> 

You figured correctly. Thanks!
