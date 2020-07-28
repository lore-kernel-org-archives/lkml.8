Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48834C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F2D2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939265;
	bh=qnRKNV/9tPNIK8cgNXrpAYqVq9OezK6wne8F/ideH70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gD1ad2jl257Aa3Ocl504Z7I+Kk4j15jiCSfWTuHdQ3Ms4YEdt7kTAue1zwPBTTO0X
	 jHa0VHPAH1FmNcRSW7FxOcLObVUuUBj2Ymc99eVptRcyBhgLkyyqqoyxHT3O74s9v4
	 qy8QU/0ArjrGdTw7MAXxi8X4voJCrOuT8Ae29aW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgG1M1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgG1M1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:27:43 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF4C2206D4;
        Tue, 28 Jul 2020 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939263;
        bh=qnRKNV/9tPNIK8cgNXrpAYqVq9OezK6wne8F/ideH70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=18PJFQzKSgEfX6w5l7FD2l/J4i3OJtk2avJI96Hic+PEvKHGS4cULqh6Y2Jsh4YW1
         ByZgoDwRy8hPnAGUavapobEWY8X/PGL5pPfk+vWlJbjsRlnYzbCf+wUtEBmnWspQzy
         K3cS2vIX1cJCOGuyx8h6n++4xI+HRFC6KVVbea0g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B27E2404B1; Tue, 28 Jul 2020 09:27:39 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:27:39 -0300
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
Subject: Re: [PATCH 02/19] perf metric: Add expr__add_id function
Message-ID: <20200728122739.GI40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-3-jolsa@kernel.org>
 <73111916-408d-d3a1-53d8-050314505535@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73111916-408d-d3a1-53d8-050314505535@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 26, 2020 at 02:46:47PM +0530, kajoljain escreveu:
> 
> 
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > Adding expr__add_id function to data for ID
> > with zero value, which is used when scanning
> > the expression for IDs.
> > 
> 
> Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Kajol Jain
> 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/expr.c | 31 +++++++++++++++++++++++++------
> >  tools/perf/util/expr.h |  1 +
> >  tools/perf/util/expr.y |  2 +-
> >  3 files changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 578a173d4873..9228f60e2a20 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -32,6 +32,26 @@ static bool key_equal(const void *key1, const void *key2,
> >  	return !strcmp((const char *)key1, (const char *)key2);
> >  }
> >  
> > +/* Caller must make sure id is allocated */
> > +int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
> > +{
> > +	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
> > +	char *old_key = NULL;
> > +	int ret;
> > +
> > +	data_ptr = malloc(sizeof(*data_ptr));
> > +	if (!data_ptr)
> > +		return -ENOMEM;
> > +
> > +	ret = hashmap__set(&ctx->ids, id, data_ptr,
> > +			   (const void **)&old_key, (void **)&old_data);
> > +	if (ret)
> > +		free(data_ptr);
> > +	free(old_key);
> > +	free(old_data);
> > +	return ret;
> > +}
> > +
> >  /* Caller must make sure id is allocated */
> >  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
> >  {
> > @@ -39,12 +59,11 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
> >  	char *old_key = NULL;
> >  	int ret;
> >  
> > -	if (val != 0.0) {
> > -		data_ptr = malloc(sizeof(*data_ptr));
> > -		if (!data_ptr)
> > -			return -ENOMEM;
> > -		data_ptr->val = val;
> > -	}
> > +	data_ptr = malloc(sizeof(*data_ptr));
> > +	if (!data_ptr)
> > +		return -ENOMEM;
> > +	data_ptr->val = val;
> > +
> >  	ret = hashmap__set(&ctx->ids, id, data_ptr,
> >  			   (const void **)&old_key, (void **)&old_data);
> >  	if (ret)
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index 21fe5bd85718..ac32cda42006 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -26,6 +26,7 @@ struct expr_scanner_ctx {
> >  
> >  void expr__ctx_init(struct expr_parse_ctx *ctx);
> >  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> > +int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
> >  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
> >  int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
> >  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index b2b3420ea6ec..8befe4a46f87 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -69,7 +69,7 @@ all_other: all_other other
> >  
> >  other: ID
> >  {
> > -	expr__add_id_val(ctx, $1, 0.0);
> > +	expr__add_id(ctx, $1);
> >  }
> >  |
> >  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> > 

-- 

- Arnaldo
