Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A7BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF972084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDPOEqV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgDUGR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgDUGR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:17:26 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE02C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:17:24 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id b17so6612924ybq.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DChIRG5zUeqKCiLUPD4OJXbb7VfsS96nO4HchslRsQA=;
        b=vDPOEqV/whfQAFMVlVeTWFak27T+QL3ZjR2hkg8ut0KXD63U0/d+fNUb+sCJsnyhm6
         LF/GdaCLu1mh60/8C3XQ3o/WaNuyg2RpYJ2k7KJr70n2Fla2sfGpp/LUDv5pe9O0Hb1K
         fLUlypAtPVKHyEJEv+BFEwJSMLXa+Dt/p+EXv4ehaDXi7H/gVqIBwtKN7fpyoLhyru5t
         1ZCHCn//nLnOWsPVhWvPsldHhXo9wvPrIDNkUMPEpu+5jKrfyTeyloFW3+zmGdroL221
         k/vN8eA30mBjmZDSkb8u/rSDKpKT4JHVpwiuD2oPHd2JdR4eQBhSfAYhPOmaRHEe9bR/
         zz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DChIRG5zUeqKCiLUPD4OJXbb7VfsS96nO4HchslRsQA=;
        b=XJ3gxh23tdVYeS8zGQMLT6h4HQKKOs1Obr1gL7npO0xOg2K3msNd7Z6VYTfJNl/eh7
         M3yXbOe8c2t+ZKVlfpLVXSUZCqW3pTHbnll4kHgYQ9ie95HCVUr4dTAOy6CpfwdfcYWE
         8kqpF6oaL29n8+keoLF3Nncsg6EJ68s/wlNq4J/DuIqetCGOaA+rr7VcsafRNi7V9uux
         3z4GxOLL7PZ1AuZGOQec1bAHiYokKanry6eI+NO58hVXVcrwXxf6U9kPKsTJtjobyaMB
         OLXR1xNSZmBmSZhuJTqxQp3djmJYb2eKPO0crPOxGgko2B7nyZjzxmw/r+nkwDS9X5jp
         JlNw==
X-Gm-Message-State: AGi0Pua0z9q1kS+cflTSNlAsMUahjFzpFXGSTK30c4RKrnWH9MT8Lb9J
        kP+BRsXCLsRrcMsVBysu8E+Hgkcx6ZW0yMuyouNp2g==
X-Google-Smtp-Source: APiQypJqcaWsQDXLumxqdKOtZt7SvhNP5lwk0/LoIcrlCznfXtlKfx9z5aJCiRK5BwUqhz53ut+5UNXHiWQ5GfSOGYE=
X-Received: by 2002:a25:d993:: with SMTP id q141mr25438673ybg.403.1587449843511;
 Mon, 20 Apr 2020 23:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200416004713.192740-1-irogers@google.com> <20200420083720.GB718574@krava>
In-Reply-To: <20200420083720.GB718574@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Apr 2020 23:17:12 -0700
Message-ID: <CAP-5=fWMm+Bvuja8wLS4fSAxx5AVchKBGZ96KKc0sb0sze6x3Q@mail.gmail.com>
Subject: Re: [PATCH] perf record: add dummy event during system wide synthesis
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:44 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Apr 15, 2020 at 05:47:13PM -0700, Ian Rogers wrote:
> > During the processing of /proc during event synthesis new processes may
> > start. Add a dummy event if /proc is to be processed, to capture mmaps
> > for starting processes. This reuses the existing logic for
> > initial-delay.
> >
> > Suggested-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 1ab349abe904..bab4fc8568d1 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -805,16 +805,18 @@ static int record__open(struct record *rec)
> >       int rc = 0;
> >
> >       /*
> > -      * For initial_delay we need to add a dummy event so that we can track
> > -      * PERF_RECORD_MMAP while we wait for the initial delay to enable the
> > -      * real events, the ones asked by the user.
> > +      * For initial_delay or system wide, we need to add a dummy event so
> > +      * that we can track PERF_RECORD_MMAP to cover the delay (of waiting or
> > +      * synthesis) prior to the real user events being enabled.
> >        */
> > -     if (opts->initial_delay) {
> > +     if (opts->initial_delay || target__has_cpu(&opts->target)) {
>
> hum, how this works for system wide? IIRC the delay works
> for monitoring tasks by setting dummy with enable_on_exec,
> and enabling the rest by ioctl after the delay.. so without
> the monitored task there's no enable_on_exec effect

Thanks! I sent a 2nd version that makes the comments actually agree
with the code :-)
https://lore.kernel.org/lkml/20200421061103.109440-1-irogers@google.com/

Ian

> jirka
>
> >               if (perf_evlist__add_dummy(evlist))
> >                       return -ENOMEM;
> >
> > +             /* Disable tracking of mmaps on lead event. */
> >               pos = evlist__first(evlist);
> >               pos->tracking = 0;
> > +             /* Activate dummy event immediately. */
> >               pos = evlist__last(evlist);
> >               pos->tracking = 1;
> >               pos->core.attr.enable_on_exec = 1;
> > --
> > 2.26.0.110.g2183baf09c-goog
> >
>
