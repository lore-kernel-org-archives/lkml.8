Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C8EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D95206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGZJSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:18:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgGZJSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:18:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q91WxJ014667;
        Sun, 26 Jul 2020 05:18:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ggww5xh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:18:43 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q98MJi029701;
        Sun, 26 Jul 2020 05:18:42 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ggww5xh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:18:42 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9EYgw016449;
        Sun, 26 Jul 2020 09:18:42 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 32gcy3k1gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:18:42 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9If9I33292724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:18:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8732F28058;
        Sun, 26 Jul 2020 09:18:41 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2347B2805A;
        Sun, 26 Jul 2020 09:18:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:18:36 +0000 (GMT)
Subject: Re: [PATCH 09/19] perf metric: Collect referenced metrics in struct
 metric_expr
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
 <20200719181320.785305-10-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <92070405-8993-decb-46e3-04189dddb1b6@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:48:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200719181320.785305-10-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/20 11:43 PM, Jiri Olsa wrote:
> Add referenced metrics into struct metric_expr object,
> so they are accessible when computing the metric.
> 
> Storing just name and expression itself, so the metric
> can be resolved and computed.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> ---
>  tools/perf/util/metricgroup.c | 32 ++++++++++++++++++++++++++++++++
>  tools/perf/util/metricgroup.h |  6 ++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index d1b2c1aa436f..bb5757b9419d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -83,6 +83,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
>  	struct metric_expr *expr, *tmp;
>  
>  	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
> +		free(expr->metric_refs);
>  		free(expr);
>  	}
>  
> @@ -248,6 +249,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>  
>  	list_for_each_entry (eg, groups, nd) {
>  		struct evsel **metric_events;
> +		struct metric_ref *metric_refs = NULL;
>  
>  		metric_events = calloc(sizeof(void *),
>  				hashmap__size(&eg->pctx.ids) + 1);
> @@ -279,6 +281,36 @@ static int metricgroup__setup_events(struct list_head *groups,
>  			free(metric_events);
>  			break;
>  		}
> +
> +		/*
> +		 * Collect and store collected nested expressions
> +		 * for metric processing.
> +		 */
> +		if (eg->metric_refs_cnt) {
> +			struct metric_ref_node *ref;
> +
> +			metric_refs = zalloc(sizeof(struct metric_ref) * (eg->metric_refs_cnt + 1));
> +			if (!metric_refs) {
> +				ret = -ENOMEM;
> +				free(metric_events);
> +				break;
> +			}
> +
> +			i = 0;
> +			list_for_each_entry(ref, &eg->metric_refs, list) {
> +				/*
> +				 * Intentionally passing just const char pointers,
> +				 * originally from 'struct pmu_event' object.
> +				 * We don't need to change them, so there's no
> +				 * need to create our own copy.
> +				 */
> +				metric_refs[i].metric_name = ref->metric_name;
> +				metric_refs[i].metric_expr = ref->metric_expr;
> +				i++;
> +			}
> +		};
> +
> +		expr->metric_refs = metric_refs;
>  		expr->metric_expr = eg->metric_expr;
>  		expr->metric_name = eg->metric_name;
>  		expr->metric_unit = eg->metric_unit;
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 8315bd1a7da4..62623a39cbec 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -18,12 +18,18 @@ struct metric_event {
>  	struct list_head head; /* list of metric_expr */
>  };
>  
> +struct metric_ref {
> +	const char *metric_name;
> +	const char *metric_expr;
> +};
> +
>  struct metric_expr {
>  	struct list_head nd;
>  	const char *metric_expr;
>  	const char *metric_name;
>  	const char *metric_unit;
>  	struct evsel **metric_events;
> +	struct metric_ref *metric_refs;
>  	int runtime;
>  };
>  
> 
