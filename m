Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5010C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0AE206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591798701;
	bh=z7KFVQZk8qW/Pw30I7ufim4YMm3G+Ws+4rx63Jpn9l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o1Gem4tTdAnYLs/NlEZVhM6GVjPND8Khd2oWyQxM04IQubhsXtVeo3CHmMUHrOz9Z
	 GdwS5rkQh8edyvoHUI+VeXUwpvescSFAmeKI5Oq3Fq5rNF3mCH2h1W8S1tb9vswiR7
	 lIQAZ2aS/j2jCtIvS1bsUcMFmAv9yJlC0rvxqtDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgFJOSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgFJOSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:18:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A342067B;
        Wed, 10 Jun 2020 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591798699;
        bh=z7KFVQZk8qW/Pw30I7ufim4YMm3G+Ws+4rx63Jpn9l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPhZDcLChNVltiMrGKHrxWBtJSU0nbQqnnCvsGgDRE76gTVLaWypOkXE0lzX7Wfk/
         NJTcKmaJpyuzxhDi2Y7wnxuNv7jY5SAIQ6U2bGGs2HkeKRTZu4a2Axlu6YctAQFvpZ
         yHhtf1xGPthH/P5cGtKJeJwsOZD3kHuzo0eNnRVQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1498340AFD; Wed, 10 Jun 2020 11:18:17 -0300 (-03)
Date:   Wed, 10 Jun 2020 11:18:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
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
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] perf parse-events: enable more flex/yacc warnings
Message-ID: <20200610141817.GM24868@kernel.org>
References: <20200609234344.3795-1-irogers@google.com>
 <20200609234344.3795-2-irogers@google.com>
 <20200610140526.GK24868@kernel.org>
 <20200610140956.GL24868@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610140956.GL24868@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 10, 2020 at 11:09:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jun 10, 2020 at 11:05:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Jun 09, 2020 at 04:43:44PM -0700, Ian Rogers escreveu:
> > > All C compiler warnings are disabled are disabled by -w. This change
> > > removes the -w from flex and bison targets. To avoid implicit
> > > declarations header files are declared as targets and included.
> 
> > > Tested with GCC 9.3.0 and clang 9.0.1.
> 
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> > > +++ b/tools/perf/util/Build
> <SNIP>
> > > -$(OUTPUT)util/parse-events-flex.c: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
> > > +$(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
> > >  	$(call rule_mkdir)
> > > -	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) util/parse-events.l
> > > +	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
> > > +		--header-file=$(OUTPUT)util/parse-events-flex.h \
> > > +		$(PARSER_DEBUG_FLEX) $<
> 
> <SNIP>
>  
> > And you took advantage of util/parse-events.l being
> > the first dependency to replace it with $<
> 
> <SNIP>
>  
> > Damn, Makefiles are obtuse, we better do this more piecemeal, for
> > instance, using $< where applicable first, etc.
> 
> I mean, first this, ok? Then you do the other bits, and please try to
> keep the positioning as far as possible, so that visually we see what is
> being replaced by what.

Argh, replace all %< below with, of course, $<

- Arnaldo
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 8d18380ecd10..cc50fdfd0c2f 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -193,27 +193,27 @@ CFLAGS_genelf_debug.o  += -Wno-packed
>  
>  $(OUTPUT)util/parse-events-flex.c: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) util/parse-events.l
> +	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) %<
>  
>  $(OUTPUT)util/parse-events-bison.c: util/parse-events.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v util/parse-events.y -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v %< -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
>  
>  $(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) util/expr.l
> +	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) %<
>  
>  $(OUTPUT)util/expr-bison.c: util/expr.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v %< -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
>  
>  $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h util/pmu.l
> +	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h %<
>  
>  $(OUTPUT)util/pmu-bison.c: util/pmu.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v util/pmu.y -d -o $@ -p perf_pmu_
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v %< -d -o $@ -p perf_pmu_
>  
>  CFLAGS_parse-events-flex.o  += -w
>  CFLAGS_pmu-flex.o           += -w

-- 

- Arnaldo
