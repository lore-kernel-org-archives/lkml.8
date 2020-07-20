Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD88C43458
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C036206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0x2LOjN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbgGTQrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbgGTPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:39:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD981C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SORy7n9Lm/HsaDAW1ESZ+sVeiSH8dZynS/Gg7rN5onA=; b=0x2LOjN9+Nyf7IFsRZ1XmqsGP3
        4GO0WvFxBXZhPXGC27lbhuR8MAUq1V6A/G9Ao3Le95dh8pbFyZpNaQtojWulwdTHTGj9zgPXE1Zz0
        332P0GUMeMYOP2wNTrqWj1/6WRPPcMDVcb0xepz1hnmPYyv0wUgS0wKCboA6Gh2bhR1Z3T3R+N2dw
        1LzDlJ1KYBL4JHaMehHc5Rc0Py4+USN+ztQYz/7ztCEstQqg/Wj45/jyYcK+VobpLv0qNsXEErnEQ
        YzN13c2WKw/n85LAVAdUpM6Qy/ajc5Jse52JfRI1GEb8+nMQXx/cvoHhDLmiOfPY7qZfOvsNrHerW
        wIrE33DQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxXsZ-0002C7-LF; Mon, 20 Jul 2020 15:39:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C4C2307983;
        Mon, 20 Jul 2020 17:38:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67B2F20DCCA0D; Mon, 20 Jul 2020 17:38:55 +0200 (CEST)
Date:   Mon, 20 Jul 2020 17:38:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720153855.GS10769@hirez.programming.kicks-ass.net>
References: <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720140224.GD6612@redhat.com>
 <20200720142105.GR10769@hirez.programming.kicks-ass.net>
 <20200720143930.GE6612@redhat.com>
 <20200720153514.GF6612@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720153514.GF6612@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 05:35:15PM +0200, Oleg Nesterov wrote:
> On 07/20, Oleg Nesterov wrote:
> >
> > On 07/20, Peter Zijlstra wrote:
> > >
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4193,9 +4193,6 @@ static void __sched notrace __schedule(bool preempt)
> > >  	local_irq_disable();
> > >  	rcu_note_context_switch(preempt);
> > >
> > > -	/* See deactivate_task() below. */
> > > -	prev_state = prev->state;
> > > -
> > >  	/*
> > >  	 * Make sure that signal_pending_state()->signal_pending() below
> > >  	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
> > > @@ -4223,7 +4220,8 @@ static void __sched notrace __schedule(bool preempt)
> > >  	 * We must re-load prev->state in case ttwu_remote() changed it
> > >  	 * before we acquired rq->lock.
> > >  	 */
> > > -	if (!preempt && prev_state && prev_state == prev->state) {
> > > +	prev_state = prev->state;
> > > +	if (!preempt && prev_state) {
> >
> > Heh ;) Peter, you know what? I did the same change and tried to understand
> > why it is wrong and what have I missed.
> >
> > Thanks, now I can relax. But my head hurts too, I'll probably try to re-read
> > this code and other emails from you tomorrow.
> 
> Yes, I can no longer read this code today ;)
> 
> but now it seems to me that (in theory) we need READ_ONCE(prev->state) here
> and probably WRITE_ONCE(on_rq) in deactivate_task() to ensure ctrl-dep?
> 
> Probably not, I got lost.
> Probably not, I got lost.
> Probably not, I got lost.

So, task_struct::state is declared volatile (we should probably 'fix'
that some day), so that doesn't require READ_ONCE() -- in fact, that
caused a bunch of re-reads in the old code which made the loadavg race
more likely.

->on_rq is only ever written 0,1,2, there's no possibe store-tearing.
But possibly, yes, WRITE_ONCE() would be nicer.
