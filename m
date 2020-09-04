Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2747C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC6420772
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599236841;
	bh=2RRj6nLhkvIeHTlemnBKUBFl91QqKSd7+hZ/cYCzku4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sz5DsTdX6hlTsgdpctrqErUdgwhcr/CKeBm9iNjYfpaT+ilp0BFfxeKWF1Gp27Kvo
	 Gc3x2hsK2Jns5sMlYfoRytXaxteIEqZA22naUU/G0QgORNKLectQHBa3ZyCn5/jWYP
	 Oc1q8B9Uu8/TnyqJBZi4rKrf0Eq58N3ZvrRxhYb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIDQ1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgIDQ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:27:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89611206A5;
        Fri,  4 Sep 2020 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599236839;
        bh=2RRj6nLhkvIeHTlemnBKUBFl91QqKSd7+hZ/cYCzku4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1VDsfRMWeGSpBH/8XFaVsbpZ+3AFtEdr1/GUPZZ+IOIL/jIpwdJTAsw+RVJGWyMy
         id9/cpt7oExtzYL+chJEVf/38WHpQmo9p1VFIxpLLzjBFWFhh7UJoYlAOL3OkbhrKC
         S0Mf2682u1NwyjPorGx8bJOQXKZ89gRfTsyks8kk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8779340D3D; Fri,  4 Sep 2020 13:27:16 -0300 (-03)
Date:   Fri, 4 Sep 2020 13:27:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [RESEND PATCH] perf: ftrace: Add filter support for option
 -F/--funcs
Message-ID: <20200904162716.GT3495158@kernel.org>
References: <20200904152357.6053-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904152357.6053-1-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 04, 2020 at 11:23:57PM +0800, Changbin Du escreveu:
> Same as 'perf probe -F', this patch adds filter support for the ftrace
> subcommand option '-F, --funcs <[FILTER]>'.
> 
> Here is an example that only lists functions which start with 'vfs_':
> $ sudo perf ftrace -F vfs_*
> vfs_fadvise
> vfs_fallocate
> vfs_truncate
> vfs_open
> vfs_setpos
> vfs_llseek
> vfs_readf
> vfs_writef
> ...

I'll process these now, the urgent ones were already sent to Linus, so I
will now concentrate on the new stuff for v5.10,

Thanks for working on this!

- Arnaldo
 
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  3 +-
>  tools/perf/builtin-ftrace.c              | 84 ++++++++++++++++++++++--
>  2 files changed, 80 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 78358af9a1c4..1e91121bac0f 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -33,7 +33,8 @@ OPTIONS
>  
>  -F::
>  --funcs::
> -        List all available functions to trace.
> +        List available functions to trace. It accepts a pattern to
> +        only list interested functions.
>  
>  -p::
>  --pid=::
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 1d44bc2f63d8..9366fad591dc 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -25,6 +25,7 @@
>  #include "target.h"
>  #include "cpumap.h"
>  #include "thread_map.h"
> +#include "strfilter.h"
>  #include "util/cap.h"
>  #include "util/config.h"
>  #include "util/units.h"
> @@ -36,7 +37,6 @@ struct perf_ftrace {
>  	struct evlist		*evlist;
>  	struct target		target;
>  	const char		*tracer;
> -	bool			list_avail_functions;
>  	struct list_head	filters;
>  	struct list_head	notrace;
>  	struct list_head	graph_funcs;
> @@ -181,6 +181,40 @@ static int read_tracing_file_to_stdout(const char *name)
>  	return ret;
>  }
>  
> +static int read_tracing_file_by_line(const char *name,
> +				     void (*cb)(char *str, void *arg),
> +				     void *cb_arg)
> +{
> +	char *line = NULL;
> +	size_t len = 0;
> +	char *file;
> +	FILE *fp;
> +
> +	file = get_tracing_file(name);
> +	if (!file) {
> +		pr_debug("cannot get tracing file: %s\n", name);
> +		return -1;
> +	}
> +
> +	fp = fopen(file, "r");
> +	if (fp == NULL) {
> +		pr_debug("cannot open tracing file: %s\n", name);
> +		put_tracing_file(file);
> +		return -1;
> +	}
> +
> +	while (getline(&line, &len, fp) != -1) {
> +		cb(line, cb_arg);
> +	}
> +
> +	if (line)
> +		free(line);
> +
> +	fclose(fp);
> +	put_tracing_file(file);
> +	return 0;
> +}
> +
>  static int write_tracing_file_int(const char *name, int value)
>  {
>  	char buf[16];
> @@ -557,9 +591,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	signal(SIGCHLD, sig_handler);
>  	signal(SIGPIPE, sig_handler);
>  
> -	if (ftrace->list_avail_functions)
> -		return read_tracing_file_to_stdout("available_filter_functions");
> -
>  	if (reset_tracing_files(ftrace) < 0) {
>  		pr_err("failed to reset ftrace\n");
>  		goto out;
> @@ -683,6 +714,46 @@ static int perf_ftrace_config(const char *var, const char *value, void *cb)
>  	return -1;
>  }
>  
> +static void list_function_cb(char *str, void *arg)
> +{
> +	struct strfilter *filter = (struct strfilter *)arg;
> +
> +	if (strfilter__compare(filter, str))
> +		printf("%s", str);
> +}
> +
> +static int opt_list_avail_functions(const struct option *opt __maybe_unused,
> +				    const char *str, int unset)
> +{
> +	struct strfilter *filter;
> +	const char *err = NULL;
> +	int ret;
> +
> +	if (unset || !str)
> +		return -1;
> +
> +	filter = strfilter__new(str, &err);
> +	if (!filter)
> +		return err ? -EINVAL : -ENOMEM;
> +
> +	ret = strfilter__or(filter, str, &err);
> +	if (ret == -EINVAL) {
> +		pr_err("Filter parse error at %td.\n", err - str + 1);
> +		pr_err("Source: \"%s\"\n", str);
> +		pr_err("         %*c\n", (int)(err - str + 1), '^');
> +		strfilter__delete(filter);
> +		return ret;
> +	}
> +
> +	ret = read_tracing_file_by_line("available_filter_functions",
> +					list_function_cb, filter);
> +	strfilter__delete(filter);
> +	if (ret < 0)
> +		return ret;
> +
> +	exit(0);
> +}
> +
>  static int parse_filter_func(const struct option *opt, const char *str,
>  			     int unset __maybe_unused)
>  {
> @@ -817,8 +888,9 @@ int cmd_ftrace(int argc, const char **argv)
>  	const struct option ftrace_options[] = {
>  	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
>  		   "Tracer to use: function_graph(default) or function"),
> -	OPT_BOOLEAN('F', "funcs", &ftrace.list_avail_functions,
> -		    "Show available functions to filter"),
> +	OPT_CALLBACK_DEFAULT('F', "funcs", NULL, "[FILTER]",
> +			     "Show available functions to filter",
> +			     opt_list_avail_functions, "*"),
>  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
>  		   "Trace on existing process id"),
>  	/* TODO: Add short option -t after -t/--tracer can be removed. */
> -- 
> 2.25.1
> 

-- 

- Arnaldo
