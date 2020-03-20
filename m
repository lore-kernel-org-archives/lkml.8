Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E073C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681B220709
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgCTQis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:38:48 -0400
Received: from outbound-smtp39.blacknight.com ([46.22.139.222]:56425 "EHLO
        outbound-smtp39.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727269AbgCTQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:38:48 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id 1A1331BBF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:38:46 +0000 (GMT)
Received: (qmail 5667 invoked from network); 20 Mar 2020 16:38:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Mar 2020 16:38:45 -0000
Date:   Fri, 20 Mar 2020 16:38:43 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200320163843.GD3818@techsingularity.net>
References: <20200309203625.GU3818@techsingularity.net>
 <20200312095432.GW3818@techsingularity.net>
 <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net>
 <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net>
 <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net>
 <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 04:30:08PM +0100, Jirka Hladky wrote:
> >
> > MPI or OMP and what is a low thread count? For MPI at least, I saw a 0.4%
> > gain on an 4-node machine for bt_C and a 3.88% regression on 8-nodes. I
> > think it must be OMP you are using because I found I had to disable UA
> > for MPI at some point in the past for reasons I no longer remember.
> 
> 
> Yes, it's indeed OMP.  With low threads count, I mean up to 2x number of
> NUMA nodes (8 threads on 4 NUMA node servers, 16 threads on 8 NUMA node
> servers).
> 

Ok, so we know it's within the imbalance threshold where a NUMA node can
be left idle.

> One possibility would be to spread wide always at clone time and assume
> > wake_affine will pull related tasks but it's fragile because it breaks
> > if the cloned task execs and then allocates memory from a remote node
> > only to migrate to a local node immediately.
> 
> 
> I think the only way to find out how it performs is to test it. If you
> could prepare a patch like that, I'm more than happy to give it a try!
> 

When the initial spreading was prevented, it was for pipelines mainly --
even basic shell scripts. In that case it was observed that a shell would
fork/exec two tasks connected via pipe that started on separate nodes and
had allocated remote data before being pulled close. The processes were
typically too short lived for NUMA balancing to fix it up by exec time
the information on where the fork happened was lost.  See 2c83362734da
("sched/fair: Consider SD_NUMA when selecting the most idle group to
schedule on"). Now the logic has probably been partially broken since
because of how SD_NUMA is now treated but the concern about spreading
wide prematurely remains.

-- 
Mel Gorman
SUSE Labs
