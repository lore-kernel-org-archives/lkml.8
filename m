Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9064CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5183A20754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W55oNCm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCRTtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:49:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33015 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCRTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:49:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id d22so21919483qtn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EeSuReggLIg9Ox6sjE8UT3GrLrfZSx0nQIcES/Xp4IA=;
        b=W55oNCm5I+BocXm2uI5ujyYCusyOePEZHsx9m7fX2sFraAG2yfWGFjlqVXji4YIwGo
         hmYyBHEG+RlbWTfLtWbXENdVqWhgZDG6mYzVD1twFgIYf+c0LTWU9w9GO00aBX9vhW6u
         TjIQidebNpuHgIockn6mNnNHcbVVQsPdyVRR2DooANRJBmRjEIycNHX2ojshW92xIDfW
         1rslGDTXawABAivGBjUfmQwnTsiXk/1OgSda5lU3j8kDBNZyPWq3ayGCihCnXY2URNGY
         9Up7i1YtCu+iK5WuOGeZNEwMl7gnHLr2NOmjTaTuVacpnrMED0LvW/ZsEb7/vewSghAi
         CeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EeSuReggLIg9Ox6sjE8UT3GrLrfZSx0nQIcES/Xp4IA=;
        b=rN9wSYQTstWD0YLc59eTFKvjjtakPK7UdEBqe9TL5wQw+mOHWTPARkAYuNr72R3KBw
         bnpq/Xq56Jm6Gzv0z2e1hh9smxoS8jjd5nsRX8XheuXYIVwnIj41dtZCPmRTMOJQzoyf
         J3z4IDMnh7HLtvueNHL394GmcfRyZgIGAQywHsemKFr2OHDdDvGNxaOoe71I2t/wo0/6
         JBdKaoAukuISsB2hqU5UnVb5s+QDw4k+caIjmzALykJw49iF8zjcr1aauSOmr0tS7DuE
         mDxHRRTB+3ntF802FjrxiXLHutZBaJGxld+M20cjCn2yPCB6CmLZueyFKa3YU8q92pho
         kOhw==
X-Gm-Message-State: ANhLgQ0LI4qdpNTuifb65zZBUjtTrpTihGx2gI+y7nVwnwYilhc4mmtl
        zaNigtn+by272bhSmC3/QwY=
X-Google-Smtp-Source: ADFU+vt9O733980EoN+JDNanXkWGnsgq6sDoqUgx64Bg6FfXWAVomph8iqouUg7ymznKs6T8hGJyqA==
X-Received: by 2002:aed:2605:: with SMTP id z5mr6435466qtc.240.1584560980218;
        Wed, 18 Mar 2020 12:49:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y60sm5281537qtd.32.2020.03.18.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:49:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A442D404E4; Wed, 18 Mar 2020 16:49:37 -0300 (-03)
Date:   Wed, 18 Mar 2020 16:49:37 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V3 02/17] perf header: Support CPU PMU capabilities
Message-ID: <20200318194937.GS11531@kernel.org>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
 <20200313183319.17739-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313183319.17739-3-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 13, 2020 at 11:33:04AM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> To stitch LBR call stack, the max LBR information is required. So the
