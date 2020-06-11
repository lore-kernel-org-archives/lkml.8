Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8177C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC7920760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591880982;
	bh=M1kdDMOYUBHTr6O3MA/xIGGV+1dYvD+EhW8wMA54zlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BxWMtHoWNtEdcFxuKWq+Af+JrbShZU0BHyFj+c04a/Y5PC5uGWQPVd5qQnucECz8D
	 gE1aCRR1ZxArKt4sYlFEHn9VJkrG+SRAEViQFXxTB26B2J2n7E750feb04o65WfxyV
	 j2/UT0HFbnBL9gvWJNv6gCuHqO1lVu06Tu8zQZ7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgFKNJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFKNJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:09:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D535C20691;
        Thu, 11 Jun 2020 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591880980;
        bh=M1kdDMOYUBHTr6O3MA/xIGGV+1dYvD+EhW8wMA54zlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4LinmqC3MtDW7Gl2S8TYVYMZr/ilDMTPSDM46H6BOHlsH6b1YDrZKCyVtYB4Gu9L
         8fp2wTdphxTpU6y3gP42gmSTaORtF1yhreHya3K8us4ayam5UqJ7StrXiGecekZYav
         ubQ18RaqPtjLE1fpBT6d5l0/+Zb96NmJVIKWulH0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 19679410F5; Thu, 11 Jun 2020 10:09:38 -0300 (-03)
Date:   Thu, 11 Jun 2020 10:09:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20200611130938.GB18482@kernel.org>
References: <20200610235823.52557-1-irogers@google.com>
 <20200611083846.GA1786122@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611083846.GA1786122@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 11, 2020 at 10:38:46AM +0200, Jiri Olsa escreveu:
> On Wed, Jun 10, 2020 at 04:58:22PM -0700, Ian Rogers wrote:
> > d_ratio avoids division by 0 yielding infinity, such as when a counter
> > doesn't get scheduled. An example usage is:
> > 
> > {
> >     "BriefDescription": "DCache L1 misses",
> >     "MetricExpr": "d_ratio(MEM_LOAD_RETIRED.L1_MISS, MEM_LOAD_RETIRED.L1_HIT + MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT)",
> >     "MetricGroup": "DCache;DCache_L1",
> >     "MetricName": "DCache_L1_Miss",
> >     "ScaleUnit": "100%",
> > }
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied both,

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/tests/expr.c |  2 ++
> >  tools/perf/util/expr.l  |  1 +
> >  tools/perf/util/expr.y  | 14 ++++++++++++--
> >  3 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > index 1cb02ca2b15f..c4877b36ab58 100644
> > --- a/tools/perf/tests/expr.c
> > +++ b/tools/perf/tests/expr.c
> > @@ -39,6 +39,8 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> >  	ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
> >  	ret |= test(&ctx, "1.1 + 2.1", 3.2);
> >  	ret |= test(&ctx, ".1 + 2.", 2.1);
> > +	ret |= test(&ctx, "d_ratio(1, 2)", 0.5);
> > +	ret |= test(&ctx, "d_ratio(2.5, 0)", 0);
> >  
> >  	if (ret)
> >  		return ret;
> > diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> > index f397bf8b1a48..298d86660a96 100644
> > --- a/tools/perf/util/expr.l
> > +++ b/tools/perf/util/expr.l
> > @@ -100,6 +100,7 @@ symbol		({spec}|{sym})+
> >  		}
> >  	}
> >  
> > +d_ratio		{ return D_RATIO; }
> >  max		{ return MAX; }
> >  min		{ return MIN; }
> >  if		{ return IF; }
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index bf3e898e3055..fe145344bb39 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -10,6 +10,14 @@
> >  #include "smt.h"
> >  #include <string.h>
> >  
> > +static double d_ratio(double val0, double val1)
> > +{
> > +	if (val1 == 0) {
> > +		return 0;
> > +	}
> > +	return  val0 / val1;
> > +}
> > +
> >  %}
> >  
> >  %define api.pure full
> > @@ -28,7 +36,7 @@
> >  %token <num> NUMBER
> >  %token <str> ID
> >  %destructor { free ($$); } <str>
> > -%token MIN MAX IF ELSE SMT_ON
> > +%token MIN MAX IF ELSE SMT_ON D_RATIO
> >  %left MIN MAX IF
> >  %left '|'
> >  %left '^'
> > @@ -64,7 +72,8 @@ other: ID
> >  }
> >  |
> >  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> > -
> > +|
> > +D_RATIO
> >  
> >  all_expr: if_expr			{ *final_val = $1; }
> >  	;
> > @@ -105,6 +114,7 @@ expr:	  NUMBER
> >  	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
> >  	| MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
> >  	| SMT_ON		 { $$ = smt_on() > 0; }
> > +	| D_RATIO '(' expr ',' expr ')' { $$ = d_ratio($3,$5); }
> >  	;
> >  
> >  %%
> > -- 
> > 2.27.0.278.ge193c7cf3a9-goog
> > 
> 

-- 

- Arnaldo
