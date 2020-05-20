Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164BFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC1320874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590009267;
	bh=ogmmMv3wWB+wC0mzCxOQhYH+rGKcs7Y7AtmDBuRdh5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2qzb+Im9B7v2627Xi5sBwAXKCGZ8t3QS7c1IYg9DKLwv9pdKqLXj+HHwdGihM9++9
	 ijKPovA4SqSzYuF3Q2ywIwbzEAYnHkThX1X0n0px3NFH99AgiozyqO5jHBEKhtFKij
	 3TnqujFcGU5btYjVD9alHb11veh0YUkYQyLTuzZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgETVO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgETVO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:14:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA0F720829;
        Wed, 20 May 2020 21:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590009266;
        bh=ogmmMv3wWB+wC0mzCxOQhYH+rGKcs7Y7AtmDBuRdh5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxeLBoQWsqIdUNHbCkMdKCXeGqKqyUvl5ylLVWObfeDkbRUc13AKHtWX8PjhaOUdL
         DRWBa07gfKg0JKpDP6oDmwusqAMvESN5B9200voKXuGzmuHho0uDfVSiHwPlMGPUA2
         YCUTAXud3T7RUdkhi7u+KQMNvX2cM7hPUNPC2pBA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C8DE140AFD; Wed, 20 May 2020 18:14:23 -0300 (-03)
Date:   Wed, 20 May 2020 18:14:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] perf ftrace: add option --latency-format to
 display more info about delay
Message-ID: <20200520211423.GB3898@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-19-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-19-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:27PM +0800, Changbin Du escreveu:
> This is for the function graph tracer to display more info about latency.
> The execution context is shown in this case.

Ok, another --function-graph-opts entry, maybe you can just make -G
receive optional args.

- Arnaldo
 
> $ sudo perf ftrace -G --latency-format
> \# tracer: function_graph
> \#
>  1)  .... |   0.992 us    |  mutex_unlock();
>  1)  .... |   1.404 us    |  __fsnotify_parent();
>  1)  .... |   1.023 us    |  fsnotify();
>  1)  .... |   0.335 us    |  __sb_end_write();
>  1)  d... |   0.439 us    |  fpregs_assert_state_consistent();
>  1)  d... |               |  do_syscall_64() {
>  1)  .... |               |    __x64_sys_close() {
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index d376b37c53fc..fd8e2f305136 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -44,6 +44,7 @@ struct perf_ftrace {
>  	bool			nosleep_time;
>  	bool			nofuncgraph_irqs;
>  	bool			funcgraph_tail;
> +	bool			latency_format;
>  	bool			long_info;
>  	unsigned		tracing_thresh;
>  	bool			trace_children;
> @@ -217,6 +218,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>  	write_tracing_option_file("sleep-time", "1");
>  	write_tracing_option_file("funcgraph-irqs", "1");
>  	write_tracing_option_file("funcgraph-tail", "0");
> +	write_tracing_option_file("latency-format", "0");
>  	write_tracing_option_file("funcgraph-proc", "0");
>  	write_tracing_option_file("funcgraph-abstime", "0");
>  	write_tracing_option_file("irq-info", "0");
> @@ -456,6 +458,17 @@ static int set_tracing_funcgraph_tail(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_latency_format(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->latency_format)
> +		return 0;
> +
> +	if (write_tracing_option_file("latency-format", "1") < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int set_tracing_trace_children(struct perf_ftrace *ftrace)
>  {
>  	if (!ftrace->trace_children)
> @@ -579,6 +592,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_latency_format(ftrace) < 0) {
> +		pr_err("failed to set tracing option latency-format\n");
> +		goto out_reset;
> +	}
> +
>  	if (set_tracing_trace_children(ftrace) < 0) {
>  		pr_err("failed to set tracing option function-fork\n");
>  		goto out_reset;
> @@ -748,6 +766,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		    "Ignore functions that happen inside interrupt (function_graph only)"),
>  	OPT_BOOLEAN(0, "funcgraph-tail", &ftrace.funcgraph_tail,
>  		    "Show function tails comment (function_graph only)"),
> +	OPT_BOOLEAN(0, "latency-format", &ftrace.latency_format,
> +		    "displays additional information about the latency (function_graph only)"),
>  	OPT_BOOLEAN('l', "long-info", &ftrace.long_info,
>  		    "Show process names, PIDs, timestamps, irq-info if available"),
>  	OPT_UINTEGER(0, "tracing-thresh", &ftrace.tracing_thresh,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
