Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5C5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D758B20842
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk9VOWrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgETByl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgETByk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:54:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F9CC061A0E;
        Tue, 19 May 2020 18:54:40 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f189so2098992qkd.5;
        Tue, 19 May 2020 18:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BPvyg9aLzZSidK2jwc9A0a0QJdM14HLsmNAc4UqNnWw=;
        b=bk9VOWrZdxtWejU0wwUrEp92cbcxU7B4aoAEjFQYKbbnVl6rGUy+EieyvVidJILCbL
         gTRQkA8oEKJhQIJunYnEJBUyQSPPYNVuylvgkZACCKWLtScx9mG5kXopOKta4haFkq8R
         tBe85Ue+vLedLp8lkdz/ouKo09pVJ3EVlrP/yoE/Pee5eR/AmsSjQQYvE/011Gux5tEW
         gBpmUPdWWKnW1sfrOXRDY9hfdxoJIEPeF6+6fjThv4YhtNz8rKCXxG4p92jVtjDA+omE
         fIVgnorp2z7FqUiieat8JWySNIETtfnx3nFWX7dUarPHSU2WKyrgLfDRWHxqnvfNFuLj
         fywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPvyg9aLzZSidK2jwc9A0a0QJdM14HLsmNAc4UqNnWw=;
        b=ctiZLUeCv9CUxOXlVYDcOzYJlvM3PTGDamV39uR8POUJoMspZTYeZ7W23GeB0k9dca
         2BzNzT5/+aUM5+nGjbHaLcySLwDNauOJbdAToyw9ZvxNrLxc4PTgV7wK5niz6gD/odVs
         0UOauGktqMq3YBApK2SNF0tzXF2qXPQjsCRpri6dOz7JPpAbtZ54UgfirsL3apyK/g0m
         ZJ5jl1qNVlLw/WcWu+Ji6F36oUdGdkxuCGLaxwFJf5bZPUwTM71O1BH12WGcwHRrNs3M
         8kvsSl9ojqlAOLxfF0Nk6UDfe/4D4ab46426SWLnebzvfPyZSvUSVx1SdNVLLT3PkVnR
         tUcQ==
X-Gm-Message-State: AOAM531VfhN/24bZocKN27pozCZApPAbYjmghwGVlQ/NocxB0ogzQAud
        X9QRihZOOef31OdLut0mA3I=
X-Google-Smtp-Source: ABdhPJwk113WUqIfuE5VIhiW41+BCys+lB/+jo3XMFC+9vurf7YNZnW9plOPJVw2XMvLxOfpEEH0Iw==
X-Received: by 2002:a37:9d09:: with SMTP id g9mr2511807qke.154.1589939679414;
        Tue, 19 May 2020 18:54:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x24sm1382927qth.57.2020.05.19.18.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 18:54:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B8ED840AFD; Tue, 19 May 2020 22:54:35 -0300 (-03)
Date:   Tue, 19 May 2020 22:54:35 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf record: add dummy event during system wide
 synthesis
Message-ID: <20200520015435.GB32678@kernel.org>
References: <20200422173615.59436-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422173615.59436-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 22, 2020 at 10:36:15AM -0700, Ian Rogers escreveu:
> During the processing of /proc during event synthesis new processes may
> start. Add a dummy event if /proc is to be processed, to capture mmaps
> for starting processes. This reuses the existing logic for
> initial-delay.
> 
> v3 fixes the attr test of test-record-C0
> v2 fixes the dummy event configuration and a branch stack issue.

Something I noticed only now is that this ends up in the perf.data file,
and we don't need it at all there, i.e.

  # perf record -I

I.e. system wide, asking for registers now ends up with:

[root@quaco ~]# perf record -I
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.855 MB perf.data (4902 samples) ]
[root@quaco ~]# perf evlist
cycles
dummy:HG
[root@quaco ~]# perf evlist -v
cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD|REGS_INTR, read_format: ID, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, sample_regs_intr: 0xff0fff
dummy:HG: type: 1, size: 120, config: 0x9, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD|REGS_INTR, read_format: ID, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, sample_regs_intr: 0xff0fff
[root@quaco ~]#

For perf top is ok to reuse the main evlist, as those are not going to
hit the disk, but for 'perf record' it pollutes the perf.data file with
that dummy event.

This was a problem introduced with initial-delay, that IIRC predates the
side band thread tho, I'll have to think about it, just writing this
down to revisit this, as may raise some eyebrows by now being more
exposed.

- Arnaldo
 
