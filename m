Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5960206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkzPGfG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgHTPPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgHTPPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:15:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781AC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:15:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i10so1295107pgk.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+i2rLOLDfJQgKqdiOBngyPNxtVIJB7Ri9t9x2ddN/V4=;
        b=QkzPGfG5kJOuLTCBb4R2ScqS7WUTbzqAfh6mZ4RGT+dW3ng9pOOWxwWoeb0D0JhK4X
         W9kYOa5M49eSpO2o2Elzzgm0rJX7As5HkDgfeXNZ5PahEsD5qO3SdD/ByyaK+/SqTvB1
         4bnocO4K/ufgUJ4DVAvJAWBmmZSVoz/REYhFTaNJY6L3Zv5WhKVbJBYJyql3vNxnQUHw
         0Bu/bUIk7LS8Jq6mEQVinG/oEezDkQ2dwU+3SAuLP8aCE1HA8FxzyzzMxAyUI9JNBMKQ
         ZnfB1RKN+asnBdKbNY/L+mIGKaPb6M9KPO3ka4CokUpcjcfq2bNJLQBe9fBVzMuTsukI
         3hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+i2rLOLDfJQgKqdiOBngyPNxtVIJB7Ri9t9x2ddN/V4=;
        b=UGFVvggewF0vLNbp+1szbOjd9wEsvmGKphgGyS4BXAO84Uue8VGhQq671/vCa3jHFv
         Ngvv74JC1p7yKdfqa9zCQp12h1QWSitIy4oiAaa/9deKhDyDtfeKfw9jY9UNe99e2epJ
         RQsC93be6g+7NHkqUpO67WfUkOkJ6Kq9zcnudy92f0KpyWyH7KR7C9mW6wStrzfTxwHp
         RrW9ckowUKHqllPbb97FUTRTPviLg8+kN2d+wSr9fB8Ntspk+3P/MhsFkrrcgw4TCaeP
         pBJ5R+nA1slD3nbrDDcBmRy/rRgSXKsU3XLAGa1zR8zVcH22j+GtPJd+1BQAaJXK0wGi
         ATSA==
X-Gm-Message-State: AOAM530iUli+UycE76rbayR9fZoVMOD7TkOy8szu7tJ6Jk7Y/wBG4l5C
        vbu7t3WpPa19TyksGJLV7xHL53THUXpBIw==
X-Google-Smtp-Source: ABdhPJxUbNzmvqrp8wqPrNT8Ww/CtNMCLFipkHXr7nYEKxGIdwsURqD0AqBi8i9ZC8lldqlytjlWEQ==
X-Received: by 2002:a62:e405:: with SMTP id r5mr2593488pfh.61.1597936539478;
        Thu, 20 Aug 2020 08:15:39 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id y1sm3235176pfl.136.2020.08.20.08.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:15:38 -0700 (PDT)
Date:   Thu, 20 Aug 2020 23:15:28 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/18] perf ftrace: add support for tracing option
 'func_stack_trace'
Message-ID: <20200820151528.yedul64eb24cjo7l@mail.google.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-9-changbin.du@gmail.com>
 <20200814122440.GY13995@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814122440.GY13995@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 09:24:40AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Aug 08, 2020 at 10:31:31AM +0800, Changbin Du escreveu:
