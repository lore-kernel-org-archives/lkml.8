Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C03C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816A2214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597408006;
	bh=GW/SFrYPF//O+vnSjDpnSBDiFUl5S0m9zp+KwyLcYGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cSVb8tSO670PzxEpprbWI3EwW8TUVxbKsx/f1tF72bkOh/JnmdjiV0P/0jBHwcAwW
	 kRiy7uF929+4RavbSp/IQe7MYJs/vIT0PucHVU69np3jnEFwlk/LQKdghwgXIBwklL
	 mvYdGla9toJ/pTH4IMulT/9lPuQSUSP5TyK5pnlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgHNM0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbgHNM0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:26:44 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A55920866;
        Fri, 14 Aug 2020 12:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408003;
        bh=GW/SFrYPF//O+vnSjDpnSBDiFUl5S0m9zp+KwyLcYGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkCb9UQNqRQWP1MHlzwNZDpsQ4BqrNt5F/NLF4jLKTtNI+2so7hMq3YDuv6tCW1SF
         3y/oB9Yhvmd3lsD97gzCfim/u0AbaCXUOdOdYhoMn3YfKxxQCwfbRBT2RQ7XJaPS8A
         BFU3jMGH7edOoOwJYOJ7xuDcELclf5lJ3IuTyTbg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA05940D3D; Fri, 14 Aug 2020 09:26:40 -0300 (-03)
Date:   Fri, 14 Aug 2020 09:26:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/18] perf ftrace: add support for trace option
 sleep-time
Message-ID: <20200814122640.GZ13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-10-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808023141.14227-10-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 08, 2020 at 10:31:32AM +0800, Changbin Du escreveu:
> This adds an option '--graph-opts nosleep-time' which allow us
> only to measure on-CPU time. This option is function_graph tracer
> only.

Here an example showing its usage would be great. Even better, on
perf-ftrace.txt, so that people can see it in action and learn about its
output and usefullness.

Applied,

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> ---
> v3: switch to uniform option --graph-opts.
> v2: option name '--nosleep-time' -> '--graph-nosleep-time'.
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  4 +++
>  tools/perf/builtin-ftrace.c              | 41 ++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 8f08ad0992c2..3380a2e2c9ad 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -101,6 +101,10 @@ OPTIONS
>  --graph-depth=::
>  	Set max depth for function graph tracer to follow
>  
> +--graph-opts::
> +	List of options allowed to set:
> +	  nosleep-time - Measure on-CPU time only for function_graph tracer.
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-trace[1]
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 469b89748c42..47d63bba6a48 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -44,6 +44,7 @@ struct perf_ftrace {
>  	unsigned long		percpu_buffer_size;
>  	bool			inherit;
>  	int			func_stack_trace;
> +	int			graph_nosleep_time;
>  };
>  
>  struct filter_entry {
> @@ -205,6 +206,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>  {
>  	write_tracing_option_file("function-fork", "0");
>  	write_tracing_option_file("func_stack_trace", "0");
> +	write_tracing_option_file("sleep-time", "1");
>  }
>  
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> @@ -386,6 +388,17 @@ static int set_tracing_trace_inherit(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->graph_nosleep_time)
> +		return 0;
> +
> +	if (write_tracing_option_file("sleep-time", "0") < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>  	char *trace_file;
> @@ -465,6 +478,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_sleep_time(ftrace) < 0) {
> +		pr_err("failed to set tracing option sleep-time\n");
> +		goto out_reset;
> +	}
> +
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>  		goto out_reset;
> @@ -637,6 +655,26 @@ static int parse_func_tracer_opts(const struct option *opt,
>  	return 0;
>  }
>  
> +static int parse_graph_tracer_opts(const struct option *opt,
> +				  const char *str, int unset)
> +{
> +	int ret;
> +	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
> +	struct sublevel_option graph_tracer_opts[] = {
> +		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
> +		{ .name = NULL, }
> +	};
> +
> +	if (unset)
> +		return 0;
> +
> +	ret = perf_parse_sublevel_options(str, graph_tracer_opts);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static void select_tracer(struct perf_ftrace *ftrace)
>  {
>  	bool graph = !list_empty(&ftrace->graph_funcs) ||
> @@ -694,6 +732,9 @@ int cmd_ftrace(int argc, const char **argv)
>  		     "Set nograph filter on given functions", parse_filter_func),
>  	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
>  		    "Max depth for function graph tracer"),
> +	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> +		     "graph tracer options, available options: nosleep-time",
> +		     parse_graph_tracer_opts),
>  	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
>  		     "size of per cpu buffer", parse_buffer_size),
>  	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
