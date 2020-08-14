Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA5EC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECD5208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597407142;
	bh=a5cJXZnxRDDWp6/4Bwx3wvRp2g4eKgki2u8fzNxfEbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YuCspc8YMMDSzIcAQNxLrpC1XE8e1IJ7Xd6lT3MtGDH1Xd/WmFcFSWAlFzoVYAkNl
	 5oGA5IOVhJv5TOySAFdAK1SawfAnxqZBi+zFodcVl0xdGkScvf5/z17fshlEkjOzRe
	 MCtMbPW1m4jjSDvJMaS8VayWiOGuZSDnOQ8ccm1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgHNMMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgHNMME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:12:04 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA2E206B2;
        Fri, 14 Aug 2020 12:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597407124;
        bh=a5cJXZnxRDDWp6/4Bwx3wvRp2g4eKgki2u8fzNxfEbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJUNcTifHZNi4npz33OGkqn4gVcmbiYMkBaQ4q3na8rZczaZO6icimF6VFFL8WqBy
         e1rxEpf9qn7hiW1Q0Z4nW4tJl2oG1O8BFUCyBkwP8VEz4PBHrYdhsOFyRv+0NjWn2E
         LUTkTvmwXqVWomSczKWaYYf0oXA6A44y0ahhbEPw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3618640D3D; Fri, 14 Aug 2020 09:12:02 -0300 (-03)
Date:   Fri, 14 Aug 2020 09:12:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/18] perf ftrace: add option '--inherit' to trace
 children processes
Message-ID: <20200814121202.GW13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-7-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808023141.14227-7-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 08, 2020 at 10:31:29AM +0800, Changbin Du escreveu:
> This adds an option '--inherit' to allow us trace children
> processes spawned by our target.

One thing I'm missing from your commit log messages is the exact
sequence of commands and the outputs for the options you're introducing.

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> ---
> v2: option name '--trace-children' -> '--inherit'.
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  3 ++
>  tools/perf/builtin-ftrace.c              | 38 ++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 7a5d915f60b0..c46d0a09b38c 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -58,6 +58,9 @@ OPTIONS
>  	Set the size of per-cpu tracing buffer, <size> is expected to
>  	be a number with appended unit character - B/K/M/G.
>  
> +--inherit::
> +	Trace children processes spawned by our target.
> +
>  -T::
>  --trace-funcs=::
>  	Select function tracer and set function filter on the given
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 39c694be2b71..07b81d0c1658 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -41,6 +41,7 @@ struct perf_ftrace {
>  	struct list_head	nograph_funcs;
>  	int			graph_depth;
>  	unsigned long		percpu_buffer_size;
> +	bool			inherit;
>  };
>  
>  struct filter_entry {
> @@ -182,9 +183,27 @@ static int write_tracing_file_int(const char *name, int value)
>  	return 0;
>  }
>  
> +static int write_tracing_option_file(const char *name, const char *val)
> +{
> +	char *file;
> +	int ret;
> +
> +	if (asprintf(&file, "options/%s", name) < 0)
> +		return -1;
> +
> +	ret = __write_tracing_file(file, val, false);
> +	free(file);
> +	return ret;
> +}
> +
>  static int reset_tracing_cpu(void);
>  static void reset_tracing_filters(void);
>  
> +static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> +{
> +	write_tracing_option_file("function-fork", "0");
> +}
> +
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  {
>  	if (write_tracing_file("tracing_on", "0") < 0)
> @@ -203,6 +222,7 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  		return -1;
>  
>  	reset_tracing_filters();
> +	reset_tracing_options(ftrace);
>  	return 0;
>  }
>  
> @@ -341,6 +361,17 @@ static int set_tracing_percpu_buffer_size(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_trace_inherit(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->inherit)
> +		return 0;
> +
> +	if (write_tracing_option_file("function-fork", "1") < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>  	char *trace_file;
> @@ -410,6 +441,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_trace_inherit(ftrace) < 0) {
> +		pr_err("failed to set tracing option function-fork\n");
> +		goto out_reset;
> +	}
> +
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>  		goto out_reset;
> @@ -618,6 +654,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		    "Max depth for function graph tracer"),
>  	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
>  		     "size of per cpu buffer", parse_buffer_size),
> +	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
> +		    "trace children processes"),
>  	OPT_END()
>  	};
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
