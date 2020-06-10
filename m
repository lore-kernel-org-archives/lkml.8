Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334462072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591807389;
	bh=QP3+X8cmUt4+ZcgiNEh3rYdgCTKhxQ0YgjQdC5l481I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wxq+EY92tT1kIXGDc/MB0E7FlR55B9Ay7+Hq4R0ClZoJAVccusjXkXyuW3t22SVOx
	 clVE1Jo1MrKxh3PRVgLem0nG6zhmrJnHQJ+szT2erfFATEFNeitJ+8Y/L9EvlB4UUk
	 eLa/gG2cjYAjl4t8yC3C8IHx0qi+tG5zlL1e1HMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgFJQnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgFJQnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:43:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88BE3206F4;
        Wed, 10 Jun 2020 16:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591807386;
        bh=QP3+X8cmUt4+ZcgiNEh3rYdgCTKhxQ0YgjQdC5l481I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWpweWJdfHk7c642NiX4iO9wV2samkDpZIeHuqKHqBBah+QBQObZg3SF6cnuC9Re+
         fJlxmEWX+jnc4FgbqSEE8o0HTKl0ybkD0MLq6AvPu8E1tNEXiBKymraPhFu+mxpnV2
         zyHnhQTJ5Gffsuf+usggNu5P1dT0JVN8NPv1wvnc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 903A040AFD; Wed, 10 Jun 2020 13:43:04 -0300 (-03)
Date:   Wed, 10 Jun 2020 13:43:04 -0300
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
Subject: Re: [PATCH 1/2] perf expr: Add d_ratio operation
Message-ID: <20200610164304.GA29052@kernel.org>
References: <20200610051717.170457-1-irogers@google.com>
 <20200610154129.GA1776102@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610154129.GA1776102@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 10, 2020 at 05:41:29PM +0200, Jiri Olsa escreveu:
> On Tue, Jun 09, 2020 at 10:17:15PM -0700, Ian Rogers wrote:
> > This simplifies computing ratios in json expressions.
> 
> please put in the comment some usage example and add
> a test for this to tests/expr.c
> 
> same for the '<>' operators in the other patch
> 
> I'll put documentation on this together with the rest to
> stat man page with my other changes, so no need to document
> this, but at least bit more details in changelog ;-)

Removed those from my local branch, pushed what I have to tmp.perf/core

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/expr.l |  1 +
> >  tools/perf/util/expr.y | 14 ++++++++++++--
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> > 
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
