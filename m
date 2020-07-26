Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCDFC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AE4206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgGZJVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:21:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgGZJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:21:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q94X0s114406;
        Sun, 26 Jul 2020 05:20:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32h1yfcxgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:20:51 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q9KoDe144444;
        Sun, 26 Jul 2020 05:20:50 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32h1yfcxgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:20:50 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9JCLU020645;
        Sun, 26 Jul 2020 09:20:49 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 32gcy2k1v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:20:49 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9Knaj48955760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:20:49 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D8AF28059;
        Sun, 26 Jul 2020 09:20:49 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58EBA28058;
        Sun, 26 Jul 2020 09:20:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:20:45 +0000 (GMT)
Subject: Re: [PATCH 17/19] perf metric: Add metric group test
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
 <20200719181320.785305-18-jolsa@kernel.org>
 <CAP-5=fWmm5pvH-hwkaAKV=__7Ocbc-4Qj8OCJWz_xi4pc65A=Q@mail.gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <58b40fd1-570c-cbeb-50f7-b793b3eaf26e@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:50:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWmm5pvH-hwkaAKV=__7Ocbc-4Qj8OCJWz_xi4pc65A=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/20 4:11 AM, Ian Rogers wrote:
> On Sun, Jul 19, 2020 at 11:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> Adding test for metric group plus compute_metric_group
>> function to get metrics values within the group.
>>
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> 
> Thanks,
> Ian
> 
>> ---
>>  tools/perf/tests/parse-metric.c | 48 +++++++++++++++++++++++++++++++--
>>  1 file changed, 46 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
>> index 5ac32f80f8ea..f2ba5b2c5557 100644
>> --- a/tools/perf/tests/parse-metric.c
>> +++ b/tools/perf/tests/parse-metric.c
>> @@ -18,6 +18,7 @@ static struct pmu_event pme_test[] = {
>>  {
>>         .metric_expr    = "inst_retired.any / cpu_clk_unhalted.thread",
>>         .metric_name    = "IPC",
>> +       .metric_group   = "group1",
>>  },
>>  {
>>         .metric_expr    = "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * "
>> @@ -35,6 +36,7 @@ static struct pmu_event pme_test[] = {
>>  {
>>         .metric_expr    = "(dcache_miss_cpi + icache_miss_cycles)",
>>         .metric_name    = "cache_miss_cycles",
>> +       .metric_group   = "group1",
>>  },
>>  {
>>         .metric_expr    = "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
>> @@ -127,7 +129,9 @@ static double compute_single(struct rblist *metric_events, struct evlist *evlist
>>         return 0.;
>>  }
>>
>> -static int compute_metric(const char *name, struct value *vals, double *ratio)
>> +static int __compute_metric(const char *name, struct value *vals,
>> +                           const char *name1, double *ratio1,
>> +                           const char *name2, double *ratio2)
>>  {
>>         struct rblist metric_events = {
>>                 .nr_entries = 0,
>> @@ -166,7 +170,10 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
>>         load_runtime_stat(&st, evlist, vals);
>>
>>         /* And execute the metric */
>> -       *ratio = compute_single(&metric_events, evlist, &st, name);
>> +       if (name1 && ratio1)
>> +               *ratio1 = compute_single(&metric_events, evlist, &st, name1);
>> +       if (name2 && ratio2)
>> +               *ratio2 = compute_single(&metric_events, evlist, &st, name2);
>>
>>         /* ... clenup. */
>>         metricgroup__rblist_exit(&metric_events);
>> @@ -177,6 +184,18 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
>>         return 0;
>>  }
>>
>> +static int compute_metric(const char *name, struct value *vals, double *ratio)
>> +{
>> +       return __compute_metric(name, vals, name, ratio, NULL, NULL);
>> +}
>> +
>> +static int compute_metric_group(const char *name, struct value *vals,
>> +                               const char *name1, double *ratio1,
>> +                               const char *name2, double *ratio2)
>> +{
>> +       return __compute_metric(name, vals, name1, ratio1, name2, ratio2);
>> +}
>> +
>>  static int test_ipc(void)
>>  {
>>         double ratio;
>> @@ -297,6 +316,30 @@ static int test_recursion_fail(void)
>>         return 0;
>>  }
>>
>> +static int test_metric_group(void)
>> +{
>> +       double ratio1, ratio2;
>> +       struct value vals[] = {
>> +               { .event = "cpu_clk_unhalted.thread", .val = 200 },
>> +               { .event = "l1d-loads-misses",        .val = 300 },
>> +               { .event = "l1i-loads-misses",        .val = 200 },
>> +               { .event = "inst_retired.any",        .val = 400 },
>> +               { 0 },
>> +       };
>> +
>> +       TEST_ASSERT_VAL("failed to find recursion",
>> +                       compute_metric_group("group1", vals,
>> +                                            "IPC", &ratio1,
>> +                                            "cache_miss_cycles", &ratio2) == 0);
>> +
>> +       TEST_ASSERT_VAL("group IPC failed, wrong ratio",
>> +                       ratio1 == 2.0);
>> +
>> +       TEST_ASSERT_VAL("group cache_miss_cycles failed, wrong ratio",
>> +                       ratio2 == 1.25);
>> +       return 0;
>> +}
>> +
>>  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
>>  {
>>         TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
>> @@ -304,5 +347,6 @@ int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unu
>>         TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
>>         TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
>>         TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
>> +       TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
>>         return 0;
>>  }
>> --
>> 2.25.4
>>
