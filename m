Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507B0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C30920734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594997562;
	bh=2od25Q1VdQOA69Zrte8drsEjwehuDeHLS7JyAaKmumc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w8HDYAgJLcardNCKinCbPwDds5lrWynfX/E6JQinRpOCCGio4NAHWIzE1RKAwGJmC
	 A+rfZcL8AGKb4ffd5ML4kuczPpEbVYqH7QVaILgD36vqzq01wXonukhGUjvwLxgU0A
	 ZqXaZD389yEp6XdYObsoQKQkb601bnj1CRvsz9zU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGQOwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgGQOwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:52:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 168422070E;
        Fri, 17 Jul 2020 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594997559;
        bh=2od25Q1VdQOA69Zrte8drsEjwehuDeHLS7JyAaKmumc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=05gnnOnNZ9i2ge2z54hbQaoELtKOXzoXJQEuxtV6+SKBLuwqYqqEQPa696RHzOnZu
         ukCWvZweXtnko3BtRp2OctMgF1D0dmgvYS7ho5donabouQVFgvHpmatrQrreLnMrOk
         BJYRGPxA7Z708A16+8gh+MEgoaoaPeOmT4S6r1aw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EA3D540482; Fri, 17 Jul 2020 11:52:36 -0300 (-03)
Date:   Fri, 17 Jul 2020 11:52:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/17] perf ftrace: add option '-F/--funcs' to list
 available functions
Message-ID: <20200717145236.GA712240@kernel.org>
References: <20200717143628.47721-1-changbin.du@gmail.com>
 <20200717143628.47721-3-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717143628.47721-3-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 10:36:13PM +0800, Changbin Du escreveu:
> This adds an option '-F/--funcs' to list all available functions to trace,
> which is read from tracing file 'available_filter_functions'.

I'll apply and add a comment stating that this is the same workflow as
for 'perf probe', i.e. stress that the value in 'perf ftrace' as opposed
to use 'trace-cmd' or plain using the debugfs/tracefs interface is to
have a consistent set of options and procedures accross perf and ftrace,
one that allows users to go from:

perf trace --pid 1234

to:

perf ftrace --pid 1234

to:

perf stat --pid 1234

to:

perf top --pid 1234

to:

perf record --pid 1234

to:

perf script --pid 1234

etc

and get different views, for live or postmortem analysis.

- Arnaldo
 
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
> index 952e46669168..d79560dea19f 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -30,6 +30,10 @@ OPTIONS
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
> index 5f53da87040d..3c0e60fdfe0f 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -32,6 +32,7 @@ struct perf_ftrace {
>  	struct evlist		*evlist;
>  	struct target		target;
>  	const char		*tracer;
> +	bool			list_avail_functions;
>  	struct list_head	filters;
>  	struct list_head	notrace;
>  	struct list_head	graph_funcs;
> @@ -127,6 +128,46 @@ static int append_tracing_file(const char *name, const char *val)
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
> @@ -301,6 +342,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	signal(SIGCHLD, sig_handler);
>  	signal(SIGPIPE, sig_handler);
>  
> +	if (ftrace->list_avail_functions)
> +		return read_tracing_file_to_stdout("available_filter_functions");
> +
>  	if (reset_tracing_files(ftrace) < 0) {
>  		pr_err("failed to reset ftrace\n");
>  		goto out;
> @@ -470,6 +514,8 @@ int cmd_ftrace(int argc, const char **argv)
>  	const struct option ftrace_options[] = {
>  	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
>  		   "tracer to use: function or function_graph (This option is deprecated)"),
> +	OPT_BOOLEAN('F', "funcs", &ftrace.list_avail_functions,
> +		    "Show available functions to filter"),
>  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
>  		   "trace on existing process id"),
>  	OPT_INCR('v', "verbose", &verbose,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
