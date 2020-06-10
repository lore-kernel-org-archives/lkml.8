Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4550AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6D5207C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591797932;
	bh=cO8BSTPTlW078U+dsGuLWA9YFoCwBmyzsYNN0Pibmdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RPFUlUzehT0g229J4VedDJ3mAw7pEkHxXhI3B00CPmmSqyHsS2rHC49zA/HxmyJN2
	 8VKLTNyd4+eoN3n5xOxc2qBqOmXiftmSsWZRRyNdAofvVa8ZBd9Z9XmmaMI6ePwty3
	 mSfvqpoQZDmQ05H6+LF7uPncEYICVqdJXzJQH7Ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFJOFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgFJOFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:05:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3042D2067B;
        Wed, 10 Jun 2020 14:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591797929;
        bh=cO8BSTPTlW078U+dsGuLWA9YFoCwBmyzsYNN0Pibmdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUX5vf7cNb4cVWOQ56mxgMeiaffQBBYYIcar0brGCDYZkQAIqdKkrEVrRQV4ITL0Q
         qkTOWHbw1rx+1IruRngcBxWQK+cyX9vyC6JYAm4xn7sI7euNLlcVNxSOjv4RekIGKQ
         gBKN/bwUsFQZWVyQXWQ7c3R/uIXw+RXYe1+F4ax4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7DD9B40AFD; Wed, 10 Jun 2020 11:05:26 -0300 (-03)
Date:   Wed, 10 Jun 2020 11:05:26 -0300
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
Message-ID: <20200610140526.GK24868@kernel.org>
References: <20200609234344.3795-1-irogers@google.com>
 <20200609234344.3795-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609234344.3795-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 09, 2020 at 04:43:44PM -0700, Ian Rogers escreveu:
> All C compiler warnings are disabled are disabled by -w. This change
> removes the -w from flex and bison targets. To avoid implicit
> declarations header files are declared as targets and included.
> 
> Tested with GCC 9.3.0 and clang 9.0.1.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/Build          | 55 ++++++++++++++++++++++------------
>  tools/perf/util/expr.y         |  2 ++
>  tools/perf/util/parse-events.y |  1 +
>  3 files changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 8d18380ecd10..8d47dd3ecf2e 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -191,36 +191,53 @@ CFLAGS_llvm-utils.o += -DPERF_INCLUDE_DIR="BUILD_STR($(perf_include_dir_SQ))"
>  # avoid compiler warnings in 32-bit mode
>  CFLAGS_genelf_debug.o  += -Wno-packed
>  
> -$(OUTPUT)util/parse-events-flex.c: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
> +$(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) util/parse-events.l
> +	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
> +		--header-file=$(OUTPUT)util/parse-events-flex.h \
> +		$(PARSER_DEBUG_FLEX) $<

Wouldn't this be equivalent to:

+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) $< \
+		--header-file=$(OUTPUT)util/parse-events-flex.h

So that we match what is being replaced more easily?

You have to replace $@ by (OUTPUT)util/parse-events-flex.c because now
you're multi-target, but then as $@ is replaced by whichever of those
targets caused the recipe to run, and what is in other places is
$(OUTPUT)util/parse-events-flex.c, we can continue to use $@, no?

And you took advantage of util/parse-events.l being
the first dependency to replace it with $<

So I think you can have it as:

$(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
 	$(call rule_mkdir)
	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) $< \
		--header-file=$(OUTPUT)util/parse-events-flex.h


Right?

You have $(OUTPUT)util/parse-events-flex.h later on as a dependency, but
by then this has resolved already and that recipe won't be called for
it?

Damn, Makefiles are obtuse, we better do this more piecemeal, for
instance, using $< where applicable first, etc.

This will help us bisect problems here,

Thanks,

- Arnaldo

> -$(OUTPUT)util/parse-events-bison.c: util/parse-events.y
> +$(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v util/parse-events.y -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v util/parse-events.y \
> +		$(PARSER_DEBUG_BISON) -o $(OUTPUT)util/parse-events-bison.c \
> +		--defines=$(OUTPUT)util/parse-events-bison.h \
> +		-p parse_events_
>  
> -$(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
> +$(OUTPUT)util/parse-events-bison.o: $(OUTPUT)util/parse-events-flex.h
> +
> +$(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) util/expr.l
> +	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/expr-flex.c \
> +		--header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) $<
>  
> -$(OUTPUT)util/expr-bison.c: util/expr.y
> +$(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y $(PARSER_DEBUG_BISON) \
> +		-o $(OUTPUT)util/expr-bison.c \
> +		--defines=$(OUTPUT)util/expr-bison.h -p expr_
> +
> +$(OUTPUT)util/expr-bison.o: $(OUTPUT)util/expr-flex.h
>  
> -$(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
> +$(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h util/pmu.l
> +	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/pmu-flex.c \
> +		--header-file=$(OUTPUT)util/pmu-flex.h $(PARSER_DEBUG_FLEX) $<
>  
> -$(OUTPUT)util/pmu-bison.c: util/pmu.y
> +$(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v util/pmu.y -d -o $@ -p perf_pmu_
> -
> -CFLAGS_parse-events-flex.o  += -w
> -CFLAGS_pmu-flex.o           += -w
> -CFLAGS_expr-flex.o          += -w
> -CFLAGS_parse-events-bison.o += -DYYENABLE_NLS=0 -w
> -CFLAGS_pmu-bison.o          += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
> -CFLAGS_expr-bison.o         += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v util/pmu.y $(PARSER_DEBUG_BISON) \
> +		-o $(OUTPUT)util/pmu-bison.c \
> +		--defines=$(OUTPUT)util/pmu-bison.h -p perf_pmu_
> +
> +flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-redundant-decls
> +bison_flags := -Wno-unused-parameter -Wno-nested-externs
> +CFLAGS_parse-events-flex.o  += $(flex_flags)
> +CFLAGS_pmu-flex.o           += $(flex_flags)
> +CFLAGS_expr-flex.o          += $(flex_flags)
> +CFLAGS_parse-events-bison.o += -DYYENABLE_NLS=0 $(bison_flags)
> +CFLAGS_pmu-bison.o          += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
> +CFLAGS_expr-bison.o         += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
>  
>  $(OUTPUT)util/parse-events.o: $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-bison.c
>  $(OUTPUT)util/pmu.o: $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-bison.c
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index bf3e898e3055..f34a5e544a41 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -39,6 +39,8 @@
>  %type <num> expr if_expr
>  
>  %{
> +#include "expr-flex.h"
> +
>  static void expr_error(double *final_val __maybe_unused,
>  		       struct expr_parse_ctx *ctx __maybe_unused,
>  		       void *scanner,
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index acef87d9af58..ae0aa47dbafb 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -17,6 +17,7 @@
>  #include "evsel.h"
>  #include "parse-events.h"
>  #include "parse-events-bison.h"
> +#include "parse-events-flex.h"
>  
>  void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
>  
> -- 
> 2.27.0.278.ge193c7cf3a9-goog
> 

-- 

- Arnaldo
