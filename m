Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22441C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB54A20714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgGZJSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:18:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgGZJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:18:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q91B8l075526;
        Sun, 26 Jul 2020 05:18:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32gdnshgvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:18:28 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q9GKHj104487;
        Sun, 26 Jul 2020 05:18:28 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32gdnshgvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:18:28 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9FZ9I023380;
        Sun, 26 Jul 2020 09:18:27 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 32gcy90u8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:18:27 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9IRXn11666218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:18:27 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58BE028058;
        Sun, 26 Jul 2020 09:18:27 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 040802805E;
        Sun, 26 Jul 2020 09:18:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:18:22 +0000 (GMT)
Subject: Re: [PATCH 08/19] perf metric: Collect referenced metrics in struct
 metric_ref_node
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
 <20200719181320.785305-9-jolsa@kernel.org>
 <CAP-5=fW59n2_GXVvcfmwiOHks3OWjvB=Et5wqh1a8zupEZci+w@mail.gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <e46d5572-13a5-7917-deb5-f9be3e76678d@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:48:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fW59n2_GXVvcfmwiOHks3OWjvB=Et5wqh1a8zupEZci+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=2 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/20 3:48 AM, Ian Rogers wrote:
> On Sun, Jul 19, 2020 at 11:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> Collecting referenced metrics in struct metric_ref_node object,
>> so we can process them later on.
>>
>> The change will parse nested metric names out of expression and
>> 'resolve' them.
>>
>> All referenced metrics are dissolved into one context, meaning all
>> nested metrics events and added to the parent context.
>>
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> 
>> ---
>>  tools/perf/util/metricgroup.c | 170 +++++++++++++++++++++++++++++++---
>>  1 file changed, 156 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index ccd80538a6ae..d1b2c1aa436f 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -102,12 +102,25 @@ void metricgroup__rblist_exit(struct rblist *metric_events)
>>         rblist__exit(metric_events);
>>  }
>>
>> +/*
>> + * A node in the list of referenced metrics. metric_expr
>> + * is held as a convenience to avoid a search through the
>> + * metric list.
>> + */
>> +struct metric_ref_node {
>> +       const char *metric_name;
>> +       const char *metric_expr;
>> +       struct list_head list;
>> +};
>> +
>>  struct egroup {
>>         struct list_head nd;
>>         struct expr_parse_ctx pctx;
>>         const char *metric_name;
>>         const char *metric_expr;
>>         const char *metric_unit;
>> +       struct list_head metric_refs;
>> +       int metric_refs_cnt;
>>         int runtime;
>>         bool has_constraint;
>>  };
>> @@ -574,27 +587,72 @@ int __weak arch_get_runtimeparam(void)
>>  static int __add_metric(struct list_head *group_list,
>>                         struct pmu_event *pe,
>>                         bool metric_no_group,
>> -                       int runtime)
>> +                       int runtime,
>> +                       struct egroup **egp)
>>  {
>> +       struct metric_ref_node *ref;
>>         struct egroup *eg;
>>
>> -       eg = malloc(sizeof(*eg));
>> -       if (!eg)
>> -               return -ENOMEM;
>> +       if (*egp == NULL) {
>> +               /*
>> +                * We got in here for the parent group,
>> +                * allocate it and put it on the list.
>> +                */
>> +               eg = malloc(sizeof(*eg));
>> +               if (!eg)
>> +                       return -ENOMEM;
>> +
>> +               expr__ctx_init(&eg->pctx);
>> +               eg->metric_name = pe->metric_name;
>> +               eg->metric_expr = pe->metric_expr;
>> +               eg->metric_unit = pe->unit;
>> +               eg->runtime = runtime;
>> +               eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
>> +               INIT_LIST_HEAD(&eg->metric_refs);
>> +               eg->metric_refs_cnt = 0;
>> +               *egp = eg;
>> +       } else {
>> +               /*
>> +                * We got here for the referenced metric, via the
>> +                * recursive metricgroup__add_metric call, add
>> +                * it to the parent group.
>> +                */
>> +               eg = *egp;
>> +
>> +               ref = malloc(sizeof(*ref));
>> +               if (!ref)
>> +                       return -ENOMEM;
>> +
>> +               /*
>> +                * Intentionally passing just const char pointers,
>> +                * from 'pe' object, so they never go away. We don't
>> +                * need to change them, so there's no need to create
>> +                * our own copy.
>> +                */
>> +               ref->metric_name = pe->metric_name;
>> +               ref->metric_expr = pe->metric_expr;
>>
>> -       expr__ctx_init(&eg->pctx);
>> -       eg->metric_name = pe->metric_name;
>> -       eg->metric_expr = pe->metric_expr;
>> -       eg->metric_unit = pe->unit;
>> -       eg->runtime = runtime;
>> -       eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
>> +               list_add(&ref->list, &eg->metric_refs);
>> +               eg->metric_refs_cnt++;
>> +       }
>>
>> +       /*
>> +        * For both the parent and referenced metrics, we parse
>> +        * all the metric's IDs and add it to the parent context.
>> +        */
>>         if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
>>                 expr__ctx_clear(&eg->pctx);
>>                 free(eg);
>>                 return -EINVAL;
>>         }
>>
>> +       /*
>> +        * We add new group only in the 'parent' call,
>> +        * so bail out for referenced metric case.
>> +        */
>> +       if (eg->metric_refs_cnt)
>> +               return 0;
>> +
>>         if (list_empty(group_list))
>>                 list_add(&eg->nd, group_list);
>>         else {
>> @@ -625,16 +683,78 @@ static int __add_metric(struct list_head *group_list,
>>                     (match_metric(__pe->metric_group, __metric) ||      \
>>                      match_metric(__pe->metric_name, __metric)))
>>
>> +static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
>> +{
>> +       struct pmu_event *pe;
>> +       int i;
>> +
>> +       map_for_each_event(pe, i, map) {
>> +               if (match_metric(pe->metric_name, metric))
>> +                       return pe;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static int add_metric(struct list_head *group_list,
>> +                     struct pmu_event *pe,
>> +                     bool metric_no_group,
>> +                     struct egroup **egp);
>> +
>> +static int resolve_metric(struct egroup *eg,
>> +                         bool metric_no_group,
>> +                         struct list_head *group_list,
>> +                         struct pmu_events_map *map)
>> +{
>> +       struct hashmap_entry *cur;
>> +       size_t bkt;
>> +       bool all;
>> +       int ret;
>> +
>> +       /*
>> +        * Iterate all the parsed IDs and if there's metric,
>> +        * add it to the context.
>> +        */
>> +       do {
>> +               all = true;
>> +               hashmap__for_each_entry((&eg->pctx.ids), cur, bkt) {
>> +                       struct pmu_event *pe;
>> +
>> +                       pe = find_metric(cur->key, map);
>> +                       if (!pe)
>> +                               continue;
>> +
>> +                       all = false;
>> +                       /* The metric key itself needs to go out.. */
>> +                       expr__del_id(&eg->pctx, cur->key);
>> +
>> +                       /* ... and it gets resolved to the parent context. */
>> +                       ret = add_metric(group_list, pe, metric_no_group, &eg);
>> +                       if (ret)
>> +                               return ret;
>> +
>> +                       /*
>> +                        * We added new metric to hashmap, so we need
>> +                        * to break the iteration and start over.
>> +                        */
>> +                       break;
>> +               }
>> +       } while (!all);
>> +
>> +       return 0;
>> +}
>> +
>>  static int add_metric(struct list_head *group_list,
>>                       struct pmu_event *pe,
>> -                     bool metric_no_group)
>> +                     bool metric_no_group,
>> +                     struct egroup **egp)
>>  {
>>         int ret = 0;
>>
>>         pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>>
>>         if (!strstr(pe->metric_expr, "?")) {
>> -               ret = __add_metric(group_list, pe, metric_no_group, 1);
>> +               ret = __add_metric(group_list, pe, metric_no_group, 1, egp);
>>         } else {
>>                 int j, count;
>>
>> @@ -646,7 +766,7 @@ static int add_metric(struct list_head *group_list,
>>                  */
>>
>>                 for (j = 0; j < count && !ret; j++) {
>> -                       ret = __add_metric(group_list, pe, metric_no_group, j);
>> +                       ret = __add_metric(group_list, pe, metric_no_group, j, egp);
>>                 }
>>         }
>>
>> @@ -657,6 +777,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>>                                    struct strbuf *events,
>>                                    struct list_head *group_list,
>>                                    struct pmu_events_map *map)
>> +
>>  {
>>         struct pmu_event *pe;
>>         struct egroup *eg;
>> @@ -665,8 +786,18 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>>
>>         map_for_each_metric(pe, i, map, metric) {
>>                 has_match = true;
>> +               eg = NULL;
>>
>> -               ret = add_metric(group_list, pe, metric_no_group);
>> +               ret = add_metric(group_list, pe, metric_no_group, &eg);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               /*
>> +                * Process any possible referenced metrics
>> +                * included in the expression.
>> +                */
>> +               ret = resolve_metric(eg, metric_no_group,
>> +                                    group_list, map);
>>                 if (ret)
>>                         return ret;
>>         }
>> @@ -723,11 +854,22 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>>         return ret;
>>  }
>>
>> +static void egroup__free_refs(struct egroup *egroup)
>> +{
>> +       struct metric_ref_node *ref, *tmp;
>> +
>> +       list_for_each_entry_safe(ref, tmp, &egroup->metric_refs, list) {
>> +               list_del(&ref->list);
>> +               free(ref);
>> +       }
>> +}
>> +
>>  static void metricgroup__free_egroups(struct list_head *group_list)
>>  {
>>         struct egroup *eg, *egtmp;
>>
>>         list_for_each_entry_safe (eg, egtmp, group_list, nd) {
>> +               egroup__free_refs(eg);
>>                 expr__ctx_clear(&eg->pctx);
>>                 list_del_init(&eg->nd);
>>                 free(eg);
>> --
>> 2.25.4
>>
