Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CD8C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BB22067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgCLP4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:56:46 -0400
Received: from outbound-smtp40.blacknight.com ([46.22.139.223]:40299 "EHLO
        outbound-smtp40.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbgCLP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:56:45 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id 32A3A1C3568
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 15:56:43 +0000 (GMT)
Received: (qmail 6294 invoked from network); 12 Mar 2020 15:56:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Mar 2020 15:56:42 -0000
Date:   Thu, 12 Mar 2020 15:56:40 +0000
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
Message-ID: <20200312155640.GX3818@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200309191233.GG10065@pauld.bos.csb>
 <20200309203625.GU3818@techsingularity.net>
 <20200312095432.GW3818@techsingularity.net>
 <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:10:36PM +0100, Jirka Hladky wrote:
> Hi Mel,
> 
> thanks a lot for analyzing it!
> 
> My big concern is that the performance drop for low threads counts (roughly
> up to 2x number of NUMA nodes) is not just a rare corner case, but it might
> be more common.

That is hard to tell. In my case I was seeing the problem running a HPC
workload, dedicated to that machine and using only 6% of available CPUs. I
find it unlikely that is common because who acquires such a large machine
and then uses a tiny percentage of it. Rember also the other points I made
such as 1M migrations happening in the first few seconds just trying to
deal with the load balancer and NUMA balancer fighting each other. While
that might happen to be good for SP, it's not universally good behaviour
and I've dealt with issues in the past whereby the NUMA balancer would
get confused and just ramp up the frequency it samples and migrates trying
to override the load balancer.

> We see the drop for the following benchmarks/tests,
> especially on 8 NUMA nodes servers. However, four and even 2 NUMA node
> servers are affected as well.
> 
> Numbers show average performance drop (median of runtime collected from 5
> subsequential runs) compared to vanilla kernel.
> 
> 2x AMD 7351 (EPYC Naples), 8 NUMA nodes
> ===================================
> NAS: sp_C test: -50%, peak perf. drop with 8 threads

I hadn't tested 8 threads specifically I think that works out as
using 12.5% of the available machine. The allowed imbalance between
nodes means that some SP instances will stack on the same node but not
the same CPU.

> NAS: mg_D: -10% with 16 threads

While I do not have the most up to date figures available, I found the
opposite trend at 21 threads (the test case I used were 1/3rd available
CPUs and as close to maximum CPUs as possible). There I found it was 10%
faster for an 8 node machine.

For 4 nodes, using a single JVM was performance neutral *on average* but
much less variable. With one JVM per node, there was a mix of small <2%
regressions for some thread counts and up to 9% faster on others.

> SPECjvm2008: co_sunflow test: -20% (peak drop with 8 threads)
> SPECjvm2008: compress and cr_signverify tests: -10%(peak drop with 8
> threads)

I didn't run SPECjvm for multiple thread sizes so I don't have data yet
and may not have for another day at least.

> SPECjbb2005: -10% for 16 threads
> 

I found this to depend in the number of JVMs used and the thread count.
Slower at low thread counts, faster at higher thread counts but with
more stable results with the series applied and less NUMA balancer
activity.

This is somewhat of a dilemma. Without the series, the load balancer and
NUMA balancer use very different criteria on what should happen and
results are not stable. In some cases acting randomly happens to work
out and in others it does not and overall it depends on the workload and
machine. It's very highly dependent on both the workload and the machine
and it's a question if we want to continue dealing with two parts of the
scheduler disagreeing on what criteria to use or try to improve the
reconciled load and memory balancer sharing similar logic.

In *general*, I found that the series won a lot more than it lost across
a spread of workloads and machines but unfortunately it's also an area
where counter-examples can be found.

-- 
Mel Gorman
SUSE Labs
