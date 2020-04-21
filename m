Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E417C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BB02087E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUHKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:10:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbgDUHKn (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:10:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L6Xbqh088887;
        Tue, 21 Apr 2020 03:10:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmuy9mts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 03:10:33 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03L6gctL113496;
        Tue, 21 Apr 2020 03:10:33 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmuy9mt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 03:10:33 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03L7AKiM005921;
        Tue, 21 Apr 2020 07:10:32 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 30fs66n4f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 07:10:31 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03L7AU7w39649682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 07:10:30 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98F77C6057;
        Tue, 21 Apr 2020 07:10:30 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17CDBC6055;
        Tue, 21 Apr 2020 07:10:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.181.81])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 Apr 2020 07:10:24 +0000 (GMT)
Subject: Re: [PATCH v2] perf stat: Improve runtime stat for interval mode
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200420145417.6864-1-yao.jin@linux.intel.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <3d966653-bba1-f2ee-b77f-8d892f7976da@linux.ibm.com>
Date:   Tue, 21 Apr 2020 12:40:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200420145417.6864-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_02:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/20 8:24 PM, Jin Yao wrote:
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
>         if (config->interval)
>                 init_stats(ps->res_stats);
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
> Now the second 'insn per cycle' and CPI are calculated by the counts
> generated in this interval.
> 
>  v2:
>  ---
>  Use just existing perf_stat__reset_shadow_per_stat(&rt_stat).
>  We don't need to define new function perf_stat__reset_rt_stat.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 2 ++
>  tools/perf/builtin-stat.c              | 1 +
>  2 files changed, 3 insertions(+)
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
> index 9207b6c45475..3f050d85c277 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -359,6 +359,7 @@ static void process_interval(void)
>  	clock_gettime(CLOCK_MONOTONIC, &ts);
>  	diff_timespec(&rs, &ts, &ref_time);
>  
> +	perf_stat__reset_shadow_per_stat(&rt_stat);

Tested-By: Kajol Jain <kjain@linux.ibm.com>

Thanks,
Kajol
>  	read_counters(&rs);
>  
>  	if (STAT_RECORD) {
> 
