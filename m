Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF9AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C369206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKfE0dIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgF1Vwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 17:52:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20566 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbgF1Vwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 17:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593381169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8EQX9vaNpAb//mfFi/UtZHvGSMpSNIESnWY0xlOk7I=;
        b=UKfE0dIxico/NL5oIkDDWfl/NoiQgzdhXdx07tK9oZH2XFCSGJWhCMOxgGTuRvokmOeexL
        +hhBgS+rBhUnadySZ8wfkzzSSvhqB6xA6EovFiz89f4UWueyFOdwNmVgq/bHhJyQX1PikU
        K/1qMGmM8JUe+gUMOQ0m7kjZBahy1sU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-LIZ29J2xO3C1ZKGHRkRfBQ-1; Sun, 28 Jun 2020 17:52:45 -0400
X-MC-Unique: LIZ29J2xO3C1ZKGHRkRfBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC2D91800D4A;
        Sun, 28 Jun 2020 21:52:43 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 20EA8100164D;
        Sun, 28 Jun 2020 21:52:40 +0000 (UTC)
Date:   Sun, 28 Jun 2020 23:52:40 +0200
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
Subject: Re: [PATCH 05/10] perf tools: Add expr__del_id function
Message-ID: <20200628215240.GL2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-6-jolsa@kernel.org>
 <CAP-5=fWKPRYJ3D264=qKVyRs15n-tNPqPfqv_dL2q15KGzTeaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWKPRYJ3D264=qKVyRs15n-tNPqPfqv_dL2q15KGzTeaw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:55:37PM -0700, Ian Rogers wrote:
> On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding expr__del_id function to remove ID from hashmap.
> > It will save us few lines in following changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/expr.c | 21 +++++++++++++--------
> >  tools/perf/util/expr.h |  1 +
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 29cdef18849c..aa14c7111ecc 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -75,6 +75,17 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> >         return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
> >  }
> >
> > +void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
> > +{
> > +       struct expr_parse_data *old_val = NULL;
> > +       char *old_key = NULL;
> > +
> > +       hashmap__delete(&ctx->ids, id,
> > +                       (const void **)&old_key, (void **)&old_val);
> > +       free(old_key);
> > +       free(old_val);
> > +}
> > +
> >  void expr__ctx_init(struct expr_parse_ctx *ctx)
> >  {
> >         hashmap__init(&ctx->ids, key_hash, key_equal, NULL);
> > @@ -132,16 +143,10 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> >  int expr__find_other(const char *expr, const char *one,
> >                      struct expr_parse_ctx *ctx, int runtime)
> >  {
> > -       struct expr_parse_data *old_val = NULL;
> > -       char *old_key = NULL;
> >         int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
> >
> > -       if (one) {
> > -               hashmap__delete(&ctx->ids, one,
> > -                               (const void **)&old_key, (void **)&old_val);
> > -               free(old_key);
> > -               free(old_val);
> > -       }
> > +       if (one)
> > +               expr__del_id(ctx, one);
> 
> Nit, I always have to read the code to know why we have "one" as an
> argument. Could we remove it as an argument and have the caller use
> expr__del_id?

I'll check sounds like good thing to do

thanks,
jirka

