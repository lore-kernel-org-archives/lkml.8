Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05664C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83EA20734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgFPMd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:33:26 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:58851 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgFPMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:33:25 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 46BD8FAA1B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:33:22 +0100 (IST)
Received: (qmail 25132 invoked from network); 16 Jun 2020 12:33:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Jun 2020 12:33:21 -0000
Date:   Tue, 16 Jun 2020 13:33:20 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Hillf Danton <hdanton@sina.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [sched/core] 2ebb177175: will-it-scale.per_thread_ops -3.7%
 regression
Message-ID: <20200616123320.GH3183@techsingularity.net>
References: <20200616073908.GG5653@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616073908.GG5653@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:39:08PM +0800, kernel test robot wrote:
> 
> FYI, we noticed a -3.7% regression of will-it-scale.per_thread_ops due to commit:
> 

Thanks.

> 
> commit: 2ebb17717550607bcd85fb8cf7d24ac870e9d762 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: will-it-scale
> on test machine: 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz with 16G memory
> with following parameters:
> 
> <SNIP>
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+--------------------------------------------------------------------------+
> | testcase: change | lmbench3: lmbench3.AF_UNIX.sock.stream.bandwidth.MB/sec 5.1% improvement |
> | test machine     | 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 48G memory         |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | mode=development                                                         |
> |                  | nr_threads=50%                                                           |
> |                  | test=UNIX                                                                |
> |                  | test_memory_size=50%                                                     |
> |                  | ucode=0x7000019                                                          |
> +------------------+--------------------------------------------------------------------------+
> | testcase: change | vm-scalability: vm-scalability.throughput 4.6% improvement               |
> | test machine     | 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory        |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | runtime=300s                                                             |
> |                  | size=2T                                                                  |
> |                  | test=shm-pread-seq-mt                                                    |
> |                  | ucode=0xca                                                               |
> +------------------+--------------------------------------------------------------------------+
> 

This is telling me that there are both wins and losses due to the
patch. That is not entirely unexpected given the nature of the patch and
how it impacts timings.

> c6e7bd7afaeb3af5 2ebb17717550607bcd85fb8cf7d 
> ---------------- --------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>            :4           25%           1:4     dmesg.RIP:find_vma
>           1:4          -25%            :4     dmesg.RIP:loop
>            :4           25%           1:4     dmesg.RIP:poll_idle
>            :4           25%           1:4     dmesg.RIP:release_pages
>            :4           25%           1:4     kmsg.a562403>]usb_hcd_irq
>           1:4          -25%            :4     kmsg.a9be0b>]usb_hcd_irq
>            :4           25%           1:4     kmsg.c867d3b>]usb_hcd_irq
>            :4           25%           1:4     kmsg.e2bf9>]usb_hcd_irq
>           1:4          -25%            :4     kmsg.e6afaad>]usb_hcd_irq
>           1:4          -25%            :4     kmsg.ef22>]usb_hcd_irq
>          %stddev     %change         %stddev
>              \          |                \  
>    1564377            -3.7%    1506585        will-it-scale.per_thread_ops
>   12515025            -3.7%   12052684        will-it-scale.workload

What is the variability here? The stddev is blank.

>       7295 ± 18%     +32.3%       9651 ±  3%  slabinfo.kmalloc-32.active_objs
>       7295 ± 18%     +32.3%       9651 ±  3%  slabinfo.kmalloc-32.num_objs
>      52712 ±167%     -99.8%     122.25 ±  9%  softirqs.CPU7.NET_RX
>     167833 ± 37%     -96.0%       6770 ± 70%  softirqs.NET_RX

This is curious, why was there a storm of network traffic during the
baseline run? It may not matter but I find it interesting that there was
different background traffic during the two tests.

>       8.17            -6.2        1.95 ±  2%  mpstat.cpu.all.idle%
>       0.05 ± 39%      -0.0        0.00 ± 92%  mpstat.cpu.all.soft%
>      36.39            +4.6       40.97        mpstat.cpu.all.usr%
>      54.75            +2.3%      56.00        vmstat.cpu.sy
>      36.00           +11.8%      40.25        vmstat.cpu.us
>     879009            +9.8%     964967        vmstat.system.cs
>      80622          +438.9%     434480        vmstat.system.in
>    8567964 ± 11%     -24.3%    6482942 ±  4%  cpuidle.C1.time
>    7399663 ± 10%     -46.7%    3944245 ±  5%  cpuidle.C1.usage
>    4762729 ± 15%     -76.7%    1108338 ±  4%  cpuidle.C1E.time
>    2825633 ± 12%     -92.5%     213227 ± 11%  cpuidle.C1E.usage
>    1392828 ± 18%     -89.8%     142380 ± 13%  cpuidle.C3.usage
>    9138464 ± 19%     -39.7%    5510711 ± 12%  cpuidle.C6.time
>   49832321           -80.0%    9988732 ±  5%  cpuidle.POLL.time
>   67398769 ±  2%     -89.1%    7335934 ±  6%  cpuidle.POLL.usage

