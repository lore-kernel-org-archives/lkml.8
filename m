Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE2C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13361216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+kY3rjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgEHQ3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgEHQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:29:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2971FC061A0C;
        Fri,  8 May 2020 09:29:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j2so1445058qtr.12;
        Fri, 08 May 2020 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+FbGte5bWwzVrU69fkb2DJo9HTGmvulg/GoLmibMfo=;
        b=Z+kY3rjW5kPTjbC49sGBHdyTAKh7MUqEsryTr4Yk4CWuNcGiCoKbTBF99DqWN0wO8t
         hX/TwhYCK6EEAAb4bFMNvBxDMmu5gh6yl6WaiV3xJbUs25pHAyDDzJt8LYZWmDR31YKx
         KtD5fFNkmubok7u0GSIwDLo/0lJj9of296QH+DqraMTRBbLX7LGT44GAmzJR1/R+UkUO
         WtnkT9CzZ+qMFLVZ5tw83N/opxz8JM47t439kn1r2yDX/og//pKhl2nLhkqQMOLVuU86
         odZw4H1nbhZKZ2rtCkTQmYmsIPycASitIS8qurSLXYNTkk7ewsJovIhzXm6SP/qCKhh1
         4H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+FbGte5bWwzVrU69fkb2DJo9HTGmvulg/GoLmibMfo=;
        b=dg97CmpBigSB9+FO3uzd1m42u8j79UC0GIbuTbZIgsaavl30V1QzAK/auw8DHhB0+U
         F2u7j0r6de7vT3FunVyHJ70ANms+FIPy5ayd/M8AMl3zDnz0gDxrorUTwY7qdeZdwZq8
         bBgJ0KRxheatyH1+jtQIHr2wvdcBhYAJoqC5UNn8aV9lLflhhW7h2k84Z0ocYZ9cLVYS
         Wmuh2grV5vUJynchYL/p/7vKrcixEYnmdGakdzf7kZDqvpqYB+vGGELLfeQ0p0O/TdHh
         q8uhSF8H4a0auVXt1E8PdSt7rmYg0pwKwDaVXxU+LNTfVAlxP0yXnHkII9fTeVMq1rz/
         YqJw==
X-Gm-Message-State: AGi0PuaD7jvB95YYgI/KwI0DaoTluOePTCasfemuyO85TNA/PAlZw6LX
        BjZoHZd7Um4OzRbguvWyg/4=
X-Google-Smtp-Source: APiQypKdQNBCPNY3xbXnaZdUSrjKy+TY1aNwdddfSExSKJoQ6CyXhCQ7tCFVCYLKRgIN7sot8oTu/w==
X-Received: by 2002:aed:34c6:: with SMTP id x64mr4080661qtd.66.1588955387280;
        Fri, 08 May 2020 09:29:47 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a16sm1481830qko.92.2020.05.08.09.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 09:29:46 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4370E40AFD; Fri,  8 May 2020 13:29:44 -0300 (-03)
Date:   Fri, 8 May 2020 13:29:44 -0300
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
Message-ID: <20200508162944.GA20581@kernel.org>
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

Thanks, applied after splitting it up into two patches, one for this
part:

> +++ b/tools/perf/util/evsel.c
> @@ -1163,11 +1163,14 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
>       }
>
>       /*
> +      * A dummy event never triggers any actual counter and therefore
> +      * cannot be used with branch_stack.
> +      *
>        * For initial_delay, a dummy event is added implicitly.
>        * The software event will trigger -EOPNOTSUPP error out,
>        * if BRANCH_STACK bit is set.
>        */
> -     if (opts->initial_delay && is_dummy_event(evsel))
> +     if (is_dummy_event(evsel))
>               perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
>  }

Which isn't related to what is in the subject line for this patch, ok?

We don't need to get more patches, but we need to have patches that do
one thing and just that, to ease with bisecting, reverting things
sometimes, etc.

And thanks for the extra comments :-)

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
