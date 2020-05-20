Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331A6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7FB20671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008715;
	bh=H+0YEqphbDH29yv2oc+57hfNzq7deHukdVPhHcYS2H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qmeeGIn1BI6zlnbEoBlfthFU91ucNHnFSiRowrIfsu3c1rfS39snliRcqeWN9Hian
	 tya5DowPsB+P5INQZRaCFPxk85uKb1h3XwTrQPofidE7HLnVRDUH2QnVyhDnPgiEB7
	 oGLNK0v3KIGQicu6eaQ7qx/JTXXAo69Xa2uDuCkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgETVFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETVFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:05:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E73A2084C;
        Wed, 20 May 2020 21:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008711;
        bh=H+0YEqphbDH29yv2oc+57hfNzq7deHukdVPhHcYS2H0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CyHD5gOqXKmwWItvVQTBZJu0iRZIw5MziGTsFkUzQ7FgBZ31wYQUh7Q+7YkQhl3Ct
         fK4nmupU0rZxp4QgGs9ltanO/UxAYQY81QaUqzBLakSQHa8IptM9bmJtElJ2uHs/5o
         DjI7jrQdI7D7wDFVhtSfatfZ3o/MJaxhXGgU8CWM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 904C840AFD; Wed, 20 May 2020 18:05:09 -0300 (-03)
Date:   Wed, 20 May 2020 18:05:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/19] perf ftrace: add support for trace option
 funcgraph-tail
Message-ID: <20200520210509.GY32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-11-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-11-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:19PM +0800, Changbin Du escreveu:
> This adds an option '--funcgraph-tail' for function graph tracer.

And I think we should make these available in a compact way, as Intel PT
has, i.e. instead of doing something like:

   --function-graph-options nosleep_time,noirqs,no_tail,long_info

We could have:

   -G ns,ni,nt,li

To save on typing, or something like that.

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 20bc14d6c5fb..2ef5d1c4b23c 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -42,6 +42,7 @@ struct perf_ftrace {
>  	bool			func_stack_trace;
>  	bool			nosleep_time;
>  	bool			nofuncgraph_irqs;
> +	bool			funcgraph_tail;
>  	bool			long_info;
>  	unsigned		tracing_thresh;
>  };
> @@ -192,6 +193,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>  	write_tracing_option_file("func_stack_trace", "0");
>  	write_tracing_option_file("sleep-time", "1");
>  	write_tracing_option_file("funcgraph-irqs", "1");
> +	write_tracing_option_file("funcgraph-tail", "0");
>  	write_tracing_option_file("funcgraph-proc", "0");
>  	write_tracing_option_file("funcgraph-abstime", "0");
>  	write_tracing_option_file("irq-info", "0");
> @@ -411,6 +413,17 @@ static int set_tracing_thresh(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_funcgraph_tail(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->funcgraph_tail)
> +		return 0;
> +
> +	if (write_tracing_option_file("funcgraph-tail", "1") < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>  	char *trace_file;
> @@ -499,6 +512,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_funcgraph_tail(ftrace) < 0) {
> +		pr_err("failed to set tracing option funcgraph-tail\n");
> +		goto out_reset;
> +	}
> +
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>  		goto out_reset;
> @@ -638,6 +656,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		    "Measure on-CPU time only (function_graph only)"),
>  	OPT_BOOLEAN(0, "nofuncgraph-irqs", &ftrace.nofuncgraph_irqs,
>  		    "Ignore functions that happen inside interrupt (function_graph only)"),
> +	OPT_BOOLEAN(0, "funcgraph-tail", &ftrace.funcgraph_tail,
> +		    "Show function tails comment (function_graph only)"),
>  	OPT_BOOLEAN('l', "long-info", &ftrace.long_info,
>  		    "Show process names, PIDs, timestamps, irq-info if available"),
>  	OPT_UINTEGER(0, "tracing-thresh", &ftrace.tracing_thresh,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