> > This adds support to display call trace for function tracer. To do this,
> > just specify a '--func-opts call-graph' option.
> 
> Applied, thanks for providing the usage example and the output of the
> tool, please consider making this more compact and similar to the other
> perf tools as:
> 
>    # perf ftrace -g -T vfs_read
> 
>   # perf report -h -g
>   
>    Usage: perf report [<options>]
>   
>       -g, --call-graph <print_type,threshold[,print_limit],order,sort_key[,branch],value>
>                             Display call graph (stack chain/backtrace):
>   
>                                   print_type:     call graph printing style (graph|flat|fractal|folded|none)
>                                   threshold:      minimum call graph inclusion threshold (<percent>)
>                                   print_limit:    maximum number of call graph entry (<number>)
>                                   order:          call graph order (caller|callee)
>                                   sort_key:       call graph sort key (function|address)
>                                   branch:         include last branch info to call graph (branch)
>                                   value:          call graph value (percent|period|count)
>   
>                                   Default: graph,0.5,caller,function,percent
>   
>   # 
> 
> Is there a way to ask for a limit in the number of levels? That is
> similar to /proc/sys/kernel/perf_event_max_stack (system wide) and
> perf_event_attr.sample_max_stack (per event)?
> 
No, there is no such limit for function tracer yet (kernel doesn't support it).
It just backtraces from current to top.

For graph tracer, the option is --graph-opts depth=<n>.

> One can ask for that per event:
> 
>   # perf trace -e sched:*_wakeup/max-stack=2/ -e sched:*switch/max-stack=5/ --max-events=4
>      0.000 migration/0/12 sched:sched_switch(prev_comm: "migration/0", prev_pid: 12 (migration/0), prev_prio: 0, prev_state: 1, next_comm: "swapper/0", next_pid: 0, next_prio: 120)
>                                        __schedule ([kernel.kallsyms])
>                                        __schedule ([kernel.kallsyms])
>                                        schedule ([kernel.kallsyms])
>                                        smpboot_thread_fn ([kernel.kallsyms])
>                                        kthread ([kernel.kallsyms])
>      2.381 :0/0 sched:sched_wakeup(comm: "PacerThread", pid: 111637 (PacerThread), prio: 120, success: 1, target_cpu: 0)
>                                        ttwu_do_wakeup ([kernel.kallsyms])
>                                        ttwu_do_wakeup ([kernel.kallsyms])
>      2.387 :0/0 sched:sched_switch(prev_comm: "swapper/0", prev_pid: 0, prev_prio: 120, prev_state: 0, next_comm: "PacerThread", next_pid: 111637 (PacerThread), next_prio: 120)
>                                        __schedule ([kernel.kallsyms])
>                                        __schedule ([kernel.kallsyms])
>                                        schedule_idle ([kernel.kallsyms])
>                                        do_idle ([kernel.kallsyms])
>                                        cpu_startup_entry ([kernel.kallsyms])
>      2.410 PacerThread/111637 sched:sched_switch(prev_comm: "PacerThread", prev_pid: 111637 (PacerThread), prev_prio: 120, prev_state: 1, next_comm: "swapper/0", next_pid: 0, next_prio: 120)
>                                        __schedule ([kernel.kallsyms])
>                                        __schedule ([kernel.kallsyms])
>                                        schedule ([kernel.kallsyms])
>                                        futex_wait_queue_me ([kernel.kallsyms])
>                                        futex_wait ([kernel.kallsyms])
>   #
> 
> - Arnaldo
>  
> > $ sudo perf ftrace -T vfs_read --func-opts call-graph
> >  iio-sensor-prox-855   [003]   6168.369657: vfs_read <-ksys_read
> >  iio-sensor-prox-855   [003]   6168.369677: <stack trace>
> >  => vfs_read
> >  => ksys_read
> >  => __x64_sys_read
> >  => do_syscall_64
> >  => entry_SYSCALL_64_after_hwframe
> >  ...
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > 
> > ---
> > v3: switch to uniform option --func-opts.
> > v2: option name '-s' -> '--func-call-graph'
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt |  4 +++
> >  tools/perf/builtin-ftrace.c              | 42 ++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index c46d0a09b38c..8f08ad0992c2 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -76,6 +76,10 @@ OPTIONS
> >  	specify multiple functions (or glob patterns).  It will be
> >  	passed to 'set_ftrace_notrace' in tracefs.
> >  
> > +--func-opts::
> > +	List of options allowed to set:
> > +	  call-graph - Display kernel stack trace for function tracer.
> > +
> >  -G::
> >  --graph-funcs=::
> >  	Select function_graph tracer and set graph filter on the given
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 07b81d0c1658..469b89748c42 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -27,6 +27,7 @@
> >  #include "util/cap.h"
> >  #include "util/config.h"
> >  #include "util/units.h"
> > +#include "util/parse-sublevel-options.h"
> >  
> >  #define DEFAULT_TRACER  "function_graph"
> >  
> > @@ -42,6 +43,7 @@ struct perf_ftrace {
> >  	int			graph_depth;
> >  	unsigned long		percpu_buffer_size;
> >  	bool			inherit;
> > +	int			func_stack_trace;
> >  };
> >  
> >  struct filter_entry {
> > @@ -202,6 +204,7 @@ static void reset_tracing_filters(void);
> >  static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> >  {
> >  	write_tracing_option_file("function-fork", "0");
> > +	write_tracing_option_file("func_stack_trace", "0");
> >  }
> >  
> >  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> > @@ -278,6 +281,17 @@ static int set_tracing_cpu(struct perf_ftrace *ftrace)
> >  	return set_tracing_cpumask(cpumap);
> >  }
> >  
> > +static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
> > +{
> > +	if (!ftrace->func_stack_trace)
> > +		return 0;
> > +
> > +	if (write_tracing_option_file("func_stack_trace", "1") < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> >  static int reset_tracing_cpu(void)
> >  {
> >  	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
> > @@ -426,6 +440,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  		goto out_reset;
> >  	}
> >  
> > +	if (set_tracing_func_stack_trace(ftrace) < 0) {
> > +		pr_err("failed to set tracing option func_stack_trace\n");
> > +		goto out_reset;
> > +	}
> > +
> >  	if (set_tracing_filters(ftrace) < 0) {
> >  		pr_err("failed to set tracing filters\n");
> >  		goto out_reset;
> > @@ -598,6 +617,26 @@ static int parse_buffer_size(const struct option *opt,
> >  	return -1;
> >  }
> >  
> > +static int parse_func_tracer_opts(const struct option *opt,
> > +				  const char *str, int unset)
> > +{
> > +	int ret;
> > +	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
> > +	struct sublevel_option func_tracer_opts[] = {
> > +		{ .name = "call-graph",	.value_ptr = &ftrace->func_stack_trace },
> > +		{ .name = NULL, }
> > +	};
> > +
> > +	if (unset)
> > +		return 0;
> > +
> > +	ret = perf_parse_sublevel_options(str, func_tracer_opts);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> >  static void select_tracer(struct perf_ftrace *ftrace)
> >  {
> >  	bool graph = !list_empty(&ftrace->graph_funcs) ||
> > @@ -645,6 +684,9 @@ int cmd_ftrace(int argc, const char **argv)
> >  		     parse_filter_func),
> >  	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
> >  		     "do not trace given functions", parse_filter_func),
> > +	OPT_CALLBACK(0, "func-opts", &ftrace, "options",
> > +		     "function tracer options, available options: call-graph",
> > +		     parse_func_tracer_opts),
> >  	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
> >  		     "trace given functions using function_graph tracer",
> >  		     parse_filter_func),
> > -- 
> > 2.25.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 
Cheers,
Changbin Du
