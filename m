Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7439EC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5704920714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGZJTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:19:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54760 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgGZJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:19:52 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q92YOF039705;
        Sun, 26 Jul 2020 05:19:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32h2bfmsdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:19:42 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q92kC3040103;
        Sun, 26 Jul 2020 05:19:42 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32h2bfmsds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:19:42 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9JZpn018291;
        Sun, 26 Jul 2020 09:19:41 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 32gcpqrwr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:19:41 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9Jfc047841742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:19:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0003E28058;
        Sun, 26 Jul 2020 09:19:40 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BE682805E;
        Sun, 26 Jul 2020 09:19:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:19:36 +0000 (GMT)
Subject: Re: [PATCH 13/19] perf metric: Add cache_miss_cycles to metric parse
 test
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-14-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <d5fc8fdc-35ee-7e01-eb6b-bfdfce177910@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:49:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200719181320.785305-14-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/20 11:43 PM, Jiri Olsa wrote:
> Adding test that compute metric with other metrics in it.
> 
>   cache_miss_cycles = metric:dcache_miss_cpi + metric:icache_miss_cycles
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> ---
>  tools/perf/tests/parse-metric.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 8c48251425e1..28f33893338b 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -11,6 +11,8 @@
>  #include "debug.h"
>  #include "expr.h"
>  #include "stat.h"
> +#include <perf/cpumap.h>
> +#include <perf/evlist.h>
>  
>  static struct pmu_event pme_test[] = {
>  {
> @@ -22,6 +24,18 @@ static struct pmu_event pme_test[] = {
>  			  "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
>  	.metric_name	= "Frontend_Bound_SMT",
>  },
> +{
> +	.metric_expr	= "l1d\\-loads\\-misses / inst_retired.any",
> +	.metric_name	= "dcache_miss_cpi",
> +},
> +{
> +	.metric_expr	= "l1i\\-loads\\-misses / inst_retired.any",
> +	.metric_name	= "icache_miss_cycles",
> +},
> +{
> +	.metric_expr	= "(dcache_miss_cpi + icache_miss_cycles)",
> +	.metric_name	= "cache_miss_cycles",
> +},
>  };
>  
>  static struct pmu_events_map map = {
> @@ -162,9 +176,28 @@ static int test_frontend(void)
>  	return 0;
>  }
>  
> +static int test_cache_miss_cycles(void)
> +{
> +	double ratio;
> +	struct value vals[] = {
> +		{ .event = "l1d-loads-misses",  .val = 300 },
> +		{ .event = "l1i-loads-misses",  .val = 200 },
> +		{ .event = "inst_retired.any",  .val = 400 },
> +		{ 0 },
> +	};
> +
> +	TEST_ASSERT_VAL("failed to compute metric",
> +			compute_metric("cache_miss_cycles", vals, &ratio) == 0);
> +
> +	TEST_ASSERT_VAL("cache_miss_cycles failed, wrong ratio",
> +			ratio == 1.25);
> +	return 0;
> +}
> +
>  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
>  	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
> +	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
>  	return 0;
>  }
> 
