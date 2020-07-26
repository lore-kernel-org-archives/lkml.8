Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E8C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2D5206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgGZJUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:20:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgGZJUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:20:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q93NZ7146088;
        Sun, 26 Jul 2020 05:19:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32gdmbhufc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:19:54 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q9HRGc025446;
        Sun, 26 Jul 2020 05:19:54 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32gdmbhuf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:19:53 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9JHQH020708;
        Sun, 26 Jul 2020 09:19:53 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 32gcy2k1nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:19:53 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9Jqse52298102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:19:52 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37E3E28059;
        Sun, 26 Jul 2020 09:19:52 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EA902805A;
        Sun, 26 Jul 2020 09:19:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:19:47 +0000 (GMT)
Subject: Re: [PATCH 14/19] perf metric: Add DCache_L2 to metric parse test
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
 <20200719181320.785305-15-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <7addd402-9d59-674e-8d02-0e330cb5665f@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:49:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200719181320.785305-15-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_03:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007260069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/20 11:43 PM, Jiri Olsa wrote:
> Adding test that compute DCache_L2 metrics with other related metrics in it.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> ---
>  tools/perf/tests/parse-metric.c | 71 +++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 28f33893338b..aa4d5a9f09a8 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -36,6 +36,27 @@ static struct pmu_event pme_test[] = {
>  	.metric_expr	= "(dcache_miss_cpi + icache_miss_cycles)",
>  	.metric_name	= "cache_miss_cycles",
>  },
> +{
> +	.metric_expr	= "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
> +	.metric_name	= "DCache_L2_All_Hits",
> +},
> +{
> +	.metric_expr	= "max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + "
> +			  "l2_rqsts.pf_miss + l2_rqsts.rfo_miss",
> +	.metric_name	= "DCache_L2_All_Miss",
> +},
> +{
> +	.metric_expr	= "dcache_l2_all_hits + dcache_l2_all_miss",
> +	.metric_name	= "DCache_L2_All",
> +},
> +{
> +	.metric_expr	= "d_ratio(dcache_l2_all_hits, dcache_l2_all)",
> +	.metric_name	= "DCache_L2_Hits",
> +},
> +{
> +	.metric_expr	= "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
> +	.metric_name	= "DCache_L2_Misses",
> +},
>  };
>  
>  static struct pmu_events_map map = {
> @@ -194,10 +215,60 @@ static int test_cache_miss_cycles(void)
>  	return 0;
>  }
>  
> +
> +/*
> + * DCache_L2_All_Hits = l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hi
> + * DCache_L2_All_Miss = max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) +
> + *                      l2_rqsts.pf_miss + l2_rqsts.rfo_miss
> + * DCache_L2_All      = dcache_l2_all_hits + dcache_l2_all_miss
> + * DCache_L2_Hits     = d_ratio(dcache_l2_all_hits, dcache_l2_all)
> + * DCache_L2_Misses   = d_ratio(dcache_l2_all_miss, dcache_l2_all)
> + *
> + * l2_rqsts.demand_data_rd_hit = 100
> + * l2_rqsts.pf_hit             = 200
> + * l2_rqsts.rfo_hi             = 300
> + * l2_rqsts.all_demand_data_rd = 400
> + * l2_rqsts.pf_miss            = 500
> + * l2_rqsts.rfo_miss           = 600
> + *
> + * DCache_L2_All_Hits = 600
> + * DCache_L2_All_Miss = MAX(400 - 100, 0) + 500 + 600 = 1400
> + * DCache_L2_All      = 600 + 1400  = 2000
> + * DCache_L2_Hits     = 600 / 2000  = 0.3
> + * DCache_L2_Misses   = 1400 / 2000 = 0.7
> + */
> +static int test_dcache_l2(void)
> +{
> +	double ratio;
> +	struct value vals[] = {
> +		{ .event = "l2_rqsts.demand_data_rd_hit", .val = 100 },
> +		{ .event = "l2_rqsts.pf_hit",             .val = 200 },
> +		{ .event = "l2_rqsts.rfo_hit",            .val = 300 },
> +		{ .event = "l2_rqsts.all_demand_data_rd", .val = 400 },
> +		{ .event = "l2_rqsts.pf_miss",            .val = 500 },
> +		{ .event = "l2_rqsts.rfo_miss",           .val = 600 },
> +		{ 0 },
> +	};
> +
> +	TEST_ASSERT_VAL("failed to compute metric",
> +			compute_metric("DCache_L2_Hits", vals, &ratio) == 0);
> +
> +	TEST_ASSERT_VAL("DCache_L2_Hits failed, wrong ratio",
> +			ratio == 0.3);
> +
> +	TEST_ASSERT_VAL("failed to compute metric",
> +			compute_metric("DCache_L2_Misses", vals, &ratio) == 0);
> +
> +	TEST_ASSERT_VAL("DCache_L2_Misses failed, wrong ratio",
> +			ratio == 0.7);
> +	return 0;
> +}
> +
>  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
>  	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
>  	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
> +	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
>  	return 0;
>  }
> 
