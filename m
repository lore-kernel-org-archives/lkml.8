Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35E3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBC620857
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594913350;
	bh=hS5O6VbCGFstwe7qTNBkSKjk2+CRG9CpB7W6Gyem78Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0k8fYwGkVnBf7IX00/NugBsxDHl4BARrJz62V2rsjoK8t3YZx1k+Z0jYjFwA/Xr0T
	 oSsd72b+8Iww13QMLupU6d21UabgLqoXfazH2f4scagS2MTrixWKq8RROuEc5dOpUZ
	 EGXtbXa6S9Rnv9i9k1Y/owHMTqFwkaOXBnKZes1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgGPP3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbgGPP3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:29:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141F9206F5;
        Thu, 16 Jul 2020 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594913348;
        bh=hS5O6VbCGFstwe7qTNBkSKjk2+CRG9CpB7W6Gyem78Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJViGfjylYYNx4Cs5j83gcWalpBd2Q/s1i5cgL0hCYpfaKHLD7LIqDOwE2Qirnnnw
         5YoBIzc/OgMd54v/TNi/zblfqKjbf7wpRwPLmTvvphX+0lLcWy0fpRgj8sG+ugl6Hy
         i16ZXymnnOVVsN3TfieeYrledsJRz4MaalCsXmDA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3A0F6403C7; Thu, 16 Jul 2020 12:29:06 -0300 (-03)
Date:   Thu, 16 Jul 2020 12:29:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 03/18] perf metric: Add expr__add_id function
Message-ID: <20200716152906.GC374956@kernel.org>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712132634.138901-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 12, 2020 at 03:26:19PM +0200, Jiri Olsa escreveu:
> Adding expr__add_id function to data for ID
> with zero value, which is used when scanning
> the expression for IDs.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/expr.c | 29 +++++++++++++++++++++++------
>  tools/perf/util/expr.h |  1 +
>  tools/perf/util/expr.y |  2 +-
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 5d05f9765ed8..4b8953605aed 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -32,6 +32,24 @@ static bool key_equal(const void *key1, const void *key2,
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
> +	free(old_key);
> +	free(old_data);

Hey, if hashmap__set() fails then we leak data_ptr?

- Arnaldo

> +	return ret;
> +}
> +
>  /* Caller must make sure id is allocated */
>  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>  {
> @@ -39,12 +57,11 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
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
>  	free(old_key);
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
> -- 
> 2.25.4
> 

-- 

- Arnaldo
