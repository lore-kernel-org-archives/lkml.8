Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44A0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DF020656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg5+h4vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgFKIjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:39:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53643 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726560AbgFKIjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591864760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XB/QLkfNPpEWUD3t+7iKbigF61vALbbUqs1AQI2PfJE=;
        b=Sg5+h4vtbCRd7htfE7AS9SoMenibdYe0TcDgkMjuOsGcZhs+ivE7jhIWT7yfZWt8jWKFIo
        HiOXxMt+D9E+tO+ERUi3jJKIg0GYi2DaACJrfNP6uKpqzLbXQKiGPttA48VPuKW3EI0Oi4
        aES2MaJcQOB4F1ZzuL7yD0CyfJKPjRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-IZeWgbxBMVeBkR_zotK_0Q-1; Thu, 11 Jun 2020 04:39:04 -0400
X-MC-Unique: IZeWgbxBMVeBkR_zotK_0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0239218FE861;
        Thu, 11 Jun 2020 08:39:03 +0000 (UTC)
Received: from krava (unknown [10.40.194.223])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0D0EA5D9D3;
        Thu, 11 Jun 2020 08:38:59 +0000 (UTC)
Date:   Thu, 11 Jun 2020 10:38:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf expr: Add < and > operators
Message-ID: <20200611083858.GB1786122@krava>
References: <20200610235823.52557-1-irogers@google.com>
 <20200610235823.52557-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610235823.52557-2-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:58:23PM -0700, Ian Rogers wrote:
> These are broadly useful but required to handle TMA metrics. For
> example encoding Ports_Utilization from:
> https://download.01.org/perfmon/TMA_Metrics.csv
> requires '<'.
> 
> {
>   "BriefDescription": "This metric estimates fraction of cycles the CPU performance was potentially limited due to Core computation issues (non divider-related).  Two distinct categories can be attributed into this metric: (1) heavy data-dependency among contiguous instructions would manifest in this metric - such cases are often referred to as low Instruction Level Parallelism (ILP). (2) Contention on some hardware execution unit other than Divider. For example; when there are too many multiply operations.",
>   "MetricExpr": "( ( cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + cpu@EXE_ACTIVITY.1_PORTS_UTIL@ + ( cpu@EXE_ACTIVITY.2_PORTS_UTIL@ * ( ( ( cpu@UOPS_RETIRED.RETIRE_SLOTS@ ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) ) / ( ( 4.000000 ) + 1.000000 ) ) ) ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) if ( cpu@ARITH.DIVIDER_ACTIVE\\,cmask\\=1@ < cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ ) else ( ( cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + cpu@EXE_ACTIVITY.1_PORTS_UTIL@ + ( cpu@EXE_ACTIVITY.2_PORTS_UTIL@ * ( ( ( cpu@UOPS_RETIRED.RETIRE_SLOTS@ ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) ) / ( ( 4.000000 ) + 1.000000 ) ) ) ) - cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) )",
>   "MetricGroup": "Topdown_Group_Ports_Utilization",
>   "MetricName": "Topdown_Metric_Ports_Utilization"
> },
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/tests/expr.c | 6 ++++++
>  tools/perf/util/expr.l  | 2 ++
>  tools/perf/util/expr.y  | 5 ++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index c4877b36ab58..b7e5ef3007fc 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -41,6 +41,12 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  	ret |= test(&ctx, ".1 + 2.", 2.1);
>  	ret |= test(&ctx, "d_ratio(1, 2)", 0.5);
>  	ret |= test(&ctx, "d_ratio(2.5, 0)", 0);
> +	ret |= test(&ctx, "1.1 < 2.2", 1);
> +	ret |= test(&ctx, "2.2 > 1.1", 1);
> +	ret |= test(&ctx, "1.1 < 1.1", 0);
> +	ret |= test(&ctx, "2.2 > 2.2", 0);
> +	ret |= test(&ctx, "2.2 < 1.1", 0);
> +	ret |= test(&ctx, "1.1 > 2.2", 0);
>  
>  	if (ret)
>  		return ret;
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 298d86660a96..13e5e3c75f56 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -111,6 +111,8 @@ else		{ return ELSE; }
>  "|"		{ return '|'; }
>  "^"		{ return '^'; }
>  "&"		{ return '&'; }
> +"<"		{ return '<'; }
> +">"		{ return '>'; }
>  "-"		{ return '-'; }
>  "+"		{ return '+'; }
>  "*"		{ return '*'; }
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index fe145344bb39..5fcb98800f9c 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -41,6 +41,7 @@ static double d_ratio(double val0, double val1)
>  %left '|'
>  %left '^'
>  %left '&'
> +%left '<' '>'
>  %left '-' '+'
>  %left '*' '/' '%'
>  %left NEG NOT
> @@ -73,7 +74,7 @@ other: ID
>  |
>  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
>  |
> -D_RATIO
> +'<' | '>' | D_RATIO
>  
>  all_expr: if_expr			{ *final_val = $1; }
>  	;
> @@ -94,6 +95,8 @@ expr:	  NUMBER
>  	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
>  	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
>  	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
> +	| expr '<' expr		{ $$ = $1 < $3; }
> +	| expr '>' expr		{ $$ = $1 > $3; }
>  	| expr '+' expr		{ $$ = $1 + $3; }
>  	| expr '-' expr		{ $$ = $1 - $3; }
>  	| expr '*' expr		{ $$ = $1 * $3; }
> -- 
> 2.27.0.278.ge193c7cf3a9-goog
> 

