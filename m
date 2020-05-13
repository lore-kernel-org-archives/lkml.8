Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549ACCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3479120753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+5AO0jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgEMLZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:25:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39457 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726020AbgEMLZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589369137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iMcnKpcK4+A9xC5bYEcrshADP6iDpNNfbFlVi1KcwVc=;
        b=M+5AO0jIzW2XnHuAaXjavWX5yzyx9XqVXe74q8bMLzBn4lCDtjTkBBHXFaLWpMBkRo/nxf
        n+lsfJflha6N+Njr7hYKSHltSMkhZ2T+ST+PfQIJ30XQwFeKP+WZawiY2vopPPF3vmyWpZ
        SFLYFc58fxXmlgM1j2e/38CquTY+BCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-lZ2InMozNMSB-UA6yhsLLQ-1; Wed, 13 May 2020 07:25:33 -0400
X-MC-Unique: lZ2InMozNMSB-UA6yhsLLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C56BBEC1AC;
        Wed, 13 May 2020 11:25:31 +0000 (UTC)
Received: from krava (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id 17B587D945;
        Wed, 13 May 2020 11:25:28 +0000 (UTC)
Date:   Wed, 13 May 2020 13:25:28 +0200
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
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/4] perf expr: Add parsing support for multiple
 expressions
Message-ID: <20200513112528.GH3158213@krava>
References: <20200511205307.3107775-1-jolsa@kernel.org>
 <20200511205307.3107775-2-jolsa@kernel.org>
 <CAP-5=fU_JxSRJqY0zGo1UHj2gzoAigfr=g-1fUUU8W62pB9auA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU_JxSRJqY0zGo1UHj2gzoAigfr=g-1fUUU8W62pB9auA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:50:18PM -0700, Ian Rogers wrote:
> On Mon, May 11, 2020 at 1:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to parse metric difinitions in following form:
> 
> Typo on definitions.

right

SNIP

> > +int expr__parse_custom(struct expr_parse_ctx *ctx, const char *expr)
> > +{
> > +       return __expr__parse(NULL, ctx, expr, EXPR_CUSTOM, 0);
> > +}
> > +
> >  static bool
> >  already_seen(const char *val, const char *one, const char **other,
> >              int num_other)
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index 40fc452b0f2b..ef116b58a5d4 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -4,15 +4,29 @@
> >
> >  #define EXPR_MAX_OTHER 64
> >  #define MAX_PARSE_ID EXPR_MAX_OTHER
> > +#define EXPR_MAX 20
> 
> Currently deduplication of ids is done after rather than during
> expression pasing, meaning hitting these limits is quite easy. This is
> fixed in:
> https://lore.kernel.org/lkml/20200508053629.210324-8-irogers@google.com/
> But not for custom expressions being added here. I plan to rebase that
> work and clone hashmap from libbpf into libapi to workaround the
> dependency issue.
> That patch also adds expr__ctx_clear as a convenience for cleaning up
> the context, and passes the context around inside of metricgroup
> rather than ids.

ok

SNIP

> >  symbol         ({spec}|{sym})+
> > +all            [^;]+
> >
> >  %%
> >         struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
> > @@ -100,6 +103,12 @@ symbol             ({spec}|{sym})+
> >                 }
> >         }
> >
> > +<custom>{
> > +
> > +{all}          { BEGIN(INITIAL); return str(yyscanner, ALL, sctx->runtime); }
> > +
> > +}
> > +
> >  max            { return MAX; }
> >  min            { return MIN; }
> >  if             { return IF; }
> > @@ -118,6 +127,9 @@ else                { return ELSE; }
> >  "("            { return '('; }
> >  ")"            { return ')'; }
> >  ","            { return ','; }
> > +";"            { return ';'; }
> > +"="            { BEGIN(custom); return '='; }
> 
> Will this interfere with the \\= encoded in MetricExpr? Could you test with:
> https://lore.kernel.org/lkml/20200513062752.3681-2-irogers@google.com/

it shouldn't, the escape is matched first.. but I'll put it on top
of the new tests to be sure

> 
> > +\n             { }
> >  .              { }
> >  %%
> >
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index 21e82a1e11a2..0521e48fa5e3 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -24,9 +24,10 @@
> >         char    *str;
> >  }
> >
> > -%token EXPR_PARSE EXPR_OTHER EXPR_ERROR
> > +%token EXPR_PARSE EXPR_OTHER EXPR_CUSTOM EXPR_ERROR
> >  %token <num> NUMBER
> >  %token <str> ID
> > +%token <str> ALL
> 
> Missing %destructor, fix is here:
> https://lore.kernel.org/lkml/20200513000318.15166-1-irogers@google.com/

oops, right.. thanks

jirka

