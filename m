Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5096CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A1E207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597406007;
	bh=ktjPay3yFnO4JqZFYteRtnI9GZ/d+zijon3jWq6olDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PApdgUydvC6B8BGMYvAHqqf0UyOMcmWHZWldRLEtNAciMZuc3FupWXGRHZeB9LYWf
	 HJ+8BJh5/cnM+DHCb8U858YyTy8LIsCFDGVowN6FqA8GqIi+tP9+4l+FHIghxtI3YJ
	 amujhREIvNMu4mofZT0+QL5+88OytDPsDwaZqtv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHNLxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHNLxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:53:22 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED59F20716;
        Fri, 14 Aug 2020 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597406001;
        bh=ktjPay3yFnO4JqZFYteRtnI9GZ/d+zijon3jWq6olDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wT4vU4kXSd/xx2GSftU0AV6SBaeOWY6BVThCYk2Svr5K8CVJfT21GMtjBy+ixIGjg
         mFog/EqERhF0M0gekdZQz0HpBLVSJCQ1d+H/Ir+0jKclLaO/SnDYUITIAf6loEcQjT
         GFfJ+k697I0TvO/lq2F+l6wYwwtvOWRwfgfLaB1E=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 91A7C4097F; Fri, 14 Aug 2020 08:53:18 -0300 (-03)
Date:   Fri, 14 Aug 2020 08:53:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/18] perf ftrace: add option '-m/--buffer-size' to
 set per-cpu buffer size
Message-ID: <20200814115318.GT13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-5-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808023141.14227-5-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 08, 2020 at 10:31:27AM +0800, Changbin Du escreveu:
> This adds an option '-m/--buffer-size' to allow us set the size of per-cpu
> tracing buffer.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

So this is a little bit confusing, i.e. if I don't specify a suffix (B,
K, M, G) I get:

  # perf ftrace -m 2048
  
   Usage: perf ftrace [<options>] [<command>]
      or: perf ftrace [<options>] -- <command> [<options>]
  
      -m, --buffer-size <size>
                            size of per cpu buffer
  #

  Which is not very helpful, and you also forgot to add an entry to 'man
  perf-ftrace' (tools/perf/Documentation/perf-ftrace.txt), so only by
  looking at the patch I was able to figure out that a suffix is
  required.

  Now look how 'perf trace' works:

  # perf trace -m 2048 -e open* --max-events 1
     0.772 sh/343169 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC) = 3
  # 

I.e. it doesn't require a unit suffix, which is more natural.

  # perf trace -h -m

    -m, --mmap-pages <pages>
                          number of mmap data pages

  #

It indicates that the argument is in units of 'pages', while you don't
state that in:
  
  $ perf ftrace -h -m
  
      -m, --buffer-size <size>
                            size of per cpu buffer
  
  $ 

So please improve the option description and add its longer explanation
in the man page, also I suggest you interpret:

  # perf ftrace -m 2048

as asking for 2048K since the file as _kb in its name, so people used to
ftrace will get what they ask for, i.e. N kb. Please add this to the one
line description in 'perf ftrace -h', namely that the default unit os
'K'.

All this can be made on top of this series, so I'm applying it now to
make progress.

- Arnaldo

> ---
> v2: support units as a suffix.
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  5 +++
>  tools/perf/builtin-ftrace.c              | 55 ++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 4f5628445a63..7a5d915f60b0 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -53,6 +53,11 @@ OPTIONS
>  	Ranges of CPUs are specified with -: 0-2.
>  	Default is to trace on all online CPUs.
>  
> +-m::
> +--buffer-size::
> +	Set the size of per-cpu tracing buffer, <size> is expected to
> +	be a number with appended unit character - B/K/M/G.
> +
>  -T::
>  --trace-funcs=::
>  	Select function tracer and set function filter on the given
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 4b3fcee5725a..a3a4f4be9dde 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -26,6 +26,7 @@
>  #include "thread_map.h"
>  #include "util/cap.h"
>  #include "util/config.h"
> +#include "util/units.h"
>  
>  #define DEFAULT_TRACER  "function_graph"
>  
> @@ -39,6 +40,7 @@ struct perf_ftrace {
>  	struct list_head	graph_funcs;
>  	struct list_head	nograph_funcs;
>  	int			graph_depth;
> +	unsigned long		percpu_buffer_size;
>  };
>  
>  struct filter_entry {
> @@ -324,6 +326,21 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
>  	return 0;
>  }
>  
> +static int set_tracing_percpu_buffer_size(struct perf_ftrace *ftrace)
> +{
> +	int ret;
> +
> +	if (ftrace->percpu_buffer_size == 0)
> +		return 0;
> +
> +	ret = write_tracing_file_int("buffer_size_kb",
> +				     ftrace->percpu_buffer_size / 1024);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>  	char *trace_file;
> @@ -388,6 +405,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  		goto out_reset;
>  	}
>  
> +	if (set_tracing_percpu_buffer_size(ftrace) < 0) {
> +		pr_err("failed to set tracing per-cpu buffer size\n");
> +		goto out_reset;
> +	}
> +
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>  		goto out_reset;
> @@ -506,6 +528,37 @@ static void delete_filter_func(struct list_head *head)
>  	}
>  }
>  
> +static int parse_buffer_size(const struct option *opt,
> +			     const char *str, int unset)
> +{
> +	unsigned long *s = (unsigned long *)opt->value;
> +	static struct parse_tag tags_size[] = {
> +		{ .tag  = 'B', .mult = 1       },
> +		{ .tag  = 'K', .mult = 1 << 10 },
> +		{ .tag  = 'M', .mult = 1 << 20 },
> +		{ .tag  = 'G', .mult = 1 << 30 },
> +		{ .tag  = 0 },
> +	};
> +	unsigned long val;
> +
> +	if (unset) {
> +		*s = 0;
> +		return 0;
> +	}
> +
> +	val = parse_tag_value(str, tags_size);
> +	if (val != (unsigned long) -1) {
> +		if (val < 1024) {
> +			pr_err("buffer size too small, must larger than 1KB.");
> +			return -1;
> +		}
> +		*s = val;
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
>  static void select_tracer(struct perf_ftrace *ftrace)
>  {
>  	bool graph = !list_empty(&ftrace->graph_funcs) ||
> @@ -560,6 +613,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		     "Set nograph filter on given functions", parse_filter_func),
>  	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
>  		    "Max depth for function graph tracer"),
> +	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
> +		     "size of per cpu buffer", parse_buffer_size),
>  	OPT_END()
>  	};
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
