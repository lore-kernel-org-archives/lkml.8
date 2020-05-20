Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9D5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7AEF2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008582;
	bh=uyf+wpnbvMCA+KKkDsZ57pe3xA1JZhzPoaS/ZNfJBhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1l4oLgVle+ICK+H2sWbI/gNZIvJ82w+4jTWDeh3+szQi9JTcOT0taW02wZe0DkhR5
	 IXc1yDyxf5cPOxcJIQEEdD5b66l1u5KFqw9xTWgqvIaR1V0v1SDFvbgCpa1zQV25L/
	 TnvstNkC+9ZHaqWvVUrxx/Uq7MwatnPAPT8cyfjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgETVDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgETVDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:03:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB012075F;
        Wed, 20 May 2020 21:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590008580;
        bh=uyf+wpnbvMCA+KKkDsZ57pe3xA1JZhzPoaS/ZNfJBhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdMfq2otSnPS3ILIDB3TxZLHbeGCXVEAT5JP4khm2Gfj6z4kpOZjT/wh8hSvNJlqS
         kJuejX07yPIK6MgcKceR8ukxoKQPMfFoxa3vVYr34LpSTUI9ZjLEqbh5NtBCiUOBNW
         RRjv6dTZwn34gPEs+JIxCl6Dpwi1v6jNcfmfC9a0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E839240AFD; Wed, 20 May 2020 18:02:57 -0300 (-03)
Date:   Wed, 20 May 2020 18:02:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/19] perf ftrace: add option -l/--long-info to show
 more info
Message-ID: <20200520210257.GV32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-9-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-9-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:17PM +0800, Changbin Du escreveu:
> Sometimes we want ftrace display more and longer information about trace.

Humm, -v? Or that would bring too much stuff from other parts of perf?
I guess so, perhaps as an option to the function-graph tracer, one that
combines, as you do, several options provided by that tracer?

- Arnaldo
 
> $ sudo perf ftrace -G -l
>  6800.190937 |   4)   <...>-7683   |   2.072 us    |  mutex_unlock();
>  6800.190941 |   4)   <...>-7683   |   2.171 us    |  __fsnotify_parent();
>  6800.190943 |   4)   <...>-7683   |   1.497 us    |  fsnotify();
>  6800.190944 |   4)   <...>-7683   |   0.775 us    |  __sb_end_write();
>  6800.190945 |   4)   <...>-7683   |   0.854 us    |  fpregs_assert_state_consistent();
>  6800.190947 |   4)   <...>-7683   |               |  do_syscall_64() {
>  6800.190948 |   4)   <...>-7683   |               |    __x64_sys_close() {
>  6800.190948 |   4)   <...>-7683   |               |      __close_fd() {
>  6800.190948 |   4)   <...>-7683   |   0.322 us    |        _raw_spin_lock();
>  6800.190949 |   4)   <...>-7683   |               |        filp_close() {
>  6800.190949 |   4)   <...>-7683   |   0.320 us    |          dnotify_flush();
>  6800.190950 |   4)   <...>-7683   |   0.325 us    |          locks_remove_posix();
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index b16600a16efa..f11f2d3431b0 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -42,6 +42,7 @@ struct perf_ftrace {
>  	bool			func_stack_trace;
>  	bool			nosleep_time;
>  	bool			nofuncgraph_irqs;
> +	bool			long_info;
>  };
>  
>  struct filter_entry {
> @@ -190,6 +191,9 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>  	write_tracing_option_file("func_stack_trace", "0");
>  	write_tracing_option_file("sleep-time", "1");
>  	write_tracing_option_file("funcgraph-irqs", "1");
> +	write_tracing_option_file("funcgraph-proc", "0");
> +	write_tracing_option_file("funcgraph-abstime", "0");
> +	write_tracing_option_file("irq-info", "0");
>  }
>  
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> @@ -371,6 +375,23 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_long_info(struct perf_ftrace *ftrace)
> +{
> +	if (!ftrace->long_info)
> +		return 0;
> +
> +	if (write_tracing_option_file("funcgraph-proc", "1") < 0)
> +		return -1;
> +
> +	if (write_tracing_option_file("funcgraph-abstime", "1") < 0)
> +		return -1;
> +
> +	if (write_tracing_option_file("irq-info", "1") < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>  	char *trace_file;
> @@ -449,6 +470,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_long_info(ftrace) < 0) {
> +		pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime/irq-info\n");
> +		goto out_reset;
> +	}
> +
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>  		goto out_reset;
> @@ -588,6 +614,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		    "Measure on-CPU time only (function_graph only)"),
>  	OPT_BOOLEAN(0, "nofuncgraph-irqs", &ftrace.nofuncgraph_irqs,
>  		    "Ignore functions that happen inside interrupt (function_graph only)"),
> +	OPT_BOOLEAN('l', "long-info", &ftrace.long_info,
> +		    "Show process names, PIDs, timestamps, irq-info if available"),
>  	OPT_END()
>  	};
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
