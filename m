Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55E4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C4A2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adAROd3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHZPc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgHZPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:32:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:32:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so2219997wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHbmQjFjNCFtKI3a8N3tMoSt3Q8boWEf5S1FhlOo45w=;
        b=adAROd3us0jzSLD08JlGQlZzqtJlWrEIYn0eD13NkgQSaEPv6jntDiOpo/YOLx4tBv
         UxEbyt46wXjgFJsgGkZLHFO0+3Bf7TeY21GtXVREKMqZcKQZP5+wGD0z7t1fRtzwBwqQ
         4wyMl6U6lXQgv1sOWlxC5CJ4al1dYVSDIHJVbq1Hoeu62NZwujDuVf8DVdvzPR6zXpUK
         gwNGBZAYBtRFro3n0TGJhXBH6D/kBRpKbNK/o6aUyMyO0nw4B1pD2BKJgls7h7rNP2/4
         GEuxNsGIB518S1K8zmUpi5Uyj6FnP2xdPoZmek+ktYBWMreaE7uhl9EVnqY2cweb+TDY
         8V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHbmQjFjNCFtKI3a8N3tMoSt3Q8boWEf5S1FhlOo45w=;
        b=PVIpkl9VrJOcG5w1iIEA3+xnGEzlfxDSPJ73B5iSIxDpi6s/PNyNTjF55QsfJGzJc5
         IzRQURlLmCpimFyLDdKU3ae8fLqoM9zKnB2Mna33R1/rH4R1u2g8pQZx5FvXLBe3+B0r
         qPtTbGAvn5p04+GI7somrzeMY+dqKsOiDfY2LZfNRqw8RkqjfI/Fg0JYG7sPx1BnDoWl
         QusBGsGoIrL6oHNV6p2e86Ic6unVKfhQNSHL4nrvWULsvEs3SxA562u6/cqFa5VBjFWp
         B3B5ft9wY0jRSbpCZVk7nigNAEocOlmye70R9amHUZIbMOs9yneslb7WREWpkW4Ia3kF
         od3Q==
X-Gm-Message-State: AOAM5330DoMnjRklcOe6Jlt0DcqGt7hIgYI6nqIFFWguWweRwSZCAPV7
        vXf/KTX/WCv5reKbnB5WZsfK/3WHvs6oUaUywA6wuA==
X-Google-Smtp-Source: ABdhPJwRFivRG2rGhJI873qc+J/NsA2aarU23UF5qXJdH6d+CRJoxlxJKGrkDe/vJUTUx4eGA4vlNTECb2i+Au1/0wU=
X-Received: by 2002:adf:f184:: with SMTP id h4mr3035147wro.376.1598455943683;
 Wed, 26 Aug 2020 08:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200826042910.1902374-1-irogers@google.com> <20200826113354.GB753783@krava>
In-Reply-To: <20200826113354.GB753783@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 26 Aug 2020 08:32:12 -0700
Message-ID: <CAP-5=fVT6wDwJPJFF30ttBeAcOxgkqiQgUPEKtwZWbPLJPqtBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf expr: Force encapsulation on expr_id_data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 4:34 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Aug 25, 2020 at 09:29:09PM -0700, Ian Rogers wrote:
> > This patch resolves some undefined behavior where variables in
> > expr_id_data were accessed (for debugging) without being defined. To
> > better enforce the tagged union behavior, the struct is moved into
> > expr.c and accessors provided. Tag values (kinds) are explicitly
> > identified.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/expr.c        | 64 ++++++++++++++++++++++++++++++-----
> >  tools/perf/util/expr.h        | 17 +++-------
> >  tools/perf/util/expr.y        |  2 +-
> >  tools/perf/util/metricgroup.c |  4 +--
> >  4 files changed, 62 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 53482ef53c41..1ca0992db86b 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -17,6 +17,25 @@
> >  extern int expr_debug;
> >  #endif
> >
> > +struct expr_id_data {
> > +     union {
> > +             double val;
> > +             struct {
> > +                     double val;
> > +                     const char *metric_name;
> > +                     const char *metric_expr;
> > +             } ref;
> > +             struct expr_id  *parent;
> > +     };
> > +
> > +     enum {
> > +             EXPR_ID_DATA__VALUE,
> > +             EXPR_ID_DATA__REF,
> > +             EXPR_ID_DATA__REF_VALUE,
> > +             EXPR_ID_DATA__PARENT,
> > +     } kind;
>
> I like that, it's more clear than current state ;-)
>
> could you still put a small comment for each enum above,
> as a hint what it's used for?

Thanks, I had a go at this in v2:
https://lore.kernel.org/lkml/20200826153055.2067780-1-irogers@google.com/T/#u

Ian

> thanks,
> jirka
>
