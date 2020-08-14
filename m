Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C095C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB512087D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597408397;
	bh=tmSjrnWHnIR5nNAlJudislRb3fi769/gr5l0KSK4yls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GHiP6Qj7AXxIInz3ynSTqLljnYMWK70A5WAvyjraQGAh2EZi2CDqOOdvAiRNnOWvF
	 6LuVcEr3xNV+KaJPOcwFClKvswfRwdLuNqnRY/3H+IfeM+XXGk848diKKOO5cuuWVI
	 2spMBFo4+3opU1eGh7UtHaMyKj6b6qU/gBg++Kag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgHNMdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgHNMdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:33:14 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A82220866;
        Fri, 14 Aug 2020 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408393;
        bh=tmSjrnWHnIR5nNAlJudislRb3fi769/gr5l0KSK4yls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FvENzcYnq5xjoQ/WXGlRBMqqSCCZ+QDwtXk9SohgLMRcKhCcCcdECxTUTT62jzpfA
         KlocHmRCXUI1JKFUvNLwg5OJUcjN3pmJsSmkS5mQd7PbGVpHGfNChELmk0OvQtPujp
         isH89e8X3DlyIg7k8vrvx2PEOrW97ZtxGmRoVu8o=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B09F040D3D; Fri, 14 Aug 2020 09:33:10 -0300 (-03)
Date:   Fri, 14 Aug 2020 09:33:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 13/18] perf ftrace: add support for trace option
 tracing_thresh
Message-ID: <20200814123310.GC13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-14-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808023141.14227-14-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 08, 2020 at 10:31:36AM +0800, Changbin Du escreveu:
> This adds an option '--graph-opts thresh' to setup trace duration
> threshold for funcgraph tracer.

Applied, please consider making --duration an alias for this, as this is
also available in 'perf trace':

[root@quaco ~]# perf trace --duration 500 --max-events=5
   369.860 gnome-shell/2084 poll(ufds: 0x559577983080, nfds: 21, timeout_msecs: 7194) = 1
   493.654 pool-geoclue/386046 futex(uaddr: 0x56024843b610, op: WAIT|PRIVATE_FLAG, val: 1201, utime: 0x7f32bd7f9cc0) = -1 ETIMEDOUT (Connection timed out)
    71.604 WebRTC_Worker/111634 futex(uaddr: 0x7fb4c364d608, op: WAIT_BITSET|PRIVATE_FLAG, val: 0, utime: 0x7fb4c364d410, val3: MATCH_ANY) = -1 ETIMEDOUT (Connection timed out)
   601.645 pool-gsd-smart/2469 clock_nanosleep(which_clock: 0, flags: 0, rqtp: 0x7fb82cbd1cf0, rmtp: 0x7fb82cbd1d00) = 0
   623.823 chromium-brows/92363 futex(uaddr: 0x7ffcfd064e38, op: WAIT_BITSET|PRIVATE_FLAG, val: 0, utime: 0x7ffcfd064c40, val3: MATCH_ANY) = -1 ETIMEDOUT (Connection timed out)
[root@quaco ~]#

  $ perf trace -h duration

        --duration <float>
                          show only events with duration > N.M ms

  $

This way one would be able to do:

  # perf trace --duration N.M

To see at syscall level, then add 'f':

  # perf ftrace --duration N.M

To see at kernel function level. Switching from one perf tool to another
with such ease is the main objective here, I'd say :-)

- Arnaldo
 
> $ sudo ./perf ftrace -G '*' --graph-opts thresh=100
>  3) ! 184.060 us  |    } /* schedule */
>  3) ! 185.600 us  |  } /* exit_to_usermode_loop */
>  2) ! 225.989 us  |    } /* schedule_idle */
>  2) # 4140.051 us |  } /* do_idle */
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  1 +
>  tools/perf/builtin-ftrace.c              | 26 +++++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index a2056aaf2ece..6fa927e5971b 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -107,6 +107,7 @@ OPTIONS
>  	  nosleep-time - Measure on-CPU time only for function_graph tracer.
>  	  noirqs       - Ignore functions that happen inside interrupt.
>  	  verbose      - Show process names, PIDs, timestamps, etc.
> +	  thresh=<n>   - Setup trace duration threshold in microseconds.
>  
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 8ee5287bd84a..ca61f8b8bbf6 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -48,6 +48,7 @@ struct perf_ftrace {
>  	int			graph_nosleep_time;
>  	int			graph_noirqs;
>  	int			graph_verbose;
> +	int			graph_thresh;
>  };
>  
>  struct filter_entry {
> @@ -234,6 +235,9 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  	if (write_tracing_file("max_graph_depth", "0") < 0)
>  		return -1;
>  
> +	if (write_tracing_file("tracing_thresh", "0") < 0)
> +		return -1;
> +
>  	reset_tracing_filters();
>  	reset_tracing_options(ftrace);
>  	return 0;
> @@ -446,6 +450,20 @@ static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_thresh(struct perf_ftrace *ftrace)
> +{
> +	int ret;
> +
> +	if (ftrace->graph_thresh == 0)
> +		return 0;
> +
> +	ret = write_tracing_file_int("tracing_thresh", ftrace->graph_thresh);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>  	char *trace_file;
> @@ -545,6 +563,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_thresh(ftrace) < 0) {
> +		pr_err("failed to set tracing thresh\n");
> +		goto out_reset;
> +	}
> +
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>  		goto out_reset;
> @@ -727,6 +750,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
>  		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
>  		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
>  		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
> +		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
>  		{ .name = NULL, }
>  	};
>  
> @@ -798,7 +822,7 @@ int cmd_ftrace(int argc, const char **argv)
>  	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
>  		    "Max depth for function graph tracer"),
>  	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> -		     "graph tracer options, available options: nosleep-time,noirqs,verbose",
> +		     "graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>",
>  		     parse_graph_tracer_opts),
>  	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
>  		     "size of per cpu buffer", parse_buffer_size),
> -- 
> 2.25.1
> 

-- 

- Arnaldo
