Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCF4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A53207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyR3LGpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFKIi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:38:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46215 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbgFKIi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591864737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQvsHlbdLLk2oPLG+sIIm0tAuRXY9FK815iXLJ6E6vM=;
        b=MyR3LGpadqomUFfDrowCqGvitoBWuhNkFMkaAmh1BEY7XMcghSpfnRtiIV9QyjOl4yUlbc
        03ZwMsSuGR7esP2GB48b3UAgeKBgp8IxUgwn3MUlEJHRogjJ2fvySonADTPABYp+tOpYoR
        rPsa2J2dQKxqr0FGm9nnFd+A8meXm58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-lwnGxThNPNy4gqosOjk2FQ-1; Thu, 11 Jun 2020 04:38:53 -0400
X-MC-Unique: lwnGxThNPNy4gqosOjk2FQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FB02107ACCA;
        Thu, 11 Jun 2020 08:38:51 +0000 (UTC)
Received: from krava (unknown [10.40.194.223])
        by smtp.corp.redhat.com (Postfix) with SMTP id AC8175C241;
        Thu, 11 Jun 2020 08:38:47 +0000 (UTC)
Date:   Thu, 11 Jun 2020 10:38:46 +0200
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
Subject: Re: [PATCH v2 1/2] perf expr: Add d_ratio operation
Message-ID: <20200611083846.GA1786122@krava>
References: <20200610235823.52557-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610235823.52557-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:58:22PM -0700, Ian Rogers wrote:
> d_ratio avoids division by 0 yielding infinity, such as when a counter
> doesn't get scheduled. An example usage is:
> 
> {
>     "BriefDescription": "DCache L1 misses",
>     "MetricExpr": "d_ratio(MEM_LOAD_RETIRED.L1_MISS, MEM_LOAD_RETIRED.L1_HIT + MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT)",
>     "MetricGroup": "DCache;DCache_L1",
>     "MetricName": "DCache_L1_Miss",
>     "ScaleUnit": "100%",
> }
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/tests/expr.c |  2 ++
>  tools/perf/util/expr.l  |  1 +
>  tools/perf/util/expr.y  | 14 ++++++++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index 1cb02ca2b15f..c4877b36ab58 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -39,6 +39,8 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  	ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
>  	ret |= test(&ctx, "1.1 + 2.1", 3.2);
>  	ret |= test(&ctx, ".1 + 2.", 2.1);
> +	ret |= test(&ctx, "d_ratio(1, 2)", 0.5);
> +	ret |= test(&ctx, "d_ratio(2.5, 0)", 0);
>  
>  	if (ret)
>  		return ret;
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index f397bf8b1a48..298d86660a96 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -100,6 +100,7 @@ symbol		({spec}|{sym})+
>  		}
>  	}
>  
> +d_ratio		{ return D_RATIO; }
>  max		{ return MAX; }
>  min		{ return MIN; }
>  if		{ return IF; }
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index bf3e898e3055..fe145344bb39 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -10,6 +10,14 @@
>  #include "smt.h"
>  #include <string.h>
>  
> +static double d_ratio(double val0, double val1)
> +{
> +	if (val1 == 0) {
> +		return 0;
> +	}
> +	return  val0 / val1;
> +}
> +
>  %}
>  
>  %define api.pure full
> @@ -28,7 +36,7 @@
>  %token <num> NUMBER
>  %token <str> ID
>  %destructor { free ($$); } <str>
> -%token MIN MAX IF ELSE SMT_ON
> +%token MIN MAX IF ELSE SMT_ON D_RATIO
>  %left MIN MAX IF
>  %left '|'
>  %left '^'
> @@ -64,7 +72,8 @@ other: ID
>  }
>  |
>  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> -
> +|
> +D_RATIO
>  
>  all_expr: if_expr			{ *final_val = $1; }
>  	;
> @@ -105,6 +114,7 @@ expr:	  NUMBER
>  	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
>  	| MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
>  	| SMT_ON		 { $$ = smt_on() > 0; }
> +	| D_RATIO '(' expr ',' expr ')' { $$ = d_ratio($3,$5); }
>  	;
>  
>  %%
> -- 
> 2.27.0.278.ge193c7cf3a9-goog
> 

