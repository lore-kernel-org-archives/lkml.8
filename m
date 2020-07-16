Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80FEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752B22065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594913107;
	bh=zbTp/C0RcG42cvdhEDgVsriLWlz5cdwkVF9X5oDTxSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hby1IqdKs8jOdarnHYlDYAjfo05dA0IqE1knpq1ctq8ZIpsWyVxmVx+KyN5hI0IET
	 OFlb6Sh2ukiJarXIDxBpAGPdZqmYu+G615gyDCV/a9o+qj8PhGRZGnk1Dat3v48Gp9
	 RJeEZZ5mbc+JiBR9xvyI7MpPvlxxwFGqR9H6ZuM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgGPPZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgGPPZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:25:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CDA32063A;
        Thu, 16 Jul 2020 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594913104;
        bh=zbTp/C0RcG42cvdhEDgVsriLWlz5cdwkVF9X5oDTxSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zQA06fcEXfQX4FZj3s/t9y+se6+Hot/V8eg12Y8LDTkZSpXpy7pxj5FoCDuUpzY1z
         ePjehpwgD4o70w6AbpZ01h5lxOqVV51UgP623fouC9dRqJ5Tn2gH5RiiDEKLDZKryf
         sZiIb25U1QKMPyFYCbHqJ78NPwlRfySMVVyOmeuo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74C10403C7; Thu, 16 Jul 2020 12:25:02 -0300 (-03)
Date:   Thu, 16 Jul 2020 12:25:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 01/18] perf metric: Rename expr__add_id to expr__add_val
Message-ID: <20200716152502.GA374956@kernel.org>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-2-jolsa@kernel.org>
 <CAP-5=fW+1PxuzcPKN8iMSH3y_6qRTkiry6+gO3JpeT5kWxiOoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW+1PxuzcPKN8iMSH3y_6qRTkiry6+gO3JpeT5kWxiOoQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 14, 2020 at 02:05:36PM -0700, Ian Rogers escreveu:
> On Sun, Jul 12, 2020 at 6:26 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Renaming expr__add_id to expr__add_val so we can use
> > expr__add_id to actually add just id without any value
> > in following changes.
> >
> > There's no functional change.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/expr.c       | 4 ++--
> >  tools/perf/tests/pmu-events.c | 4 ++--
> >  tools/perf/util/expr.c        | 2 +-
> >  tools/perf/util/expr.h        | 2 +-
> >  tools/perf/util/expr.y        | 2 +-
> >  tools/perf/util/stat-shadow.c | 4 ++--
> >  6 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > index b7e5ef3007fc..d13fc1dfd5ef 100644
> > --- a/tools/perf/tests/expr.c
> > +++ b/tools/perf/tests/expr.c
> > @@ -24,8 +24,8 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> >         struct expr_parse_ctx ctx;
> >
> >         expr__ctx_init(&ctx);
> > -       expr__add_id(&ctx, strdup("FOO"), 1);
> > -       expr__add_id(&ctx, strdup("BAR"), 2);
> > +       expr__add_id_val(&ctx, strdup("FOO"), 1);
> > +       expr__add_id_val(&ctx, strdup("BAR"), 2);
> >
> >         ret = test(&ctx, "1+1", 2);
> >         ret |= test(&ctx, "FOO+BAR", 3);
> > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> > index b66b021476ec..eb19f9a0bc15 100644
> > --- a/tools/perf/tests/pmu-events.c
> > +++ b/tools/perf/tests/pmu-events.c
> > @@ -492,7 +492,7 @@ static int test_parsing(void)
> >                          */
> >                         k = 1;
> >                         hashmap__for_each_entry((&ctx.ids), cur, bkt)
> > -                               expr__add_id(&ctx, strdup(cur->key), k++);
> > +                               expr__add_id_val(&ctx, strdup(cur->key), k++);
> >
> >                         hashmap__for_each_entry((&ctx.ids), cur, bkt) {
> >                                 if (check_parse_cpu(cur->key, map == cpus_map,
> > @@ -547,7 +547,7 @@ static int metric_parse_fake(const char *str)
> >          */
> >         i = 1;
> >         hashmap__for_each_entry((&ctx.ids), cur, bkt)
> > -               expr__add_id(&ctx, strdup(cur->key), i++);
> > +               expr__add_id_val(&ctx, strdup(cur->key), i++);
> >
> >         hashmap__for_each_entry((&ctx.ids), cur, bkt) {
> >                 if (check_parse_fake(cur->key)) {
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index e8f777830a23..9116a3a01eea 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -33,7 +33,7 @@ static bool key_equal(const void *key1, const void *key2,
> >  }
> >
> >  /* Caller must make sure id is allocated */
> > -int expr__add_id(struct expr_parse_ctx *ctx, const char *name, double val)
> > +int expr__add_id_val(struct expr_parse_ctx *ctx, const char *name, double val)
> >  {
> >         double *val_ptr = NULL, *old_val = NULL;
> >         char *old_key = NULL;
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index 8a2c1074f90f..bb6bac836b48 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -22,7 +22,7 @@ struct expr_scanner_ctx {
> >
> >  void expr__ctx_init(struct expr_parse_ctx *ctx);
> >  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> > -int expr__add_id(struct expr_parse_ctx *ctx, const char *id, double val);
> > +int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
> >  int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
> >  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> >                 const char *expr, int runtime);
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index 5fcb98800f9c..b2b3420ea6ec 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -69,7 +69,7 @@ all_other: all_other other
> >
> >  other: ID
> >  {
> > -       expr__add_id(ctx, $1, 0.0);
> > +       expr__add_id_val(ctx, $1, 0.0);
> >  }
> >  |
> >  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > index 8fdef47005e6..fc9ac4b4218e 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -773,9 +773,9 @@ static int prepare_metric(struct evsel **metric_events,
> >                         *pn = 0;
> >
> >                 if (metric_total)
> > -                       expr__add_id(pctx, n, metric_total);
> > +                       expr__add_id_val(pctx, n, metric_total);
> >                 else
> > -                       expr__add_id(pctx, n, avg_stats(stats)*scale);
> > +                       expr__add_id_val(pctx, n, avg_stats(stats)*scale);
> >         }
> >
> >         return i;
> > --
> > 2.25.4
> >

-- 

- Arnaldo
