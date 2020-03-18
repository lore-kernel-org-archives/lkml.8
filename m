Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B2C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222772076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgCRLfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:35:02 -0400
Received: from foss.arm.com ([217.140.110.172]:48736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgCRLfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:35:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3CFF1FB;
        Wed, 18 Mar 2020 04:35:00 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DB4A3F534;
        Wed, 18 Mar 2020 04:34:59 -0700 (PDT)
Date:   Wed, 18 Mar 2020 11:34:56 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched/cpuset: distribute tasks within affinity masks
Message-ID: <20200318113456.3h64jpyb6xiczhcj@e107158-lin.cambridge.arm.com>
References: <20200311010113.136465-1-joshdon@google.com>
 <20200311140533.pclgecwhbpqzyrks@e107158-lin.cambridge.arm.com>
 <20200317192401.GE20713@hirez.programming.kicks-ass.net>
 <CABk29NuAYvkqNmZZ6cjZBC6=hv--2siPPjZG-BUpNewxm02O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABk29NuAYvkqNmZZ6cjZBC6=hv--2siPPjZG-BUpNewxm02O6A@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17/20 14:35, Josh Don wrote:
> On Wed, Mar 11, 2020 at 7:05 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > This actually helps me fix a similar problem I faced in RT [1]. If multiple RT
> > tasks wakeup at the same time we get a 'thundering herd' issue where they all
> > end up going to the same CPU, just to be pushed out again.
> >
> > Beside this will help fix another problem for RT tasks fitness, which is
> > a manifestation of the problem above. If two tasks wake up at the same time and
> > they happen to run on a little cpu (but request to run on a big one), one of
> > them will end up being migrated because find_lowest_rq() will return the first
> > cpu in the mask for both tasks.
> >
> > I tested the API (not the change in sched/core.c) and it looks good to me.
> 
> Nice, glad that the API already has another use case. Thanks for taking a look.
> 
> > nit: cpumask_first_and() is better here?
> 
> Yea, I would also prefer to use it, but the definition of
> cpumask_first_and() follows this section, as it itself uses
> cpumask_next_and().
> 
> > It might be a good idea to split the API from the user too.
> 
> Not sure what you mean by this, could you clarify?

I meant it'd be a good idea to split the cpumask API into its own patch and
have a separate patch for the user in sched/core.c. But that was a small nit.
If the user (in sched/core.c) somehow introduces a regression, reverting it
separately should be trivial.

Thanks

--
Qais Yousef

> 
> On Tue, Mar 17, 2020 at 12:24 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > Anyway, for the API.
> > >
> > > Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> > > Tested-by: Qais Yousef <qais.yousef@arm.com>
> >
> > Thanks guys!
> 
> Thanks Peter, any other comments or are you happy with merging this patch as-is?
