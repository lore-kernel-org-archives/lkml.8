Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2722AC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09558206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGZJRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:17:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51536 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgGZJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:17:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06Q8XUeN137331;
        Sun, 26 Jul 2020 05:16:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggmep8v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:16:55 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06Q8Y0UU140420;
        Sun, 26 Jul 2020 05:16:55 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggmep8us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 05:16:55 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06Q9FCq8016683;
        Sun, 26 Jul 2020 09:16:54 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 32gcy2k14h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 09:16:54 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06Q9GrZc56557988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 09:16:53 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 810F628058;
        Sun, 26 Jul 2020 09:16:53 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E6D128066;
        Sun, 26 Jul 2020 09:16:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.120])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jul 2020 09:16:48 +0000 (GMT)
Subject: Re: [PATCH 02/19] perf metric: Add expr__add_id function
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
 <20200719181320.785305-3-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <73111916-408d-d3a1-53d8-050314505535@linux.ibm.com>
Date:   Sun, 26 Jul 2020 14:46:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200719181320.785305-3-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-26_02:2020-07-24,2020-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/20 11:43 PM, Jiri Olsa wrote:
> Adding expr__add_id function to data for ID
> with zero value, which is used when scanning
> the expression for IDs.
> 

Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/expr.c | 31 +++++++++++++++++++++++++------
>  tools/perf/util/expr.h |  1 +
>  tools/perf/util/expr.y |  2 +-
>  3 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 578a173d4873..9228f60e2a20 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -32,6 +32,26 @@ static bool key_equal(const void *key1, const void *key2,
>  	return !strcmp((const char *)key1, (const char *)key2);
>  }
>  
> +/* Caller must make sure id is allocated */
> +int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
> +{
> +	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
> +	char *old_key = NULL;
> +	int ret;
> +
> +	data_ptr = malloc(sizeof(*data_ptr));
> +	if (!data_ptr)
> +		return -ENOMEM;
> +
> +	ret = hashmap__set(&ctx->ids, id, data_ptr,
> +			   (const void **)&old_key, (void **)&old_data);
> +	if (ret)
> +		free(data_ptr);
> +	free(old_key);
> +	free(old_data);
> +	return ret;
> +}
> +
>  /* Caller must make sure id is allocated */
>  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>  {
> @@ -39,12 +59,11 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>  	char *old_key = NULL;
>  	int ret;
>  
> -	if (val != 0.0) {
> -		data_ptr = malloc(sizeof(*data_ptr));
> -		if (!data_ptr)
> -			return -ENOMEM;
> -		data_ptr->val = val;
> -	}
> +	data_ptr = malloc(sizeof(*data_ptr));
> +	if (!data_ptr)
> +		return -ENOMEM;
> +	data_ptr->val = val;
> +
>  	ret = hashmap__set(&ctx->ids, id, data_ptr,
>  			   (const void **)&old_key, (void **)&old_data);
>  	if (ret)
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 21fe5bd85718..ac32cda42006 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -26,6 +26,7 @@ struct expr_scanner_ctx {
>  
>  void expr__ctx_init(struct expr_parse_ctx *ctx);
>  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> +int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
>  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index b2b3420ea6ec..8befe4a46f87 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -69,7 +69,7 @@ all_other: all_other other
>  
>  other: ID
>  {
> -	expr__add_id_val(ctx, $1, 0.0);
> +	expr__add_id(ctx, $1);
>  }
>  |
>  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> 
