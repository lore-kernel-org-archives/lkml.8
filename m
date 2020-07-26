Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE40C433F1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D966620829
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGZJTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:19:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbgGZJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:19:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q91pqd078409;
        Sun, 26 Jul 2020 05:19:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggthwv7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:19:11 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q91nVJ078250;
        Sun, 26 Jul 2020 05:19:10 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggthwv7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:19:10 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9Fa7R023385;
        Sun, 26 Jul 2020 09:19:09 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 32gcy90ubs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:19:09 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9J9IT14746590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:19:09 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E1F2805A;
        Sun, 26 Jul 2020 09:19:09 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AB1C28058;
        Sun, 26 Jul 2020 09:19:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:19:04 +0000 (GMT)
Subject: Re: [PATCH 11/19] perf metric: Compute referenced metrics
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
 <20200719181320.785305-12-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <201d05c0-7aef-b853-da7f-0371fd221084@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:49:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200719181320.785305-12-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=2 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/20 11:43 PM, Jiri Olsa wrote:
> Adding computation (expr__parse call) of referenced metric at
> the point when it needs to be resolved during the parent metric
> computation.
> 
> Once the inner metric is computed, the result is stored and
> used if there's another usage of that metric.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> ---
>  tools/perf/util/expr.c | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/expr.h |  3 +++
>  tools/perf/util/expr.y |  4 ++--
>  3 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index d3997c2b4a90..a346ca590513 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -112,6 +112,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
>  	 */
>  	data_ptr->ref.metric_name = ref->metric_name;
>  	data_ptr->ref.metric_expr = ref->metric_expr;
> +	data_ptr->ref.counted = false;
>  	data_ptr->is_ref = true;
>  
>  	ret = hashmap__set(&ctx->ids, name, data_ptr,
> @@ -133,6 +134,34 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>  	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
>  }
>  
> +int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
> +		     struct expr_id_data **datap)
> +{
> +	struct expr_id_data *data;
> +
> +	if (expr__get_id(ctx, id, datap) || !*datap) {
> +		pr_debug("%s not found\n", id);
> +		return -1;
> +	}
> +
> +	data = *datap;
> +
> +	pr_debug2("lookup: is_ref %d, counted %d, val %f: %s\n",
> +		  data->is_ref, data->ref.counted, data->val, id);
> +
> +	if (data->is_ref && !data->ref.counted) {
> +		data->ref.counted = true;
> +		pr_debug("processing metric: %s ENTRY\n", id);
> +		if (expr__parse(&data->val, ctx, data->ref.metric_expr, 1)) {
> +			pr_debug("%s failed to count\n", id);
> +			return -1;
> +		}
> +		pr_debug("processing metric: %s EXIT: %f\n", id, data->val);
> +	}
> +
> +	return 0;
> +}
> +
>  void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
>  {
>  	struct expr_id_data *old_val = NULL;
> @@ -173,6 +202,8 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
>  	void *scanner;
>  	int ret;
>  
> +	pr_debug2("parsing metric: %s\n", expr);
> +
>  	ret = expr_lex_init_extra(&scanner_ctx, &scanner);
>  	if (ret)
>  		return ret;
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 81d04ff7f857..9ed208d93418 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -23,6 +23,7 @@ struct expr_id_data {
>  		struct {
>  			const char *metric_name;
>  			const char *metric_expr;
> +			bool counted;
>  		} ref;
>  	};
>  
> @@ -42,6 +43,8 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
>  int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>  		 struct expr_id_data **data);
> +int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
> +		     struct expr_id_data **datap);
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
>  		const char *expr, int runtime);
>  int expr__find_other(const char *expr, const char *one,
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 0d4f5d324be7..d34b370391c6 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -88,11 +88,11 @@ expr:	  NUMBER
>  	| ID			{
>  					struct expr_id_data *data;
>  
> -					if (expr__get_id(ctx, $1, &data) || !data) {
> -						pr_debug("%s not found\n", $1);
> +					if (expr__resolve_id(ctx, $1, &data)) {
>  						free($1);
>  						YYABORT;
>  					}
> +
>  					$$ = data->val;
>  					free($1);
>  				}
> 
