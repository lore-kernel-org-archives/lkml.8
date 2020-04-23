Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF68C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28C22166E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1AyhSp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgDWL2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:28:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728092AbgDWL2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587641330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T5LP/86R6RJodTw+xNHNMGgzEhuInJZx2HqvTUy6zd8=;
        b=S1AyhSp2GYOctzz9SfqTeQ6xhv1V65paw1sRjq4no0vXT8Bdiq1UfCrYE8ObkeayUfBne1
        CfVHib+hI/1GI4konxoijNdvG+yp31Zf3ni530WRTJWUHE5KtfpSVyzzR3j3Bz6+21nLAF
        c33/fUE8qMnub7s8oRXSGpJyp42uFJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-xJgTRP31Nu-cIqxWkO_Fhw-1; Thu, 23 Apr 2020 07:28:46 -0400
X-MC-Unique: xJgTRP31Nu-cIqxWkO_Fhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD52A80B70D;
        Thu, 23 Apr 2020 11:28:43 +0000 (UTC)
Received: from krava (unknown [10.40.196.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F6355D706;
        Thu, 23 Apr 2020 11:28:39 +0000 (UTC)
Date:   Thu, 23 Apr 2020 13:28:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 10/11] perf expr: print a debug message for division
 by zero
Message-ID: <20200423112837.GE1136647@krava>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-11-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422220430.254014-11-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:04:29PM -0700, Ian Rogers wrote:
> If an expression yields 0 and is then divided-by/modulus-by then the
> parsing aborts. Add a debug error message to better enable debugging
> when this happens.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.y | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 54260094b947..21e82a1e11a2 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -103,8 +103,18 @@ expr:	  NUMBER
>  	| expr '+' expr		{ $$ = $1 + $3; }
>  	| expr '-' expr		{ $$ = $1 - $3; }
>  	| expr '*' expr		{ $$ = $1 * $3; }
> -	| expr '/' expr		{ if ($3 == 0) YYABORT; $$ = $1 / $3; }
> -	| expr '%' expr		{ if ((long)$3 == 0) YYABORT; $$ = (long)$1 % (long)$3; }
> +	| expr '/' expr		{ if ($3 == 0) {
> +					pr_debug("division by zero\n");
> +					YYABORT;
> +				  }
> +				  $$ = $1 / $3;
> +	                        }
> +	| expr '%' expr		{ if ((long)$3 == 0) {

is that (long) cast necessary? it's missing for the '/' case

jirka

> +					pr_debug("division by zero\n");
> +					YYABORT;
> +				  }
> +				  $$ = (long)$1 % (long)$3;
> +	                        }
>  	| '-' expr %prec NEG	{ $$ = -$2; }
>  	| '(' if_expr ')'	{ $$ = $2; }
>  	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

