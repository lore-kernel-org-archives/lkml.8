Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F510C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D698D2192A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgAQV7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:59:00 -0500
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:39274 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729080AbgAQV67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:58:59 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 2B6901C2F85
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 21:58:56 +0000 (GMT)
Received: (qmail 16458 invoked from network); 17 Jan 2020 21:58:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jan 2020 21:58:55 -0000
Date:   Fri, 17 Jan 2020 21:58:53 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Message-ID: <20200117215853.GS3466@techsingularity.net>
References: <20200114101319.GO3466@techsingularity.net>
 <20200117175631.GC20112@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200117175631.GC20112@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:26:31PM +0530, Srikar Dronamraju wrote:
> * Mel Gorman <mgorman@techsingularity.net> [2020-01-14 10:13:20]:
> 
> > Changelog since V3
> > o Allow a fixed imbalance a basic comparison with 2 tasks. This turned out to
> >   be as good or better than allowing an imbalance based on the group weight
> >   without worrying about potential spillover of the lower scheduler domains.
> > 
> 
> We certainly are seeing better results than v1.
> However numa02, numa03, numa05, numa09 and numa10 still seem to regressing, while
> the others are improving.
> 
> While numa04 improves by 14%, numa02 regress by around 12%.
> 

Ok, so it's both a win and a loss. This is a curiousity that this patch
may be the primary factor given that the logic only triggers when the
local group has spare capacity and the busiest group is nearly idle. The
test cases you describe should have fairly busy local groups.

> Setup:
> Architecture:        ppc64le
> Byte Order:          Little Endian
> CPU(s):              256
> On-line CPU(s) list: 0-255
> Thread(s) per core:  8
> Core(s) per socket:  1
> Socket(s):           32
> NUMA node(s):        8
> Model:               2.1 (pvr 004b 0201)
> Model name:          POWER8 (architected), altivec supported
> Hypervisor vendor:   pHyp
> Virtualization type: para
> L1d cache:           64K
> L1i cache:           32K
> L2 cache:            512K
> L3 cache:            8192K
> NUMA node0 CPU(s):   0-31
> NUMA node1 CPU(s):   32-63
> NUMA node2 CPU(s):   64-95
> NUMA node3 CPU(s):   96-127
> NUMA node4 CPU(s):   128-159
> NUMA node5 CPU(s):   160-191
> NUMA node6 CPU(s):   192-223
> NUMA node7 CPU(s):   224-255
> 
> numa01 is a set of 2 process each running 128 threads;
> each thread doing 50 loops on 3GB process shared memory operations.

Are the shared operations shared between the 2 processes? 256 threads
in total would more than exceed the capacity of a local group, even 128
threads per process would exceed the capacity of the local group. In such
a situation, much would depend on the locality of the accesses as well
as any shared accesses.

> numa02 is a single process with 256 threads;
> each thread doing 800 loops on 32MB thread local memory operations.
> 

This one is more interesting. False sharing shouldn't be an issue so the
threads should be independent.

> numa03 is a single process with 256 threads;
> each thread doing 50 loops on 3GB process shared memory operations.
> 

Similar.

> numa04 is a set of 8 process (as many nodes) each running 32 threads;
> each thread doing 50 loops on 3GB process shared memory operations.
> 

Less clear as you don't say what is sharing the memory operations.

> numa05 is a set of 16 process (twice as many nodes) each running 16 threads;
> each thread doing 50 loops on 3GB process shared memory operations.
> 

Again, hard to tell because the shared memory operations are not described.

Of all of these, numa02 is the most interesting as it's the simplest
case showing a problem.

> Details below:

How many iterations for each test? 

