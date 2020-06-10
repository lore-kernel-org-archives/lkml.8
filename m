Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D35C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E482072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWzr4ffD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgFJPlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:41:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48027 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727910AbgFJPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591803699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hjSM67DtmOsqtTYEGUCI40HSbVxGiINgh5sSqThFUtk=;
        b=XWzr4ffDBW/X2f8sRxhYmdmSKLFRBwjaCs0CTTU0x4aYA9+2r+aCcFC5nq7SeO2mAygF/3
        lpQnO8EV2+I6EUroK2h1ocSVNK6UMOhi21CiLkcYQvR0dwsvJ+ZWbwteOgaX5tL2cr9UoS
        WoKhzXbmBzYMTtWx0WYdMwuoC9e8oKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-HxNOpix2OHu6zV4Sll2K6w-1; Wed, 10 Jun 2020 11:41:35 -0400
X-MC-Unique: HxNOpix2OHu6zV4Sll2K6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3067464;
        Wed, 10 Jun 2020 15:41:33 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2ECE460CC0;
        Wed, 10 Jun 2020 15:41:30 +0000 (UTC)
Date:   Wed, 10 Jun 2020 17:41:29 +0200
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
Subject: Re: [PATCH 1/2] perf expr: Add d_ratio operation
Message-ID: <20200610154129.GA1776102@krava>
References: <20200610051717.170457-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610051717.170457-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 10:17:15PM -0700, Ian Rogers wrote:
> This simplifies computing ratios in json expressions.

please put in the comment some usage example and add
a test for this to tests/expr.c

same for the '<>' operators in the other patch

I'll put documentation on this together with the rest to
stat man page with my other changes, so no need to document
this, but at least bit more details in changelog ;-)

thanks,
jirka

> 
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

