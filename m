Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D4CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E130204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ID60jriV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgFJRBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFJRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:00:59 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378BCC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:00:59 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id h39so1526849ybj.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAn/vEENpEbesBOWaBTuDMNJu3dq2SPxsANahUJVgJs=;
        b=ID60jriV2Uju36JWKStG8hpF8OHlm/pfioalRdyEhRZJyNqEILQ+EYFjKBu0cIiyMP
         oV+qiiMWde9OmhxTm9fJD4bJb6KDOCvafU/uAt+9CWXRb4Dl68EM7UVbCdbHJ98ZjhRI
         xNpRx9j2aliYy9eKvnjqq0ouMO3vxcFJABsTM2J6gRIwILCTPgl9ksq4huinWnhqNep7
         V6bCI9a3UIcgAEGPm4zug8zkc6OkkcnRDWce0+nhxR++abC11Rc7RpLz472uYRR7429R
         0AQLGp8vHnYj3d3gZhhUZHyxgO+G8DxkEtjbCfCOHjN05rIcYG1w5Esrs4CIdQfAg40x
         w1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAn/vEENpEbesBOWaBTuDMNJu3dq2SPxsANahUJVgJs=;
        b=pbu3dSgAJPt9GLmed9Q7bo/i+v0QVvLLu8Rl6na4jyGfFt3xMyaiUgib9aS3aDRJm/
         /SCeP8C0BycVDpkUI3L+UfHONQn/ltrN2AXiIe0USGGKpxjSfsdX6aWD53O60SQOWJ7F
         Y9DNE9vWfZCa5iMBc4dH3r9zuFpVVsPEZ00qlfBeBSJk4hlAmSC6hlCN6egONtpkGDQr
         Q/MWb1eat+X518NZMP3ivc0/R2lAvqeusQBoA/+VFNUjP92bKUdDMNtngj6oAauuUG72
         pbo8mxwuK/yWW42+kvdnTH0urDj+kTqZuHDDflkp31wLr5NGesu+1rjNfcCcLdyzONyW
         m/SA==
X-Gm-Message-State: AOAM53005E/Ek/WuJx9b36OqlAKmtzJtSMtZRF4+1WXjnTo1TQTtYr3X
        J+MWAcyRyWd//Q6buJ3x6LgrY6QFtJ6hq1ueU3xaKw==
X-Google-Smtp-Source: ABdhPJw8bgDvl6gUCqh2SzcipGnhs+JBOLrAekTdtj/91HV2WxW2KAmb5VfFMYqS0Z5nscaCAUaDP48unGBE1VvM4T8=
X-Received: by 2002:a25:3782:: with SMTP id e124mr7027440yba.403.1591808458193;
 Wed, 10 Jun 2020 10:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200609234344.3795-1-irogers@google.com> <20200609234344.3795-2-irogers@google.com>
 <20200610140526.GK24868@kernel.org> <20200610140956.GL24868@kernel.org> <20200610141817.GM24868@kernel.org>
In-Reply-To: <20200610141817.GM24868@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 Jun 2020 10:00:47 -0700
Message-ID: <CAP-5=fWnsyE07MD8oAYa8cXGsxD7sP6j3B4voBj2Gj5y44AHtQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf parse-events: enable more flex/yacc warnings
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 7:18 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jun 10, 2020 at 11:09:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Jun 10, 2020 at 11:05:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Jun 09, 2020 at 04:43:44PM -0700, Ian Rogers escreveu:
> > > > All C compiler warnings are disabled are disabled by -w. This change
> > > > removes the -w from flex and bison targets. To avoid implicit
> > > > declarations header files are declared as targets and included.
> >
> > > > Tested with GCC 9.3.0 and clang 9.0.1.
> >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > > > +++ b/tools/perf/util/Build
> > <SNIP>
> > > > -$(OUTPUT)util/parse-events-flex.c: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
> > > > +$(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
> > > >   $(call rule_mkdir)
> > > > - $(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) util/parse-events.l
> > > > + $(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
> > > > +         --header-file=$(OUTPUT)util/parse-events-flex.h \
> > > > +         $(PARSER_DEBUG_FLEX) $<
> >
> > <SNIP>
> >
> > > And you took advantage of util/parse-events.l being
> > > the first dependency to replace it with $<
> >
> > <SNIP>
> >
> > > Damn, Makefiles are obtuse, we better do this more piecemeal, for
> > > instance, using $< where applicable first, etc.
> >
> > I mean, first this, ok? Then you do the other bits, and please try to
> > keep the positioning as far as possible, so that visually we see what is
> > being replaced by what.
>
> Argh, replace all %< below with, of course, $<

Thanks, I'll pull it into a series of changes. I'm more worried that
the -W flags aren't going to be supported by an old clang or GCC.
Worth the pain to get rid of the -w that introduced some issues.

Ian

> - Arnaldo
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 8d18380ecd10..cc50fdfd0c2f 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -193,27 +193,27 @@ CFLAGS_genelf_debug.o  += -Wno-packed
> >
> >  $(OUTPUT)util/parse-events-flex.c: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
> >       $(call rule_mkdir)
> > -     $(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) util/parse-events.l
> > +     $(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) %<
> >
> >  $(OUTPUT)util/parse-events-bison.c: util/parse-events.y
> >       $(call rule_mkdir)
> > -     $(Q)$(call echo-cmd,bison)$(BISON) -v util/parse-events.y -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
> > +     $(Q)$(call echo-cmd,bison)$(BISON) -v %< -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
> >
> >  $(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
> >       $(call rule_mkdir)
> > -     $(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) util/expr.l
> > +     $(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) %<
> >
> >  $(OUTPUT)util/expr-bison.c: util/expr.y
> >       $(call rule_mkdir)
> > -     $(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
> > +     $(Q)$(call echo-cmd,bison)$(BISON) -v %< -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
> >
> >  $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
> >       $(call rule_mkdir)
> > -     $(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h util/pmu.l
> > +     $(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h %<
> >
> >  $(OUTPUT)util/pmu-bison.c: util/pmu.y
> >       $(call rule_mkdir)
> > -     $(Q)$(call echo-cmd,bison)$(BISON) -v util/pmu.y -d -o $@ -p perf_pmu_
> > +     $(Q)$(call echo-cmd,bison)$(BISON) -v %< -d -o $@ -p perf_pmu_
> >
> >  CFLAGS_parse-events-flex.o  += -w
> >  CFLAGS_pmu-flex.o           += -w
>
> --
>
> - Arnaldo
