Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9583FC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D07206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939294;
	bh=9CwXsB6j+cdGoq+F1LJq20569Wf5iMHB/VG545qV3Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TmOIHBC+mfwQyHbk3EAqJtHTo5l9vVqByiI9TC1/QaoPrzrQJhVNPlEV7HQ2J0hMS
	 x5YWJP8CKgnzRkrAoQUtbwQFvATKql+7M6RkCq4dSeKO498JNR/YZpUf0V85ikO5Ag
	 s/+C8wfBWJYuHeE16FrawtgUg/bCEIHmumfIAtz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgG1M2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgG1M2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:28:11 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAE12070B;
        Tue, 28 Jul 2020 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939291;
        bh=9CwXsB6j+cdGoq+F1LJq20569Wf5iMHB/VG545qV3Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXjstydTgTg2gyyVbqIto0qyGOuzwTjHhzLLQqjdLqxJUG59oDW6xX+krcFxFBlGg
         KhuF/sYDZWekHv9SrH0+2g2RwuZx0AZ7spQccFChVcIMQ76IUjICsbz63JP7HEq/CP
         KrEEbKd2+3TT1lpxlUHUwFOenvJwAPUDERRKRGJo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A72F404B1; Tue, 28 Jul 2020 09:28:08 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:28:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 03/19] perf metric: Change expr__get_id to return struct
 expr_id_data
Message-ID: <20200728122808.GJ40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-4-jolsa@kernel.org>
 <c5590463-0896-fa70-4c8f-77daa67a8e88@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5590463-0896-fa70-4c8f-77daa67a8e88@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 26, 2020 at 02:47:00PM +0530, kajoljain escreveu:
> 
> 
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > Changing expr__get_id to use and return struct expr_id_data
> > pointer as value for the ID. This way we can access data other
> > than value for given ID in following changes.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Kajol Jain
> 
> >  tools/perf/util/expr.c | 10 +++-------
> >  tools/perf/util/expr.h |  3 ++-
> >  tools/perf/util/expr.y | 14 +++++++++-----
> >  3 files changed, 14 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 9228f60e2a20..4e5a6533dfce 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -73,14 +73,10 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
> >  	return ret;
> >  }
> >  
> > -int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr)
> > +int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> > +		 struct expr_id_data **data)
> >  {
> > -	struct expr_id_data *data;
> > -
> > -	if (!hashmap__find(&ctx->ids, id, (void **)&data))
> > -		return -1;
> > -	*val_ptr = (data == NULL) ?  0.0 : data->val;
> > -	return 0;
> > +	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
> >  }
> >  
> >  void expr__ctx_init(struct expr_parse_ctx *ctx)
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index ac32cda42006..f38292fdab19 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -28,7 +28,8 @@ void expr__ctx_init(struct expr_parse_ctx *ctx);
> >  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> >  int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
> >  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
> > -int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
> > +int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> > +		 struct expr_id_data **data);
> >  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> >  		const char *expr, int runtime);
> >  int expr__find_other(const char *expr, const char *one,
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index 8befe4a46f87..0d4f5d324be7 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -85,12 +85,16 @@ if_expr:
> >  	;
> >  
> >  expr:	  NUMBER
> > -	| ID			{ if (expr__get_id(ctx, $1, &$$)) {
> > -					pr_debug("%s not found\n", $1);
> > +	| ID			{
> > +					struct expr_id_data *data;
> > +
> > +					if (expr__get_id(ctx, $1, &data) || !data) {
> > +						pr_debug("%s not found\n", $1);
> > +						free($1);
> > +						YYABORT;
> > +					}
> > +					$$ = data->val;
> >  					free($1);
> > -					YYABORT;
> > -				  }
> > -				  free($1);
> >  				}
> >  	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
> >  	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
> > 

-- 

- Arnaldo
