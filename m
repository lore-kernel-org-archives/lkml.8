Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49021C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9A0206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSB7z7lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgC0QjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:39:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39381 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgC0QjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:39:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id b62so11487741qkf.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r+Nps9/bUgxUQtwTDCzwPnWnt5n60SwhRR8T6RVQ9F8=;
        b=OSB7z7lqD70y48mAI/ZuTE2eiCoio430l7wpWrye9P3j6g1+HLOlG8Ouy/ONI6RTWN
         Z0JvXmrWtFFkcWKjNR7gsB9TzYG7KBvSZ8QXWc0OY+Ff16CXS70opcdcamv0Dj9Uupfa
         YikfLxhLw3wpJUTe9wIt90AJCmKUu9XYU7NZNiQM4HbJVVgqzS2gpt5oVlA7I2nUcglR
         NnyJ4SW6pl9puNWBSeIyTsG7hytfoKxWzf3C4qHIeLuBil0yRpSpS8T2L9VqGnCHo0MA
         TmD1Bogfom6c4wSeNwc8E9VNicC0okAxjvZBjXG1XMyUQ+QfJw6OgLwnySQkjkJWu5aE
         q4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+Nps9/bUgxUQtwTDCzwPnWnt5n60SwhRR8T6RVQ9F8=;
        b=nHnEA3K4IkPEE7vrQqHZA6XRhMjOp1/iqXyEhoigE4Ht4RjJmHiQcS6IJeTRgP03KF
         UeuGTiZIZR7hYax1qEotEe3zdiiUMFou0KwMdedNYkrM68OJYaNh3tH3KoYW4Up+ITgZ
         NaO8oeRiekOLHtGb0xG0QmJ2M3r9woa4Ke7pwjasU7PWzbgWdeIpuRxguimTXkOUNubV
         +DgKWJq3XBjDTuJJ8Gq/Whr/L+PZSD0ncyn/H7g/69ty+6+qUmr0+SViPEQwyayEohvb
         RNGvW9ushpNvlm6pvqBh941vO6X9Dsrxbg04cJrbnh5ER6t/2JPyqkLnz1VElKNl8i09
         vF4Q==
X-Gm-Message-State: ANhLgQ1JfMB5a/wP5vVDW/V8RD8Qy1CMalWctOp8kkY3mkiIVhEV4jQZ
        f/428x6GCjWIfMCsi28sTsc=
X-Google-Smtp-Source: ADFU+vuiah5YwbkxpvUp2bCMoec6W6j+uajQFrLikmeCtOi25OaqekoDQ6WsQ2MqG0rFCUGDucJO+A==
X-Received: by 2002:a37:5907:: with SMTP id n7mr153810qkb.227.1585327152332;
        Fri, 27 Mar 2020 09:39:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id z18sm4347940qtz.77.2020.03.27.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 09:39:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E539409A3; Fri, 27 Mar 2020 13:39:09 -0300 (-03)
Date:   Fri, 27 Mar 2020 13:39:09 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 9/9] perf script: Add --show-cgroup-events option
Message-ID: <20200327163909.GC19927@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
 <20200325124536.2800725-10-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325124536.2800725-10-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 09:45:36PM +0900, Namhyung Kim escreveu:
> The --show-cgroup-events option is to print CGROUP events in the
> output like others.

Added this to the comment:

