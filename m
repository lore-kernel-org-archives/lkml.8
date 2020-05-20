Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12940C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA11D2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR2mj9cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgETBi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETBiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:38:25 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46260C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:38:25 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so1377279qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NAwfRzMUaDbKJtKKvp1pPRk9GBPLZtS1+sZO6+2NA3k=;
        b=NR2mj9cx+JEW5tgijfbyLOjgUXA8GoIiFDp2198kPkIlewKtFLgDk7xeBOeA0G/u+P
         Y7KId64Ux6bXTK/OzF3jDONwhxco8B0Wci4uWqcDaJSnft14aR9f4cJE6tPo3S5qMba+
         Dz4hrRtDVdvRkvL8ei9blr1aJDL0wJwerKRXSx7W0UQnq8qQgDCp75rpdcdxsBGB41+E
         WK2fT1bij1b3t7xveCbPJbp9FI706z9v7ZwbyWJDs8/ZAG3JsNFz8vGwMxYU4AKvsTs1
         bVQt21PL8R/efHozNMHtAJoG00pscaCaBGs1TBc/QdWkT1PxWL6LziyttxSDutTp4DpA
         sSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NAwfRzMUaDbKJtKKvp1pPRk9GBPLZtS1+sZO6+2NA3k=;
        b=Gk/8ElJ5D9SiSJOoNbNMT+pl9+dEdFy2BIPYqcaTyPovULOoaggTz0/io6QMVvkTLF
         Ez7/b87NPzbwsesnuORrv0WC+h+K707S0L7jZxKCfsnW9F1o61CktgQO8lw7siGFqFMb
         A0Kd0vIc8puDRTtO9NYoTh+cxN7yqoNl7j1iCwEmHlDyFbed24FIKNRvPwt1V33i3151
         5CWfYJQUhrF0Wz/vSYkY6yxkBHUvQb1uLWhnoUFyGdqIW8z26URWounDz4esdE9UfPZ6
         N00izvtAcZI7/wY0Oq8aHiNeTuQ3V6ulBgvMKsTE+UINemRDk1oPqTjxWfqCfHcHIMJ3
         dxVg==
X-Gm-Message-State: AOAM530g6cd1TNvgt8a0OTCUlH2xOc0RNMijN/HYqS5AyvuLlmSwyGSz
        z8kqSIrH9fPxQgIOVjsy8pc=
X-Google-Smtp-Source: ABdhPJzJ/SF3MaDgn+IyYnUQQtcuy34VHYZ7/LOdGfgoAEr94dVh62AJyx8RxWmwBbC9iCjHEHHFTw==
X-Received: by 2002:aed:3185:: with SMTP id 5mr2985124qth.187.1589938704215;
        Tue, 19 May 2020 18:38:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y23sm1458924qta.37.2020.05.19.18.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 18:38:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4FDA440AFD; Tue, 19 May 2020 22:38:20 -0300 (-03)
Date:   Tue, 19 May 2020 22:38:20 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 15/15] perf script: Show text poke address symbol
Message-ID: <20200520013820.GE28228@kernel.org>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <20200512121922.8997-16-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512121922.8997-16-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 03:19:22PM +0300, Adrian Hunter escreveu:
> It is generally more useful to show the symbol with an address. In this
> case, the print function requires the 'machine' which means changing
> callers to provide it as a parameter. It is optional because most events
> do not need it and the callers that matter can provide it.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-script.c    |  4 ++--
>  tools/perf/tests/perf-record.c |  4 ++--
>  tools/perf/util/event.c        | 23 ++++++++++++++++++-----
>  tools/perf/util/event.h        |  6 ++++--
>  tools/perf/util/intel-pt.c     |  2 +-
>  tools/perf/util/machine.c      |  2 +-
>  6 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 35ed8f69ed6a..5bdd1a393399 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2170,7 +2170,7 @@ static int print_event_with_time(struct perf_tool *tool,
>  					   event->header.type, stdout);
>  	}
>  
> -	perf_event__fprintf(event, stdout);
> +	perf_event__fprintf(machine, event, stdout);

Since this is for a perf event, the first arg should be event, not
machine, but I can fixup this when processing these patches, no need to
resend.
  
