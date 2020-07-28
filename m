Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B501AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB4620759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939317;
	bh=RlLNX+3G8fgpyvQOngE0tyQZ5bJFF6YCGkdbOlilhMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lFOYQOuKTAJ5VXwyVw+R4zDVd183/8kp2V2e/zpZgWUE27JTeyNMoJuILU5g62MTA
	 7WLfSJ6TlTrxVq137cHrAxOrfe9eDqcBrpQOhS6L7HtHCIDFe984Jhn7KU9Gn+lq4S
	 QBM4UoS7VqJnONCi1R8OmtnxchkB/F9o60uP6ido=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgG1M2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgG1M2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:28:35 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B20F5206D4;
        Tue, 28 Jul 2020 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939315;
        bh=RlLNX+3G8fgpyvQOngE0tyQZ5bJFF6YCGkdbOlilhMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0TctDtjvpZzjLLh6Wi1KtikeLAxpiAdv9gHCqO2T7+D8lmS+fyZoX3LuwImPsTA2
         Ey81iuokoyxME4uyXpNn4szu73scILCAosEQKt6csKbWVIhc0F0aEuES7OTqpQ9maz
         E8j5vo50Sk6tow1ggB3VB5qynB7IgToQFcQ+ywJE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BDC5B404B1; Tue, 28 Jul 2020 09:28:32 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:28:32 -0300
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
Subject: Re: [PATCH 04/19] perf metric: Add expr__del_id function
Message-ID: <20200728122832.GK40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-5-jolsa@kernel.org>
 <78a80947-fe21-9131-7f1f-07ee752631f9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a80947-fe21-9131-7f1f-07ee752631f9@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 26, 2020 at 02:47:11PM +0530, kajoljain escreveu:
> 
> 
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > Adding expr__del_id function to remove ID from hashmap.
> > It will save us few lines in following changes.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Kajol Jain
> 
> > ---
> >  tools/perf/util/expr.c | 21 +++++++++++++--------
> >  tools/perf/util/expr.h |  1 +
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 4e5a6533dfce..f726211f49d4 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -79,6 +79,17 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> >  	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
> >  }
> >  
> > +void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
> > +{
> > +	struct expr_id_data *old_val = NULL;
> > +	char *old_key = NULL;
> > +
> > +	hashmap__delete(&ctx->ids, id,
> > +			(const void **)&old_key, (void **)&old_val);
> > +	free(old_key);
> > +	free(old_val);
> > +}
> > +
> >  void expr__ctx_init(struct expr_parse_ctx *ctx)
> >  {
> >  	hashmap__init(&ctx->ids, key_hash, key_equal, NULL);
> > @@ -136,16 +147,10 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> >  int expr__find_other(const char *expr, const char *one,
> >  		     struct expr_parse_ctx *ctx, int runtime)
> >  {
> > -	struct expr_id_data *old_val = NULL;
> > -	char *old_key = NULL;
> >  	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
> >  
> > -	if (one) {
> > -		hashmap__delete(&ctx->ids, one,
> > -				(const void **)&old_key, (void **)&old_val);
> > -		free(old_key);
> > -		free(old_val);
> > -	}
> > +	if (one)
> > +		expr__del_id(ctx, one);
> >  
> >  	return ret;
> >  }
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index f38292fdab19..2462abd0ac65 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -26,6 +26,7 @@ struct expr_scanner_ctx {
> >  
> >  void expr__ctx_init(struct expr_parse_ctx *ctx);
> >  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> > +void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
> >  int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
> >  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
> >  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> > 

-- 

- Arnaldo
