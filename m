Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132B9C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E214120736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6KNwpWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgDWL3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:29:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39754 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728145AbgDWL3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587641383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/04+YFQHiFQVZxLaFFOOSgTN0IfacWGGUXf6Xho6qs=;
        b=f6KNwpWE27kwEe53A/vR2irnIbqyrNw+aOfAK91U+CNa+r4FaE9iOwn2UcAulwovdvU75C
        iIzw4cNTnU0qiXHhpwCcseMrTlk5zbJ0mY6obLCtnEZeQPoQn/+iClgpTUwn3tySAe0rKi
        AkIMfsTs+XDVVBB6iPWjOLpMgYN/VNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-jqe5plPvMgW8Mcxazv8h-w-1; Thu, 23 Apr 2020 07:29:37 -0400
X-MC-Unique: jqe5plPvMgW8Mcxazv8h-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62FC2107ACF3;
        Thu, 23 Apr 2020 11:29:35 +0000 (UTC)
Received: from krava (unknown [10.40.196.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73DD15D706;
        Thu, 23 Apr 2020 11:29:31 +0000 (UTC)
Date:   Thu, 23 Apr 2020 13:29:28 +0200
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
Subject: Re: [PATCH v2 06/11] perf expr: parse numbers as doubles
Message-ID: <20200423112928.GI1136647@krava>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422220430.254014-7-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:04:25PM -0700, Ian Rogers wrote:
> This is expected in expr.y and metrics use floating point values such as
> x86 broadwell IFetch_Line_Utilization.

ugh, I wonder why we did not get any compiler warning when expr.y
expects double.. good catch

jirka

> 
> Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.l | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 95bcf3629edf..0efda2ce2766 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -10,12 +10,12 @@
>  char *expr_get_text(yyscan_t yyscanner);
>  YYSTYPE *expr_get_lval(yyscan_t yyscanner);
>  
> -static int __value(YYSTYPE *yylval, char *str, int base, int token)
> +static double __value(YYSTYPE *yylval, char *str, int token)
>  {
> -	u64 num;
> +	double num;
>  
>  	errno = 0;
> -	num = strtoull(str, NULL, base);
> +	num = strtod(str, NULL);
>  	if (errno)
>  		return EXPR_ERROR;
>  
> @@ -23,12 +23,12 @@ static int __value(YYSTYPE *yylval, char *str, int base, int token)
>  	return token;
>  }
>  
> -static int value(yyscan_t scanner, int base)
> +static int value(yyscan_t scanner)
>  {
>  	YYSTYPE *yylval = expr_get_lval(scanner);
>  	char *text = expr_get_text(scanner);
>  
> -	return __value(yylval, text, base, NUMBER);
> +	return __value(yylval, text, NUMBER);
>  }
>  
>  /*
> @@ -68,7 +68,7 @@ static int str(yyscan_t scanner, int token)
>  }
>  %}
>  
> -number		[0-9]+
> +number		[0-9]*\.?[0-9]+
>  
>  sch		[-,=]
>  spec		\\{sch}
> @@ -92,7 +92,7 @@ min		{ return MIN; }
>  if		{ return IF; }
>  else		{ return ELSE; }
>  #smt_on		{ return SMT_ON; }
> -{number}	{ return value(yyscanner, 10); }
> +{number}	{ return value(yyscanner); }
>  {symbol}	{ return str(yyscanner, ID); }
>  "|"		{ return '|'; }
>  "^"		{ return '^'; }
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

