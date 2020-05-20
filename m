Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A23C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283E12084C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008485;
	bh=DXBohV2cwrznWunItONX0BOZAXRxsaxcI8aYj2nW/Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rhtb09ZgNMU//yAfDq6yWuU8mDzufgNdN10HkdF3guTa/c9Br6RTyWySg1+UgtLO5
	 uytIqS/hxPqEjrFwJ7Ily9qHxHjGD03qFcxlNdfs13gk97tUgZdRlrJDpbZxrZfDsq
	 FkdJcijMsGRtIc9YkeJixaX+WjMQZs+6nbjLr1L8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgETVBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgETVBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:01:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE59C20829;
        Wed, 20 May 2020 21:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008482;
        bh=DXBohV2cwrznWunItONX0BOZAXRxsaxcI8aYj2nW/Io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eR++PXJopPFqFOEUk8v15A8bB4GjT4YG0dNnx7uPaq6UrlST1IYf8owl4TRao9PTO
         2mxEXBUjPGDFoSwul4MC5zrnIl0CMTEuZbvZwFE2BP/cg8eZ0Lv3mY3TIclw5O443T
         u7uuvWf8xUWCW14ftKidrWF+5C+hwonZjSDusmmI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C701840AFD; Wed, 20 May 2020 18:01:20 -0300 (-03)
Date:   Wed, 20 May 2020 18:01:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/19] perf ftrace: add support for trace option
 funcgraph-irqs
Message-ID: <20200520210120.GU32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-8-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-8-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:16PM +0800, Changbin Du escreveu:
> This adds an option '--nofuncgraph-irqs' to filter out functions executed
> in irq context.

Ditto
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index d3fcf3b0b792..b16600a16efa 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -41,6 +41,7 @@ struct perf_ftrace {
>  	int			graph_depth;
>  	bool			func_stack_trace;
>  	bool			nosleep_time;
> +	bool			nofuncgraph_irqs;
>  };
>  
>  struct filter_entry {
> @@ -188,6 +189,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>  {
>  	write_tracing_option_file("func_stack_trace", "0");
>  	write_tracing_option_file("sleep-time", "1");
> +	write_tracing_option_file("funcgraph-irqs", "1");
>  }
>  
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> @@ -358,6 +360,17 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->nofuncgraph_irqs)
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
> @@ -431,6 +444,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
> @@ -568,6 +586,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		    "Max depth for function graph tracer"),
>  	OPT_BOOLEAN(0, "nosleep-time", &ftrace.nosleep_time,
>  		    "Measure on-CPU time only (function_graph only)"),
> +	OPT_BOOLEAN(0, "nofuncgraph-irqs", &ftrace.nofuncgraph_irqs,
> +		    "Ignore functions that happen inside interrupt (function_graph only)"),
>  	OPT_END()
>  	};
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
