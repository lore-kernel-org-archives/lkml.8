Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E646C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E60320BED
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599159946;
	bh=S4OWQr0lh3A84tDodUTIQgBMD2WAfSUcEaGz68wdnD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PwsL+lahqgnxF765hKArnkz5zU67PNMdEbqs1tiAUC0qKXxGYvbhcfEOF76OIpw+6
	 lTxdILwyOp0cBiH9vZ2TIVDiPGzQKJc0vyycFOMFwNQ+ejoHczdkgtawvsPBv6wLJv
	 7PFr/Mc73pj9gdONHHgj+rg51QU4VuKoD2A7mJVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgICTFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgICTFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:05:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82812098B;
        Thu,  3 Sep 2020 19:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599159942;
        bh=S4OWQr0lh3A84tDodUTIQgBMD2WAfSUcEaGz68wdnD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4yXExKi8SvmWwwHNDxCvO5BkoGHtUg46pIDlIqWHi67JiqVryyxcUKiSDO1lYG8N
         OKBx9/WKH8hJ9PSUe61vA3VpHv55j1kPQnthGSFqP3RvSAkcUulBue4bgh6iZl3Hfw
         SCRhx9BZ4gTdy7l2zzMGZbQAts4VIcrsjqaAUD18=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8EEE40D3D; Thu,  3 Sep 2020 16:05:39 -0300 (-03)
Date:   Thu, 3 Sep 2020 16:05:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf tools: Add bpf image check to __map__is_kmodule
Message-ID: <20200903190539.GJ3495158@kernel.org>
References: <20200826213017.818788-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826213017.818788-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 26, 2020 at 11:30:17PM +0200, Jiri Olsa escreveu:
> When validating kcore modules the do_validate_kcore_modules
> function checks on every kernel module dso against modules
> record. The __map__is_kmodule check is used to get only
> kernel module dso objects through.
> 
> Currently the bpf images are slipping through the check and
> making the validation to fail, so report falls back from kcore
> usage to kallsyms.
> 
> Adding __map__is_bpf_image check for bpf image and adding
> it to __map__is_kmodule check.

looks ok, applied to perf/urgent.

Thanks,

- Arnaldo
 
> Fixes: 3c29d4483e85 ("perf annotate: Add basic support for bpf_image")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/machine.c |  6 ------
>  tools/perf/util/map.c     | 16 ++++++++++++++++
>  tools/perf/util/map.h     |  9 ++++++++-
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 208b813e00ea..85587de027a5 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -736,12 +736,6 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
>  	return 0;
>  }
>  
> -static int is_bpf_image(const char *name)
> -{
> -	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) == 0 ||
> -	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1) == 0;
> -}
> -
>  static int machine__process_ksymbol_register(struct machine *machine,
>  					     union perf_event *event,
>  					     struct perf_sample *sample __maybe_unused)
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 1d7210804639..cc0faf8f1321 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -267,6 +267,22 @@ bool __map__is_bpf_prog(const struct map *map)
>  	return name && (strstr(name, "bpf_prog_") == name);
>  }
>  
> +bool __map__is_bpf_image(const struct map *map)
> +{
> +	const char *name;
> +
> +	if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_IMAGE)
> +		return true;
> +
> +	/*
> +	 * If PERF_RECORD_KSYMBOL is not included, the dso will not have
> +	 * type of DSO_BINARY_TYPE__BPF_IMAGE. In such cases, we can
> +	 * guess the type based on name.
> +	 */
> +	name = map->dso->short_name;
> +	return name && is_bpf_image(name);
> +}
> +
>  bool __map__is_ool(const struct map *map)
>  {
>  	return map->dso && map->dso->binary_type == DSO_BINARY_TYPE__OOL;
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 9e312ae2d656..c2f5d28fe73a 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -147,12 +147,14 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
>  bool __map__is_kernel(const struct map *map);
>  bool __map__is_extra_kernel_map(const struct map *map);
>  bool __map__is_bpf_prog(const struct map *map);
> +bool __map__is_bpf_image(const struct map *map);
>  bool __map__is_ool(const struct map *map);
>  
>  static inline bool __map__is_kmodule(const struct map *map)
>  {
>  	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map) &&
> -	       !__map__is_bpf_prog(map) && !__map__is_ool(map);
> +	       !__map__is_bpf_prog(map) && !__map__is_ool(map) &&
> +	       !__map__is_bpf_image(map);
>  }
>  
>  bool map__has_symbols(const struct map *map);
> @@ -164,4 +166,9 @@ static inline bool is_entry_trampoline(const char *name)
>  	return !strcmp(name, ENTRY_TRAMPOLINE_NAME);
>  }
>  
> +static inline bool is_bpf_image(const char *name)
> +{
> +	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) == 0 ||
> +	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1) == 0;
> +}
>  #endif /* __PERF_MAP_H */
> -- 
> 2.25.4
> 

-- 

- Arnaldo