Committer testing:

  [root@seventh ~]# perf record --all-cgroups --namespaces /wb/cgtest
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.039 MB perf.data (487 samples) ]
  [root@seventh ~]# perf script --show-cgroup-events | grep PERF_RECORD_CGROUP -B2 -A2
           swapper     0     0.000000: PERF_RECORD_CGROUP cgroup: 1 /
              perf 12145 11200.440730:          1 cycles:  ffffffffb900d58b __intel_pmu_enable_all.constprop.0+0x3b (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
              perf 12145 11200.440733:          1 cycles:  ffffffffb900d58b __intel_pmu_enable_all.constprop.0+0x3b (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
  --
            cgtest 12145 11200.440739:     193472 cycles:  ffffffffb90f6fbc commit_creds+0x1fc (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
            cgtest 12145 11200.440790:    2691608 cycles:      7fa2cb43019b _dl_sysdep_start+0x7cb (/usr/lib64/ld-2.29.so)
            cgtest 12145 11200.440962: PERF_RECORD_CGROUP cgroup: 83 /sub
            cgtest 12147 11200.441054:          1 cycles:  ffffffffb900d58b __intel_pmu_enable_all.constprop.0+0x3b (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
            cgtest 12147 11200.441057:          1 cycles:  ffffffffb900d58b __intel_pmu_enable_all.constprop.0+0x3b (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
  --
            cgtest 12148 11200.441103:      10227 cycles:  ffffffffb9a0153d end_repeat_nmi+0x48 (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
            cgtest 12148 11200.441106:     273295 cycles:  ffffffffb99ecbc7 copy_page+0x7 (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
            cgtest 12147 11200.441133: PERF_RECORD_CGROUP cgroup: 88 /sub/cgrp1
            cgtest 12147 11200.441143:    2788845 cycles:  ffffffffb94676c2 security_genfs_sid+0x102 (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
            cgtest 12148 11200.441162: PERF_RECORD_CGROUP cgroup: 93 /sub/cgrp2
            cgtest 12148 11200.441182:    2669546 cycles:            401020 _init+0x20 (/wb/cgtest)
            cgtest 12149 11200.441247:          1 cycles:  ffffffffb900d58b __intel_pmu_enable_all.constprop.0+0x3b (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
  [root@seventh ~]#

Thanks, series applied and tested, seems to work :-)

Now to trampolines...

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-script.txt |  3 ++
>  tools/perf/builtin-script.c              | 41 ++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index db6a36aac47e..515ff9f6af30 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -319,6 +319,9 @@ OPTIONS
>  --show-bpf-events
>  	Display bpf events i.e. events of type PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT.
>  
> +--show-cgroup-events
> +	Display cgroup events i.e. events of type PERF_RECORD_CGROUP.
> +
>  --demangle::
>  	Demangle symbol names to human readable form. It's enabled by default,
>  	disable with --no-demangle.
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 656b347f6dd8..6cc2d1da6ece 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1685,6 +1685,7 @@ struct perf_script {
>  	bool			show_lost_events;
>  	bool			show_round_events;
>  	bool			show_bpf_events;
> +	bool			show_cgroup_events;
>  	bool			allocated;
>  	bool			per_event_dump;
>  	struct evswitch		evswitch;
> @@ -2203,6 +2204,41 @@ static int process_namespaces_event(struct perf_tool *tool,
>  	return ret;
>  }
>  
> +static int process_cgroup_event(struct perf_tool *tool,
> +				union perf_event *event,
> +				struct perf_sample *sample,
> +				struct machine *machine)
> +{
> +	struct thread *thread;
> +	struct perf_script *script = container_of(tool, struct perf_script, tool);
> +	struct perf_session *session = script->session;
> +	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> +	int ret = -1;
> +
> +	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
> +	if (thread == NULL) {
> +		pr_debug("problem processing CGROUP event, skipping it.\n");
> +		return -1;
> +	}
> +
> +	if (perf_event__process_cgroup(tool, event, sample, machine) < 0)
> +		goto out;
> +
> +	if (!evsel->core.attr.sample_id_all) {
> +		sample->cpu = 0;
> +		sample->time = 0;
> +	}
> +	if (!filter_cpu(sample)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_CGROUP, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
> +	ret = 0;
> +out:
> +	thread__put(thread);
> +	return ret;
> +}
> +
>  static int process_fork_event(struct perf_tool *tool,
>  			      union perf_event *event,
>  			      struct perf_sample *sample,
> @@ -2542,6 +2578,8 @@ static int __cmd_script(struct perf_script *script)
>  		script->tool.context_switch = process_switch_event;
>  	if (script->show_namespace_events)
>  		script->tool.namespaces = process_namespaces_event;
> +	if (script->show_cgroup_events)
> +		script->tool.cgroup = process_cgroup_event;
>  	if (script->show_lost_events)
>  		script->tool.lost = process_lost_event;
>  	if (script->show_round_events) {
> @@ -3467,6 +3505,7 @@ int cmd_script(int argc, const char **argv)
>  			.mmap2		 = perf_event__process_mmap2,
>  			.comm		 = perf_event__process_comm,
>  			.namespaces	 = perf_event__process_namespaces,
> +			.cgroup		 = perf_event__process_cgroup,
>  			.exit		 = perf_event__process_exit,
>  			.fork		 = perf_event__process_fork,
>  			.attr		 = process_attr,
> @@ -3567,6 +3606,8 @@ int cmd_script(int argc, const char **argv)
>  		    "Show context switch events (if recorded)"),
>  	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
>  		    "Show namespace events (if recorded)"),
> +	OPT_BOOLEAN('\0', "show-cgroup-events", &script.show_cgroup_events,
> +		    "Show cgroup events (if recorded)"),
>  	OPT_BOOLEAN('\0', "show-lost-events", &script.show_lost_events,
>  		    "Show lost events (if recorded)"),
>  	OPT_BOOLEAN('\0', "show-round-events", &script.show_round_events,
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

-- 

- Arnaldo
