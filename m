Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FAAC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039C2206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hven9cSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgEKPza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgEKPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:55:29 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:55:29 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f83so10211036qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g1psp0p93Lmielnim8tKouJ3UDYX3Y8+qacLcTsCyGA=;
        b=hven9cSIOKXpnZWaYm8KOVU7Am3oOi+4lXJWAY0Au1uMkv/0vGr7+8MRaOPjlrmPVj
         FX8gEeQCLmSDb+50nSsKsTL1vBByfmpCADTF4pEiyBwBHcieXq/urYGs0jc91d9fv4Lp
         hQcaE9mjSfzK9LFcCIp5/1g8fs81yYEb2kneT3xkv3nWCABp4dbs0AINs7z0xtFSi4Is
         bMzRPUQAaF6IDhl4pWjYithRl7Q5BDMwr7qpUesw+Q3PAOhwNaBTeTeUd167F6el93/s
         FhsI5PpwOh9toUDYwdXgmN4HymwG29zFRvC4ExAmk5IbBP8Us0HHywYifsIPhVQdy78k
         dICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1psp0p93Lmielnim8tKouJ3UDYX3Y8+qacLcTsCyGA=;
        b=rVExygm1Ha843Wnx1XBPK6rawtUmN4RgPgv51g+mdxOAbckfNU820WC6zxHVAuSptb
         ij5i89Wf4KOTjtcg24Pmek7k717HBlJzN9e6NmLG3Gw+Pu5zfma/wnqnh/Po/XQsI8xf
         rTslqVqvPMhvV3EOqQw9jn3SGtXNMqgxFJxgCfLIeygRNXH513loEGTOd5m4DuHUckZV
         ll5g9woqdNGlQS5aVfPnxhuv0/hVMGgh1zjIatvBIRqKkd3tT/huEF3ZJ9KHiRYSwVbf
         9K8ekiLAJn5FKkDbLFUbw1TWKJ1AvXCFUnAR8v/Hp4L2hyeOzLbCjubkv5phKAhMtkEJ
         5BDA==
X-Gm-Message-State: AGi0PubAdUbxA4XsP1EqMehzbPYNLVxercB+73yjinuoSq1Qu7dmdDAv
        0d+ZFempddjfCDA8t2fx8tgaHQoeqTM=
X-Google-Smtp-Source: APiQypIqnOfUnI5uiVhwigv8W/k0nB1JU/DdxXaVO9CVzKky0qQbkBpI0LTlWCJcoJ6lySLHQxF2Bg==
X-Received: by 2002:a37:4b02:: with SMTP id y2mr15135830qka.178.1589212528583;
        Mon, 11 May 2020 08:55:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id b42sm9945665qta.29.2020.05.11.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:55:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 418C740AFD; Mon, 11 May 2020 12:55:25 -0300 (-03)
Date:   Mon, 11 May 2020 12:55:25 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf c2c: fix '-e list'
Message-ID: <20200511155525.GE28888@kernel.org>
References: <20200507220604.3391-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507220604.3391-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 07, 2020 at 03:06:04PM -0700, Ian Rogers escreveu:
> When the event is passed as list, the default events should be listed as
> per 'perf mem record -e list'. Previous behavior is:
> 
> $ perf c2c record -e list
> failed: event 'list' not found, use '-e list' to get list of available events
> 
>  Usage: perf c2c record [<options>] [<command>]
>     or: perf c2c record [<options>] -- <command> [<options>]
> 
>     -e, --event <event>   event selector. Use 'perf mem record -e list' to list available events
> 
> New behavior:
> 
> $ perf c2c record -e list
> ldlat-loads  : available
> ldlat-stores : available
> 
> v3: is a rebase.
> v2: addresses review comments by Jiri Olsa.

Thanks, applied and tested, Jiri, can I have your Reviewed-by?

- Arnaldo

> https://lore.kernel.org/lkml/20191127081844.GH32367@krava/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-c2c.txt |  2 +-
>  tools/perf/builtin-c2c.c              |  9 ++++++++-
>  tools/perf/builtin-mem.c              | 24 +++++++-----------------
>  tools/perf/util/mem-events.c          | 15 +++++++++++++++
>  tools/perf/util/mem-events.h          |  2 ++
>  5 files changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> index 2133eb320cb0..98efdab5fbd4 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -40,7 +40,7 @@ RECORD OPTIONS
>  --------------
>  -e::
>  --event=::
> -	Select the PMU event. Use 'perf mem record -e list'
> +	Select the PMU event. Use 'perf c2c record -e list'
>  	to list available events.
>  
>  -v::
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 1baf4cae086f..d617d5682c68 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2887,8 +2887,15 @@ static int parse_record_events(const struct option *opt,
>  {
>  	bool *event_set = (bool *) opt->value;
>  
> +	if (!strcmp(str, "list")) {
> +		perf_mem_events__list();
> +		exit(0);
> +	}
> +	if (perf_mem_events__parse(str))
> +		exit(-1);
> +
>  	*event_set = true;
> -	return perf_mem_events__parse(str);
> +	return 0;
>  }
>  
>  
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 68a7eb84561a..3523279af6af 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -38,26 +38,16 @@ static int parse_record_events(const struct option *opt,
>  			       const char *str, int unset __maybe_unused)
>  {
>  	struct perf_mem *mem = *(struct perf_mem **)opt->value;
> -	int j;
>  
> -	if (strcmp(str, "list")) {
> -		if (!perf_mem_events__parse(str)) {
> -			mem->operation = 0;
> -			return 0;
> -		}
> -		exit(-1);
> +	if (!strcmp(str, "list")) {
> +		perf_mem_events__list();
> +		exit(0);
>  	}
> +	if (perf_mem_events__parse(str))
> +		exit(-1);
>  
> -	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -		struct perf_mem_event *e = &perf_mem_events[j];
> -
> -		fprintf(stderr, "%-13s%-*s%s\n",
> -			e->tag,
> -			verbose > 0 ? 25 : 0,
> -			verbose > 0 ? perf_mem_events__name(j) : "",
> -			e->supported ? ": available" : "");
> -	}
> -	exit(0);
> +	mem->operation = 0;
> +	return 0;
>  }
>  
>  static const char * const __usage[] = {
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index aa29589f6904..ea0af0bc4314 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -103,6 +103,21 @@ int perf_mem_events__init(void)
>  	return found ? 0 : -ENOENT;
>  }
>  
> +void perf_mem_events__list(void)
> +{
> +	int j;
> +
> +	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> +		struct perf_mem_event *e = &perf_mem_events[j];
> +
> +		fprintf(stderr, "%-13s%-*s%s\n",
> +			e->tag,
> +			verbose > 0 ? 25 : 0,
> +			verbose > 0 ? perf_mem_events__name(j) : "",
> +			e->supported ? ": available" : "");
> +	}
> +}
> +
>  static const char * const tlb_access[] = {
>  	"N/A",
>  	"HIT",
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index f1389bdae7bf..904dad34f7f7 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -39,6 +39,8 @@ int perf_mem_events__init(void);
>  
>  char *perf_mem_events__name(int i);
>  
> +void perf_mem_events__list(void);
> +
>  struct mem_info;
>  int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
>  int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 

-- 

- Arnaldo
