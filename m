Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61B2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1C8207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFZKAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:00:53 -0400
Received: from foss.arm.com ([217.140.110.172]:60038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgFZKAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:00:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A0101FB;
        Fri, 26 Jun 2020 03:00:52 -0700 (PDT)
Received: from [10.37.12.15] (unknown [10.37.12.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71E063F71E;
        Fri, 26 Jun 2020 03:00:49 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] sched: Optionally skip uclamp logic in fast path
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        linux-kernel@vger.kernel.org
References: <20200625154352.24767-1-qais.yousef@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7aa76981-85f2-f73a-9bbb-d40b3eb38f6c@arm.com>
Date:   Fri, 26 Jun 2020 11:00:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200625154352.24767-1-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 6/25/20 4:43 PM, Qais Yousef wrote:
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
> Changes in v4:
> 	* Fix broken boosting of RT tasks when static key is disabled.
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


I've tried this v4 series with mmtest netperf-udp (30x each UDP
size) - results are good (just double checking and making sure
the tag indicating that v4 was tested can be applied).

                       v5.7-rc7-base-noucl    v5.7-rc7-ucl-tsk-nofix 
v5.7-rc7-ucl-tsk-grp-fix_v4
Hmean     send-64          62.15 (   0.00%)       59.65 *  -4.02%* 
65.86 *   5.97%*
Hmean     send-128        122.88 (   0.00%)      119.37 *  -2.85%* 
131.75 *   7.22%*
Hmean     send-256        244.85 (   0.00%)      234.26 *  -4.32%* 
259.33 *   5.92%*
Hmean     send-1024       919.24 (   0.00%)      880.67 *  -4.20%* 
979.49 *   6.55%*
Hmean     send-2048      1689.45 (   0.00%)     1647.54 *  -2.48%* 
1805.21 *   6.85%*
Hmean     send-3312      2542.36 (   0.00%)     2485.23 *  -2.25%* 
2658.30 *   4.56%*
Hmean     send-4096      2935.69 (   0.00%)     2861.09 *  -2.54%* 
3083.08 *   5.02%*
Hmean     send-8192      4800.35 (   0.00%)     4680.09 *  -2.51%* 
4984.22 *   3.83%*
Hmean     send-16384     7473.66 (   0.00%)     7349.60 *  -1.66%* 
7703.88 *   3.08%*
Hmean     recv-64          62.15 (   0.00%)       59.65 *  -4.03%* 
65.85 *   5.96%*
Hmean     recv-128        122.88 (   0.00%)      119.37 *  -2.85%* 
131.74 *   7.21%*
Hmean     recv-256        244.84 (   0.00%)      234.26 *  -4.32%* 
259.33 *   5.92%*
Hmean     recv-1024       919.24 (   0.00%)      880.67 *  -4.20%* 
979.46 *   6.55%*
Hmean     recv-2048      1689.44 (   0.00%)     1647.54 *  -2.48%* 
1805.17 *   6.85%*
Hmean     recv-3312      2542.36 (   0.00%)     2485.23 *  -2.25%* 
2657.67 *   4.54%*
Hmean     recv-4096      2935.69 (   0.00%)     2861.09 *  -2.54%* 
3082.58 *   5.00%*
Hmean     recv-8192      4800.35 (   0.00%)     4678.15 *  -2.55%* 
4982.49 *   3.79%*
Hmean     recv-16384     7473.63 (   0.00%)     7349.52 *  -1.66%* 
7701.53 *   3.05%*

You can add my:

Tested-by: Lukasz Luba <lukasz.luba@arm.com>

If anyone would like to see some other tests, please let me know,
maybe I can setup something.

Regards,
Lukasz