>  	thread__put(thread);
>  
> @@ -2305,7 +2305,7 @@ process_finished_round_event(struct perf_tool *tool __maybe_unused,
>  			     struct ordered_events *oe __maybe_unused)
>  
>  {
> -	perf_event__fprintf(event, stdout);
> +	perf_event__fprintf(NULL, event, stdout);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
> index 83adfd846ccd..ff6febf15269 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -185,14 +185,14 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
>  				err = perf_evlist__parse_sample(evlist, event, &sample);
>  				if (err < 0) {
>  					if (verbose > 0)
> -						perf_event__fprintf(event, stderr);
> +						perf_event__fprintf(NULL, event, stderr);
>  					pr_debug("Couldn't parse sample\n");
>  					goto out_delete_evlist;
>  				}
>  
>  				if (verbose > 0) {
>  					pr_info("%" PRIu64" %d ", sample.time, sample.cpu);
> -					perf_event__fprintf(event, stderr);
> +					perf_event__fprintf(NULL, event, stderr);
>  				}
>  
>  				if (prev_time > sample.time) {
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index dde2f0147713..4b60cd57ad62 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -440,14 +440,26 @@ static int text_poke_printer(enum binary_printer_ops op, unsigned int val,
>  	}
>  }
>  
> -size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp)
> +size_t perf_event__fprintf_text_poke(struct machine *machine,
> +				     union perf_event *event, FILE *fp)

Ditto

>  {
>  	struct perf_record_text_poke_event *tp = &event->text_poke;
>  	size_t ret;
>  	bool old;
>  
> -	ret = fprintf(fp, " %" PRI_lx64 " old len %u new len %u\n",
> -		      tp->addr, tp->old_len, tp->new_len);
> +	ret = fprintf(fp, " %" PRI_lx64 " ", tp->addr);
> +	if (machine) {
> +		struct addr_location al;
> +
> +		al.map = maps__find(&machine->kmaps, tp->addr);
> +		if (al.map && map__load(al.map) >= 0) {
> +			al.addr = al.map->map_ip(al.map, tp->addr);
> +			al.sym = map__find_symbol(al.map, al.addr);
> +			if (al.sym)
> +				ret += symbol__fprintf_symname_offs(al.sym, &al, fp);
> +		}
> +	}
> +	ret += fprintf(fp, " old len %u new len %u\n", tp->old_len, tp->new_len);
>  	old = true;
>  	ret += binary__fprintf(tp->bytes, tp->old_len, 16, text_poke_printer,
>  			       &old, fp);
> @@ -457,7 +469,8 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp)
>  	return ret;
>  }
>  
> -size_t perf_event__fprintf(union perf_event *event, FILE *fp)
> +size_t perf_event__fprintf(struct machine *machine, union perf_event *event,
> +			   FILE *fp)
>  {
>  	size_t ret = fprintf(fp, "PERF_RECORD_%s",
>  			     perf_event__name(event->header.type));
> @@ -502,7 +515,7 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
>  		ret += perf_event__fprintf_bpf(event, fp);
>  		break;
>  	case PERF_RECORD_TEXT_POKE:
> -		ret += perf_event__fprintf_text_poke(event, fp);
> +		ret += perf_event__fprintf_text_poke(machine, event, fp);
>  		break;
>  	default:
>  		ret += fprintf(fp, "\n");
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index dbbba6dea51d..611c8e5ad9d9 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -389,8 +389,10 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
> -size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp);
> -size_t perf_event__fprintf(union perf_event *event, FILE *fp);
> +size_t perf_event__fprintf_text_poke(struct machine *machine,
> +				     union perf_event *event, FILE *fp);
> +size_t perf_event__fprintf(struct machine *machine, union perf_event *event,
> +			   FILE *fp);
>  
>  int kallsyms__get_function_start(const char *kallsyms_filename,
>  				 const char *symbol_name, u64 *addr);
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index e2e199a58222..4c6bb45d8200 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -236,7 +236,7 @@ static void intel_pt_log_event(union perf_event *event)
>  	if (!intel_pt_enable_logging || !f)
>  		return;
>  
> -	perf_event__fprintf(event, f);
> +	perf_event__fprintf(NULL, event, f);
>  }
>  
>  static void intel_pt_dump_sample(struct perf_session *session,
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 9120d7dc274f..5f52b579b3fe 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -821,7 +821,7 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
>  	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>  
>  	if (dump_trace)
> -		perf_event__fprintf_text_poke(event, stdout);
> +		perf_event__fprintf_text_poke(machine, event, stdout);
>  
>  	if (!event->text_poke.new_len)
>  		return 0;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
