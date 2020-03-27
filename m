Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6472C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FBE206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceB9Ln3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC0OGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:06:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34190 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0OGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:06:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id i6so10888998qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RHKLk+NbxIh13Yv5XXpdCWe+KIHosWx52SgfzEZFApY=;
        b=ceB9Ln3Fvbweo+ptwALnZ+0jI01ldIui6GoxVBVM0bb/lkTrcZ4bR7dlo8qcPwayvg
         whaEYcUNBLu5C1p8iNCT4bHFITKr9Oi7uNinWRL7XfvRzm7EAfHw7a6lzVPd5w3lz5UV
         Xfd8NfSBe4UZwcgPmR/kjMGaNi0kqtOXIO5ELHRgpxuQkluv+6EyD0A0LaUmRXPv17e+
         cAB55ClNwcO1Hphw6OFkZNK1/sAAkHZ+YtOSTWNOVSb/31GqDzZwNf9ab2WdHz0kqivg
         R8x/zBJz8B3bGw77BFksIAEeb0Ki1IxA5dRXlt/SRojchEEEFzQRKWo0pqAz42ac4pU3
         Eydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RHKLk+NbxIh13Yv5XXpdCWe+KIHosWx52SgfzEZFApY=;
        b=ttAGGqKta1+fqc3ozspu+mFnXCMjABaqAYdYHIjoP5Tp2pOalrNpFEiEUPHh+G+cgx
         /AxElN3j85ouHlPfPpcIKab/M4/oQFQZIq2rd7oSkgSY37tZMs6Sya0sMktMBF3ZXi8T
         KMPatJjisYs3sPqKB8xpD95WifXiar7vdp/7pIKYxCi4XVvMUu6UppdYqJZEyy9EN9VR
         dSc97FNrNHd4rICwUv0aXE4YhDB2uvnL4OD2waTI7eyxTzzckY7UH18RJMoEScqdpdpu
         gUf6zIBffj/Gu7rr2FJonhB3GAzA0gYNLD8x0BI2Cel5iHiGMcAn7Lf/q22ZNnd7LLyp
         WPZw==
X-Gm-Message-State: ANhLgQ2K8wh/h/w1WWBCF4n9lnj20Zn2hJz1k2C1O5tdsbwRSbjDulQP
        uSZoeJEgPEXsYkppqHixErQ=
X-Google-Smtp-Source: ADFU+vvZq+QiOAg0GKsuUkJBxPbeAPAyRidWlTTr4x9qF9QkWQyAg8/GNpsMBq/1wVqV9/x0r5EXoA==
X-Received: by 2002:a37:6e87:: with SMTP id j129mr14482258qkc.358.1585317973975;
        Fri, 27 Mar 2020 07:06:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w4sm3767523qkc.122.2020.03.27.07.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 07:06:12 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D21BA409A3; Fri, 27 Mar 2020 11:06:10 -0300 (-03)
Date:   Fri, 27 Mar 2020 11:06:10 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH 3/9] perf tools: Basic support for CGROUP event
Message-ID: <20200327140610.GA19927@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
 <20200325124536.2800725-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325124536.2800725-4-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 09:45:30PM +0900, Namhyung Kim escreveu:
> Implement basic functionality to support cgroup tracking.  Each cgroup
> can be identified by inode number which can be read from userspace
> too.  The actual cgroup processing will come in the later patch.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> [fix perf test failure on sampling parsing]
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---

I'm just separating the UAPI header from the rest of this patch, as has
been usual,

- Arnaldo