> CPU PMU capabilities information has to be stored in perf header.
> 
> Add a new feature HEADER_CPU_PMU_CAPS for CPU PMU capabilities.
> Retrieve all CPU PMU capabilities, not just max LBR information.
> 
> Add variable max_branches to facilitate future usage.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  .../Documentation/perf.data-file-format.txt   |  16 +++
>  tools/perf/util/env.h                         |   3 +
>  tools/perf/util/header.c                      | 110 ++++++++++++++++++
>  tools/perf/util/header.h                      |   1 +
>  4 files changed, 130 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index b0152e1095c5..b6472e463284 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -373,6 +373,22 @@ struct {
>  Indicates that trace contains records of PERF_RECORD_COMPRESSED type
>  that have perf_events records in compressed form.
>  
> +	HEADER_CPU_PMU_CAPS = 28,
> +
> +	A list of cpu PMU capabilities. The format of data is as below.
> +
> +struct {
> +	u32 nr_cpu_pmu_caps;
> +	{
> +		char	name[];
> +		char	value[];
> +	} [nr_cpu_pmu_caps]
> +};
> +
> +
> +Example:
> + cpu pmu capabilities: branches=32, max_precise=3, pmu_name=icelake
> +
>  	other bits are reserved and should ignored for now
>  	HEADER_FEAT_BITS	= 256,
>  
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 11d05ae3606a..d286d478b4d8 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -48,6 +48,7 @@ struct perf_env {
>  	char			*cpuid;
>  	unsigned long long	total_mem;
>  	unsigned int		msr_pmu_type;
> +	unsigned int		max_branches;
>  
>  	int			nr_cmdline;
>  	int			nr_sibling_cores;
> @@ -57,12 +58,14 @@ struct perf_env {
>  	int			nr_memory_nodes;
>  	int			nr_pmu_mappings;
>  	int			nr_groups;
> +	int			nr_cpu_pmu_caps;
>  	char			*cmdline;
>  	const char		**cmdline_argv;
>  	char			*sibling_cores;
>  	char			*sibling_dies;
>  	char			*sibling_threads;
>  	char			*pmu_mappings;
> +	char			*cpu_pmu_caps;
>  	struct cpu_topology_map	*cpu;
>  	struct cpu_cache_level	*caches;
>  	int			 caches_cnt;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index acbd046bf95c..ce29321a4e1d 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1395,6 +1395,39 @@ static int write_compressed(struct feat_fd *ff __maybe_unused,
>  	return do_write(ff, &(ff->ph->env.comp_mmap_len), sizeof(ff->ph->env.comp_mmap_len));
>  }
>  
> +static int write_cpu_pmu_caps(struct feat_fd *ff,
> +			      struct evlist *evlist __maybe_unused)
> +{
> +	struct perf_pmu_caps *caps = NULL;
> +	struct perf_pmu *cpu_pmu;
> +	int nr_caps;
> +	int ret;
> +
> +	cpu_pmu = perf_pmu__find("cpu");

please combine decl + assign:

+	struct perf_pmu *cpu_pmu = perf_pmu__find("cpu");

> +	if (!cpu_pmu)
> +		return -ENOENT;
> +
> +	nr_caps = perf_pmu__caps_parse(cpu_pmu);
> +	if (nr_caps < 0)
> +		return nr_caps;
> +
> +	ret = do_write(ff, &nr_caps, sizeof(nr_caps));
> +	if (ret < 0)
> +		return ret;
> +
> +	while ((caps = perf_pmu__scan_caps(cpu_pmu, caps))) {

Why can't you play use list_for_each_entry() here and remove that perf_pmu__scan_caps()?

> +		ret = do_write_string(ff, caps->name);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = do_write_string(ff, caps->value);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
>  static void print_hostname(struct feat_fd *ff, FILE *fp)
>  {
>  	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
> @@ -1809,6 +1842,28 @@ static void print_compressed(struct feat_fd *ff, FILE *fp)
>  		ff->ph->env.comp_level, ff->ph->env.comp_ratio);
>  }
>  
> +static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
> +{
> +	const char *delimiter = "# cpu pmu capabilities: ";
> +	char *str;
> +	u32 nr_caps;
> +
> +	nr_caps = ff->ph->env.nr_cpu_pmu_caps;

ditto

> +	if (!nr_caps) {
> +		fprintf(fp, "# cpu pmu capabilities: not available\n");
> +		return;
> +	}
> +
> +	str = ff->ph->env.cpu_pmu_caps;
> +	while (nr_caps--) {
> +		fprintf(fp, "%s%s", delimiter, str);
> +		delimiter = ", ";
> +		str += strlen(str) + 1;
> +	}
> +
> +	fprintf(fp, "\n");
> +}
> +
>  static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
>  {
>  	const char *delimiter = "# pmu mappings: ";
> @@ -2846,6 +2901,60 @@ static int process_compressed(struct feat_fd *ff,
>  	return 0;
>  }
>  
> +static int process_cpu_pmu_caps(struct feat_fd *ff,
> +				void *data __maybe_unused)
> +{
> +	char *name, *value;
> +	struct strbuf sb;
> +	u32 nr_caps;
> +
> +	if (do_read_u32(ff, &nr_caps))
> +		return -1;
> +
> +	if (!nr_caps) {
> +		pr_debug("cpu pmu capabilities not available\n");
> +		return 0;
> +	}
> +
> +	ff->ph->env.nr_cpu_pmu_caps = nr_caps;
> +
> +	if (strbuf_init(&sb, 128) < 0)
> +		return -1;
> +
> +	while (nr_caps--) {
> +		name = do_read_string(ff);
> +		if (!name)
> +			goto error;
> +
> +		value = do_read_string(ff);
> +		if (!value)
> +			goto free_name;
> +
> +		if (strbuf_addf(&sb, "%s=%s", name, value) < 0)
> +			goto free_value;
> +
> +		/* include a NULL character at the end */
> +		if (strbuf_add(&sb, "", 1) < 0)
> +			goto free_value;
> +
> +		if (!strcmp(name, "branches"))
> +			ff->ph->env.max_branches = atoi(value);
> +
> +		free(value);
> +		free(name);
> +	}
> +	ff->ph->env.cpu_pmu_caps = strbuf_detach(&sb, NULL);
> +	return 0;
> +
> +free_value:
> +	free(value);
> +free_name:
> +	free(name);
> +error:
> +	strbuf_release(&sb);
> +	return -1;
> +}
> +
>  #define FEAT_OPR(n, func, __full_only) \
>  	[HEADER_##n] = {					\
>  		.name	    = __stringify(n),			\
> @@ -2903,6 +3012,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
>  	FEAT_OPR(BPF_BTF,       bpf_btf,        false),
>  	FEAT_OPR(COMPRESSED,	compressed,	false),
> +	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 840f95cee349..650bd1c7a99b 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -43,6 +43,7 @@ enum {
>  	HEADER_BPF_PROG_INFO,
>  	HEADER_BPF_BTF,
>  	HEADER_COMPRESSED,
> +	HEADER_CPU_PMU_CAPS,
>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> -- 
> 2.17.1
> 

-- 

- Arnaldo
