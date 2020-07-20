Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A3AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374A122B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGTGoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:44:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgGTGoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:44:14 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06K6WXnc110456;
        Mon, 20 Jul 2020 02:44:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvqu99s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 02:44:09 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06K6Xfp0116411;
        Mon, 20 Jul 2020 02:44:08 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvqu99rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 02:44:08 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06K6TJ28007607;
        Mon, 20 Jul 2020 06:44:07 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 32brq86wem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 06:44:07 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06K6i3uR54854138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 06:44:03 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8089C6E056;
        Mon, 20 Jul 2020 06:44:06 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 665AA6E053;
        Mon, 20 Jul 2020 06:44:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.114.242])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 06:44:01 +0000 (GMT)
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
References: <20200719181320.785305-1-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <dbe59791-937d-de95-4ba0-c34e7a1cd273@linux.ibm.com>
Date:   Mon, 20 Jul 2020 12:14:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_01:2020-07-17,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/20 11:43 PM, Jiri Olsa wrote:
> hi,
> this patchset is adding the support to reused metric in
> another metric.
> 
> For example, to define IPC by using CPI with change like:
> 
>      {
>          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> +        "MetricExpr": "1/CPI",
>          "MetricGroup": "TopDownL1",
>          "MetricName": "IPC"
>      },
> 
> I won't be able to find all the possible places we could
> use this at, so I wonder you guys (who was asking for this)
> would try it and come up with comments if there's something
> missing or we could already use it at some places.
> 
> It's based on Arnaldo's tmp.perf/core.
> 
> v3 changes:
>   - added some acks
>   - some patches got merged
>   - added missing zalloc include [John Garry]
>   - added ids array outside the egroup object [Ian]
>   - removed wrong m->has_constraint assignment [Ian]
>   - renamed 'list' to 'metric_list' [Ian]
>   - fixed group metric and added test for it [Paul A. Clarke]
>   - fixed memory leak [Arnaldo]
>   - using lowercase keys for metrics in hashmap, because jevents
>     converts metric_expr to lowercase
> 
> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/metric
> 

Hi Jiri,
   I am trying to review these patches and also test it in power box. I am testing your `perf/metric` branch.
With your current patches,some of hv-24x7 events not giving appropriate result
while doing "--metric-only" command. I can't see corresponding output for all chips.

This is output on power9 machine:

Without your patches on upstream kernel:

command# ./perf stat --metric-only -M PowerBUS_Frequency -I 1000 -C 0
#           time GHz  PowerBUS_Frequency_0 GHz  PowerBUS_Frequency_1 
     1.000073877                        2.0                        2.0 
     2.000240551                        2.0                        1.9 
^C     2.452590532                        0.9                        0.9 

 Performance counter stats for 'CPU(s) 0':

                       4.8                        4.8 

       2.452654834 seconds time elapsed

With your patches on perf/metric branch:

command# ./perf stat --metric-only -M PowerBUS_Frequency -I 1000 -C 0
assertion failed at util/metricgroup.c:709
#           time GHz  PowerBUS_Frequency_0 
     1.000073875                        2.0 
     2.000380706                        2.0 
^C     2.658962182                        1.3 

 Performance counter stats for 'CPU(s) 0':

                       5.2 

Please let me know, if I am missing something. 

Thanks,
Kajol Jain

> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (19):
>       perf metric: Fix memory leak in expr__add_id function
>       perf metric: Add expr__add_id function
>       perf metric: Change expr__get_id to return struct expr_id_data
>       perf metric: Add expr__del_id function
>       perf metric: Add macros for iterating map events
>       perf metric: Add add_metric function
>       perf metric: Rename __metricgroup__add_metric to __add_metric
>       perf metric: Collect referenced metrics in struct metric_ref_node
>       perf metric: Collect referenced metrics in struct metric_expr
>       perf metric: Add referenced metrics to hash data
>       perf metric: Compute referenced metrics
>       perf metric: Add events for the current list
>       perf metric: Add cache_miss_cycles to metric parse test
>       perf metric: Add DCache_L2 to metric parse test
>       perf metric: Add recursion check when processing nested metrics
>       perf metric: Make compute_single function more precise
>       perf metric: Add metric group test
>       perf metric: Rename struct egroup to metric
>       perf metric: Rename group_list to metric_list
> 
>  tools/perf/tests/parse-metric.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++++----
>  tools/perf/util/expr.c          | 143 ++++++++++++++++++++++++++++++++-----
>  tools/perf/util/expr.h          |  30 +++++++-
>  tools/perf/util/expr.y          |  16 +++--
>  tools/perf/util/metricgroup.c   | 466 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
>  tools/perf/util/metricgroup.h   |   6 ++
>  tools/perf/util/stat-shadow.c   |  20 ++++--
>  7 files changed, 751 insertions(+), 136 deletions(-)
> 
