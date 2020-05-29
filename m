Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A510C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51114207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgE2JLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:11:53 -0400
Received: from foss.arm.com ([217.140.110.172]:33990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgE2JLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:11:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 986A61045;
        Fri, 29 May 2020 02:11:51 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF41E3F52E;
        Fri, 29 May 2020 02:11:48 -0700 (PDT)
Date:   Fri, 29 May 2020 10:11:46 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
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
Message-ID: <20200529091145.irvbvxxvhbetbwvw@e107158-lin>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200528165130.m5unoewcncuvxynn@e107158-lin.cambridge.arm.com>
 <20200528182913.GQ2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528182913.GQ2483@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/20 20:29, Peter Zijlstra wrote:
> On Thu, May 28, 2020 at 05:51:31PM +0100, Qais Yousef wrote:
> 
> > In my head, the simpler version of
> > 
> > 	if (rt_task(p) && !uc->user_defined)
> > 		// update_uclamp_min
> > 
> > Is a single branch and write to cache, so should be fast. I'm failing to see
> > how this could generate an overhead tbh, but will not argue about it :-)
> 
> Mostly true; but you also had a load of that sysctl in there, which is
> likely to be a miss, and those are expensive.

Hmm yes there's no guarantee the sysctl global variable will be in LLC, though
I thought that would be the likely case.

> 
> Also; if we're going to have to optimize this, less logic is in there,
> the less we need to take out. Esp. for stuff that 'never' changes, like
> this.

Agreed.

> 
> > > It's more code, but it is all outside of the normal paths where we care
> > > about performance.
> > 
> > I am happy to take that direction if you think it's worth it. I'm thinking
> > task_woken_rt() is good. But again, maybe I am missing something.
> 
> Basic rule, if the state 'never' changes, don't touch fast paths.
> 
> Such little things can be very difficult to measure, but at some point
> they cause death-by-a-thousnd-cuts.

Yeah we're bound to reach the critical mass at some point if too much bloat
creeps up on the hot path.

Thanks

--
Qais Yousef

> 
> > > Indeed, that one. The fact that regular distros cannot enable this
> > > feature due to performance overhead is unfortunate. It means there is a
> > > lot less potential for this stuff.
> > 
> > I had a humble try to catch the overhead but wasn't successful. The observation
> > wasn't missed by us too then.
> 
> Right, I remember us doing benchmarks when we introduced all this and
> clearly we missed something. I would be good if Mel can share which
> benchmark hurt most so we can go have a look.
