Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A87C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446A0206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgFVJGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:06:38 -0400
Received: from foss.arm.com ([217.140.110.172]:59542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgFVJGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:06:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58D1B1FB;
        Mon, 22 Jun 2020 02:06:36 -0700 (PDT)
Received: from [10.37.12.68] (unknown [10.37.12.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B60393F6CF;
        Mon, 22 Jun 2020 02:06:33 -0700 (PDT)
Subject: Re: [PATCH 0/2] sched: Optionally skip uclamp logic in fast path
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        linux-kernel@vger.kernel.org
References: <20200618195525.7889-1-qais.yousef@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b2bfbf7f-b77b-a66e-b256-1cd4cdf260c7@arm.com>
Date:   Mon, 22 Jun 2020 10:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200618195525.7889-1-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 6/18/20 8:55 PM, Qais Yousef wrote:
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
> Thanks
> 
> --
> Qais Yousef
> 

I have given it a try on my machine
(HP server 2 socket 24 CPUs X86 64bit 4 NUMA nodes, AMD Opteron 6174,
L2 512KB/cpu, L3 6MB/node, RAM 40GB/node).
Kernel v5.7-rc7 with Open Suse 15.1 distro config.
The numa control for pinning tasks has not been used.

The results are better than the last time I have checked this uclamp
issue [1]. Here are the results for kernel built based on Suse 15.1
distor config + uclamp tasks + task groups (similar to 3rd kernel from
[1] tests).
They are really good in terms of nteperf-udp performance and how they
deal with statistical noise due to context switch and/or tasks jumping
around CPUs.

The netperf-udp (100 tests for each udp size):
                         ./v5.7-rc7-base    ./v5.7-rc7-uclamp-tsk-grp-fix
Hmean     send-64         62.36 (   0.00%)       66.27 *   6.27%*
Hmean     send-128       124.24 (   0.00%)      132.03 *   6.27%*
Hmean     send-256       244.81 (   0.00%)      261.21 *   6.70%*
Hmean     send-1024      922.18 (   0.00%)      985.84 *   6.90%*
Hmean     send-2048      1716.61 (   0.00%)     1811.30 *   5.52%*
Hmean     send-3312      2564.73 (   0.00%)     2690.62 *   4.91%*
Hmean     send-4096      2967.01 (   0.00%)     3128.71 *   5.45%*
Hmean     send-8192      4834.31 (   0.00%)     5028.15 *   4.01%*
Hmean     send-16384     7569.17 (   0.00%)     7734.05 *   2.18%*
Hmean     recv-64         62.35 (   0.00%)       66.27 *   6.28%*
Hmean     recv-128       124.24 (   0.00%)      132.03 *   6.27%*
Hmean     recv-256       244.79 (   0.00%)      261.20 *   6.70%*
Hmean     recv-1024      922.10 (   0.00%)      985.82 *   6.91%*
Hmean     recv-2048      1716.61 (   0.00%)     1811.29 *   5.52%*
Hmean     recv-3312      2564.46 (   0.00%)     2690.60 *   4.92%*
Hmean     recv-4096      2967.00 (   0.00%)     3128.71 *   5.45%*
Hmean     recv-8192      4834.06 (   0.00%)     5028.05 *   4.01%*
Hmean     recv-16384     7568.70 (   0.00%)     7733.69 *   2.18%*

Statistics info showing performance when there is the context
switch noise and/or tasks are jumping around CPUs. This is from
netperf-udp benchmark but running only 64B test case once with
tracing, but repeated 100 times in bash loop.
Traced functions performance combined and presented in statistical form
(padas dataframe describe() output).
It can be compared with basic kernel results or the similar kernel
(but w/o this fix) results present at [1].
For completeness I also put them below.

kernel with uclamp task + task group + this fix
activate_task
              Hit    Time_us  Avg_us  s^2_us
count     101.00     101.00  101.00  101.00
mean   26,269.33  19,397.98    1.15    0.51
std   123,464.10  90,121.64    0.36    0.19
min       101.00     161.49    0.37    0.03
50%       408.00     479.45    1.26    0.50
75%       720.00     704.05    1.40    0.60
90%     1,795.00   1,071.86    1.57    0.72
95%     3,688.00   1,776.87    1.61    0.79
99%   733,737.00 518,448.60    1.73    1.03
max   756,631.00 537,865.40    1.76    1.06
deactivate_task
                Hit    Time_us  Avg_us  s^2_us
count       101.00     101.00  101.00  101.00
mean    111,714.44  55,791.32    0.80    0.27
std     307,358.56 153,230.31    0.26    0.14
min          88.00      91.73    0.31    0.00
50%         464.00     381.30    0.90    0.29
75%       1,118.00     622.70    1.01    0.36
90%     517,991.00 255,669.50    1.10    0.44
95%     997,663.00 484,013.20    1.12    0.47
99%   1,189,980.00 578,987.30    1.14    0.51
max   1,422,640.00 686,828.60    1.16    0.60


Basic kernel traced functions performance
(no uclamp, no fixes, just built based on distro config)

activate_task
                Hit    Time_us  Avg_us  s^2_us
count       138.00     138.00  138.00  138.00
mean     20,387.44  14,587.33    1.15    0.53
std     114,980.19  81,427.51    0.42    0.23
min         110.00     181.68    0.32    0.00
50%         411.00     461.55    1.32    0.54
75%         881.75     760.08    1.47    0.66
90%       2,885.60   1,302.03    1.61    0.80
95%      55,318.05  41,273.41    1.66    0.92
99%     501,660.04 358,939.04    1.77    1.09
max   1,131,457.00 798,097.30    1.80    1.42
deactivate_task
                Hit    Time_us  Avg_us  s^2_us
count       138.00     138.00  138.00  138.00
mean     81,828.83  39,991.61    0.81    0.28
std     260,130.01 126,386.89    0.28    0.14
min          97.00      92.35    0.26    0.00
50%         424.00     340.35    0.94    0.30
75%       1,062.25     684.98    1.05    0.37
90%     330,657.50 168,320.94    1.11    0.46
95%     748,920.70 359,498.23    1.15    0.51
99%   1,094,614.76 528,459.50    1.21    0.56
max   1,630,473.00 789,476.50    1.25    0.60

Old kernel (w/o fix, uclamp task + tsg grp) which had this uclamp issue

activate_task
                Hit      Time_us  Avg_us  s^2_us
count       273.00       273.00  273.00  273.00
mean     15,958.34    16,471.84    1.58    0.67
std     105,096.88   108,322.03    0.43    0.32
min           3.00         4.96    0.41    0.00
50%         245.00       400.23    1.70    0.64
75%         384.00       565.53    1.85    0.78
90%       1,602.00     1,069.08    1.95    0.95
95%       3,403.00     1,573.74    2.01    1.13
99%     589,484.56   604,992.57    2.11    1.75
max   1,035,866.00 1,096,975.00    2.40    3.08
deactivate_task
                Hit      Time_us  Avg_us  s^2_us
count       273.00       273.00  273.00  273.00
mean     94,607.02    63,433.12    1.02    0.34
std     325,130.91   216,844.92    0.28    0.16
min           2.00         2.79    0.29    0.00
50%         244.00       291.49    1.11    0.36
75%         496.00       448.72    1.19    0.43
90%     120,304.60    82,964.94    1.25    0.55
95%     945,480.60   626,793.58    1.33    0.60
99%   1,485,959.96 1,010,615.72    1.40    0.68
max   2,120,682.00 1,403,280.00    1.80    1.11


Based on these statistics this fix has better distribution in almost all
marked points and better performance results for netperf-udp.

I can run also tests for kernel just with uclamp tasks today, if it's
needed.

Regards,
Lukasz

[1] 
https://lore.kernel.org/lkml/d9c951da-87eb-ab20-9434-f15b34096d66@arm.com/
