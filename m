Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B90C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B5B207C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591798794;
	bh=Qio3HNTyxxsnayctJ6tO2ji86upI7eM98FBvAyT4RG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tHncA3VCerTiFXIL2GuHpBZzGNisVni/Hjxnp0nXnzsVQD70L5zNkfrpambrgQiwO
	 H74aGo6XoxYh+d3wT9ULeDbVt2+Jx/zGVxZJvKwCEOQybfytyV7e5NfOOnr8oVO7k0
	 Nx1BPgBUHMAqNALZsqNfW1wWIsVqtigEcSy5+owU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgFJOTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgFJOTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:19:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A07206F7;
        Wed, 10 Jun 2020 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591798791;
        bh=Qio3HNTyxxsnayctJ6tO2ji86upI7eM98FBvAyT4RG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0qWcOcPfZ/xZzHWzKmSQp6OOABeIbiZe+Anaxtk2+APmenWQ0VMdkFtZgOH0knAZv
         vUSzDr85GWFWHVfyyYGuggzb1K18PZm6O5BR5H8sviQM+kiHrXO9rJVKHWodhawonS
         iPA+0y1HKCNZYhOzjc5MVy/ZdM04MtQW13RRU6sk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9219540AFD; Wed, 10 Jun 2020 11:19:49 -0300 (-03)
Date:   Wed, 10 Jun 2020 11:19:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf expr: Add d_ratio operation
Message-ID: <20200610141949.GN24868@kernel.org>
References: <20200610051717.170457-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610051717.170457-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 09, 2020 at 10:17:15PM -0700, Ian Rogers escreveu:
> This simplifies computing ratios in json expressions.

Appling to my local branch, Jiri, can I have your acked-by?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.l |  1 +
>  tools/perf/util/expr.y | 14 ++++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
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

-- 

- Arnaldo
