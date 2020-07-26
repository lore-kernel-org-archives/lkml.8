Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCA9C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77686206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgGZJVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:21:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbgGZJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:21:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q91faT071018;
        Sun, 26 Jul 2020 05:21:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggw3p0ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:21:27 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q95CD6076855;
        Sun, 26 Jul 2020 05:21:26 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggw3p0j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:21:26 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9JFe4032114;
        Sun, 26 Jul 2020 09:21:25 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 32gcy50tyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:21:25 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9LOhp50463058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:21:24 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7C5D28059;
        Sun, 26 Jul 2020 09:21:24 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A650528058;
        Sun, 26 Jul 2020 09:21:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:21:20 +0000 (GMT)
Subject: Re: [PATCH 19/19] perf metric: Rename group_list to metric_list
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
 <20200719181320.785305-20-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <edc5dfc3-1fd3-754d-396b-a02601a1f8bd@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:51:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200719181320.785305-20-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=2 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/20 11:43 PM, Jiri Olsa wrote:
> Following the previous change that rename egroup
> to metric, there's no reason to call the list
> 'group_list' anymore, renaming it to metric_list.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> ---
>  tools/perf/util/metricgroup.c | 42 +++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 9d5fff36042d..6f179b9903a0 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -639,7 +639,7 @@ int __weak arch_get_runtimeparam(void)
>  	return 1;
>  }
>  
> -static int __add_metric(struct list_head *group_list,
> +static int __add_metric(struct list_head *metric_list,
>  			struct pmu_event *pe,
>  			bool metric_no_group,
>  			int runtime,
> @@ -726,13 +726,13 @@ static int __add_metric(struct list_head *group_list,
>  	if (m->metric_refs_cnt)
>  		return 0;
>  
> -	if (list_empty(group_list))
> -		list_add(&m->nd, group_list);
> +	if (list_empty(metric_list))
> +		list_add(&m->nd, metric_list);
>  	else {
>  		struct list_head *pos;
>  
>  		/* Place the largest groups at the front. */
> -		list_for_each_prev(pos, group_list) {
> +		list_for_each_prev(pos, metric_list) {
>  			struct metric *old = list_entry(pos, struct metric, nd);
>  
>  			if (hashmap__size(&m->pctx.ids) <=
> @@ -813,7 +813,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
>  	return p->id ? 0 : -ENOMEM;
>  }
>  
> -static int add_metric(struct list_head *group_list,
> +static int add_metric(struct list_head *metric_list,
>  		      struct pmu_event *pe,
>  		      bool metric_no_group,
>  		      struct metric **mp,
> @@ -822,7 +822,7 @@ static int add_metric(struct list_head *group_list,
>  
>  static int resolve_metric(struct metric *m,
>  			  bool metric_no_group,
> -			  struct list_head *group_list,
> +			  struct list_head *metric_list,
>  			  struct pmu_events_map *map,
>  			  struct expr_ids *ids)
>  {
> @@ -854,7 +854,7 @@ static int resolve_metric(struct metric *m,
>  			expr__del_id(&m->pctx, cur->key);
>  
>  			/* ... and it gets resolved to the parent context. */
> -			ret = add_metric(group_list, pe, metric_no_group, &m, parent, ids);
> +			ret = add_metric(metric_list, pe, metric_no_group, &m, parent, ids);
>  			if (ret)
>  				return ret;
>  
> @@ -869,7 +869,7 @@ static int resolve_metric(struct metric *m,
>  	return 0;
>  }
>  
> -static int add_metric(struct list_head *group_list,
> +static int add_metric(struct list_head *metric_list,
>  		      struct pmu_event *pe,
>  		      bool metric_no_group,
>  		      struct metric **m,
> @@ -881,7 +881,7 @@ static int add_metric(struct list_head *group_list,
>  	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>  
>  	if (!strstr(pe->metric_expr, "?")) {
> -		ret = __add_metric(group_list, pe, metric_no_group, 1, m, parent, ids);
> +		ret = __add_metric(metric_list, pe, metric_no_group, 1, m, parent, ids);
>  	} else {
>  		int j, count;
>  
> @@ -889,11 +889,11 @@ static int add_metric(struct list_head *group_list,
>  
>  		/* This loop is added to create multiple
>  		 * events depend on count value and add
> -		 * those events to group_list.
> +		 * those events to metric_list.
>  		 */
>  
>  		for (j = 0; j < count && !ret; j++) {
> -			ret = __add_metric(group_list, pe, metric_no_group, j, m, parent, ids);
> +			ret = __add_metric(metric_list, pe, metric_no_group, j, m, parent, ids);
>  		}
>  	}
>  
> @@ -902,7 +902,7 @@ static int add_metric(struct list_head *group_list,
>  
>  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  				   struct strbuf *events,
> -				   struct list_head *group_list,
> +				   struct list_head *metric_list,
>  				   struct pmu_events_map *map)
>  
>  {
> @@ -948,14 +948,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  		}
>  	}
>  
> -	list_splice(&list, group_list);
> +	list_splice(&list, metric_list);
>  	expr_ids__exit(&ids);
>  	return 0;
>  }
>  
>  static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>  					struct strbuf *events,
> -					struct list_head *group_list,
> +					struct list_head *metric_list,
>  					struct pmu_events_map *map)
>  {
>  	char *llist, *nlist, *p;
> @@ -971,7 +971,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>  
>  	while ((p = strsep(&llist, ",")) != NULL) {
>  		ret = metricgroup__add_metric(p, metric_no_group, events,
> -					      group_list, map);
> +					      metric_list, map);
>  		if (ret == -EINVAL) {
>  			fprintf(stderr, "Cannot find metric or group `%s'\n",
>  					p);
> @@ -996,11 +996,11 @@ static void metric__free_refs(struct metric *metric)
>  	}
>  }
>  
> -static void metricgroup__free_metrics(struct list_head *group_list)
> +static void metricgroup__free_metrics(struct list_head *metric_list)
>  {
>  	struct metric *m, *tmp;
>  
> -	list_for_each_entry_safe (m, tmp, group_list, nd) {
> +	list_for_each_entry_safe (m, tmp, metric_list, nd) {
>  		metric__free_refs(m);
>  		expr__ctx_clear(&m->pctx);
>  		list_del_init(&m->nd);
> @@ -1017,13 +1017,13 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  {
>  	struct parse_events_error parse_error;
>  	struct strbuf extra_events;
> -	LIST_HEAD(group_list);
> +	LIST_HEAD(metric_list);
>  	int ret;
>  
>  	if (metric_events->nr_entries == 0)
>  		metricgroup__rblist_init(metric_events);
>  	ret = metricgroup__add_metric_list(str, metric_no_group,
> -					   &extra_events, &group_list, map);
> +					   &extra_events, &metric_list, map);
>  	if (ret)
>  		return ret;
>  	pr_debug("adding %s\n", extra_events.buf);
> @@ -1034,10 +1034,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  		goto out;
>  	}
>  	strbuf_release(&extra_events);
> -	ret = metricgroup__setup_events(&group_list, metric_no_merge,
> +	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
>  					perf_evlist, metric_events);
>  out:
> -	metricgroup__free_metrics(&group_list);
> +	metricgroup__free_metrics(&metric_list);
>  	return ret;
>  }
>  
> 
