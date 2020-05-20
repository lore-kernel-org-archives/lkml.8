Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A441C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E510E20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008866;
	bh=CtGRHuKKEnDSvWHoHfzqUcrsu2KIrLcF0btXPapMeP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IXXyf/4s1+Mq9AQCQRbdQpe3j+AxWBIvr2ff21l05/ttOgWHTU/UoWpDxpG29BLru
	 lzdzxx2mwsV22sV+4hCgJUBfAm2FdaeJNjkYLeerJK8dF/zIiwQ1eBOM1UCHrS20d7
	 jYMc6v5t7INHlV8qflmaGlnwznxqsoe+x1Rgryb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgETVHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETVHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:07:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E330C207E8;
        Wed, 20 May 2020 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008864;
        bh=CtGRHuKKEnDSvWHoHfzqUcrsu2KIrLcF0btXPapMeP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F87wIk/dB6+dhyT1DY3Gb7YCK7vp62MVuNJo34F3+iDjA/v9CYJh9FbFUKUKBCsUM
         MhGCElWMn5/KroWVA3UkePMpfdfS5+O/wS1WqvgQwjFMOVNPTj323uL0gd2RuAzC/Y
         bAjceJjT+51WfpT/7rSgpgIpJge7t0WshohGWfE0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFEEF40AFD; Wed, 20 May 2020 18:07:41 -0300 (-03)
Date:   Wed, 20 May 2020 18:07:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/19] perf ftrace: add option '-u/--userstacktrace' to
 show userspace stacktrace
Message-ID: <20200520210741.GZ32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-12-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-12-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:20PM +0800, Changbin Du escreveu:
> This adds an option ''-u/--userstacktrace' for function tracer to display
> userspace back trace.

Probably we should have this as a term, an option to --call-graph?

For --call-graph the way to suppress this is to ask for the event to be
in the kernel only, i.e. something like:

	perf record -e cycles:k --call-graph

So perhaps we should have something like:

	perf ftrace --call-graph 

With some default, possibly a bit different than the other perf tools,
just including the kernel, and accepting:

	perf ftrace --call-graph
	perf ftrace --call-graph k
	perf ftrace --call-graph u
	perf ftrace --call-graph uk

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 2ef5d1c4b23c..ab76ba66bd9e 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -40,6 +40,7 @@ struct perf_ftrace {
>  	struct list_head	nograph_funcs;
>  	int			graph_depth;
>  	bool			func_stack_trace;
> +	bool			userstacktrace;
>  	bool			nosleep_time;
>  	bool			nofuncgraph_irqs;
>  	bool			funcgraph_tail;
> @@ -197,6 +198,8 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>  	write_tracing_option_file("funcgraph-proc", "0");
>  	write_tracing_option_file("funcgraph-abstime", "0");
>  	write_tracing_option_file("irq-info", "0");
> +	write_tracing_option_file("userstacktrace", "0");
> +	write_tracing_option_file("sym-userobj", "0");
>  }
>  
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> @@ -287,6 +290,20 @@ static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_userstacktrace(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->userstacktrace)
> +		return 0;
> +
> +	if (write_tracing_option_file("userstacktrace", "1") < 0)
> +		return -1;
> +
> +	if (write_tracing_option_file("sym-userobj", "1") < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int reset_tracing_cpu(void)
>  {
>  	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
> @@ -482,6 +499,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_userstacktrace(ftrace) < 0) {
> +		pr_err("failed to set tracing option userstacktrace\n");
> +		goto out_reset;
> +	}
> +
>  	if (set_tracing_filters(ftrace) < 0) {
>  		pr_err("failed to set tracing filters\n");
>  		goto out_reset;
> @@ -644,6 +666,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		     "do not trace given functions", parse_filter_func),
>  	OPT_BOOLEAN('s', "func-stack-trace", &ftrace.func_stack_trace,
>  		    "Show kernel stack trace for function tracer"),
> +	OPT_BOOLEAN('u', "userstacktrace", &ftrace.userstacktrace,
> +		    "Show stacktrace of the current user space thread"),
>  	OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
>  		     "Set graph filter on given functions (imply to use function_graph tracer)",
>  		     parse_filter_func, "*"),
> -- 
> 2.25.1
> 

-- 

- Arnaldo
