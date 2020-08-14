Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AFFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514B220866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597408114;
	bh=P7av6s6abXr/7wGMfslLn8S1fP4ii34kLGB77dbKxL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D5nVuqazUtsNGe0SYp3nMIMQe2VWsL6HjurNk9fGHuKGXI/tNN+lo7R850DJVzsbv
	 rufUqTF/tTrRNesmoq+KjNoQstPMi6UGDiJGyLG+CrYydrjPOcLZhIZu/+96DcKY9Z
	 jy4jc7A6bNK82kXHdqEEfMXGpux8eTJ8SFoEtZlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgHNM21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgHNM2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:28:11 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3878E20866;
        Fri, 14 Aug 2020 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408090;
        bh=P7av6s6abXr/7wGMfslLn8S1fP4ii34kLGB77dbKxL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X36Byv/QPmZ8n9I/VjyV2N334zGlawYGTDj76Y+bG1WkvGfn1zR4BvxvcUjfqaeuB
         qKOCOipvUmpScTWFVPuU+AFaev57FVpYJDc+AGR6tDN7nt8Tj6gRf/w3KL5/bcOX/c
         o4axnltwC0ZJgIsEGcHTqfeTjdJEStQBZgtwAKN0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 81AE040D3D; Fri, 14 Aug 2020 09:28:07 -0300 (-03)
Date:   Fri, 14 Aug 2020 09:28:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/18] perf ftrace: add support for tracing option
 'irq-info'
Message-ID: <20200814122807.GB13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-12-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808023141.14227-12-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 08, 2020 at 10:31:34AM +0800, Changbin Du escreveu:
> This adds support to display irq context info for function tracer. To do
> this, just specify a '--func-opts irq-info' option.

Applied, ditto about adding an example to perf-ftrace.txt
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  1 +
>  tools/perf/builtin-ftrace.c              | 21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index fca55ac55ff3..37ea3ea97922 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -79,6 +79,7 @@ OPTIONS
>  --func-opts::
>  	List of options allowed to set:
>  	  call-graph - Display kernel stack trace for function tracer.
> +	  irq-info   - Display irq context info for function tracer.
>  
>  -G::
>  --graph-funcs=::
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index b4c821be4fb5..d1241febe143 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -44,6 +44,7 @@ struct perf_ftrace {
>  	unsigned long		percpu_buffer_size;
>  	bool			inherit;
>  	int			func_stack_trace;
> +	int			func_irq_info;
>  	int			graph_nosleep_time;
>  	int			graph_noirqs;
>  };
> @@ -209,6 +210,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>  	write_tracing_option_file("func_stack_trace", "0");
>  	write_tracing_option_file("sleep-time", "1");
>  	write_tracing_option_file("funcgraph-irqs", "1");
> +	write_tracing_option_file("irq-info", "0");
>  }
>  
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> @@ -296,6 +298,17 @@ static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_func_irqinfo(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->func_irq_info)
> +		return 0;
> +
> +	if (write_tracing_option_file("irq-info", "1") < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int reset_tracing_cpu(void)
>  {
>  	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
> @@ -471,6 +484,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_func_irqinfo(ftrace) < 0) {
> +		pr_err("failed to set tracing option irq-info\n");
> +		goto out_reset;
> +	}
> +
>  	if (set_tracing_filters(ftrace) < 0) {
>  		pr_err("failed to set tracing filters\n");
>  		goto out_reset;
> @@ -660,6 +678,7 @@ static int parse_func_tracer_opts(const struct option *opt,
>  	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
>  	struct sublevel_option func_tracer_opts[] = {
>  		{ .name = "call-graph",	.value_ptr = &ftrace->func_stack_trace },
> +		{ .name = "irq-info",	.value_ptr = &ftrace->func_irq_info },
>  		{ .name = NULL, }
>  	};
>  
> @@ -742,7 +761,7 @@ int cmd_ftrace(int argc, const char **argv)
>  	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
>  		     "do not trace given functions", parse_filter_func),
>  	OPT_CALLBACK(0, "func-opts", &ftrace, "options",
> -		     "function tracer options, available options: call-graph",
> +		     "function tracer options, available options: call-graph,irq-info",
>  		     parse_func_tracer_opts),
>  	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
>  		     "trace given functions using function_graph tracer",
> -- 
> 2.25.1
> 

-- 

- Arnaldo
