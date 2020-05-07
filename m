Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BBAC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DED720659
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEGPy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:54:27 -0400
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:47513 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbgEGPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:54:27 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 42AB81A36
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 16:54:25 +0100 (IST)
Received: (qmail 4187 invoked from network); 7 May 2020 15:54:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 May 2020 15:54:24 -0000
Date:   Thu, 7 May 2020 16:54:22 +0100
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
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200507155422.GD3758@techsingularity.net>
References: <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net>
 <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net>
 <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net>
 <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 05:24:17PM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> > > Yes, it's indeed OMP.  With low threads count, I mean up to 2x number of
> > > NUMA nodes (8 threads on 4 NUMA node servers, 16 threads on 8 NUMA node
> > > servers).
> >
> > Ok, so we know it's within the imbalance threshold where a NUMA node can
> > be left idle.
> 
> we have discussed today with my colleagues the performance drop for
> some workloads for low threads counts (roughly up to 2x number of NUMA
> nodes). We are worried that it can be a severe issue for some use
> cases, which require a full memory bandwidth even when only part of
> CPUs is used.
> 
> We understand that scheduler cannot distinguish this type of workload
> from others automatically. However, there was an idea for a * new
> kernel tunable to control the imbalance threshold *. Based on the
> purpose of the server, users could set this tunable. See the tuned
> project, which allows creating performance profiles [1].
> 

I'm not completely opposed to it but given that the setting is global,
I imagine it could have other consequences if two applications ran
at different times have different requirements. Given that it's OMP,
I would have imagined that an application that really cared about this
would specify what was needed using OMP_PLACES. Why would someone prefer
kernel tuning or a tuned profile over OMP_PLACES? After all, it requires
specific knowledge of the application even to know that a particular
tuned profile is needed.

-- 
Mel Gorman
SUSE Labs
