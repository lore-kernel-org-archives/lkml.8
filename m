Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB8BC433EC
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB96420738
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgGZJTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:19:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbgGZJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:19:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q92fWb056883;
        Sun, 26 Jul 2020 05:18:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32gh92d9s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:18:59 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q9DRcP074785;
        Sun, 26 Jul 2020 05:18:59 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32gh92d9rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:18:59 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9FEBl028608;
        Sun, 26 Jul 2020 09:18:57 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 32gcy50tjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:18:57 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9Ivo546399830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:18:57 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4070628059;
        Sun, 26 Jul 2020 09:18:57 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF82628058;
        Sun, 26 Jul 2020 09:18:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:18:52 +0000 (GMT)
Subject: Re: [PATCH 10/19] perf metric: Add referenced metrics to hash data
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
 <20200719181320.785305-11-jolsa@kernel.org>
 <CAP-5=fVQ8Bu=YroJZH-uKmhKYoiK4VqbEnDjVw8f+7dA0+6y1g@mail.gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <53d650e3-6d8e-07c3-667f-83e14f57825e@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:48:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVQ8Bu=YroJZH-uKmhKYoiK4VqbEnDjVw8f+7dA0+6y1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=2 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/20 4:02 AM, Ian Rogers wrote:
> On Sun, Jul 19, 2020 at 11:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> Adding referenced metrics to the parsing context so they
>> can be resolved during the metric processing.
>>
>> Adding expr__add_ref function to store referenced metrics
>> into parse context.
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
>>  tools/perf/util/expr.c        | 54 +++++++++++++++++++++++++++++++++++
>>  tools/perf/util/expr.h        | 13 ++++++++-
>>  tools/perf/util/stat-shadow.c | 20 +++++++++----
>>  3 files changed, 80 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
>> index f726211f49d4..d3997c2b4a90 100644
>> --- a/tools/perf/util/expr.c
>> +++ b/tools/perf/util/expr.c
>> @@ -4,10 +4,14 @@
>>  #include <errno.h>
>>  #include <stdlib.h>
>>  #include <string.h>
>> +#include "metricgroup.h"
>> +#include "debug.h"
>>  #include "expr.h"
>>  #include "expr-bison.h"
>>  #include "expr-flex.h"
>>  #include <linux/kernel.h>
>> +#include <linux/zalloc.h>
>> +#include <ctype.h>
>>
>>  #ifdef PARSER_DEBUG
>>  extern int expr_debug;
>> @@ -63,6 +67,7 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>>         if (!data_ptr)
>>                 return -ENOMEM;
>>         data_ptr->val = val;
>> +       data_ptr->is_ref = false;
>>
>>         ret = hashmap__set(&ctx->ids, id, data_ptr,
>>                            (const void **)&old_key, (void **)&old_data);
>> @@ -73,6 +78,55 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>>         return ret;
>>  }
>>
>> +int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
>> +{
>> +       struct expr_id_data *data_ptr = NULL, *old_data = NULL;
>> +       char *old_key = NULL;
>> +       char *name, *p;
>> +       int ret;
>> +
>> +       data_ptr = zalloc(sizeof(*data_ptr));
>> +       if (!data_ptr)
>> +               return -ENOMEM;
>> +
>> +       name = strdup(ref->metric_name);
>> +       if (!name) {
>> +               free(data_ptr);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       /*
>> +        * The jevents tool converts all metric expressions
>> +        * to lowercase, including metric references, hence
>> +        * we need to add lowercase name for metric, so it's
>> +        * properly found.
>> +        */
>> +       for (p = name; *p; p++)
>> +               *p = tolower(*p);
>> +
>> +       /*
>> +        * Intentionally passing just const char pointers,
>> +        * originally from 'struct pmu_event' object.
>> +        * We don't need to change them, so there's no
>> +        * need to create our own copy.
>> +        */
>> +       data_ptr->ref.metric_name = ref->metric_name;
>> +       data_ptr->ref.metric_expr = ref->metric_expr;
>> +       data_ptr->is_ref = true;
>> +
>> +       ret = hashmap__set(&ctx->ids, name, data_ptr,
>> +                          (const void **)&old_key, (void **)&old_data);
>> +       if (ret)
>> +               free(data_ptr);
>> +
>> +       pr_debug2("adding ref metric %s: %s\n",
>> +                 ref->metric_name, ref->metric_expr);
>> +
>> +       free(old_key);
>> +       free(old_data);
>> +       return ret;
>> +}
>> +
>>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>>                  struct expr_id_data **data)
>>  {
>> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
>> index 2462abd0ac65..81d04ff7f857 100644
>> --- a/tools/perf/util/expr.h
>> +++ b/tools/perf/util/expr.h
>> @@ -11,12 +11,22 @@
>>  #include "util/hashmap.h"
>>  //#endif
>>
>> +struct metric_ref;
>> +
>>  struct expr_parse_ctx {
>>         struct hashmap ids;
>>  };
>>
>>  struct expr_id_data {
>> -       double  val;
>> +       union {
>> +               double val;
>> +               struct {
>> +                       const char *metric_name;
>> +                       const char *metric_expr;
>> +               } ref;
>> +       };
>> +
>> +       bool is_ref;
>>  };
>>
>>  struct expr_scanner_ctx {
>> @@ -29,6 +39,7 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx);
>>  void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
>>  int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
>>  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
>> +int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
>>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>>                  struct expr_id_data **data);
>>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>> index fc9ac4b4218e..e1ba6c1b916a 100644
>> --- a/tools/perf/util/stat-shadow.c
>> +++ b/tools/perf/util/stat-shadow.c
>> @@ -731,13 +731,14 @@ static void print_smi_cost(struct perf_stat_config *config,
>>  }
>>
>>  static int prepare_metric(struct evsel **metric_events,
>> +                         struct metric_ref *metric_refs,
>>                           struct expr_parse_ctx *pctx,
>>                           int cpu,
>>                           struct runtime_stat *st)
>>  {
>>         double scale;
>>         char *n, *pn;
>> -       int i;
>> +       int i, j, ret;
>>
>>         expr__ctx_init(pctx);
>>         for (i = 0; metric_events[i]; i++) {
>> @@ -778,12 +779,19 @@ static int prepare_metric(struct evsel **metric_events,
>>                         expr__add_id_val(pctx, n, avg_stats(stats)*scale);
>>         }
>>
>> +       for (j = 0; metric_refs && metric_refs[j].metric_name; j++) {
>> +               ret = expr__add_ref(pctx, &metric_refs[j]);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>>         return i;
>>  }
>>
>>  static void generic_metric(struct perf_stat_config *config,
>>                            const char *metric_expr,
>>                            struct evsel **metric_events,
>> +                          struct metric_ref *metric_refs,
>>                            char *name,
>>                            const char *metric_name,
>>                            const char *metric_unit,
>> @@ -798,7 +806,7 @@ static void generic_metric(struct perf_stat_config *config,
>>         int i;
>>         void *ctxp = out->ctx;
>>
>> -       i = prepare_metric(metric_events, &pctx, cpu, st);
>> +       i = prepare_metric(metric_events, metric_refs, &pctx, cpu, st);
>>         if (i < 0)
>>                 return;
>>
>> @@ -847,7 +855,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
>>         struct expr_parse_ctx pctx;
>>         double ratio;
>>
>> -       if (prepare_metric(mexp->metric_events, &pctx, cpu, st) < 0)
>> +       if (prepare_metric(mexp->metric_events, mexp->metric_refs, &pctx, cpu, st) < 0)
>>                 return 0.;
>>
>>         if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
>> @@ -1064,8 +1072,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>>                 else
>>                         print_metric(config, ctxp, NULL, NULL, name, 0);
>>         } else if (evsel->metric_expr) {
>> -               generic_metric(config, evsel->metric_expr, evsel->metric_events, evsel->name,
>> -                               evsel->metric_name, NULL, 1, cpu, out, st);
>> +               generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
>> +                               evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
>>         } else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
>>                 char unit = 'M';
>>                 char unit_buf[10];
>> @@ -1093,7 +1101,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>>                         if (num++ > 0)
>>                                 out->new_line(config, ctxp);
>>                         generic_metric(config, mexp->metric_expr, mexp->metric_events,
>> -                                       evsel->name, mexp->metric_name,
>> +                                       mexp->metric_refs, evsel->name, mexp->metric_name,
>>                                         mexp->metric_unit, mexp->runtime, cpu, out, st);
>>                 }
>>         }
>> --
>> 2.25.4
>>
