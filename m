Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AEDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A67D20781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbgGAQcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:32:16 -0400
Received: from foss.arm.com ([217.140.110.172]:55902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbgGAQcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:32:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D41431B;
        Wed,  1 Jul 2020 09:32:14 -0700 (PDT)
Received: from [10.37.12.71] (unknown [10.37.12.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F8133F68F;
        Wed,  1 Jul 2020 09:32:11 -0700 (PDT)
Subject: Re: [PATCH v6 0/2] sched: Optionally skip uclamp logic in fast path
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
References: <20200630112123.12076-1-qais.yousef@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c7e1d57e-5388-aaf0-1cde-2ebc9fbdd8c0@arm.com>
Date:   Wed, 1 Jul 2020 17:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200630112123.12076-1-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 6/30/20 12:21 PM, Qais Yousef wrote:
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
> Changes in v6:
> 	* s/uclamp_is_enabled/uclamp_is_used/ + add comment
> 	* Improve the bailout condition for the case where we could end up with
> 	  unbalanced call of uclamp_rq_dec_id()
> 	* Clarify some comments.
> 

I've tried this v6 series with mmtest netperf-udp (30x each UDP
size) - the results are good.

                       v5.7-rc7-base-noucl    v5.7-rc7-ucl-tsk-nofix 
v5.7-rc7-ucl-tsk-grp-fix_v6
Hmean     send-64          62.15 (   0.00%)       59.65 *  -4.02%* 
65.87 *   5.99%*
Hmean     send-128        122.88 (   0.00%)      119.37 *  -2.85%* 
131.76 *   7.23%*
Hmean     send-256        244.85 (   0.00%)      234.26 *  -4.32%* 
259.87 *   6.14%*
Hmean     send-1024       919.24 (   0.00%)      880.67 *  -4.20%* 
975.48 *   6.12%*
Hmean     send-2048      1689.45 (   0.00%)     1647.54 *  -2.48%* 
1797.23 *   6.38%*
Hmean     send-3312      2542.36 (   0.00%)     2485.23 *  -2.25%* 
2665.69 *   4.85%*
Hmean     send-4096      2935.69 (   0.00%)     2861.09 *  -2.54%* 
3087.79 *   5.18%*
Hmean     send-8192      4800.35 (   0.00%)     4680.09 *  -2.51%* 
4966.50 *   3.46%*
Hmean     send-16384     7473.66 (   0.00%)     7349.60 *  -1.66%* 
7598.49 *   1.67%*
Hmean     recv-64          62.15 (   0.00%)       59.65 *  -4.03%* 
65.86 *   5.97%*
Hmean     recv-128        122.88 (   0.00%)      119.37 *  -2.85%* 
131.76 *   7.23%*
Hmean     recv-256        244.84 (   0.00%)      234.26 *  -4.32%* 
259.80 *   6.11%*
Hmean     recv-1024       919.24 (   0.00%)      880.67 *  -4.20%* 
975.42 *   6.11%*
Hmean     recv-2048      1689.44 (   0.00%)     1647.54 *  -2.48%* 
1797.18 *   6.38%*
Hmean     recv-3312      2542.36 (   0.00%)     2485.23 *  -2.25%* 
2665.53 *   4.84%*
Hmean     recv-4096      2935.69 (   0.00%)     2861.09 *  -2.54%* 
3087.79 *   5.18%*
Hmean     recv-8192      4800.35 (   0.00%)     4678.15 *  -2.55%* 
4966.48 *   3.46%*
Hmean     recv-16384     7473.63 (   0.00%)     7349.52 *  -1.66%* 
7597.90 *   1.66%*

You can add:

Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
