Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D978DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95F0205CB
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1bWFLqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgF1V5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 17:57:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37514 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgF1V5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 17:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593381418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nnIK6dyjkHa36+vFymOUq0a3L3byDyQpMtuF9uWKz/8=;
        b=O1bWFLqvc0e9H8tFdp5N+rUBWSWEwonph7rmXU9BV/VXXBnMxOWO6wKrIpxWNrTVmC/kbC
        Gt22SX6lAwtbd0lDYNJAXMFAiLr/ZQJXpZ6Kyz7B2QhiH3oIEIm8kJCtJkt5I8GLTm3Zav
        R4RtxfFjrFBFEw+cFtzHDv5KivJpoog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-iDB7MpKJPI-mhCVhS2U6tQ-1; Sun, 28 Jun 2020 17:56:54 -0400
X-MC-Unique: iDB7MpKJPI-mhCVhS2U6tQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B18FA1005512;
        Sun, 28 Jun 2020 21:56:52 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id DD510100164D;
        Sun, 28 Jun 2020 21:56:49 +0000 (UTC)
Date:   Sun, 28 Jun 2020 23:56:48 +0200
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
Subject: Re: [PATCH 08/10] perf tools: Add other metrics to hash data
Message-ID: <20200628215648.GN2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-9-jolsa@kernel.org>
 <CAP-5=fVEyyUGU4NPk0wCCYfjkSNw=SBcPy5GWXExFG-Xh0+KFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVEyyUGU4NPk0wCCYfjkSNw=SBcPy5GWXExFG-Xh0+KFg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:16:30PM -0700, Ian Rogers wrote:
> On Fri, Jun 26, 2020 at 12:48 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding other metrics to the parsing context so they
> > can be resolved during the metric processing.
> >
> > Adding expr__add_other function to store 'other' metrics
> > into parse context.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/expr.c        | 35 +++++++++++++++++++++++++++++++++++
> >  tools/perf/util/expr.h        | 13 ++++++++++++-
> >  tools/perf/util/stat-shadow.c | 19 +++++++++++++------
> >  3 files changed, 60 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index cd73dae4588c..32f7acac7c19 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -4,6 +4,8 @@
> >  #include <errno.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > +#include "metricgroup.h"
> > +#include "debug.h"
> >  #include "expr.h"
> >  #include "expr-bison.h"
> >  #include "expr-flex.h"
> > @@ -61,6 +63,7 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
> >         if (!data_ptr)
> >                 return -ENOMEM;
> >         data_ptr->val = val;
> > +       data_ptr->is_other = false;
> >
> >         ret = hashmap__set(&ctx->ids, name, data_ptr,
> >                            (const void **)&old_key, (void **)&old_data);
> > @@ -69,6 +72,38 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
> >         return ret;
> >  }
> >
> > +int expr__add_other(struct expr_parse_ctx *ctx, struct metric_other *other)
> > +{
> > +       struct expr_parse_data *data_ptr = NULL, *old_data = NULL;
> > +       char *old_key = NULL;
> > +       char *name;
> > +       int ret;
> > +
> > +       data_ptr = malloc(sizeof(*data_ptr));
> > +       if (!data_ptr)
> > +               return -ENOMEM;
> > +
> > +       name = strdup(other->metric_name);
> > +       if (!name) {
> > +               free(data_ptr);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       data_ptr->other.metric_name = other->metric_name;
> > +       data_ptr->other.metric_expr = other->metric_expr;
> > +       data_ptr->is_other = true;
> > +
> > +       ret = hashmap__set(&ctx->ids, name, data_ptr,
> > +                          (const void **)&old_key, (void **)&old_data);
> > +
> > +       pr_debug2("adding other metric %s: %s\n",
> > +                 other->metric_name, other->metric_expr);
> > +
> > +       free(old_key);
> > +       free(old_data);
> > +       return ret;
> > +}
> > +
> >  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> >                  struct expr_parse_data **data)
> >  {
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index fd924bb4e5cd..ed60f9227b43 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -11,12 +11,22 @@
> >  #include "util/hashmap.h"
> >  //#endif
> >
> > +struct metric_other;
> > +
> >  struct expr_parse_ctx {
> >         struct hashmap ids;
> >  };
> >
> >  struct expr_parse_data {
> > -       double  val;
> > +       bool    is_other;
> > +
> > +       union {
> > +               double  val;
> > +               struct {
> > +                       const char *metric_name;
> > +                       const char *metric_expr;
> 
> It is probably worth a comment why both the metric_name and the
> metric's expression are required here? The parse and other data for
> the metric won't be here.

it's there to have it ready when processing the metric,
I'll add some more comments in here

thanks,
jirka

