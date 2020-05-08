Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D6FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0677208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEHJWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:22:17 -0400
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:58387 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbgEHJWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:22:17 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id B00DC1C39C2
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 10:22:15 +0100 (IST)
Received: (qmail 2053 invoked from network); 8 May 2020 09:22:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 May 2020 09:22:15 -0000
Date:   Fri, 8 May 2020 10:22:12 +0100
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
Message-ID: <20200508092212.GE3758@techsingularity.net>
References: <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net>
 <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net>
 <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:29:44PM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> we are not targeting just OMP applications. We see the performance
> degradation also for other workloads, like SPECjbb2005 and
> SPECjvm2008. Even worse, it also affects a higher number of threads.
> For example, comparing 5.7.0-0.rc2 against 5.6 kernel, on 4 NUMA
> server with 2x AMD 7351 CPU, we see performance degradation 22% for 32
> threads (the system has 64 CPUs in total). We observe this degradation
> only when we run a single SPECjbb binary. When running 4 SPECjbb
> binaries in parallel, there is no change in performance between 5.6
> and 5.7.
> 

Minimally I suggest confirming that it's really due to
adjust_numa_imbalance() by making the function a no-op and retesting.
I have found odd artifacts with it but I'm unsure how to proceed without
causing problems elsehwere.

For example, netperf on localhost in some cases reported a regression
when the client and server were running on the same node. The problem
appears to be that netserver completes its work faster when running
local and goes idle more regularly. The cost of going idle and waking up
builds up and a lower throughput is reported but I'm not sure if gaming
an artifact like that is a good idea.

> That's why we are asking for the kernel tunable, which we would add to
> the tuned profile. We don't expect users to change this frequently but
> rather to set the performance profile once based on the purpose of the
> server.
> 
> If you could prepare a patch for us, we would be more than happy to
> test it extensively. Based on the results, we can then evaluate if
> it's the way to go. Thoughts?
> 

I would suggest simply disabling that function first to ensure that is
really what is causing problems for you.

-- 
Mel Gorman
SUSE Labs
