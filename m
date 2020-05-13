Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2636C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A403205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZ9ECzOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbgEMRxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:53:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20605 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMRxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589392380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cKPU2UnIkMHFMemi3skP0Jo5jk1QLcLQuR3usoR03Lk=;
        b=VZ9ECzOGxAC1IoKP0DlXadS7gZ2sc/oYFL8pStS3c7C2IuJ+1VtAWXqGc/0+RylXSmhZyQ
        TFq5+n1h6OaSjisixNL9HK2aXG4smP6mPYes9BfnoWjVzC3dvsG3tw2OOzJTsU8NhfMq2a
        i4Fiy76GW9KgxVKTGaJTTx8NgMW0W+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-8XA14bRhP42nGAPBs401sw-1; Wed, 13 May 2020 13:52:58 -0400
X-MC-Unique: 8XA14bRhP42nGAPBs401sw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0DFB107ACCA;
        Wed, 13 May 2020 17:52:56 +0000 (UTC)
Received: from krava (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9804010013D9;
        Wed, 13 May 2020 17:52:54 +0000 (UTC)
Date:   Wed, 13 May 2020 19:52:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf expr: Fix memory leaks in metric bison
Message-ID: <20200513175253.GB3343750@krava>
References: <20200513000318.15166-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513000318.15166-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:03:18PM -0700, Ian Rogers wrote:
> Add a destructor for strings to reclaim memory in the event of errors.
> Free the ID given for a lookup, it was previously strdup-ed in the lex
> code.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/expr.y | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 21e82a1e11a2..3b49b230b111 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -27,6 +27,7 @@
>  %token EXPR_PARSE EXPR_OTHER EXPR_ERROR
>  %token <num> NUMBER
>  %token <str> ID
> +%destructor { free ($$); } <str>
>  %token MIN MAX IF ELSE SMT_ON
>  %left MIN MAX IF
>  %left '|'
> @@ -94,8 +95,10 @@ if_expr:
>  expr:	  NUMBER
>  	| ID			{ if (lookup_id(ctx, $1, &$$) < 0) {
>  					pr_debug("%s not found\n", $1);
> +					free($1);
>  					YYABORT;
>  				  }
> +				  free($1);
>  				}
>  	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
>  	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 

