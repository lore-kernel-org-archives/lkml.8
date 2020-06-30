Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E35B206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgF3T21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:28:27 -0400
Received: from foss.arm.com ([217.140.110.172]:59204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgF3T21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:28:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4231231B;
        Tue, 30 Jun 2020 12:28:26 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943703F68F;
        Tue, 30 Jun 2020 12:28:24 -0700 (PDT)
Date:   Tue, 30 Jun 2020 20:28:22 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200630192821.xzg53b3mx7hvjmr4@e107158-lin.cambridge.arm.com>
References: <20200630112123.12076-1-qais.yousef@arm.com>
 <20200630112123.12076-3-qais.yousef@arm.com>
 <20200630170751.GA4817@hirez.programming.kicks-ass.net>
 <20200630175502.otw4seymlynghje7@e107158-lin.cambridge.arm.com>
 <20200630190643.GC4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630190643.GC4817@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/20 21:06, Peter Zijlstra wrote:
> On Tue, Jun 30, 2020 at 06:55:02PM +0100, Qais Yousef wrote:
> > On 06/30/20 19:07, Peter Zijlstra wrote:
> 
> > > There's a fun race described in 9107c89e269d ("perf: Fix race between
> > > event install and jump_labels"), are we sure this isn't also susceptible
> > > to something similar?
> > > 
> > > I suspect not, but I just wanted to make sure.
> > 
> > IIUC, the worry is that not all CPUs might have observed the change in the
> > static key state; hence could not be running the patched
> > enqueue/dequeue_task(), so we could end up with some CPUs accounting for
> > uclamp in the enqueue/dequeue path but not others?
> > 
> > I was hoping this synchronization is guaranteed by the static_branch_*() call.
> 
> It is, that isn't quite the the problem. Looking at it more I think
> commit 1dbb6704de91 ("jump_label: Fix concurrent
> static_key_enable/disable()") fixed some of it.
> 
> From what I can remember there were two parts to this problem, one being
> fixed by the above commit, the other being that if we enable while a
> task is running we miss the switch-in event (exactly how in this patch
> we miss the enqueue).
> 
> Due to the missing switch-in, the state is 'weird' and the subsequent
> IPI to install a remote event didn't quite work.
> 
> So I put that sync_sched() call in to guarantee all CPUs have done a
> schedule() cycle after having the key switched. This makes sure that
> every running task has seen the switch-in and thus the state is as
> expected.
> 
> But like I said, I think we're good, that one extra branch deals with
> the half-state.

Got it, thanks.

Yes, we should be good for currently running tasks.

Thanks

--
Qais Yousef
