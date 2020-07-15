Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2CEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0205F206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFEls2Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgGOVgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:36:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49264 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726356AbgGOVgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594848978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=laVjfN93leH1cHQFouR1JF4R0wX0uRpHtRImBzwzE/k=;
        b=LFEls2WqSvZ9ZKLk/KuIXKE1GPX8K4VJjhS1ZV4f0K1tZQUq2+546qLwKFqdw0KW2P6q1R
        0uaMNdgEvKlI+KFjL3QksS5wSOVML3o4G+48CHoxY8xSd7bijsKTVsuflQuQCpx1tnfPtz
        MG8ZeIaakUPMkDEb5zEX6zNKn6n19uQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-D2yIgBykNZGkAJ9ePuRXPw-1; Wed, 15 Jul 2020 17:36:15 -0400
X-MC-Unique: D2yIgBykNZGkAJ9ePuRXPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8428100CCC1;
        Wed, 15 Jul 2020 21:36:13 +0000 (UTC)
Received: from krava (unknown [10.40.194.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id DD1426FDD1;
        Wed, 15 Jul 2020 21:36:10 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:36:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH 11/18] perf metric: Add referenced metrics to hash data
Message-ID: <20200715213609.GV183694@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-12-jolsa@kernel.org>
 <CAP-5=fW2wknhCEQ8cPtmup6vQgWC45s9a0WJ+NsYt9Uu-Qm3Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW2wknhCEQ8cPtmup6vQgWC45s9a0WJ+NsYt9Uu-Qm3Mw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:25:14AM -0700, Ian Rogers wrote:
> On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:

SNIP

> > +int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
> > +{
> > +       struct expr_id_data *data_ptr = NULL, *old_data = NULL;
> > +       char *old_key = NULL;
> > +       char *name;
> > +       int ret;
> > +
> > +       data_ptr = zalloc(sizeof(*data_ptr));
> > +       if (!data_ptr)
> > +               return -ENOMEM;
> > +
> > +       name = strdup(ref->metric_name);
> > +       if (!name) {
> > +               free(data_ptr);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       data_ptr->ref.metric_name = ref->metric_name;
> > +       data_ptr->ref.metric_expr = ref->metric_expr;
> 
> Having one owned string and one unowned makes the memory management
> here somewhat complicated. Perhaps dupe both?

right, will check on this

> 
> > +       data_ptr->is_ref = true;
> > +
> > +       ret = hashmap__set(&ctx->ids, name, data_ptr,
> > +                          (const void **)&old_key, (void **)&old_data);
> > +
> > +       pr_debug2("adding ref metric %s: %s\n",
> > +                 ref->metric_name, ref->metric_expr);
> > +
> > +       free(old_key);
> > +       free(old_data);
> > +       return ret;
> > +}
> > +
> >  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> >                  struct expr_id_data **data)
> >  {
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index 2462abd0ac65..d19e66915228 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -11,12 +11,22 @@
> >  #include "util/hashmap.h"
> >  //#endif
> >
> > +struct metric_ref;
> > +
> >  struct expr_parse_ctx {
> >         struct hashmap ids;
> >  };
> >
> >  struct expr_id_data {
> > -       double  val;
> > +       bool    is_ref;
> 
> nit: place at the end to avoid padding?

ok

> 
> > +
> > +       union {
> > +               double  val;
> > +               struct {
> > +                       const char *metric_name;
> > +                       const char *metric_expr;
> > +               } ref;
> > +       };
> >  };
> >
> >  struct expr_scanner_ctx {
> > @@ -29,6 +39,7 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx);
> >  void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
> >  int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
> >  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
> > +int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
> >  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> >                  struct expr_id_data **data);
> >  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > index fc9ac4b4218e..e1ba6c1b916a 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -731,13 +731,14 @@ static void print_smi_cost(struct perf_stat_config *config,
> >  }
> >
> >  static int prepare_metric(struct evsel **metric_events,
> > +                         struct metric_ref *metric_refs,
> 
> nit: the plural on refs confused me at first, perhaps a comment that
> this is the array of referenced metrics.

I'll add the comment

thanks,
jirka

