Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1928C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E40206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGZJSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:18:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725960AbgGZJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:18:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q91Wvb014672;
        Sun, 26 Jul 2020 05:18:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ggww5x87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:18:00 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q9AA7R033098;
        Sun, 26 Jul 2020 05:18:00 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ggww5x7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:17:59 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9EF57031410;
        Sun, 26 Jul 2020 09:17:59 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 32gcq0k45j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:17:59 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9HwIN54002124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:17:58 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7515C2805A;
        Sun, 26 Jul 2020 09:17:58 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBB9F28058;
        Sun, 26 Jul 2020 09:17:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:17:54 +0000 (GMT)
Subject: Re: [PATCH 06/19] perf metric: Add add_metric function
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
 <20200719181320.785305-7-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <f1b7bcb2-2dda-2ff8-79fa-62c831ba0d61@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:47:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200719181320.785305-7-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/20 11:43 PM, Jiri Olsa wrote:
> Decouple metric adding logging into add_metric function,
> so it can be used from other places in following changes.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
>  tools/perf/util/metricgroup.c | 62 ++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index b37008fc253c..4096be7a7a9e 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -625,6 +625,39 @@ static int __metricgroup__add_metric(struct list_head *group_list,
>  		    (match_metric(__pe->metric_group, __metric) ||	\
>  		     match_metric(__pe->metric_name, __metric)))
>  
> +static int add_metric(struct list_head *group_list,
> +		      struct pmu_event *pe,
> +		      bool metric_no_group)
> +{
> +	int ret = 0;
> +
> +	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> +
> +	if (!strstr(pe->metric_expr, "?")) {
> +		ret = __metricgroup__add_metric(group_list,
> +						pe,
> +						metric_no_group,
> +						1);
> +	} else {
> +		int j, count;
> +
> +		count = arch_get_runtimeparam();
> +
> +		/* This loop is added to create multiple
> +		 * events depend on count value and add
> +		 * those events to group_list.
> +		 */
> +
> +		for (j = 0; j < count && !ret; j++) {
> +			ret = __metricgroup__add_metric(
> +				group_list, pe,
> +				metric_no_group, j);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  				   struct strbuf *events,
>  				   struct list_head *group_list,
> @@ -636,34 +669,11 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  	bool has_match = false;
>  
>  	map_for_each_metric(pe, i, map, metric) {
> -		pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>  		has_match = true;
>  
> -		if (!strstr(pe->metric_expr, "?")) {
> -			ret = __metricgroup__add_metric(group_list,
> -							pe,
> -							metric_no_group,
> -							1);
> -			if (ret)
> -				return ret;
> -		} else {
> -			int j, count;
> -
> -			count = arch_get_runtimeparam();
> -
> -			/* This loop is added to create multiple
> -			 * events depend on count value and add
> -			 * those events to group_list.
> -			 */
> -
> -			for (j = 0; j < count; j++) {
> -				ret = __metricgroup__add_metric(
> -					group_list, pe,
> -					metric_no_group, j);
> -				if (ret)
> -					return ret;
> -			}
> -		}
> +		ret = add_metric(group_list, pe, metric_no_group);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	/* End of pmu events. */
> 
