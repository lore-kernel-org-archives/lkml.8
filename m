Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFBFC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D942064C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgDUMPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:15:42 -0400
Received: from foss.arm.com ([217.140.110.172]:33938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUMPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:15:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E99E531B;
        Tue, 21 Apr 2020 05:15:41 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B28CD3F68F;
        Tue, 21 Apr 2020 05:15:39 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:15:37 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
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
Message-ID: <20200421121536.rwupnm6vna374z5y@e107158-lin.cambridge.arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <jhjh7xlvqqe.mognet@arm.com>
 <20200414162742.0ef4d9ee@gandalf.local.home>
 <20200415093935.GA20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415093935.GA20730@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/20 11:39, Peter Zijlstra wrote:
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

I have answered Valentin's email. So hopefully I have addressed the concerns.

If not, I really hate this mass conversion and I think we're better off with
the status-quo.

Thanks

--
Qais Yousef