>  tools/include/uapi/linux/perf_event.h     | 16 ++++++++++++++--
>  tools/lib/perf/include/perf/event.h       |  7 +++++++
>  tools/perf/builtin-diff.c                 |  1 +
>  tools/perf/builtin-report.c               |  1 +
>  tools/perf/tests/sample-parsing.c         |  6 +++++-
>  tools/perf/util/event.c                   | 18 ++++++++++++++++++
>  tools/perf/util/event.h                   |  6 ++++++
>  tools/perf/util/evsel.c                   |  6 ++++++
>  tools/perf/util/machine.c                 | 12 ++++++++++++
>  tools/perf/util/machine.h                 |  3 +++
>  tools/perf/util/perf_event_attr_fprintf.c |  2 ++
>  tools/perf/util/session.c                 |  4 ++++
>  tools/perf/util/synthetic-events.c        |  8 ++++++++
>  tools/perf/util/tool.h                    |  1 +
>  14 files changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 397cfd65b3fe..7b2d6fc9e6ed 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -142,8 +142,9 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
>  	PERF_SAMPLE_AUX				= 1U << 20,
> +	PERF_SAMPLE_CGROUP			= 1U << 21,
>  
> -	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };
> @@ -381,7 +382,8 @@ struct perf_event_attr {
>  				ksymbol        :  1, /* include ksymbol events */
>  				bpf_event      :  1, /* include bpf events */
>  				aux_output     :  1, /* generate AUX records instead of events */
> -				__reserved_1   : 32;
> +				cgroup         :  1, /* include cgroup events */
> +				__reserved_1   : 31;
>  
>  	union {
>  		__u32		wakeup_events;	  /* wakeup every n events */
> @@ -1012,6 +1014,16 @@ enum perf_event_type {
>  	 */
>  	PERF_RECORD_BPF_EVENT			= 18,
>  
> +	/*
> +	 * struct {
> +	 *	struct perf_event_header	header;
> +	 *	u64				id;
> +	 *	char				path[];
> +	 *	struct sample_id		sample_id;
> +	 * };
> +	 */
> +	PERF_RECORD_CGROUP			= 19,
> +
>  	PERF_RECORD_MAX,			/* non-ABI */
>  };
>  
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index 18106899cb4e..69b44d2cc0f5 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -105,6 +105,12 @@ struct perf_record_bpf_event {
>  	__u8			 tag[BPF_TAG_SIZE];  // prog tag
>  };
>  
> +struct perf_record_cgroup {
> +	struct perf_event_header header;
> +	__u64			 id;
> +	char			 path[PATH_MAX];
> +};
> +
>  struct perf_record_sample {
>  	struct perf_event_header header;
>  	__u64			 array[];
> @@ -352,6 +358,7 @@ union perf_event {
>  	struct perf_record_mmap2		mmap2;
>  	struct perf_record_comm			comm;
>  	struct perf_record_namespaces		namespaces;
> +	struct perf_record_cgroup		cgroup;
>  	struct perf_record_fork			fork;
>  	struct perf_record_lost			lost;
>  	struct perf_record_lost_samples		lost_samples;
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 5e697cd2224a..c94a002f295e 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -455,6 +455,7 @@ static struct perf_diff pdiff = {
>  		.fork	= perf_event__process_fork,
>  		.lost	= perf_event__process_lost,
>  		.namespaces = perf_event__process_namespaces,
> +		.cgroup = perf_event__process_cgroup,
>  		.ordered_events = true,
>  		.ordering_requires_timestamps = true,
>  	},
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index ea673b7eb3f4..26d8fc27e427 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1105,6 +1105,7 @@ int cmd_report(int argc, const char **argv)
>  			.mmap2		 = perf_event__process_mmap2,
>  			.comm		 = perf_event__process_comm,
>  			.namespaces	 = perf_event__process_namespaces,
> +			.cgroup		 = perf_event__process_cgroup,
>  			.exit		 = perf_event__process_exit,
>  			.fork		 = perf_event__process_fork,
>  			.lost		 = perf_event__process_lost,
> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> index 14239e472187..61865699c3f4 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
> @@ -151,6 +151,9 @@ static bool samples_same(const struct perf_sample *s1,
>  	if (type & PERF_SAMPLE_PHYS_ADDR)
>  		COMP(phys_addr);
>  
> +	if (type & PERF_SAMPLE_CGROUP)
> +		COMP(cgroup);
> +
>  	if (type & PERF_SAMPLE_AUX) {
>  		COMP(aux_sample.size);
>  		if (memcmp(s1->aux_sample.data, s2->aux_sample.data,
> @@ -230,6 +233,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>  			.regs	= regs,
>  		},
>  		.phys_addr	= 113,
> +		.cgroup		= 114,
>  		.aux_sample	= {
>  			.size	= sizeof(aux_data),
>  			.data	= (void *)aux_data,
> @@ -336,7 +340,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
>  	 * were added.  Please actually update the test rather than just change
>  	 * the condition below.
>  	 */
> -	if (PERF_SAMPLE_MAX > PERF_SAMPLE_AUX << 1) {
> +	if (PERF_SAMPLE_MAX > PERF_SAMPLE_CGROUP << 1) {
>  		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
>  		return -1;
>  	}
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index c5447ff516a2..824c038e5c33 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -54,6 +54,7 @@ static const char *perf_event__names[] = {
>  	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
>  	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
>  	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
> +	[PERF_RECORD_CGROUP]			= "CGROUP",
>  	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
>  	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
>  	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
> @@ -180,6 +181,12 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp)
>  	return ret;
>  }
>  
> +size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp)
> +{
> +	return fprintf(fp, " cgroup: %" PRI_lu64 " %s\n",
> +		       event->cgroup.id, event->cgroup.path);
> +}
> +
>  int perf_event__process_comm(struct perf_tool *tool __maybe_unused,
>  			     union perf_event *event,
>  			     struct perf_sample *sample,
> @@ -196,6 +203,14 @@ int perf_event__process_namespaces(struct perf_tool *tool __maybe_unused,
>  	return machine__process_namespaces_event(machine, event, sample);
>  }
>  
> +int perf_event__process_cgroup(struct perf_tool *tool __maybe_unused,
> +			       union perf_event *event,
> +			       struct perf_sample *sample,
> +			       struct machine *machine)
> +{
> +	return machine__process_cgroup_event(machine, event, sample);
> +}
> +
>  int perf_event__process_lost(struct perf_tool *tool __maybe_unused,
>  			     union perf_event *event,
>  			     struct perf_sample *sample,
> @@ -417,6 +432,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
>  	case PERF_RECORD_NAMESPACES:
>  		ret += perf_event__fprintf_namespaces(event, fp);
>  		break;
> +	case PERF_RECORD_CGROUP:
> +		ret += perf_event__fprintf_cgroup(event, fp);
> +		break;
>  	case PERF_RECORD_MMAP2:
>  		ret += perf_event__fprintf_mmap2(event, fp);
>  		break;
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 3cda40a2fafc..b8289f160f07 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -135,6 +135,7 @@ struct perf_sample {
>  	u32 raw_size;
>  	u64 data_src;
>  	u64 phys_addr;
> +	u64 cgroup;
>  	u32 flags;
>  	u16 insn_len;
>  	u8  cpumode;
> @@ -322,6 +323,10 @@ int perf_event__process_namespaces(struct perf_tool *tool,
>  				   union perf_event *event,
>  				   struct perf_sample *sample,
>  				   struct machine *machine);
> +int perf_event__process_cgroup(struct perf_tool *tool,
> +			       union perf_event *event,
> +			       struct perf_sample *sample,
> +			       struct machine *machine);
>  int perf_event__process_mmap(struct perf_tool *tool,
>  			     union perf_event *event,
>  			     struct perf_sample *sample,
> @@ -377,6 +382,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
> +size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf(union perf_event *event, FILE *fp);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 15ccd193483f..b766eb608b97 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2267,6 +2267,12 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		array++;
>  	}
>  
> +	data->cgroup = 0;
> +	if (type & PERF_SAMPLE_CGROUP) {
> +		data->cgroup = *array;
> +		array++;
> +	}
> +
>  	if (type & PERF_SAMPLE_AUX) {
>  		OVERFLOW_CHECK_u64(array);
>  		sz = *array++;
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index fd14f1489802..399b4731b246 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -654,6 +654,16 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
>  	return err;
>  }
>  
> +int machine__process_cgroup_event(struct machine *machine __maybe_unused,
> +				  union perf_event *event,
> +				  struct perf_sample *sample __maybe_unused)
> +{
> +	if (dump_trace)
> +		perf_event__fprintf_cgroup(event, stdout);
> +
> +	return 0;
> +}
> +
>  int machine__process_lost_event(struct machine *machine __maybe_unused,
>  				union perf_event *event, struct perf_sample *sample __maybe_unused)
>  {
> @@ -1878,6 +1888,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
>  		ret = machine__process_mmap_event(machine, event, sample); break;
>  	case PERF_RECORD_NAMESPACES:
>  		ret = machine__process_namespaces_event(machine, event, sample); break;
> +	case PERF_RECORD_CGROUP:
> +		ret = machine__process_cgroup_event(machine, event, sample); break;
>  	case PERF_RECORD_MMAP2:
>  		ret = machine__process_mmap2_event(machine, event, sample); break;
>  	case PERF_RECORD_FORK:
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index be0a930eca89..fa1be9ea00fa 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -128,6 +128,9 @@ int machine__process_switch_event(struct machine *machine,
>  int machine__process_namespaces_event(struct machine *machine,
>  				      union perf_event *event,
>  				      struct perf_sample *sample);
> +int machine__process_cgroup_event(struct machine *machine,
> +				  union perf_event *event,
> +				  struct perf_sample *sample);
>  int machine__process_mmap_event(struct machine *machine, union perf_event *event,
>  				struct perf_sample *sample);
>  int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index 355d3458d4e6..b94fa07f5d32 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -35,6 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
>  		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
>  		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
>  		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
> +		bit_name(CGROUP),
>  		{ .name = NULL, }
>  	};
>  #undef bit_name
> @@ -132,6 +133,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	PRINT_ATTRf(ksymbol, p_unsigned);
>  	PRINT_ATTRf(bpf_event, p_unsigned);
>  	PRINT_ATTRf(aux_output, p_unsigned);
> +	PRINT_ATTRf(cgroup, p_unsigned);
>  
>  	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
>  	PRINT_ATTRf(bp_type, p_unsigned);
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 055b00abd56d..0b0bfe5bef17 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -471,6 +471,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
>  		tool->comm = process_event_stub;
>  	if (tool->namespaces == NULL)
>  		tool->namespaces = process_event_stub;
> +	if (tool->cgroup == NULL)
> +		tool->cgroup = process_event_stub;
>  	if (tool->fork == NULL)
>  		tool->fork = process_event_stub;
>  	if (tool->exit == NULL)
> @@ -1436,6 +1438,8 @@ static int machines__deliver_event(struct machines *machines,
>  		return tool->comm(tool, event, sample, machine);
>  	case PERF_RECORD_NAMESPACES:
>  		return tool->namespaces(tool, event, sample, machine);
> +	case PERF_RECORD_CGROUP:
> +		return tool->cgroup(tool, event, sample, machine);
>  	case PERF_RECORD_FORK:
>  		return tool->fork(tool, event, sample, machine);
>  	case PERF_RECORD_EXIT:
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 3f28af39f9c6..f72d80999506 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1230,6 +1230,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>  	if (type & PERF_SAMPLE_PHYS_ADDR)
>  		result += sizeof(u64);
>  
> +	if (type & PERF_SAMPLE_CGROUP)
> +		result += sizeof(u64);
> +
>  	if (type & PERF_SAMPLE_AUX) {
>  		result += sizeof(u64);
>  		result += sample->aux_sample.size;
> @@ -1404,6 +1407,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
>  		array++;
>  	}
>  
> +	if (type & PERF_SAMPLE_CGROUP) {
> +		*array = sample->cgroup;
> +		array++;
> +	}
> +
>  	if (type & PERF_SAMPLE_AUX) {
>  		sz = sample->aux_sample.size;
>  		*array++ = sz;
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 2abbf668b8de..472ef5eb4068 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -46,6 +46,7 @@ struct perf_tool {
>  			mmap2,
>  			comm,
>  			namespaces,
> +			cgroup,
>  			fork,
>  			exit,
>  			lost,
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

-- 

- Arnaldo
