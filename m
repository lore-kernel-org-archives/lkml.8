Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECD9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BD12078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594380863;
	bh=wr+IWCClV9eDPEwnFOfkWntkNvbhm/9mJRk7vZLMMyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQ8mgDDnr4e0NuzY+T8pPUZR9wUWyE/eZGRb8ybEMH7vuffvkVaNWF3wMgg/iHBHT
	 zvT4RcEBJEmHtgQ7howAuTQp1SX9xygiqpA+Uqh/L/VZFFqV4TOgy9s+pAMNuCjv23
	 YZg35u4SF6zha94vAzO/nW/rKOoag0beeVFEtoN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGJLeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGJLeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:34:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.179.81.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07E542077D;
        Fri, 10 Jul 2020 11:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594380858;
        bh=wr+IWCClV9eDPEwnFOfkWntkNvbhm/9mJRk7vZLMMyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfczV1GRR9zDjraJgJ81/5v6TS3qCtzSvfRGZFomzPe6JvEqaoyqvaEp5LEyw64g3
         cafhkDp9qRkam5OmNYOCm4rIIHXX5UfRuj6YFtEfFL5o+KE31Va2s2xtjIoqXej+Q1
         hBUVfVFpys7sSKRPamtr26E3VrKdgKg2FWJ7h/9s=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1FBD5405FF; Fri, 10 Jul 2020 08:34:15 -0300 (-03)
Date:   Fri, 10 Jul 2020 08:34:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20200710113415.GA22500@kernel.org>
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

I'm just inverting the order of the parameters for
perf_event__fprintf(), to keep as the first arg the pointer to the type
that is the prefix for the function, i.e. instead of:

size_t perf_event__fprintf_text_poke(struct machine *machine,
				     union perf_event *event, FILE *fp)

I'll make it be:

size_t perf_event__fprintf_text_poke(union perf_event *event,
				     struct machine *machine,FILE *fp)

Ok?

Thanks,

- Arnaldo

 
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
>  
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
