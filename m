Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D6EC433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47B1206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGZJSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:18:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41938 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727801AbgGZJSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:18:52 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q92ZgE039735;
        Sun, 26 Jul 2020 05:17:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32h2bfmrnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:17:44 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q93JCe040850;
        Sun, 26 Jul 2020 05:17:43 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32h2bfmrn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:17:43 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9FbYn015012;
        Sun, 26 Jul 2020 09:17:43 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 32gcpqrwem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:17:43 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9HgAV50201024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:17:42 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6DD628058;
        Sun, 26 Jul 2020 09:17:42 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AB6F2805A;
        Sun, 26 Jul 2020 09:17:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:17:38 +0000 (GMT)
Subject: Re: [PATCH 05/19] perf metric: Add macros for iterating map events
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
 <20200719181320.785305-6-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <68188ed3-80a7-cf03-bfdd-6bee7ded09ca@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:47:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200719181320.785305-6-jolsa@kernel.org>
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
> Adding following macros to iterate events and metric:
>   map_for_each_event(__pe, __idx, __map)
>     - iterates over all pmu_events_map events
>   map_for_each_metric(__pe, __idx, __map, __metric)
>     - iterates over all metrics that match __metric argument
> 
> and use it in metricgroup__add_metric function. Macros
> will be be used from other places in following changes.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> ---
>  tools/perf/util/metricgroup.c | 77 ++++++++++++++++++-----------------
>  1 file changed, 40 insertions(+), 37 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index df0356ec120d..b37008fc253c 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -614,6 +614,17 @@ static int __metricgroup__add_metric(struct list_head *group_list,
>  	return 0;
>  }
>  
> +#define map_for_each_event(__pe, __idx, __map)				\
> +	for (__idx = 0, __pe = &__map->table[__idx];			\
> +	     __pe->name || __pe->metric_group || __pe->metric_name;	\
> +	     __pe = &__map->table[++__idx])
> +
> +#define map_for_each_metric(__pe, __idx, __map, __metric)		\
> +	map_for_each_event(__pe, __idx, __map)				\
> +		if (__pe->metric_expr &&				\
> +		    (match_metric(__pe->metric_group, __metric) ||	\
> +		     match_metric(__pe->metric_name, __metric)))
> +
>  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  				   struct strbuf *events,
>  				   struct list_head *group_list,
> @@ -624,49 +635,41 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  	int i, ret;
>  	bool has_match = false;
>  
> -	for (i = 0; ; i++) {
> -		pe = &map->table[i];
> -
> -		if (!pe->name && !pe->metric_group && !pe->metric_name) {
> -			/* End of pmu events. */
> -			if (!has_match)
> -				return -EINVAL;
> -			break;
> -		}
> -		if (!pe->metric_expr)
> -			continue;
> -		if (match_metric(pe->metric_group, metric) ||
> -		    match_metric(pe->metric_name, metric)) {
> -			has_match = true;
> -			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> -
> -			if (!strstr(pe->metric_expr, "?")) {
> -				ret = __metricgroup__add_metric(group_list,
> -								pe,
> -								metric_no_group,
> -								1);
> -				if (ret)
> -					return ret;
> -			} else {
> -				int j, count;
> +	map_for_each_metric(pe, i, map, metric) {
> +		pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> +		has_match = true;
> +
> +		if (!strstr(pe->metric_expr, "?")) {
> +			ret = __metricgroup__add_metric(group_list,
> +							pe,
> +							metric_no_group,
> +							1);
> +			if (ret)
> +				return ret;
> +		} else {
> +			int j, count;
>  
> -				count = arch_get_runtimeparam();
> +			count = arch_get_runtimeparam();
>  
> -				/* This loop is added to create multiple
> -				 * events depend on count value and add
> -				 * those events to group_list.
> -				 */
> +			/* This loop is added to create multiple
> +			 * events depend on count value and add
> +			 * those events to group_list.
> +			 */
>  
> -				for (j = 0; j < count; j++) {
> -					ret = __metricgroup__add_metric(
> -						group_list, pe,
> -						metric_no_group, j);
> -					if (ret)
> -						return ret;
> -				}
> +			for (j = 0; j < count; j++) {
> +				ret = __metricgroup__add_metric(
> +					group_list, pe,
> +					metric_no_group, j);
> +				if (ret)
> +					return ret;
>  			}
>  		}
>  	}
> +
> +	/* End of pmu events. */
> +	if (!has_match)
> +		return -EINVAL;
> +
>  	list_for_each_entry(eg, group_list, nd) {
>  		if (events->len > 0)
>  			strbuf_addf(events, ",");
> 
