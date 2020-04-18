Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C74DC2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279F721D79
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMgStgWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDRMEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgDRMEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 08:04:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B56C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 05:04:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l25so5416118qkk.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BZwlaHWeOeafAExOcOIbelNG2HeXx9/G4hvqk9vloyo=;
        b=mMgStgWrMw67hjiTamIm6buAZPVe1wCbfjPELaYiDEL29wH0Ij/4O3xwJAjIuBUZ4A
         ADQjW9Aon9Yl8GUDjGwmwrNg6Hj6yFSUAvvGCznXS/oC3JT6Pzxww2lvKHboYAYJ1/tq
         waRtmiPmalo8eCeL3DHstUd1QkllCTARF5O3pB5TqdLKYNbIFbJ+IS8rpLTb5kbgv9Ft
         qOr9XU0eF+jopJBgB8YLpGD4QmBWq8Fejhm37B+CX02VK8Z8ZI1bGoUMGaxMfGnieWAh
         QUihX8h6Kr6S68UMNcjGCvepWKrSJCMrOZnqYcuqEMM3lPwvAdOGyND6RN0qfeLoKYMF
         DCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZwlaHWeOeafAExOcOIbelNG2HeXx9/G4hvqk9vloyo=;
        b=CRYxLt4Zr1U+TZHH6l1x7IwWfrRxukQLBDGwzxZefnJ8yakrDXHUavyOsWSJ72J0LR
         KpXk4VvfxEoEBxAOYwkcSryp61qFQY8AImrg/b4ZfvuekK3W1DerIlLsMcoP+3E14nxt
         oRQcwXBnDvx30L1dgSA1VaIDiWNxr60Ma7OSeX3rBjYJeLtDQAhR5cYQKBu6YejXpHjf
         avZvXAVYgr0JnToT/6LkF7zr4i6XLq4xNr2R2NeaN2wQOlK/HKe3W3HmT6t7HJhE4Aay
         m3k4xro8RanVGVwzmjnozMYisiEx/noaZNblHJuTu1GA7ID0B54enZ7r33YYCf2+X/CP
         1/tA==
X-Gm-Message-State: AGi0PuZgTbjdivbsWHTixHmhYSwdlJT3pCm+3MS08zgB0ZPLj4NSG91n
        UTiLScXDbjM2YERstYDIxmd4DpC2HfI=
X-Google-Smtp-Source: APiQypInWbjTJAt4tWKMWkO1EqKvHXa7Mg2NEEfLHwyt/lknjmZLJj85pTXnjef+kXGc8QvIg4TcLQ==
X-Received: by 2002:a37:4a85:: with SMTP id x127mr7666693qka.152.1587211446588;
        Sat, 18 Apr 2020 05:04:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 11sm17558479qkg.122.2020.04.18.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 05:04:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0CDBD409A3; Sat, 18 Apr 2020 09:04:04 -0300 (-03)
Date:   Sat, 18 Apr 2020 09:04:03 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] perf tools: Move and globalize
 perf_evsel__find_pmu() and perf_evsel__is_aux_event()
Message-ID: <20200418120403.GB6031@kernel.org>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-13-adrian.hunter@intel.com>
 <20200418115017.GA6031@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418115017.GA6031@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Apr 18, 2020 at 08:50:17AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 01, 2020 at 01:16:09PM +0300, Adrian Hunter escreveu:
> > Move and globalize 2 functions so that they can be reused.
> 
> So this breaks this:
> 
> [acme@five perf]$ perf test -v python
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> 19: 'import perf' in python                               :
> --- start ---
> test child forked, pid 168414
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf/python/perf.so: undefined symbol: perf_pmu__scan
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> [acme@five perf]$
> 
> I'm trying to fix...

I solved this by moving those functions to tools/perf/util/pmu.c
instead.

Please consider running 'perf test' before sending your patches to me
next time,

Thanks,

- Arnaldo
  
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/util/auxtrace.c | 19 -------------------
> >  tools/perf/util/evsel.c    | 20 ++++++++++++++++++++
> >  tools/perf/util/evsel.h    |  3 +++
> >  3 files changed, 23 insertions(+), 19 deletions(-)
> > 
> > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > index 809a09e75c55..33ad33378a90 100644
> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -58,25 +58,6 @@
> >  #include "symbol/kallsyms.h"
> >  #include <internal/lib.h>
> >  
> > -static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
> > -{
> > -	struct perf_pmu *pmu = NULL;
> > -
> > -	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> > -		if (pmu->type == evsel->core.attr.type)
> > -			break;
> > -	}
> > -
> > -	return pmu;
> > -}
> > -
> > -static bool perf_evsel__is_aux_event(struct evsel *evsel)
> > -{
> > -	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
> > -
> > -	return pmu && pmu->auxtrace;
> > -}
> > -
> >  /*
> >   * Make a group from 'leader' to 'last', requiring that the events were not
> >   * already grouped to a different leader.
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 60e6cd49dee3..d4ab073c9fe7 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -44,6 +44,7 @@
> >  #include "stat.h"
> >  #include "string2.h"
> >  #include "memswap.h"
> > +#include "pmu.h"
> >  #include "util.h"
> >  #include "../perf-sys.h"
> >  #include "util/parse-branch-options.h"
> > @@ -100,6 +101,25 @@ int perf_evsel__object_config(size_t object_size,
> >  	return 0;
> >  }
> >  
> > +struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
> > +{
> > +	struct perf_pmu *pmu = NULL;
> > +
> > +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> > +		if (pmu->type == evsel->core.attr.type)
> > +			break;
> > +	}
> > +
> > +	return pmu;
> > +}
> > +
> > +bool perf_evsel__is_aux_event(struct evsel *evsel)
> > +{
> > +	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
> > +
> > +	return pmu && pmu->auxtrace;
> > +}
> > +
> >  #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> >  
> >  int __perf_evsel__sample_size(u64 sample_type)
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index e64ed4202cab..a463bc65b001 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -158,6 +158,9 @@ int perf_evsel__object_config(size_t object_size,
> >  			      int (*init)(struct evsel *evsel),
> >  			      void (*fini)(struct evsel *evsel));
> >  
> > +struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel);
> > +bool perf_evsel__is_aux_event(struct evsel *evsel);
> > +
> >  struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
> >  
> >  static inline struct evsel *evsel__new(struct perf_event_attr *attr)
> > -- 
> > 2.17.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
