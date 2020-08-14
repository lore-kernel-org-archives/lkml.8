Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F12AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D1D20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597408057;
	bh=qXZEi5/3wCG59wN+8zasH+1mGj1FqIwR4tCJVTq0T1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CkcZLDr0yM87qbQhovtX6HhYbAyGse7jiMCADuH/+Lg0bZcRKNdvMbJZh2L+05Er5
	 VopXUDcIjg6r5tiujk7DBwLCaLgVEdikfHogdtgm0xg6e7UOTTol3+gx2EsMUVQXTW
	 HZkdZcGfWRdTiXmoIgmk2kaODRkuiRvFpkuWC3C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgHNM1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgHNM1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:27:35 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B331820866;
        Fri, 14 Aug 2020 12:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408054;
        bh=qXZEi5/3wCG59wN+8zasH+1mGj1FqIwR4tCJVTq0T1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0IYN8ll00sX+S2nw7k5gdLe5nBNtcYeukmpiG2fA8GmZ7FUtYbBVUhMq+ZLrtOBJ
         jM6+md8o5FjWeO7sZwNXcdVCJ5kqHByoDN+l/Yb84RLAaIJ2iKHl2alVduNFVaSW5J
         QTgWTwIGLrxXR0/Io99QwtMYzrnbOPfNAX9ILpGs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F352440D3D; Fri, 14 Aug 2020 09:27:32 -0300 (-03)
Date:   Fri, 14 Aug 2020 09:27:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/18] perf ftrace: add support for trace option
 funcgraph-irqs
Message-ID: <20200814122732.GA13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-11-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808023141.14227-11-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 08, 2020 at 10:31:33AM +0800, Changbin Du escreveu:
> This adds an option '--graph-opts noirqs' to filter out functions executed
> in irq context.

ditto, no example provided, please consider adding an example +
explanation to perf-ftrace.txt.
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> ---
> v2: option name '--nofuncgraph-irqs' -> '--graph-noirqs'.
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  1 +
>  tools/perf/builtin-ftrace.c              | 21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 3380a2e2c9ad..fca55ac55ff3 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -104,6 +104,7 @@ OPTIONS
>  --graph-opts::
>  	List of options allowed to set:
>  	  nosleep-time - Measure on-CPU time only for function_graph tracer.
> +	  noirqs       - Ignore functions that happen inside interrupt.
>  
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 47d63bba6a48..b4c821be4fb5 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -45,6 +45,7 @@ struct perf_ftrace {
>  	bool			inherit;
>  	int			func_stack_trace;
>  	int			graph_nosleep_time;
> +	int			graph_noirqs;
>  };
>  
>  struct filter_entry {
> @@ -207,6 +208,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>  	write_tracing_option_file("function-fork", "0");
>  	write_tracing_option_file("func_stack_trace", "0");
>  	write_tracing_option_file("sleep-time", "1");
> +	write_tracing_option_file("funcgraph-irqs", "1");
>  }
>  
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> @@ -399,6 +401,17 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->graph_noirqs)
> +		return 0;
> +
> +	if (write_tracing_option_file("funcgraph-irqs", "0") < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>  	char *trace_file;
> @@ -483,6 +496,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_funcgraph_irqs(ftrace) < 0) {
> +		pr_err("failed to set tracing option funcgraph-irqs\n");
> +		goto out_reset;
> +	}
> +
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>  		goto out_reset;
> @@ -662,6 +680,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
>  	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
>  	struct sublevel_option graph_tracer_opts[] = {
>  		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
> +		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
>  		{ .name = NULL, }
>  	};
>  
> @@ -733,7 +752,7 @@ int cmd_ftrace(int argc, const char **argv)
>  	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
>  		    "Max depth for function graph tracer"),
>  	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> -		     "graph tracer options, available options: nosleep-time",
> +		     "graph tracer options, available options: nosleep-time,noirqs",
>  		     parse_graph_tracer_opts),
>  	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
>  		     "size of per cpu buffer", parse_buffer_size),
> -- 
> 2.25.1
> 

-- 

- Arnaldo
