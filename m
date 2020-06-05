Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C8EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5CF20772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgFEK6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:58:46 -0400
Received: from foss.arm.com ([217.140.110.172]:53714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgFEK6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:58:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1C5F2B;
        Fri,  5 Jun 2020 03:58:44 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 037BA3F52E;
        Fri,  5 Jun 2020 03:58:41 -0700 (PDT)
Date:   Fri, 5 Jun 2020 11:58:39 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200605105839.ghxzcz62kz43dzxr@e107158-lin.cambridge.arm.com>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <20200603094036.GF3070@suse.de>
 <20200603124112.w5stb7v2z3kzcze3@e107158-lin.cambridge.arm.com>
 <20200604134042.GJ3070@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200604134042.GJ3070@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/20 14:40, Mel Gorman wrote:
> > > > The diffs are smaller than on openSUSE Leap 15.1 and some of the
> > > > uclamp taskgroup results are better?
> > > > 
> > > 
> > > I don't see the stddev and coeff but these look close to borderline.
> > > Sure, they are marked with a * so it passed a significant test but it's
> > > still a very marginal difference for netperf. It's possible that the
> > > systemd configurations differ in some way that is significant for uclamp
> > > but I don't know what that is.
> > 
> > Hmm so what you're saying is that Dietmar didn't reproduce the same problem
> > you're observing? I was hoping to use that to dig more into it.
> > 
> 
> Not as such, I'm saying that for whatever reason the problem is not as
> visible with Dietmar's setup. It may be machine-specific or distribution
> specific. There are alternative suggestions for testing just the fast
> paths with a pipe test that may be clearer.

Unfortunately lost access to that machine, but will resume testing on it as
soon as it's back online.

Vincent shared more info about his setup. If I can see the same thing without
having to use a big machine that'd make it easier to debug.

> > > 
> > > > With this test setup we now can play with the uclamp code in
> > > > enqueue_task() and dequeue_task().
> > > > 
> > > 
> > > That is still true. An annotated perf profile should tell you if the
> > > uclamp code is being heavily used or if it's bailing early but it's also
> > > possible that uclamp overhead is not a big deal on your particular
> > > machine.
> > > 
> > > The possibility that either the distribution, the machine or both are
> > > critical for detecting a problem with uclamp may explain why any overhead
> > > was missed. Even if it is marginal, it still makes sense to minimise the
> > > amount of uclamp code that is executed if no limit is specified for tasks.
> > 
> > So one speculation I have that might be causing the problem is that the
> > accesses of struct uclamp_rq are causing bad cache behavior in your case. Your
> > mmtest description of the netperf says that it is sensitive to cacheline
> > bouncing.
> > 
> > Looking at struct rq, the uclamp_rq is spanning 2 cachelines
> > 
> >  29954         /* --- cacheline 1 boundary (64 bytes) --- */
> >  29955         struct uclamp_rq           uclamp[2];            /*    64    96 */
> >  29956         /* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */
> >  29957         unsigned int               uclamp_flags;         /*   160     4 */
> >  29958
> >  29959         /* XXX 28 bytes hole, try to pack */
> >  29960
> > 
> > Reducing sturct uclamp_bucket to use unsigned int instead of unsigned long
> > helps putting it all in a single cacheline
> > 
> 
> I tried this and while it did not make much of a difference to the
> headline metric, the workload was less variable so if it's proven that
> cache line bouncing is reduced (I didn't measure it), it may have merit
> on its own even if it does not fully address the problem.

Yeah maybe if we can prove it's worth it. I'll keep it on my list to look at
after we fix the main issue first.

Thanks

--
Qais Yousef