> Testcase         Time:  Min        Max        Avg        StdDev
> ./numa01.sh      Real:  513.12     547.37     530.25     17.12
> ./numa01.sh      Sys:   107.73     146.26     127.00     19.26
> ./numa01.sh      User:  122812.39  129136.61  125974.50  3162.11
> ./numa02.sh      Real:  68.23      72.44      70.34      2.10
> ./numa02.sh      Sys:   52.35      55.65      54.00      1.65
> ./numa02.sh      User:  14334.37   14907.14   14620.76   286.38
> ./numa03.sh      Real:  471.36     485.19     478.27     6.92
> ./numa03.sh      Sys:   74.91      77.03      75.97      1.06
> ./numa03.sh      User:  118197.30  121238.68  119717.99  1520.69
> ./numa04.sh      Real:  450.35     454.93     452.64     2.29
> ./numa04.sh      Sys:   362.49     397.95     380.22     17.73
> ./numa04.sh      User:  93150.82   93300.60   93225.71   74.89
> ./numa05.sh      Real:  361.18     366.32     363.75     2.57
> ./numa05.sh      Sys:   678.72     726.32     702.52     23.80
> ./numa05.sh      User:  82634.58   85103.97   83869.27   1234.70
> Testcase         Time:  Min        Max        Avg        StdDev   %Change
> ./numa01.sh      Real:  485.45     530.20     507.83     22.37    4.41486%
> ./numa01.sh      Sys:   123.45     130.62     127.03     3.59     -0.0236165%
> ./numa01.sh      User:  119152.08  127121.14  123136.61  3984.53  2.30467%

The number of iterations is unknown in general but there is a lot of
overlap between the min and max ranges and the range is wide. It may or
may not be a gain overall.

Before range: 513 to 547
After  range: 485 to 530


> ./numa02.sh      Real:  78.87      82.31      80.59      1.72     -12.7187%
> ./numa02.sh      Sys:   81.18      85.07      83.12      1.94     -35.0337%
> ./numa02.sh      User:  16303.70   17122.14   16712.92   409.22   -12.5182%

Before range: 58 to 72
After range: 78 to 82

This one is more interesting in general. Can you add trace_printks to
the check for SD_NUMA the patch introduces and dump the sum_nr_running
for both local and busiest when the imbalance is ignored please? That
might give some hint as to the improper conditions where imbalance is
ignored.

However, knowing the number of iterations would be helpful. Can you also
tell me if this is consistent between boots or is it always roughly 12%
regression regardless of the number of iterations?

> ./numa03.sh      Real:  477.20     528.12     502.66     25.46    -4.85219%
> ./numa03.sh      Sys:   88.93      115.36     102.15     13.21    -25.629%
> ./numa03.sh      User:  119120.73  129829.89  124475.31  5354.58  -3.8219%

Range before: 471 to 485
Range after: 477 to 528

> ./numa04.sh      Real:  374.70     414.76     394.73     20.03    14.6708%
> ./numa04.sh      Sys:   357.14     379.20     368.17     11.03    3.27294%
> ./numa04.sh      User:  87830.73   88547.21   88188.97   358.24   5.7113%

Range before: 450 -> 454
Range after:  374 -> 414

Big gain there but the fact the range changed so much is a concern and
makes me wonder if this case is stable from boot to boot. 

> ./numa05.sh      Real:  369.50     401.56     385.53     16.03    -5.64937%
> ./numa05.sh      Sys:   718.99     741.02     730.00     11.01    -3.76438%
> ./numa05.sh      User:  84989.07   85271.75   85130.41   141.34   -1.48142%
> 

Big range changes again but the shared memory operations complicate
matters. I think it's best to focus on numa02 for and identify if there
is an improper condition where the patch has an impact, the local group
has high utilisation but spare capacity while the busiest group is
almost completely idle.

> vmstat for numa01

I'm not going to comment in detail on these other than noting that NUMA
balancing is heavily active in all cases which may be masking any effect
of the patch and may have unstable results in general.

> <SNIP vmstat>
> <SNIP description of loads that showed gains>
>
> numa09 is a set of 8 process (as many nodes) each running 4 threads;
> each thread doing 50 loops on 3GB process shared memory operations.
> 

No description of shared operations but NUMA balancing is very active so
sharing is probably between processes.

> numa10 is a set of 16 process (twice as many nodes) each running 2 threads;
> each thread doing 50 loops on 3GB process shared memory operations.
> 

Again, shared accesses without description and heavy NUMA balancing
activity.

So bottom line, a lot of these cases have shared operations where NUMA
balancing decisions should dominate and make it hard to detect any impact
from the patch. The exception is numa02 so please add tracing and dump
out local and busiest sum_nr_running when the imbalance is ignored. I
want to see if it's as simple as the local group is very busy but has
capacity where the busiest group is almost idle. I also want to see how
many times over the course of the numa02 workload that the conditions
for the patch are even met.

Thanks.

-- 
Mel Gorman
SUSE Labs
