Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3FFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C074206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405740AbgFYPVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:21:41 -0400
Received: from foss.arm.com ([217.140.110.172]:56412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404580AbgFYPVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:21:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1F3D6E;
        Thu, 25 Jun 2020 08:21:40 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CE8D3F6CF;
        Thu, 25 Jun 2020 08:21:37 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] sched: Optionally skip uclamp logic in fast path
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        linux-kernel@vger.kernel.org
References: <20200624172605.26715-1-qais.yousef@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <0de7c397-68f0-b217-3890-0c42805f9923@arm.com>
Date:   Thu, 25 Jun 2020 16:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624172605.26715-1-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 6/24/20 6:26 PM, Qais Yousef wrote:
> This series attempts to address the report that uclamp logic could be expensive
> sometimes and shows a regression in netperf UDP_STREAM under certain
> conditions.
> 
> The first patch is a fix for how struct uclamp_rq is initialized which is
> required by the 2nd patch which contains the real 'fix'.
> 
> Worth noting that the root cause of the overhead is believed to be system
> specific or related to potential certain code/data layout issues, leading to
> worse I/D $ performance.
> 
> Different systems exhibited different behaviors and the regression did
> disappear in certain kernel version while attempting to reporoduce.
> 
> More info can be found here:
> 
> https://lore.kernel.org/lkml/20200616110824.dgkkbyapn3io6wik@e107158-lin/
> 
> Having the static key seemed the best thing to do to ensure the effect of
> uclamp is minimized for kernels that compile it in but don't have a userspace
> that uses it, which will allow distros to distribute uclamp capable kernels by
> default without having to compromise on performance for some systems that could
> be affected.
> 
> Changes in v3:
> 	* Avoid double negatives and rename the static key to uclamp_used
> 	* Unconditionally enable the static key through any of the paths where
> 	  the user can modify the default uclamp value.
> 	* Use C99 named struct initializer for struct uclamp_rq which is easier
> 	  to read than the memset().
> 
> Changes in v2:
> 	* Add more info in the commit message about the result of perf diff to
> 	  demonstrate that the activate/deactivate_task pressure is reduced in
> 	  the fast path.
> 
> 	* Fix sparse warning reported by the test robot.
> 
> 	* Add an extra commit about using static_branch_likely() instead of
> 	  static_branc_unlikely().
> 
> Thanks
> 
> --
> Qais Yousef
> 
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> CC: Patrick Bellasi <patrick.bellasi@matbug.net>
> Cc: Chris Redpath <chris.redpath@arm.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: linux-kernel@vger.kernel.org
> 
> Qais Yousef (2):
>    sched/uclamp: Fix initialization of strut uclamp_rq
>    sched/uclamp: Protect uclamp fast path code with static key
> 
>   kernel/sched/core.c | 75 +++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 66 insertions(+), 9 deletions(-)
> 


The results for this v3 series from mmtest netperf-udp (30x each UDP
size) are good.

                        v5.7-rc7-base-noucl    v5.7-rc7-ucl-tsk-nofix 
v5.7-rc7-ucl-tsk-grp-fix_v3
Hmean     send-64          62.15 (   0.00%)       59.65 *  -4.02%* 
65.83 *   5.93%*
Hmean     send-128        122.88 (   0.00%)      119.37 *  -2.85%* 
133.20 *   8.40%*
Hmean     send-256        244.85 (   0.00%)      234.26 *  -4.32%* 
264.01 *   7.83%*
Hmean     send-1024       919.24 (   0.00%)      880.67 *  -4.20%* 
1005.54 *   9.39%*
Hmean     send-2048      1689.45 (   0.00%)     1647.54 *  -2.48%* 
1845.64 *   9.25%*
Hmean     send-3312      2542.36 (   0.00%)     2485.23 *  -2.25%* 
2729.11 *   7.35%*
Hmean     send-4096      2935.69 (   0.00%)     2861.09 *  -2.54%* 
3161.16 *   7.68%*
Hmean     send-8192      4800.35 (   0.00%)     4680.09 *  -2.51%* 
5090.38 *   6.04%*
Hmean     send-16384     7473.66 (   0.00%)     7349.60 *  -1.66%* 
7786.42 *   4.18%*
Hmean     recv-64          62.15 (   0.00%)       59.65 *  -4.03%* 
65.82 *   5.91%*
Hmean     recv-128        122.88 (   0.00%)      119.37 *  -2.85%* 
133.20 *   8.40%*
Hmean     recv-256        244.84 (   0.00%)      234.26 *  -4.32%* 
264.01 *   7.83%*
Hmean     recv-1024       919.24 (   0.00%)      880.67 *  -4.20%* 
1005.54 *   9.39%*
Hmean     recv-2048      1689.44 (   0.00%)     1647.54 *  -2.48%* 
1845.06 *   9.21%*
Hmean     recv-3312      2542.36 (   0.00%)     2485.23 *  -2.25%* 
2728.74 *   7.33%*
Hmean     recv-4096      2935.69 (   0.00%)     2861.09 *  -2.54%* 
3160.74 *   7.67%*
Hmean     recv-8192      4800.35 (   0.00%)     4678.15 *  -2.55%* 
5090.36 *   6.04%*
Hmean     recv-16384     7473.63 (   0.00%)     7349.52 *  -1.66%* 
7786.25 *   4.18%*

I am happy to re-run v4 if there will be, but for now:

Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
