Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C4C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B8E20714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGZJRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:17:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725960AbgGZJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:17:14 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q91XjU014704;
        Sun, 26 Jul 2020 05:17:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ggww5wtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:17:06 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q9AwaU034580;
        Sun, 26 Jul 2020 05:17:06 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ggww5wt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:17:06 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9Fa6d023385;
        Sun, 26 Jul 2020 09:17:05 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 32gcy90u1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:17:05 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9H5H037290392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:17:05 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 639C82805A;
        Sun, 26 Jul 2020 09:17:05 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C575A28058;
        Sun, 26 Jul 2020 09:17:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:17:01 +0000 (GMT)
Subject: Re: [PATCH 03/19] perf metric: Change expr__get_id to return struct
 expr_id_data
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
 <20200719181320.785305-4-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <c5590463-0896-fa70-4c8f-77daa67a8e88@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:47:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200719181320.785305-4-jolsa@kernel.org>
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
> Changing expr__get_id to use and return struct expr_id_data
> pointer as value for the ID. This way we can access data other
> than value for given ID in following changes.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

>  tools/perf/util/expr.c | 10 +++-------
>  tools/perf/util/expr.h |  3 ++-
>  tools/perf/util/expr.y | 14 +++++++++-----
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 9228f60e2a20..4e5a6533dfce 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -73,14 +73,10 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>  	return ret;
>  }
>  
> -int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr)
> +int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> +		 struct expr_id_data **data)
>  {
> -	struct expr_id_data *data;
> -
> -	if (!hashmap__find(&ctx->ids, id, (void **)&data))
> -		return -1;
> -	*val_ptr = (data == NULL) ?  0.0 : data->val;
> -	return 0;
> +	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
>  }
>  
>  void expr__ctx_init(struct expr_parse_ctx *ctx)
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index ac32cda42006..f38292fdab19 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -28,7 +28,8 @@ void expr__ctx_init(struct expr_parse_ctx *ctx);
>  void expr__ctx_clear(struct expr_parse_ctx *ctx);
>  int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
>  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
> -int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
> +int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> +		 struct expr_id_data **data);
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
>  		const char *expr, int runtime);
>  int expr__find_other(const char *expr, const char *one,
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 8befe4a46f87..0d4f5d324be7 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -85,12 +85,16 @@ if_expr:
>  	;
>  
>  expr:	  NUMBER
> -	| ID			{ if (expr__get_id(ctx, $1, &$$)) {
> -					pr_debug("%s not found\n", $1);
> +	| ID			{
> +					struct expr_id_data *data;
> +
> +					if (expr__get_id(ctx, $1, &data) || !data) {
> +						pr_debug("%s not found\n", $1);
> +						free($1);
> +						YYABORT;
> +					}
> +					$$ = data->val;
>  					free($1);
> -					YYABORT;
> -				  }
> -				  free($1);
>  				}
>  	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
>  	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
> 
