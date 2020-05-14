Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB5CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BAE206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgENJxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:53:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENJxe (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:53:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E9WEU8192547;
        Thu, 14 May 2020 05:53:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 310x51hndj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:53:25 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04E9o1ds095412;
        Thu, 14 May 2020 05:53:23 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 310x51hnd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:53:23 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04E9pxoi008764;
        Thu, 14 May 2020 09:53:22 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3100ubs7au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 09:53:22 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04E9rM2x50397450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 09:53:22 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F79DAE062;
        Thu, 14 May 2020 09:53:22 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F7F0AE05C;
        Thu, 14 May 2020 09:53:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.187.215])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 May 2020 09:53:18 +0000 (GMT)
Subject: Re: [PATCH v5 0/5] perf stat: Support overall statistics for interval
 mode
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200514053638.3736-1-yao.jin@linux.intel.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <104037dd-5e2e-a6fd-51ae-2e0a1cc2860a@linux.ibm.com>
Date:   Thu, 14 May 2020 15:23:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200514053638.3736-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 cotscore=-2147483648 clxscore=1015
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/20 11:06 AM, Jin Yao wrote:
> Currently perf-stat supports to print counts at regular interval (-I),
> but it's not very easy for user to get the overall statistics.
> 
> With this patchset, it supports to report the summary at the end of
> interval output.
> 
> For example,
> 
>  root@kbl-ppc:~# perf stat -e cycles -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000412064          2,281,114      cycles
>       2.001383658          2,547,880      cycles
> 
>   Performance counter stats for 'system wide':
> 
>           4,828,994      cycles
> 
>         2.002860349 seconds time elapsed
> 
>  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000389902          1,536,093      cycles
>       1.000389902            420,226      instructions              #    0.27  insn per cycle
>       2.001433453          2,213,952      cycles
>       2.001433453            735,465      instructions              #    0.33  insn per cycle
> 
>   Performance counter stats for 'system wide':
> 
>           3,750,045      cycles
>           1,155,691      instructions              #    0.31  insn per cycle
> 
>         2.003023361 seconds time elapsed
> 
>  root@kbl-ppc:~# perf stat -M CPI,IPC -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000435121            905,303      inst_retired.any          #      2.9 CPI
>       1.000435121          2,663,333      cycles
>       1.000435121            914,702      inst_retired.any          #      0.3 IPC
>       1.000435121          2,676,559      cpu_clk_unhalted.thread
>       2.001615941          1,951,092      inst_retired.any          #      1.8 CPI
>       2.001615941          3,551,357      cycles
>       2.001615941          1,950,837      inst_retired.any          #      0.5 IPC
>       2.001615941          3,551,044      cpu_clk_unhalted.thread
> 
>   Performance counter stats for 'system wide':
> 
>           2,856,395      inst_retired.any          #      2.2 CPI
>           6,214,690      cycles
>           2,865,539      inst_retired.any          #      0.5 IPC
>           6,227,603      cpu_clk_unhalted.thread
> 
>         2.003403078 seconds time elapsed

Hi Jin,
	Reporting the summary will be great for understanding overall stats. So, Before the
patch where we are reseting rt_stat before read_counters to make sure, whatever printing
in final aggregate is as per counts on that interval, 

we used to update stats->means and other info as described in 

RFC: https://lkml.org/lkml/2020/3/24/158

Now, stats->means is same as counts which we are using in generic_metric function. Is this expected behavior?
I am not sure, if data like stats->means and all suppose to update per interval or we are using it somewhere else.

So, As we call update_stats for each event and for each interval, can we somehow use that
to print overall stats maybe by adding some var in `struct stats` to keep count of total counts for that event.
Please let me know if my understanding is fine.

Thanks,
Kajol Jain


 
> 
>  v5:
>  ---
>  1. Create new patch "perf stat: Save aggr value to first member
>     of prev_raw_counts".
> 
>  2. Call perf_evlist__save_aggr_prev_raw_counts to save aggr value
>     to first member of prev_raw_counts for AGGR_GLOBAL. Then next,
>     perf_stat_process_counter can create aggr values from per cpu
>     values.
> 
>  Following patches are impacted in v5:
>     perf stat: Copy counts from prev_raw_counts to evsel->counts
>     perf stat: Save aggr value to first member of prev_raw_counts
>     perf stat: Report summary for interval mode
> 
>  v4:
>  ---
>  1. Create runtime_stat_reset.
> 
>  2. Zero the aggr in perf_counts__reset and use it to reset
>     prev_raw_counts.
> 
>  3. Move affinity setup and read_counter_cpu to a new function
>     read_affinity_counters. It's only called when stat_config.summary
>     is not set.
> 
>  v3:
>  ---
>  1. 'perf stat: Fix wrong per-thread runtime stat for interval mode'
>     is a new patch which fixes an existing issue found in test.
> 
>  2. We use the prev_raw_counts for summary counts. Drop the summary_counts in v2.
> 
>  3. Fix some issues.
> 
>  v2:
>  ---
>  Rebase to perf/core branch
> 
> Jin Yao (5):
>   perf stat: Fix wrong per-thread runtime stat for interval mode
>   perf counts: Reset prev_raw_counts counts
>   perf stat: Copy counts from prev_raw_counts to evsel->counts
>   perf stat: Save aggr value to first member of prev_raw_counts
>   perf stat: Report summary for interval mode
> 
>  tools/perf/builtin-stat.c | 101 ++++++++++++++++++++++++++------------
>  tools/perf/util/counts.c  |   4 +-
>  tools/perf/util/counts.h  |   1 +
>  tools/perf/util/stat.c    |  43 +++++++++++++---
>  tools/perf/util/stat.h    |   3 ++
>  5 files changed, 113 insertions(+), 39 deletions(-)
> 
