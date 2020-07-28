Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32C8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECA22078E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939595;
	bh=cd/0mkVmg4wyUp030pNKpFIKgO5Kn7PVxjjHeSdPP1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VQa/25Jq3dIKojh4+8ySOAyXhCsgwptzCa/lG3PDJ9lH6uoUfHutOlgP6RtFXUXBd
	 I7DWf4uZSqRAG1zVZ9bm53ue/0bSJJZOdF/EDpRUBIJaTEh3UC0cnoUa4HA6nHurv+
	 3CrGx7mz9FoAOa02f/g5m+yOxKgxPCJoJLnbe7sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgG1MdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbgG1MdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:33:14 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D55120759;
        Tue, 28 Jul 2020 12:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939593;
        bh=cd/0mkVmg4wyUp030pNKpFIKgO5Kn7PVxjjHeSdPP1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZDOP9vJRV69+/2XZ4cE7xDWul5LIw0LfgfL/PJfVB1hb5+1CoaY8PQKTCMr2eQeW
         xWDeV96t82XRTafRGtdz88UyBFPedWPyCPpghhQMQhCAyuWSbZyWVvsRej+AjZIi3W
         7/Wqh4qRPwjO1ZU+oUKg97saYeqja6r6a3AoD8Co=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C35F8404B1; Tue, 28 Jul 2020 09:33:10 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:33:10 -0300
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
Subject: Re: [PATCH 11/19] perf metric: Compute referenced metrics
Message-ID: <20200728123310.GR40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-12-jolsa@kernel.org>
 <201d05c0-7aef-b853-da7f-0371fd221084@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201d05c0-7aef-b853-da7f-0371fd221084@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 26, 2020 at 02:49:04PM +0530, kajoljain escreveu:
> 
> 
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > Adding computation (expr__parse call) of referenced metric at
> > the point when it needs to be resolved during the parent metric
> > computation.
> > 
> > Once the inner metric is computed, the result is stored and
> > used if there's another usage of that metric.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Kajol Jain
> > ---
> >  tools/perf/util/expr.c | 31 +++++++++++++++++++++++++++++++
> >  tools/perf/util/expr.h |  3 +++
> >  tools/perf/util/expr.y |  4 ++--
> >  3 files changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index d3997c2b4a90..a346ca590513 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -112,6 +112,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
> >  	 */
> >  	data_ptr->ref.metric_name = ref->metric_name;
> >  	data_ptr->ref.metric_expr = ref->metric_expr;
> > +	data_ptr->ref.counted = false;
> >  	data_ptr->is_ref = true;
> >  
> >  	ret = hashmap__set(&ctx->ids, name, data_ptr,
> > @@ -133,6 +134,34 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> >  	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
> >  }
> >  
> > +int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
> > +		     struct expr_id_data **datap)
> > +{
> > +	struct expr_id_data *data;
> > +
> > +	if (expr__get_id(ctx, id, datap) || !*datap) {
> > +		pr_debug("%s not found\n", id);
> > +		return -1;
> > +	}
> > +
> > +	data = *datap;
> > +
> > +	pr_debug2("lookup: is_ref %d, counted %d, val %f: %s\n",
> > +		  data->is_ref, data->ref.counted, data->val, id);
> > +
> > +	if (data->is_ref && !data->ref.counted) {
> > +		data->ref.counted = true;
> > +		pr_debug("processing metric: %s ENTRY\n", id);
> > +		if (expr__parse(&data->val, ctx, data->ref.metric_expr, 1)) {
> > +			pr_debug("%s failed to count\n", id);
> > +			return -1;
> > +		}
> > +		pr_debug("processing metric: %s EXIT: %f\n", id, data->val);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
> >  {
> >  	struct expr_id_data *old_val = NULL;
> > @@ -173,6 +202,8 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
> >  	void *scanner;
> >  	int ret;
> >  
> > +	pr_debug2("parsing metric: %s\n", expr);
> > +
> >  	ret = expr_lex_init_extra(&scanner_ctx, &scanner);
> >  	if (ret)
> >  		return ret;
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index 81d04ff7f857..9ed208d93418 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -23,6 +23,7 @@ struct expr_id_data {
> >  		struct {
> >  			const char *metric_name;
> >  			const char *metric_expr;
> > +			bool counted;
> >  		} ref;
> >  	};
> >  
> > @@ -42,6 +43,8 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
> >  int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
> >  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> >  		 struct expr_id_data **data);
> > +int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
> > +		     struct expr_id_data **datap);
> >  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> >  		const char *expr, int runtime);
> >  int expr__find_other(const char *expr, const char *one,
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index 0d4f5d324be7..d34b370391c6 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -88,11 +88,11 @@ expr:	  NUMBER
> >  	| ID			{
> >  					struct expr_id_data *data;
> >  
> > -					if (expr__get_id(ctx, $1, &data) || !data) {
> > -						pr_debug("%s not found\n", $1);
> > +					if (expr__resolve_id(ctx, $1, &data)) {
> >  						free($1);
> >  						YYABORT;
> >  					}
> > +
> >  					$$ = data->val;
> >  					free($1);
> >  				}
> > 

-- 

- Arnaldo
