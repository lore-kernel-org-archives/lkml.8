Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FFBC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358D22145D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDTFsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:48:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgDTFsY (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:48:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K5VsED060125;
        Mon, 20 Apr 2020 01:48:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gj224hnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 01:48:18 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K5fXMV101200;
        Mon, 20 Apr 2020 01:48:18 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gj224hn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 01:48:18 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03K5j5LO000420;
        Mon, 20 Apr 2020 05:48:17 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 30fs661n3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 05:48:17 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03K5mGIW15205028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 05:48:16 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05F0DBE05D;
        Mon, 20 Apr 2020 05:48:16 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B749BE054;
        Mon, 20 Apr 2020 05:48:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.47.165])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 05:48:11 +0000 (GMT)
Subject: Re: [PATCH] perf stat: Improve runtime stat for interval mode
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200417005154.9024-1-yao.jin@linux.intel.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <4950a109-ff2f-7199-c0f7-5b39ddc5afbb@linux.ibm.com>
Date:   Mon, 20 Apr 2020 11:18:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200417005154.9024-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_01:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/20 6:21 AM, Jin Yao wrote:
> For interval mode, the metric is printed after # if it exists. But
> it's not calculated by the counts generated in this interval. See
> following examples,
> 
>  root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000422803            764,809      inst_retired.any          #      2.9 CPI
>       1.000422803          2,234,932      cycles
>       2.001464585          1,960,061      inst_retired.any          #      1.6 CPI
>       2.001464585          4,022,591      cycles
> 
> The second CPI should not be 1.6 (4,022,591/1,960,061 is 2.1)
> 
>  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000429493          2,869,311      cycles
>       1.000429493            816,875      instructions              #    0.28  insn per cycle
>       2.001516426          9,260,973      cycles
>       2.001516426          5,250,634      instructions              #    0.87  insn per cycle
> 
> The second 'insn per cycle' should not be 0.87 (5,250,634/9,260,973 is 0.57).
> 
> The current code uses a global variable rt_stat for tracking and
> updating the std dev of runtime stat. Unlike the counts, rt_stat is
> not reset for interval. While the counts are reset for interval.
> 
> perf_stat_process_counter()
> {
> 	if (config->interval)
> 		init_stats(ps->res_stats);
> }
> 
> So for interval, the rt_stat should be reset either.
> 
> This patch resets rt_stat before read_counters, so the runtime
> stat is only calculated by the counts generated in this interval.
> 
> With this patch,
> 
>  root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000420924          2,408,818      inst_retired.any          #      2.1 CPI
>       1.000420924          5,010,111      cycles
>       2.001448579          2,798,407      inst_retired.any          #      1.6 CPI
>       2.001448579          4,599,861      cycles
> 
>  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000428555          2,769,714      cycles
>       1.000428555            774,462      instructions              #    0.28  insn per cycle
>       2.001471562          3,595,904      cycles
>       2.001471562          1,243,703      instructions              #    0.35  insn per cycle
>

Hi Jin,
	Thanks for the patch. Was working on similar issue raised by Joakim Zhang.
Here's link to my findings: https://lkml.org/lkml/2020/3/24/158

This patch solves the issue.

Acked-By: Kajol Jain <kjain@linux.ibm.com> and Tested-By: Kajol Jain <kjain@linux.ibm.com>
 
> Now the second 'insn per cycle' and CPI are calculated by the counts
> generated in this interval.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 2 ++
>  tools/perf/builtin-stat.c              | 1 +
>  tools/perf/util/stat-shadow.c          | 5 +++++
>  tools/perf/util/stat.h                 | 1 +
>  4 files changed, 9 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 4d56586b2fb9..3fb5028aef08 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -176,6 +176,8 @@ Print count deltas every N milliseconds (minimum: 1ms)
>  The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
>  	example: 'perf stat -I 1000 -e cycles -a sleep 5'
>  
> +If the metric exists, it is calculated by the counts generated in this interval and the metric is printed after #.
> +
>  --interval-count times::
>  Print count deltas for fixed number of times.
>  This option should be used together with "-I" option.
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ec053dc1e35c..d5c326ff46d0 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -359,6 +359,7 @@ static void process_interval(void)
>  	clock_gettime(CLOCK_MONOTONIC, &ts);
>  	diff_timespec(&rs, &ts, &ref_time);
>  
> +	perf_stat__reset_rt_stat();
>  	read_counters(&rs);
>  
>  	if (STAT_RECORD) {
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 1ad5c5be7e97..c8f5ca6c8749 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -186,6 +186,11 @@ void perf_stat__reset_shadow_stats(void)
>  	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
>  }
>  
> +void perf_stat__reset_rt_stat(void)
> +{
> +	reset_stat(&rt_stat);
> +}
> +
>  void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
>  {
>  	reset_stat(st);
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b4fdfaa7f2c0..2975494166dd 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -176,6 +176,7 @@ void runtime_stat__init(struct runtime_stat *st);
>  void runtime_stat__exit(struct runtime_stat *st);
>  void perf_stat__init_shadow_stats(void);
>  void perf_stat__reset_shadow_stats(void);
> +void perf_stat__reset_rt_stat(void);
>  void perf_stat__reset_shadow_per_stat(struct runtime_stat *st);
>  void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
>  				    int cpu, struct runtime_stat *st);
> 
