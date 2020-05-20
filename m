Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED11C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC4620829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008185;
	bh=00CJGy9X6j9vzKS1uaTCoAO2CBsQhZHYbhLE4K2mNC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pejn/9FuGGX1kEj/XQRU/Pz73sWoMrcQkrokwgLZnNe3c8gXuZxutfFnQ9qL5N/5e
	 i7KaH2lPGPueDrvkyqntXks6e+sMXr3ICa509nH0FrzqIXc9iFvCuZXuGE9Uy10VCO
	 ds5d8GRjhP2DWO8PnDd+tUeYhJFnloQTGdDz+ouw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgETU4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgETU4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:56:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D99B20758;
        Wed, 20 May 2020 20:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008183;
        bh=00CJGy9X6j9vzKS1uaTCoAO2CBsQhZHYbhLE4K2mNC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFEVFMyUAAXmlc6FkKD5V5ynfeXhzG9Y4LOP9Z4nCdo7L5wxfZ49IaD2LQKAxSFb+
         jP/3r+DZUx1FEha2ogJDGBtssInQdnN8Y/68rJRN2WDTerIQVaeQhEbO0OlDeMF+Gv
         Frzq+k4Fe8oTHO62+i43dXkxeimHfaZgcGLP65mo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38E9240AFD; Wed, 20 May 2020 17:56:21 -0300 (-03)
Date:   Wed, 20 May 2020 17:56:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/19] perf ftrace: select function/function_graph tracer
 automatically
Message-ID: <20200520205621.GQ32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-4-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-4-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:12PM +0800, Changbin Du escreveu:
> The '-g/-G' options have already implied function_graph tracer should be
> used instead of function tracer. So the extra option '--tracer' can be
> killed.

Well, since it is there, lets not remove it, you can even add a
"Deprecated" message to it and then after some time, remove it.

Also, in this area, -g is used for asking for callchains in other perf
tools, so its a candidate for a change in behaviour, as well with some
deprecation warning for a while, using --call-graph for a while, etc.

I.e. we want it to have a similar set of options as the other perf
tools, so that switching from, say:

  # perf trace <options> workload

To:

  # perf ftrace <options> workload

Would provide a similar experience, only that the first is limited to
syscalls, the other to kernel functions.

- Arnaldo

 
> This patch changes the behavior as below:
>   - By default, function tracer is used.
>   - If '-g' or '-G' option is on, then function_graph tracer is used.
>   - The perf configuration item 'ftrace.tracer' is removed.
>   - The default filter for -G is to trace all functions.
> 
> Here are some examples.
> 
> This will start tracing all functions using function tracer:
>   $ sudo perf ftrace
> 
> This will trace all functions using function graph tracer:
>   $ sudo perf ftrace -G
> 
> This will trace function vfs_read using function graph tracer:
>   $ sudo perf ftrace -G vfs_read
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/perf-config.txt |  5 ---
>  tools/perf/builtin-ftrace.c              | 39 ++++++------------------
>  2 files changed, 9 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index f16d8a71d3f5..fad6c48ed76a 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -612,11 +612,6 @@ trace.*::
>  		"libbeauty", the default, to use the same argument beautifiers used in the
>  		strace-like sys_enter+sys_exit lines.
>  
> -ftrace.*::
> -	ftrace.tracer::
> -		Can be used to select the default tracer. Possible values are
> -		'function' and 'function_graph'.
> -
>  llvm.*::
>  	llvm.clang-path::
>  		Path to clang. If omit, search it from $PATH.
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 5584f8dec25d..57e656c35d28 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -27,7 +27,7 @@
>  #include "util/cap.h"
>  #include "util/config.h"
>  
> -#define DEFAULT_TRACER  "function_graph"
> +#define DEFAULT_TRACER  "function"
>  
>  struct perf_ftrace {
>  	struct evlist		*evlist;
> @@ -408,26 +408,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	return (done && !workload_exec_errno) ? 0 : -1;
>  }
>  
> -static int perf_ftrace_config(const char *var, const char *value, void *cb)
> -{
> -	struct perf_ftrace *ftrace = cb;
> -
> -	if (!strstarts(var, "ftrace."))
> -		return 0;
> -
> -	if (strcmp(var, "ftrace.tracer"))
> -		return -1;
> -
> -	if (!strcmp(value, "function_graph") ||
> -	    !strcmp(value, "function")) {
> -		ftrace->tracer = value;
> -		return 0;
> -	}
> -
> -	pr_err("Please select \"function_graph\" (default) or \"function\"\n");
> -	return -1;
> -}
> -
>  static int parse_filter_func(const struct option *opt, const char *str,
>  			     int unset __maybe_unused)
>  {
> @@ -467,8 +447,6 @@ int cmd_ftrace(int argc, const char **argv)
>  		NULL
>  	};
>  	const struct option ftrace_options[] = {
> -	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
> -		   "tracer to use: function_graph(default) or function"),
>  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
>  		   "trace on existing process id"),
>  	OPT_INCR('v', "verbose", &verbose,
> @@ -481,10 +459,12 @@ int cmd_ftrace(int argc, const char **argv)
>  		     "trace given functions only", parse_filter_func),
>  	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
>  		     "do not trace given functions", parse_filter_func),
> -	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
> -		     "Set graph filter on given functions", parse_filter_func),
> +	OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
> +		     "Set graph filter on given functions (imply to use function_graph tracer)",
> +		     parse_filter_func, "*"),
>  	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
> -		     "Set nograph filter on given functions", parse_filter_func),
> +		     "Set nograph filter on given functions (imply to use function_graph tracer)",
> +		     parse_filter_func),
>  	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
>  		    "Max depth for function graph tracer"),
>  	OPT_END()
> @@ -495,15 +475,14 @@ int cmd_ftrace(int argc, const char **argv)
>  	INIT_LIST_HEAD(&ftrace.graph_funcs);
>  	INIT_LIST_HEAD(&ftrace.nograph_funcs);
>  
> -	ret = perf_config(perf_ftrace_config, &ftrace);
> -	if (ret < 0)
> -		return -1;
> -
>  	argc = parse_options(argc, argv, ftrace_options, ftrace_usage,
>  			    PARSE_OPT_STOP_AT_NON_OPTION);
>  	if (!argc && target__none(&ftrace.target))
>  		ftrace.target.system_wide = true;
>  
> +	if (!list_empty(&ftrace.graph_funcs) || !list_empty(&ftrace.nograph_funcs))
> +		ftrace.tracer = "function_graph";
> +
>  	ret = target__validate(&ftrace.target);
>  	if (ret) {
>  		char errbuf[512];
> -- 
> 2.25.1
> 

-- 

- Arnaldo
