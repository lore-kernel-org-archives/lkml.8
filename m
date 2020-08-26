Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7BFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F2D2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598448021;
	bh=Nja/SnEBOyihPdcNaszkrZBOjWgEKyXql5enCZ9k5jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u0f6sOqs5IZ+7OHYA7DR8ynGPHuJcxe6Bv1YSNGDp2DyXzroYw3z/yMVkF8uYwlfl
	 juS8bCHQry/ex6EevuItqTyTNREEY4pUj5cpbrzzIytq7RlZf5LmVzE20j0Vpq19LE
	 zaZiazPkcsQwmcBiHKMWWmLl3YMR4voDiJPu5c98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgHZNUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgHZNUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:20:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4092080C;
        Wed, 26 Aug 2020 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598448016;
        bh=Nja/SnEBOyihPdcNaszkrZBOjWgEKyXql5enCZ9k5jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9VYaTmXizRgEyG4Le+iYFI0f4o7212l2eaaa8zjzZHwda9ZP5gksKzlJpGnTrpem
         QX+mTe0fCQRH2m4+UZ5a1dzp20F4fn1CwfBeYJaKhCkVyuy9MS7Lc97CQy8zznR8C0
         JDwmDc3U3Sfzko9AB2JPuUh2NJh5uQLinNi7fykc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6F5340D3D; Wed, 26 Aug 2020 10:20:13 -0300 (-03)
Date:   Wed, 26 Aug 2020 10:20:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] perf parse-events: Avoid an uninitialized read.
Message-ID: <20200826132013.GG1059382@kernel.org>
References: <20200826042910.1902374-1-irogers@google.com>
 <20200826042910.1902374-2-irogers@google.com>
 <20200826113418.GC753783@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826113418.GC753783@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 26, 2020 at 01:34:18PM +0200, Jiri Olsa escreveu:
> On Tue, Aug 25, 2020 at 09:29:10PM -0700, Ian Rogers wrote:
> > With a fake_pmu the pmu_info isn't populated by perf_pmu__check_alias.
> > In this case, don't try to copy the uninitialized values to the evsel.
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
> >  tools/perf/util/parse-events.c | 30 +++++++++++++++++-------------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 9f7260e69113..3d7a48b488ed 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1533,19 +1533,23 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
> >  	evsel = __add_event(list, &parse_state->idx, &attr, true,
> >  			    get_config_name(head_config), pmu,
> >  			    &config_terms, auto_merge_stats, NULL);
> > -	if (evsel) {
> > -		evsel->unit = info.unit;
> > -		evsel->scale = info.scale;
> > -		evsel->per_pkg = info.per_pkg;
> > -		evsel->snapshot = info.snapshot;
> > -		evsel->metric_expr = info.metric_expr;
> > -		evsel->metric_name = info.metric_name;
> > -		evsel->pmu_name = name ? strdup(name) : NULL;
> > -		evsel->use_uncore_alias = use_uncore_alias;
> > -		evsel->percore = config_term_percore(&evsel->config_terms);
> > -	}
> > -
> > -	return evsel ? 0 : -ENOMEM;
> > +	if (!evsel)
> > +		return -ENOMEM;
> > +
> > +	evsel->pmu_name = name ? strdup(name) : NULL;
> > +	evsel->use_uncore_alias = use_uncore_alias;
> > +	evsel->percore = config_term_percore(&evsel->config_terms);
> > +
> > +	if (parse_state->fake_pmu)
> > +		return 0;
> > +
> > +	evsel->unit = info.unit;
> > +	evsel->scale = info.scale;
> > +	evsel->per_pkg = info.per_pkg;
> > +	evsel->snapshot = info.snapshot;
> > +	evsel->metric_expr = info.metric_expr;
> > +	evsel->metric_name = info.metric_name;
> > +	return 0;
> >  }
> >  
> >  int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
> > -- 
> > 2.28.0.297.g1956fa8f8d-goog
> > 
> 

-- 

- Arnaldo
