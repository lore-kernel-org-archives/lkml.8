Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FEAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9003620829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008470;
	bh=Bek4XvCHt9oUA9k4moA//BF3BkDYpfJWorlc0X4QLEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nqSBXMtBymEgZeX7LV+HRT2AQFeFqoRuEm/gDcYgDRw65JxaW4M4hIWQDm4aWkVqO
	 /gszaVb6/D6St2jcUfNedOtWRFKulCxvkFitgA93JEJyhjcU/HTaWSaHCmLlLcRtZJ
	 mVv7rFlOMU4XZ2Vqwan2wjgzjasLrHPGJuVg1LQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgETVBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgETVBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:01:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6193E2075F;
        Wed, 20 May 2020 21:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008468;
        bh=Bek4XvCHt9oUA9k4moA//BF3BkDYpfJWorlc0X4QLEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYAwVuR5gOYh1n0atQSB3hViMjvgjYDzoy87rzNhSw1N3ojp+tMMEtyllwVj2bf+s
         L1OopQQIl2ZYaOUdA76aTi8pcigqsxqwCus3uMzQXlzN87MmZbsMjQbdI3BbwTF25e
         CLjtZvPMovMns6nMKZ2/pDj3MT3epkoaeNk4ZLqE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 94F9B40AFD; Wed, 20 May 2020 18:01:06 -0300 (-03)
Date:   Wed, 20 May 2020 18:01:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/19] perf ftrace: add support for trace option
 sleep-time
Message-ID: <20200520210106.GT32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-7-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-7-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:15PM +0800, Changbin Du escreveu:
> This adds an option '--nosleep-time' which allow us only to measure
> on-CPU time. This option is function_graph tracer only.

This seems, for now, very specific to the function_graph tracer, so
perhaps we should have a:

	--function_graph_opts nosleep-time,other,another,etc

?

In time options that have equivalent in other perf tools can be
promoted?

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 8133d910d5d8..d3fcf3b0b792 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -40,6 +40,7 @@ struct perf_ftrace {
>  	struct list_head	nograph_funcs;
>  	int			graph_depth;
>  	bool			func_stack_trace;
> +	bool			nosleep_time;
>  };
>  
>  struct filter_entry {
> @@ -186,6 +187,7 @@ static void reset_tracing_filters(void);
>  static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>  {
>  	write_tracing_option_file("func_stack_trace", "0");
> +	write_tracing_option_file("sleep-time", "1");
>  }
>  
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> @@ -345,6 +347,17 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->nosleep_time)
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
> @@ -413,6 +426,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
> @@ -548,6 +566,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		     parse_filter_func),
>  	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
>  		    "Max depth for function graph tracer"),
> +	OPT_BOOLEAN(0, "nosleep-time", &ftrace.nosleep_time,
> +		    "Measure on-CPU time only (function_graph only)"),
>  	OPT_END()
>  	};
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
