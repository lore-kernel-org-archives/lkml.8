Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6441C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DC12076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594913216;
	bh=JnFZK7h6tl+b8TqPgJ1t4JyC9nAVfO6Mcls0/XtXzew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x+RLLssDS4/Qy/Ytt1VWD3GLKWACs0hf9avC6jSQidkhZFVDFURSfvB6pGDXbdAEU
	 a3Na4oOucGnBWnIh7KhSMwwf2igKqFACuGS4qqjGoQHEgRvs2gsW5El/rLwg7S95o2
	 46r+FCAqBsubrQJFHClXjqdJ04Hih/80mUxy7pvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgGPP0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgGPP0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:26:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7065F206F5;
        Thu, 16 Jul 2020 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594913213;
        bh=JnFZK7h6tl+b8TqPgJ1t4JyC9nAVfO6Mcls0/XtXzew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1knKxC+MrW4Qhs+gHUGu2/QNKDicPutd1+CUnL92+8I81e0Ir1vE50k+cL61y5JlU
         DX2xbXYow2RPJguyD3L6r7W43v9NJByBYh5v6JmR31tuHlCZj7W01l9iy3NghHJem7
         YmPxfDMmPs5XKlajl47J1vcrQjxeo0L1FyawPHlk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 985ED403C7; Thu, 16 Jul 2020 12:26:51 -0300 (-03)
Date:   Thu, 16 Jul 2020 12:26:51 -0300
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
Subject: Re: [PATCH 02/18] perf metric: Add struct expr_id_data to keep expr
 value
Message-ID: <20200716152651.GB374956@kernel.org>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-3-jolsa@kernel.org>
 <CAP-5=fU=WKHp5So8Wj+HossbjP1TL1gnvPczFQUK32eiuwP4SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU=WKHp5So8Wj+HossbjP1TL1gnvPczFQUK32eiuwP4SQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 14, 2020 at 02:06:23PM -0700, Ian Rogers escreveu:
> On Sun, Jul 12, 2020 at 6:26 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding struct expr_id_data to keep expr value
> > instead of just simple double pointer, so we can
> > store more data for ID in following changes.
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
> >  tools/perf/tests/expr.c       |  3 ++-
> >  tools/perf/util/expr.c        | 22 +++++++++++-----------
> >  tools/perf/util/expr.h        |  4 ++++
> >  tools/perf/util/metricgroup.c |  2 +-
> >  4 files changed, 18 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > index d13fc1dfd5ef..4d01051951cd 100644
> > --- a/tools/perf/tests/expr.c
> > +++ b/tools/perf/tests/expr.c
> > @@ -18,8 +18,9 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
> >
> >  int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> >  {
> > +       struct expr_id_data *val_ptr;
> >         const char *p;
> > -       double val, *val_ptr;
> > +       double val;
> >         int ret;
> >         struct expr_parse_ctx ctx;
> >
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 9116a3a01eea..5d05f9765ed8 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -33,32 +33,32 @@ static bool key_equal(const void *key1, const void *key2,
> >  }
> >
> >  /* Caller must make sure id is allocated */
> > -int expr__add_id_val(struct expr_parse_ctx *ctx, const char *name, double val)
> > +int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
> >  {
> > -       double *val_ptr = NULL, *old_val = NULL;
> > +       struct expr_id_data *data_ptr = NULL, *old_data = NULL;
> >         char *old_key = NULL;
> >         int ret;
> >
> >         if (val != 0.0) {
> > -               val_ptr = malloc(sizeof(double));
> > -               if (!val_ptr)
> > +               data_ptr = malloc(sizeof(*data_ptr));
> > +               if (!data_ptr)
> >                         return -ENOMEM;
> > -               *val_ptr = val;
> > +               data_ptr->val = val;
> >         }
> > -       ret = hashmap__set(&ctx->ids, name, val_ptr,
> > -                          (const void **)&old_key, (void **)&old_val);
> > +       ret = hashmap__set(&ctx->ids, id, data_ptr,
> > +                          (const void **)&old_key, (void **)&old_data);
> >         free(old_key);
> > -       free(old_val);
> > +       free(old_data);
> >         return ret;
> >  }
> >
> >  int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr)
> >  {
> > -       double *data;
> > +       struct expr_id_data *data;
> >
> >         if (!hashmap__find(&ctx->ids, id, (void **)&data))
> >                 return -1;
> > -       *val_ptr = (data == NULL) ?  0.0 : *data;
> > +       *val_ptr = (data == NULL) ?  0.0 : data->val;
> >         return 0;
> >  }
> >
> > @@ -119,7 +119,7 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> >  int expr__find_other(const char *expr, const char *one,
> >                      struct expr_parse_ctx *ctx, int runtime)
> >  {
> > -       double *old_val = NULL;
> > +       struct expr_id_data *old_val = NULL;
> >         char *old_key = NULL;
> >         int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
> >
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index bb6bac836b48..21fe5bd85718 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -15,6 +15,10 @@ struct expr_parse_ctx {
> >         struct hashmap ids;
> >  };
> >
> > +struct expr_id_data {
> > +       double  val;
> > +};
> > +
> >  struct expr_scanner_ctx {
> >         int start_token;
> >         int runtime;
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 82fecb5a302d..df0356ec120d 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -138,7 +138,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >                                       unsigned long *evlist_used)
> >  {
> >         struct evsel *ev, *current_leader = NULL;
> > -       double *val_ptr;
> > +       struct expr_id_data *val_ptr;
> >         int i = 0, matched_events = 0, events_to_match;
> >         const int idnum = (int)hashmap__size(&pctx->ids);
> >
> > --
> > 2.25.4
> >

-- 

- Arnaldo
