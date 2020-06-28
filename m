Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C60C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2DF20663
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3LM3C6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgF1ViR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 17:38:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22431 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbgF1ViR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 17:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593380295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDVmjKZTxGtyGA5yuymYdTN5Vc9Fld1DIVoEeQX/AL0=;
        b=O3LM3C6QOI8T6ZvNxMGj6wxtqWVXUia38/Ob3+KrLKUgbSHJn/Vzdo2tO+QZCvKidykQqt
        qwuH/Z5onDgW+aIKFff5dcT0DANot2I8EZOhpwv6Dw96SY3IuXn2SCtsW0mYKBaFpevSAP
        pK+cbPCsAPf0czD32ws2laBokK9RYl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-pdKj4ZOAMhKZ6_kWNvjtYg-1; Sun, 28 Jun 2020 17:38:10 -0400
X-MC-Unique: pdKj4ZOAMhKZ6_kWNvjtYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13FC2107ACCA;
        Sun, 28 Jun 2020 21:38:08 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1B05260BE2;
        Sun, 28 Jun 2020 21:38:04 +0000 (UTC)
Date:   Sun, 28 Jun 2020 23:38:04 +0200
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
Subject: Re: [PATCH 03/10] perf tools: Add expr__add_id function
Message-ID: <20200628213804.GJ2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-4-jolsa@kernel.org>
 <CAP-5=fXHKWeFCpG3mWchj5Oa+WPnsQBbt00K5MHdJ+u3U=extg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXHKWeFCpG3mWchj5Oa+WPnsQBbt00K5MHdJ+u3U=extg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:07:24PM -0700, Ian Rogers wrote:
> On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding expr__add_id function to data for ID
> > with zero value, which is used when scanning
> > the expression for IDs.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/expr.c | 29 +++++++++++++++++++++++------
> >  tools/perf/util/expr.h |  1 +
> >  tools/perf/util/expr.y |  2 +-
> >  3 files changed, 25 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 7573b21e73df..0b6d3a6ce88e 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -32,6 +32,24 @@ static bool key_equal(const void *key1, const void *key2,
> >         return !strcmp((const char *)key1, (const char *)key2);
> >  }
> >
> > +/* Caller must make sure id is allocated */
> > +int expr__add_id(struct expr_parse_ctx *ctx, const char *name)
> 
> Nit, perhaps "id" is more consistent than "name". Perhaps also change
> add_val below.

ok, will change

thanks,
jirka

> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> > +{
> > +       struct expr_parse_data *data_ptr = NULL, *old_data = NULL;
> > +       char *old_key = NULL;
> > +       int ret;
> > +
> > +       data_ptr = malloc(sizeof(*data_ptr));
> > +       if (!data_ptr)
> > +               return -ENOMEM;
> > +
> > +       ret = hashmap__set(&ctx->ids, name, data_ptr,
> > +                          (const void **)&old_key, (void **)&old_data);
> > +       free(old_key);
> > +       free(old_data);
> > +       return ret;
> > +}
> > +
> >  /* Caller must make sure id is allocated */
> >  int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
> >  {
> > @@ -39,12 +57,11 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
> >         char *old_key = NULL;
> >         int ret;
> >
> > -       if (val != 0.0) {
> > -               data_ptr = malloc(sizeof(*data_ptr));
> > -               if (!data_ptr)
> > -                       return -ENOMEM;
> > -               data_ptr->val = val;
> > -       }
> > +       data_ptr = malloc(sizeof(*data_ptr));
> > +       if (!data_ptr)
> > +               return -ENOMEM;
> > +       data_ptr->val = val;
> > +
> >         ret = hashmap__set(&ctx->ids, name, data_ptr,
> >                            (const void **)&old_key, (void **)&old_data);
> >         free(old_key);
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index f9f16efe76bc..5452e641acf4 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -26,6 +26,7 @@ struct expr_scanner_ctx {
> >
> >  void expr__ctx_init(struct expr_parse_ctx *ctx);
> >  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> > +int expr__add_id(struct expr_parse_ctx *ctx, const char *name);
> >  int expr__add_val(struct expr_parse_ctx *ctx, const char *id, double val);
> >  int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
> >  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index ff5e5f6e170d..ac4b119877e0 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -71,7 +71,7 @@ all_other: all_other other
> >
> >  other: ID
> >  {
> > -       expr__add_val(ctx, $1, 0.0);
> > +       expr__add_id(ctx, $1);
> >  }
> >  |
> >  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> > --
> > 2.25.4
> >
> 