This generally indicates that CPUs are spending less time in C-states
and more likely to be active. In itself, this is not a bad thing.

>   18365719           -91.7%    1533497 ±  4%  interrupts.RES:Rescheduling_interrupts
>     103.25 ±  5%    +159.1%     267.50 ±  5%  interrupts.TLB:TLB_shootdowns
>      13.47 ±  3%     -19.3%      10.86 ±  3%  perf-stat.i.MPKI
>  1.746e+09            +1.9%  1.779e+09        perf-stat.i.branch-instructions
>   47675183            +1.8%   48541350        perf-stat.i.branch-misses
>  1.145e+08 ±  3%     -18.3%   93535517 ±  3%  perf-stat.i.cache-references
>     885445            +9.7%     971331        perf-stat.i.context-switches
>       3.43            -1.1%       3.39        perf-stat.i.cpi
>  2.155e+09            +3.4%  2.228e+09        perf-stat.i.dTLB-loads
>   1.73e+09            +5.6%  1.827e+09        perf-stat.i.dTLB-stores
>    5869850 ±  5%     -16.5%    4900813        perf-stat.i.iTLB-load-misses
>     786437 ± 13%     -30.9%     543649 ± 16%  perf-stat.i.iTLB-loads
>  8.535e+09            +1.3%  8.642e+09        perf-stat.i.instructions
>       1492 ±  4%     +20.6%       1798        perf-stat.i.instructions-per-iTLB-miss
>       0.29            +1.1%       0.30        perf-stat.i.ipc
>     720.16            +3.2%     742.92        perf-stat.i.metric.M/sec
>      13.41 ±  3%     -19.3%      10.82 ±  3%  perf-stat.overall.MPKI
>       3.42            -1.1%       3.39        perf-stat.overall.cpi
>       1457 ±  4%     +21.0%       1763        perf-stat.overall.instructions-per-iTLB-miss
>       0.29            +1.1%       0.30        perf-stat.overall.ipc
>     205548            +5.0%     215927        perf-stat.overall.path-length
>   1.74e+09            +1.9%  1.773e+09        perf-stat.ps.branch-instructions
>   47519673            +1.8%   48383718        perf-stat.ps.branch-misses
>  1.141e+08 ±  3%     -18.3%   93221019 ±  3%  perf-stat.ps.cache-references
>     882476            +9.7%     968061        perf-stat.ps.context-switches
>  2.148e+09            +3.4%  2.221e+09        perf-stat.ps.dTLB-loads
>  1.724e+09            +5.6%  1.821e+09        perf-stat.ps.dTLB-stores
>    5850190 ±  5%     -16.5%    4884334        perf-stat.ps.iTLB-load-misses
>     783812 ± 13%     -30.9%     541830 ± 16%  perf-stat.ps.iTLB-loads
>  8.507e+09            +1.3%  8.614e+09        perf-stat.ps.instructions
>  2.572e+12            +1.2%  2.602e+12        perf-stat.total.instructions

I'm not getting much out of this. I was hoping to see something on
dcache hit/miss rates but only cache-references are mentioned. I think
what is happening is that the threads are staying active to contend on a
shared mutex more and incurring more cache misses as a result.

>       8.95 ±  2%      -6.5        2.50 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.futex_wake.do_futex.__x64_sys_futex
>       9.15 ±  2%      -6.4        2.79 ±  3%  perf-profile.calltrace.cycles-pp.wake_up_q.futex_wake.do_futex.__x64_sys_futex.do_syscall_64

Less time spend in try_to_wake_up which is not surprising given the
patch is meant to avoid spinning in that path.

>      22.31            -4.6       17.69        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lll_unlock_wake
>      21.97            -4.6       17.37        perf-profile.calltrace.cycles-pp.futex_wake.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      40.70            -4.6       36.13        perf-profile.calltrace.cycles-pp.__lll_unlock_wake
>      23.13            -4.6       18.56        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lll_unlock_wake
>      30.54            -4.5       26.03        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lll_unlock_wake
>      31.06            -4.5       26.59        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__lll_unlock_wake
>       2.81 ±  5%      -2.4        0.40 ± 58%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>       3.15 ± 10%      -1.9        1.28 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>       3.11 ± 10%      -1.8        1.26 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary

Less going into idle, generally good.

Overall, I do not think there is something worth digging into here.
Two other reports showed performance gains and the data for this profile
shows that the threads are likely spending more time being active so
they can contend on the mutex more aggressively. Having multiple threads
contend on the same mutex in a loop looks like an anti-pattern and I do
not think we want to artificially starve/stall threads just to make that
particular figure look good.

-- 
Mel Gorman
SUSE Labs