> Suggested-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c             | 19 +++++++---
>  tools/perf/tests/attr/system-wide-dummy | 50 +++++++++++++++++++++++++
>  tools/perf/tests/attr/test-record-C0    | 12 +++++-
>  tools/perf/util/evsel.c                 |  5 ++-
>  4 files changed, 78 insertions(+), 8 deletions(-)
>  create mode 100644 tools/perf/tests/attr/system-wide-dummy
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 1ab349abe904..8d1e93351298 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -805,19 +805,28 @@ static int record__open(struct record *rec)
>  	int rc = 0;
>  
>  	/*
> -	 * For initial_delay we need to add a dummy event so that we can track
> -	 * PERF_RECORD_MMAP while we wait for the initial delay to enable the
> -	 * real events, the ones asked by the user.
> +	 * For initial_delay or system wide, we need to add a dummy event so
> +	 * that we can track PERF_RECORD_MMAP to cover the delay of waiting or
> +	 * event synthesis.
>  	 */
> -	if (opts->initial_delay) {
> +	if (opts->initial_delay || target__has_cpu(&opts->target)) {
>  		if (perf_evlist__add_dummy(evlist))
>  			return -ENOMEM;
>  
> +		/* Disable tracking of mmaps on lead event. */
>  		pos = evlist__first(evlist);
>  		pos->tracking = 0;
> +		/* Set up dummy event. */
>  		pos = evlist__last(evlist);
>  		pos->tracking = 1;
> -		pos->core.attr.enable_on_exec = 1;
> +		/*
> +		 * Enable the dummy event when the process is forked for
> +		 * initial_delay, immediately for system wide.
> +		 */
> +		if (opts->initial_delay)
> +			pos->core.attr.enable_on_exec = 1;
> +		else
> +			pos->immediate = 1;
>  	}
>  
>  	perf_evlist__config(evlist, opts, &callchain_param);
> diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
> new file mode 100644
> index 000000000000..eba723cc0d38
> --- /dev/null
> +++ b/tools/perf/tests/attr/system-wide-dummy
> @@ -0,0 +1,50 @@
> +# Event added by system-wide or CPU perf-record to handle the race of
> +# processes starting while /proc is processed.
> +[event]
> +fd=1
> +group_fd=-1
> +cpu=*
> +pid=-1
> +flags=8
> +type=1
> +size=120
> +config=9
> +sample_period=4000
> +sample_type=455
> +read_format=4
> +# Event will be enabled right away.
> +disabled=0
> +inherit=1
> +pinned=0
> +exclusive=0
> +exclude_user=0
> +exclude_kernel=0
> +exclude_hv=0
> +exclude_idle=0
> +mmap=1
> +comm=1
> +freq=1
> +inherit_stat=0
> +enable_on_exec=0
> +task=1
> +watermark=0
> +precise_ip=0
> +mmap_data=0
> +sample_id_all=1
> +exclude_host=0
> +exclude_guest=0
> +exclude_callchain_kernel=0
> +exclude_callchain_user=0
> +mmap2=1
> +comm_exec=1
> +context_switch=0
> +write_backward=0
> +namespaces=0
> +use_clockid=0
> +wakeup_events=0
> +bp_type=0
> +config1=0
> +config2=0
> +branch_sample_type=0
> +sample_regs_user=0
> +sample_stack_user=0
> diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
> index 93818054ae20..317730b906dd 100644
> --- a/tools/perf/tests/attr/test-record-C0
> +++ b/tools/perf/tests/attr/test-record-C0
> @@ -9,6 +9,14 @@ cpu=0
>  # no enable on exec for CPU attached
>  enable_on_exec=0
>  
> -# PERF_SAMPLE_IP | PERF_SAMPLE_TID PERF_SAMPLE_TIME | # PERF_SAMPLE_PERIOD
> +# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> +# PERF_SAMPLE_ID | PERF_SAMPLE_PERIOD
>  # + PERF_SAMPLE_CPU added by -C 0
> -sample_type=391
> +sample_type=455
> +
> +# Dummy event handles mmaps, comm and task.
> +mmap=0
> +comm=0
> +task=0
> +
> +[event:system-wide-dummy]
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 6a571d322bb2..ca8f9533d8f9 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1163,11 +1163,14 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	}
>  
>  	/*
> +	 * A dummy event never triggers any actual counter and therefore
> +	 * cannot be used with branch_stack.
> +	 *
>  	 * For initial_delay, a dummy event is added implicitly.
>  	 * The software event will trigger -EOPNOTSUPP error out,
>  	 * if BRANCH_STACK bit is set.
>  	 */
> -	if (opts->initial_delay && is_dummy_event(evsel))
> +	if (is_dummy_event(evsel))
>  		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
>  }
>  
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

-- 

- Arnaldo
