Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32F1C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42C220724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGbqiKgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCRNrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:47:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38308 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgCRNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:47:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so38734017qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ef1D/U85592FyqWL6PuhxvAtbNbUDjLIuJcIAna7dEU=;
        b=uGbqiKgBUG7nuKMTIdv8jEQTLX5zSDUquL6p2L6A6NfYuqA/QW+HWI7egj93ai7/PB
         jE2IB5a4vs4r6oWDLGB20UT3E1lKTTJsnsx45nm8kZMr0so/wEAB3a3QtBIX/7P60sRK
         /yJJ3FJj36i0hSOxKkO5imUQXDZZRAwe30dogGLH6NCMUOo78d+DVKF41WcDtwKTfury
         Oy4PdOCNb5B564kQF9P3YDbBUU1KzTHzXNeTzgpmey3HmZZo4F1vjuFl+3YTlV63qhXv
         BxoJWEBps13e/IcSVwPrCPCx/TdkQyIxsAljvKgaVIhBviNR6lS5tVMorQT9HqNV+XJS
         jYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ef1D/U85592FyqWL6PuhxvAtbNbUDjLIuJcIAna7dEU=;
        b=mxq/Mfw67HUxJ2jE2RvTdGN5d8aC6qdbQOPCiqaUC4DFHgQdnTcgc3FdPi6rGDiOiB
         39am1cEY8ixYH8UWtzGlots9VztjoH9aJ0SgnsPBOONMr3sWrpbFB36/rGEpK/PPYzL6
         sG7G7yQGjlaY5GQxbuKpiSLro7t7e1DWy0Xp5MZPO/JFfu6x0tLLxXCuetNNEV0yuCT4
         TXhYBu5v933PYOBesxCIGswm9gr+ilRY62YUCEAidAtyP5va9lpgaPr0waHZ83NxoebY
         CJ7wYaARR6CBFkTgbRbH2foGGqQY/IScxVngIL/Po7vhaBalqeZM0+cYHr8mMybYb4bS
         muIA==
X-Gm-Message-State: ANhLgQ1fhYY9MVqfimiAy26YotdVpIqj4yqUxuBisv29HeKTdcatCfBb
        GGaDuuLXuCmC/9+0O5tjykg=
X-Google-Smtp-Source: ADFU+vsgFC5AeU7VvAuf5OJd4G0TmyaKlofklu0nZT1KZUsegSaJqCj75156VmvQorBTBpvXZResZw==
X-Received: by 2002:a37:9542:: with SMTP id x63mr4274685qkd.82.1584539239429;
        Wed, 18 Mar 2020 06:47:19 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u13sm4089617qku.92.2020.03.18.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:47:18 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A2703404E4; Wed, 18 Mar 2020 10:47:15 -0300 (-03)
Date:   Wed, 18 Mar 2020 10:47:15 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf parse-events: fix 3 use after frees
Message-ID: <20200318134715.GC11531@kernel.org>
References: <20200314170356.62914-1-irogers@google.com>
 <20200318102827.GD821557@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318102827.GD821557@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 11:28:27AM +0100, Jiri Olsa escreveu:
> On Sat, Mar 14, 2020 at 10:03:56AM -0700, Ian Rogers wrote:
> > Reproducible with a clang asan build and then running perf test in
> > particular 'Parse event definition strings'.
> > 
> > v2 frees the evsel->pmu_name avoiding a memory leak.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/evsel.c        | 1 +
> >  tools/perf/util/parse-events.c | 6 +++---
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 816d930d774e..15ccd193483f 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1287,6 +1287,7 @@ void perf_evsel__exit(struct evsel *evsel)
> >  	perf_thread_map__put(evsel->core.threads);
> >  	zfree(&evsel->group_name);
> >  	zfree(&evsel->name);
> > +	zfree(&evsel->pmu_name);
> >  	perf_evsel__object.fini(evsel);
> >  }
> >  
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index a14995835d85..593b6b03785d 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1449,7 +1449,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
> >  		evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL,
> >  				    auto_merge_stats, NULL);
> >  		if (evsel) {
> > -			evsel->pmu_name = name;
> > +			evsel->pmu_name = name ? strdup(name) : NULL;
> >  			evsel->use_uncore_alias = use_uncore_alias;
> >  			return 0;
> >  		} else {
> > @@ -1497,7 +1497,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
> >  		evsel->snapshot = info.snapshot;
> >  		evsel->metric_expr = info.metric_expr;
> >  		evsel->metric_name = info.metric_name;
> > -		evsel->pmu_name = name;
> > +		evsel->pmu_name = name ? strdup(name) : NULL;
> >  		evsel->use_uncore_alias = use_uncore_alias;
> >  		evsel->percore = config_term_percore(&evsel->config_terms);
> >  	}
> > @@ -1547,7 +1547,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
> >  				if (!parse_events_add_pmu(parse_state, list,
> >  							  pmu->name, head,
> >  							  true, true)) {
> > -					pr_debug("%s -> %s/%s/\n", config,
> > +					pr_debug("%s -> %s/%s/\n", str,
> >  						 pmu->name, alias->str);
> >  					ok++;
> >  				}
> > -- 
> > 2.25.1.481.gfbce0eb801-goog
> > 
> 

-- 

- Arnaldo
