Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C1BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB7020829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597404942;
	bh=+SScuk5qKesicxoXWFToSaNdAgaR48N+FzRr69hLNUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UvIbUHrR+yRl2Fr8iG5u4/aas8SBsCsywO2WGIDBo7+p2Ueccw0q6EmCrQHItCTNf
	 6o50YQ6JIAyVJiK+kjuyGZKt8RW6hECWdmp+eN8gnwZJqipoQ8DVzV03UDnmN/tWsh
	 rb3i7dfw7FOw2Yxj1qvs/v+k5Q8cL3NJBcGztdbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHNLfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHNLfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:35:37 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688A320771;
        Fri, 14 Aug 2020 11:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597404937;
        bh=+SScuk5qKesicxoXWFToSaNdAgaR48N+FzRr69hLNUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0F5u6IEWSPAtra/Ni8o34VKtJ2v8tUrF+3882Ir3HYULk1ap8G1+qPhlQODEay0cm
         szuRKEm2y+mXi/wU0G3qjGBrnAiKN28fv89YTxJ/tYe/0rPr1aR6ZX4xQs3ExZagyO
         hMmnqZ0DMB27PdStrUngtiXoHVsn1fqN2QugX4Ak=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7F2FD4097F; Fri, 14 Aug 2020 08:35:35 -0300 (-03)
Date:   Fri, 14 Aug 2020 08:35:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/18] perf ftrace: add option '-F/--funcs' to list
 available functions
Message-ID: <20200814113535.GS13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-3-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808023141.14227-3-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 08, 2020 at 10:31:25AM +0800, Changbin Du escreveu:
> This adds an option '-F/--funcs' to list all available functions to trace,
> which is read from tracing file 'available_filter_functions'.
> 
> $ sudo ./perf ftrace -F | head
> trace_initcall_finish_cb
> initcall_blacklisted
> do_one_initcall
> do_one_initcall
> trace_initcall_start_cb
> run_init_process
> try_to_run_init_process
> match_dev_by_label
> match_dev_by_uuid
> rootfs_init_fs_context
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> ---
> v3: fix return value issue.
> v2: option name '-l/--list-functions' -> '-F/--funcs'
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  4 +++
>  tools/perf/builtin-ftrace.c              | 46 ++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 821d4d334a09..4f5628445a63 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -31,6 +31,10 @@ OPTIONS
>  --verbose=::
>          Verbosity level.
>  
> +-F::
> +--funcs::
> +        List all available functions to trace.
> +
>  -p::
>  --pid=::
>  	Trace on existing process id (comma separated list).
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 048a11192b59..1ebf71ecc1a8 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -33,6 +33,7 @@ struct perf_ftrace {
>  	struct evlist		*evlist;
>  	struct target		target;
>  	const char		*tracer;
> +	bool			list_avail_functions;
>  	struct list_head	filters;
>  	struct list_head	notrace;
>  	struct list_head	graph_funcs;
> @@ -128,6 +129,46 @@ static int append_tracing_file(const char *name, const char *val)
>  	return __write_tracing_file(name, val, true);
>  }
>  
> +static int read_tracing_file_to_stdout(const char *name)
> +{
> +	char buf[4096];
> +	char *file;
> +	int fd;
> +	int ret = -1;
> +
> +	file = get_tracing_file(name);
> +	if (!file) {
> +		pr_debug("cannot get tracing file: %s\n", name);
> +		return -1;
> +	}
> +
> +	fd = open(file, O_RDONLY);
> +	if (fd < 0) {
> +		pr_debug("cannot open tracing file: %s: %s\n",
> +			 name, str_error_r(errno, buf, sizeof(buf)));
> +		goto out;
> +	}
> +
> +	/* read contents to stdout */
> +	while (true) {
> +		int n = read(fd, buf, sizeof(buf));
> +		if (n == 0)
> +			break;
> +		else if (n < 0)
> +			goto out_close;
> +
> +		if (fwrite(buf, n, 1, stdout) != 1)
> +			goto out_close;
> +	}
> +	ret = 0;
> +
> +out_close:
> +	close(fd);
> +out:
> +	put_tracing_file(file);
> +	return ret;
> +}
> +
>  static int reset_tracing_cpu(void);
>  static void reset_tracing_filters(void);
>  
> @@ -302,6 +343,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	signal(SIGCHLD, sig_handler);
>  	signal(SIGPIPE, sig_handler);
>  
> +	if (ftrace->list_avail_functions)
> +		return read_tracing_file_to_stdout("available_filter_functions");
> +
>  	if (reset_tracing_files(ftrace) < 0) {
>  		pr_err("failed to reset ftrace\n");
>  		goto out;
> @@ -487,6 +531,8 @@ int cmd_ftrace(int argc, const char **argv)
>  	const struct option ftrace_options[] = {
>  	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
>  		   "tracer to use: function_graph(default) or function"),
> +	OPT_BOOLEAN('F', "funcs", &ftrace.list_avail_functions,
> +		    "Show available functions to filter"),

A boolean? I guess this can be a first step, but why not do it like
'perf probe' and accept a patterna? Allows for less typing:

  # perf probe -h -F

    -F, --funcs <[FILTER]>
                          Show potential probe-able functions.

[root@quaco ~]#

# perf probe -F '*btf_parse*'
btf_parse_hdr
btf_parse_str_sec
btf_parse_vmlinux
#
# perf ftrace -F | grep btf_parse
btf_parse_str_sec
btf_parse_hdr
btf_parse_vmlinux
#

I'm applying this to make progress, but please consider sending a patch
to make this behave in the same way as 'perf probe'.

- Arnaldo


>  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
>  		   "trace on existing process id"),
>  	OPT_INCR('v', "verbose", &verbose,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
