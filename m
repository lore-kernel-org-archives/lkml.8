Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A6BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA2020829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008287;
	bh=wiqzcgRCvAbOQmETqVfIbYHquqrneyQnyLrXMEG/i3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XshLocdlazq+53QoUi16Z6zLE/i+rTePvHz25dV5ph64dM+R5/fYN00KRSV3jYQ9b
	 3tH+liDJO7Lgfg0uh+mCavahUwBT/fnrg9EcCJsnZXPKyJqhN4SOVLx69EaaRlRx/Z
	 FrhGoCeqCbB8JSs16faoUjbRAmBorZRZuHN1c8FE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgETU6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETU6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:58:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 301E220758;
        Wed, 20 May 2020 20:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008283;
        bh=wiqzcgRCvAbOQmETqVfIbYHquqrneyQnyLrXMEG/i3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x8lIteOkw6m7KI5NLnVrvk3aShdaFP1+8WcsyXjRRGRnY8fXHlpxGF7Hhf3pym3RI
         cDDTzFd8OApSNKhWdzO1r6f2kiXiJt9daHQDSfwHwq8iHamlfBEYmAt0fIaCn1smLE
         6AygEvpPfMb1ZlZuo3mpmRa/7NnY1wJC83+cebyk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 31FD140AFD; Wed, 20 May 2020 17:58:01 -0300 (-03)
Date:   Wed, 20 May 2020 17:58:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/19] perf ftrace: add support for tracing option
 'func_stack_trace'
Message-ID: <20200520205801.GR32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-5-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-5-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:13PM +0800, Changbin Du escreveu:
> This adds support to display call trace for function tracer. To do this,
> just specify a '-s' option.
> 
> $ sudo perf ftrace -T vfs_read -s
>  iio-sensor-prox-855   [003]   6168.369657: vfs_read <-ksys_read
>  iio-sensor-prox-855   [003]   6168.369677: <stack trace>
>  => vfs_read
>  => ksys_read
>  => __x64_sys_read
>  => do_syscall_64
>  => entry_SYSCALL_64_after_hwframe
>  ...

So, for the reason stated in my response to the patch 03/19, I think we
should start here with --call-graph for this, instead of
--func-stack-trace. And for now don't provide a one-letter equivalent.

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 38 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 57e656c35d28..1d30c2d5f88b 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -38,6 +38,7 @@ struct perf_ftrace {
>  	struct list_head	graph_funcs;
>  	struct list_head	nograph_funcs;
>  	int			graph_depth;
> +	bool			func_stack_trace;
>  };
>  
>  struct filter_entry {
> @@ -128,9 +129,27 @@ static int append_tracing_file(const char *name, const char *val)
>  	return __write_tracing_file(name, val, true);
>  }
>  
> +static int write_tracing_option_file(const char *name, const char *val)
> +{
> +	char *file;
> +	int ret;
> +
> +	if (asprintf(&file, "options/%s", name) < 0)
> +		return -1;
> +
> +	ret = __write_tracing_file(file, val, false);
> +	free(file);
> +	return ret;
> +}
> +
>  static int reset_tracing_cpu(void);
>  static void reset_tracing_filters(void);
>  
> +static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> +{
> +	write_tracing_option_file("func_stack_trace", "0");
> +}
> +
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  {
>  	if (write_tracing_file("tracing_on", "0") < 0)
> @@ -149,6 +168,7 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  		return -1;
>  
>  	reset_tracing_filters();
> +	reset_tracing_options(ftrace);
>  	return 0;
>  }
>  
> @@ -204,6 +224,17 @@ static int set_tracing_cpu(struct perf_ftrace *ftrace)
>  	return set_tracing_cpumask(cpumap);
>  }
>  
> +static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->func_stack_trace)
> +		return 0;
> +
> +	if (write_tracing_option_file("func_stack_trace", "1") < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int reset_tracing_cpu(void)
>  {
>  	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
> @@ -326,6 +357,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_func_stack_trace(ftrace) < 0) {
> +		pr_err("failed to set tracing option func_stack_trace\n");
> +		goto out_reset;
> +	}
> +
>  	if (set_tracing_filters(ftrace) < 0) {
>  		pr_err("failed to set tracing filters\n");
>  		goto out_reset;
> @@ -459,6 +495,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		     "trace given functions only", parse_filter_func),
>  	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
>  		     "do not trace given functions", parse_filter_func),
> +	OPT_BOOLEAN('s', "func-stack-trace", &ftrace.func_stack_trace,
> +		    "Show kernel stack trace for function tracer"),
>  	OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
>  		     "Set graph filter on given functions (imply to use function_graph tracer)",
>  		     parse_filter_func, "*"),
> -- 
> 2.25.1
> 

-- 

- Arnaldo
