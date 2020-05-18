Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D196C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CEF206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJpXpYi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgEROTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:19:20 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:19:19 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b6so10166354qkh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DiJCUgOBkt+hu1YYpKxZAToxhAv1VQmh32ecU2xJVYs=;
        b=TJpXpYi84ZRNJzAkVaPLL+ACKJhXIJfRg5N9FXa3cddldhFXTh2eQrfu13Br3gW3uv
         zp3lZT9A8UAA62whjE6C2X1df44FiKfBFcrq98cTcthKl1i6USJg/AFPMYvGLLxSenLJ
         1zmPRb1dmbdBsSRIrE2/qx2gckqDS17444GnfOm6e0SVqy9p7VDkWq3fgn7xGMW2bqkE
         S6VkdXlH2a/gLJlk2vmLegInKWVGOiZe4KfR2GxGrQueyZe4BmMPYOtPsY1YacwbXZX0
         NdbW4n4mbAADKkkktguPw2wJzIytzoqR5qJsHkout8cz6bc/wYrGhyA/ZL6xv0a2rMLq
         u8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DiJCUgOBkt+hu1YYpKxZAToxhAv1VQmh32ecU2xJVYs=;
        b=qJRsu7cOi/+lB3DFSSb9jgK2ZdQ/tthMK9aYuzio21eV7fZtMR46+v0mH8dnIa470s
         5LuLD8tFoZyYHZD8UojJo9M47HHz3l1p/0bVkdYllSTZ8GQCsLBeYXCfMDLmc9AJeOhn
         fYaR15ZC1xkpPqbTn4LPLtPp8PkJMiQdmPwtPOmqIzVhOMnWF6HR2fq2yHfTsDNYCRLi
         BBXQbaSexI4wfKTHqAp5NvZxKI5YEA+RwkgXw6u9D96q2iiEXuTOoyB/LwitR4GXR7f6
         8Wh0xBYeNveV/lPThk16ebiCZHW02qcIYBE7rFlgzN75xGwvwtPWGSm+fsrZUmVqIJTw
         +7+g==
X-Gm-Message-State: AOAM530FG9nmUDTHK61YohICWTJ7bukgcm7mo7H/cC6iBAB7vED2sCgh
        vMKovB2lDdlhjYOqyacpD3EMNX7T8qc=
X-Google-Smtp-Source: ABdhPJxjOxlzgaqTb/NMAVSCT9O9MtmiJP65fHCHKLukXV+F+21YCbbA5Pw7iD8TTMPqXcl4ql6tQw==
X-Received: by 2002:a37:3d7:: with SMTP id 206mr15667662qkd.202.1589811558818;
        Mon, 18 May 2020 07:19:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h12sm9513085qtb.19.2020.05.18.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:19:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C507A40AFD; Mon, 18 May 2020 11:19:15 -0300 (-03)
Date:   Mon, 18 May 2020 11:19:15 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC] perf trace: Fix compilation error for make NO_LIBBPF=1
 DEBUG=1
Message-ID: <20200518141915.GA24211@kernel.org>
References: <20200518141027.3765877-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518141027.3765877-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 18, 2020 at 04:10:27PM +0200, Jiri Olsa escreveu:
> I haven't tested if this breaks some perf trace functionality,
> hence RFC ;-)

Thanks for the patch, looks ok, applying, please let me know if you need
to do something else with it.

- Arnaldo
 
> The perf compilation fails for NO_LIBBPF=1 DEBUG=1 with:
> 
>   $ make NO_LIBBPF=1 DEBUG=1
>     BUILD:   Doing 'make -j8' parallel build
>     CC       builtin-trace.o
>     LD       perf-in.o
>     LINK     perf
>   /usr/bin/ld: perf-in.o: in function `trace__find_bpf_map_by_name':
>   /home/jolsa/kernel/linux-perf/tools/perf/builtin-trace.c:4608: undefined reference to `bpf_object__find_map_by_name'
>   collect2: error: ld returned 1 exit status
>   make[2]: *** [Makefile.perf:631: perf] Error 1
>   make[1]: *** [Makefile.perf:225: sub-make] Error 2
>   make: *** [Makefile:70: all] Error 2
> 
> Moving trace__find_bpf_map_by_name calls under HAVE_LIBBPF_SUPPORT
> ifdef and add make test for this.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 54 ++++++++++++++++++++++++--------------
>  tools/perf/tests/make      |  1 +
>  2 files changed, 35 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 56bcf1ab19f8..61bafca1018a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3174,6 +3174,26 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
>  }
>  
>  #ifdef HAVE_LIBBPF_SUPPORT
> +static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
> +{
> +	if (trace->bpf_obj == NULL)
> +		return NULL;
> +
> +	return bpf_object__find_map_by_name(trace->bpf_obj, name);
> +}
> +
> +static void trace__set_bpf_map_filtered_pids(struct trace *trace)
> +{
> +	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
> +}
> +
> +static void trace__set_bpf_map_syscalls(struct trace *trace)
> +{
> +	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
> +	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
> +	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
> +}
> +
>  static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
>  {
>  	if (trace->bpf_obj == NULL)
> @@ -3512,6 +3532,20 @@ static void trace__delete_augmented_syscalls(struct trace *trace)
>  	trace->bpf_obj = NULL;
>  }
>  #else // HAVE_LIBBPF_SUPPORT
> +static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace __maybe_unused,
> +						   const char *name __maybe_unused)
> +{
> +	return NULL;
> +}
> +
> +static void trace__set_bpf_map_filtered_pids(struct trace *trace __maybe_unused)
> +{
> +}
> +
> +static void trace__set_bpf_map_syscalls(struct trace *trace __maybe_unused)
> +{
> +}
> +
>  static int trace__set_ev_qualifier_bpf_filter(struct trace *trace __maybe_unused)
>  {
>  	return 0;
> @@ -4600,26 +4634,6 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
>  	return 0;
>  }
>  
> -static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
> -{
> -	if (trace->bpf_obj == NULL)
> -		return NULL;
> -
> -	return bpf_object__find_map_by_name(trace->bpf_obj, name);
> -}
> -
> -static void trace__set_bpf_map_filtered_pids(struct trace *trace)
> -{
> -	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
> -}
> -
> -static void trace__set_bpf_map_syscalls(struct trace *trace)
> -{
> -	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
> -	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
> -	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
> -}
> -
>  static int trace__config(const char *var, const char *value, void *arg)
>  {
>  	struct trace *trace = arg;
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 5d0c3a9c47a1..c3c59def9f87 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -84,6 +84,7 @@ make_no_libaudit    := NO_LIBAUDIT=1
>  make_no_libbionic   := NO_LIBBIONIC=1
>  make_no_auxtrace    := NO_AUXTRACE=1
>  make_no_libbpf	    := NO_LIBBPF=1
> +make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
>  make_no_libcrypto   := NO_LIBCRYPTO=1
>  make_with_babeltrace:= LIBBABELTRACE=1
>  make_no_sdt	    := NO_SDT=1
> -- 
> 2.25.4
> 

-- 

- Arnaldo
