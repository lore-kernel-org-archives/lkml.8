Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0023AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9BB208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596545485;
	bh=fd/ZT/LKFLc2yiJPmXJ8/NFEKIlg1LH8tpVAV7/Rfkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RhxSYbKBUTEOuau1r2+sMay8yJxDyJJz8KBxR0cPgQtPUYE8bPyejsMDytJeBZSxO
	 8I4jvw7UcBpBNN8VCi+OPb1/U0RpIwRYLpsVo4ji7vFiYkcxegmU2Jx2oeGMIEZBc/
	 cpfuLiZqFLBMZxixA3TZSA6MyY7RHRVLweXS94ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgHDMvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgHDMvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:51:23 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.178.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44C32075A;
        Tue,  4 Aug 2020 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596545482;
        bh=fd/ZT/LKFLc2yiJPmXJ8/NFEKIlg1LH8tpVAV7/Rfkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnb7D66uT0gEMvhQQujHvSZfgLZ7BbJoQ/BcMn5Tor+HpS15jk7Hez+qNhzv1O+LD
         nrHLO8MU8n8FWBiGZi88XRYkNeF0Kx2OGMxaYuliRo4KEtMEuUDOKaHNwf74y+f/x+
         LHGdGuXjUaoyy5PH2JUjf7ovilsIA5EaXUU8v8cQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF62B40C7C; Tue,  4 Aug 2020 09:51:15 -0300 (-03)
Date:   Tue, 4 Aug 2020 09:51:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/18] perf ftrace: select function/function_graph
 tracer automatically
Message-ID: <20200804125115.GF3440834@kernel.org>
References: <20200718064826.9865-1-changbin.du@gmail.com>
 <20200718064826.9865-2-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718064826.9865-2-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jul 18, 2020 at 02:48:09PM +0800, Changbin Du escreveu:
> The '-g/-G' options have already implied function_graph tracer should be
> used instead of function tracer. So the extra option '--tracer' can be
> killed.
> 
> This patch changes the behavior as below:
>   - By default, function tracer is used.
>   - If '-g' or '-G' option is on, then function_graph tracer is used.
>   - The perf configuration item 'ftrace.tracer' is marked as deprecated.
>   - The option '--tracer' is marked as deprecated.

You should try to be more granular, for instance, I think the decision
to change the default is questionable, but could be acceptable.

But why deprecate the perf configuration for the default tracer?

Say people who already use 'perf ftrace ls' go and use with this patch
and see that it changed the default from the function_graph tracer to
the function tracer and disagree with you, they want the default to be
the function graph tracer, know that there is (or there was) a
ftrace.tracer in ~/.prefconfig, and then try that, only to find out that
it is not possible, frustrating :-\

So can we please remove this deprecation of ftrace.tracer so that people
used to how it was can get that behaviour back?

I'll look at the other patches so as to provide comments on all of
them and to speed things up I may end up removing this deprecation of
ftrace.tracer and apply the rest, we can always revisit parts that I
remove.

- Arnaldo

> Here are some examples.
> 
> This will start tracing all functions using function tracer:
>   $ sudo perf ftrace
> 
> This will trace all functions using function graph tracer:
>   $ sudo perf ftrace -G '*'
> 
> This will trace function vfs_read using function graph tracer:
>   $ sudo perf ftrace -G vfs_read
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> ---
> v3: remove default '*' for -G/-T.
> ---
>  tools/perf/Documentation/perf-config.txt |  5 -----
>  tools/perf/Documentation/perf-ftrace.txt |  2 +-
>  tools/perf/builtin-ftrace.c              | 15 ++++++++++-----
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index c7d3df5798e2..a25fee7de3b2 100644
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
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index b80c84307dc9..952e46669168 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -24,7 +24,7 @@ OPTIONS
>  
>  -t::
>  --tracer=::
> -	Tracer to use: function_graph or function.
> +	Tracer to use: function_graph or function. This option is deprecated.
>  
>  -v::
>  --verbose=::
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 2bfc1b0db536..5f53da87040d 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -27,7 +27,6 @@
>  #include "util/cap.h"
>  #include "util/config.h"
>  
> -#define DEFAULT_TRACER  "function_graph"
>  
>  struct perf_ftrace {
>  	struct evlist		*evlist;
> @@ -419,6 +418,7 @@ static int perf_ftrace_config(const char *var, const char *value, void *cb)
>  	if (strcmp(var, "ftrace.tracer"))
>  		return -1;
>  
> +	pr_warning("Configuration ftrace.tracer is deprecated\n");
>  	if (!strcmp(value, "function_graph") ||
>  	    !strcmp(value, "function")) {
>  		ftrace->tracer = value;
> @@ -459,7 +459,7 @@ int cmd_ftrace(int argc, const char **argv)
>  {
>  	int ret;
>  	struct perf_ftrace ftrace = {
> -		.tracer = DEFAULT_TRACER,
> +		.tracer = "function",
>  		.target = { .uid = UINT_MAX, },
>  	};
>  	const char * const ftrace_usage[] = {
> @@ -469,7 +469,7 @@ int cmd_ftrace(int argc, const char **argv)
>  	};
>  	const struct option ftrace_options[] = {
>  	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
> -		   "tracer to use: function_graph(default) or function"),
> +		   "tracer to use: function or function_graph (This option is deprecated)"),
>  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
>  		   "trace on existing process id"),
>  	OPT_INCR('v', "verbose", &verbose,
> @@ -479,11 +479,13 @@ int cmd_ftrace(int argc, const char **argv)
>  	OPT_STRING('C', "cpu", &ftrace.target.cpu_list, "cpu",
>  		    "list of cpus to monitor"),
>  	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
> -		     "trace given functions only", parse_filter_func),
> +		     "trace given functions using function tracer",
> +		     parse_filter_func),
>  	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
>  		     "do not trace given functions", parse_filter_func),
>  	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
> -		     "Set graph filter on given functions", parse_filter_func),
> +		     "trace given functions using function_graph tracer",
> +		     parse_filter_func),
>  	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
>  		     "Set nograph filter on given functions", parse_filter_func),
>  	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
> @@ -505,6 +507,9 @@ int cmd_ftrace(int argc, const char **argv)
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
