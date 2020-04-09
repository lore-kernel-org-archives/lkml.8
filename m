Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F339C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C91620753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDISU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:20:59 -0400
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:50833 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgDISU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:20:59 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id C1746FADA1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Apr 2020 19:20:57 +0100 (IST)
Received: (qmail 27119 invoked from network); 9 Apr 2020 18:20:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2020 18:20:57 -0000
Date:   Thu, 9 Apr 2020 19:20:55 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Cgroup memory barrier usage and call frequency from scheduler
Message-ID: <20200409182055.GM3818@techsingularity.net>
References: <20200409154413.GK3818@techsingularity.net>
 <20200409175621.GA37608@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200409175621.GA37608@mtj.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 01:56:21PM -0400, Tejun Heo wrote:
> Hello, Mel.
> 
> On Thu, Apr 09, 2020 at 04:44:13PM +0100, Mel Gorman wrote:
> > Commit 9a9e97b2f1f2 ("cgroup: Add memory barriers to plug
> > cgroup_rstat_updated() race window") introduced two full memory
> > barriers to close a race. The one in cgroup_rstat_updated can be
> > called at a high frequency from the scheduler from update_curr ->
> > cgroup_account_cputime. The patch has no cc's, acks or reviews so I'm
> > not sure how closely this was looked at. cgroup_rstat_updated shows up
> > in profiles of netperf UDP_STREAM accounting for about 1% of overhead
> 
> Oops, that's pretty high.
> 
> > which doesn't sound a lot but that's about the same weight as some of
> > the critical network paths. I have three questions about the patch
> > 
> > 1. Why were full barriers used?
> 
> Given
> 
>    A    C
>   ---  ---
>    B    D
> 
> the code is trying to guarantee that either B sees C or D sees A, so it does
> need full ordering.
> 

Ok, still not particularly clear given where they are used and how
it's related to updated_children but like you say later it's "kinda
irrelevant" :)

> > 2. Why was it important that the data race be closed when the inaccuracy
> >    is temporary?
> 
> There was a pending patchset which converted memcg to use rstat and the
> conversion included the event counters which needed to be synchronous (e.g.
> for things like oom kill counts). The patchset didn't make it through due to
> the percpu memory overhead at the time. The memory overhead issue can be
> resolved now but in the meantime memcg got improved in a different way which
> made the rstat conversion not immediately necessary, so it fell through the
> cracks. In retrospect, this patch shouldn't have been committed on its own or
> at least the synchronous and pure state update paths should have been
> separate.
> 

Ah, thanks for that explanation.

> > 3. Why is it called from the context of update_curr()?
> 
> It's just being callled from the path which udpates sched statistics.
> 
> > For 1, the use of a full barrier seems unnecessary when it appears that
> > you could have used a read barrier and a write barrier. The following
> > patch drops the profile overhead to 0.1%
> 
> I'm not sure this is correct but that's kinda irrelevant.
> 
> > For 2, the changelog says the barriers are necessary because "we plan to use
> > rstat to track counters which need to be accurate". That is a bit vague.
> > Under what circumstances is a transient inaccuracy a serious enough
> > problem to justify additional barriers in the scheduler?
> 
> Hope this is explained now.
> 

It is.

> > For 3, update_curr() is called from a lot of places, some of which are
> > quite hot -- e.g. task enqueue/dequeue. This is necessary information from
> > the runqueue needs to be preserved. However, it's less clear that the cpu
> > accounting information needs to be up to date on this granularity although
> > it might be related to question 2. Why was the delta_exec not similarly
> > accumulated in cpuacct_change() and defer the hierarchical update to
> > be called from somewhere like entity_tick()? It would need tracking the
> > CPU time at the last update as delta_exec would be lost so it's not very
> > trivial but it does not look like it would be overly complicated.
> 
> Most likely historic. The code has been there for a long time and the only
> recent changes were plumbing around them. Nothing in cpuacct needs to be
> per-scheduling-event accurate, so yeah, for the longer term, it'd be a good
> idea to move them out of hot path.
> 

Even if it's a future thing it helps me to know the accuracy does not
have to be perfect. It means if it bothers me enough, I can take a shot
at addressing it myself without having to worry that some controller is
broken as a side-effect.

> For now, I'll revert the patch. Nothing in tree needs that right now. If the
> need for synchronous counting comes back later, I'll make that a separate
> path.
> 

That's perfect, thanks!

-- 
Mel Gorman
SUSE Labs
