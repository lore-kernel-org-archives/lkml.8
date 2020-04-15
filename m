Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB1C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F16F2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506289AbgDONTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370786AbgDONSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:18:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83EFC20575;
        Wed, 15 Apr 2020 13:18:40 +0000 (UTC)
Date:   Wed, 15 Apr 2020 09:18:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
Message-ID: <20200415091838.1555b45e@gandalf.local.home>
In-Reply-To: <20200415093935.GA20730@hirez.programming.kicks-ass.net>
References: <20200414150556.10920-1-qais.yousef@arm.com>
        <jhjh7xlvqqe.mognet@arm.com>
        <20200414162742.0ef4d9ee@gandalf.local.home>
        <20200415093935.GA20730@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 11:39:35 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Apr 14, 2020 at 04:27:42PM -0400, Steven Rostedt wrote:
> > On Tue, 14 Apr 2020 19:58:49 +0100
> > Valentin Schneider <valentin.schneider@arm.com> wrote:
> >   
> > > To move this forward, I would suggest renaming the current cpumask_any_*()
> > > into cpumask_first_*(), and THEN introduce the new pseudo-random
> > > ones. People are then free to hand-fix specific locations if it makes sense
> > > there, like you're doing for RT.  
> > 
> > Or leave "cpumask_any()" as is, and create a new "cpumask_random()" for
> > this purpose.  
> 
> Well, that's just twisting words, not sure I like that. 'Any' really
> means 'any'. So in order to preserve long term sanity, I'd vote for
> Valentin's approach of converting existing users over to first.

Well, to me "any" means it can be "any" and leaves it up to the
implementation to decide. Thus, "any" can always be the first one, or the
last one, or some random one. It means, "you don't care". If someone comes
to you showing you a deck of cards and says "pick any card". Picking the
first one every time is legitimate.

But saying "random" or perhaps better "shuffle" documents that you expect
something different each time.

I guess the best thing to do is to look at how they are used in the kernel,
and see if picking the same one (first or last) could cause issues. If all
the use cases really want something different each time, then great I
agree, let's make "any" give something different. But if the use cases are
"I don't care, just give me something fast" then I think we should leave it
as is. As the "random" version does add a slight overhead.

To me it comes down to documenting the use case. "first" means you really
want the first one. "any" would mean you don't care which one. "random" (or
whatever) means you would like to get something different each time.

How about calling it: cpumask_surprise_me().

-- Steve
