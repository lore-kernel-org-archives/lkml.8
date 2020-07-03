Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E170C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E5B20771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593755245;
	bh=aen9lRevch+iEg8EeGdNZ6YnSxy4YmX/EVkSfzJW8xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kI9gpAouszmlaXF1G8qvGDCk/1CzyLYFYiZBDdwncnJYWwoszvsJRY6luOmVkmgcb
	 42uU88MaGXpVXPv9GvFxkJuLkieUPaAb3c93GeEPoApwh2a8iWb2z6nzCBF7e0y+jH
	 FdSPEeiQE11+Gei/Gq4L3oLLl8g/P7c9g+Zg+LGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGCFrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:47:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42438 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCFrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:47:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id o11so31322960wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 22:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKy2GNB5sZt8VGw0VP4MCiAH01YEwlVv0x/b4QG309E=;
        b=mdwbn55wyeyn4yAjEwtBmQI/nxkRIJyYFoWyG7R79IvZ9kUe6pcTaBZRYN9J5glpAq
         btzzNbmwCFgGbAG7dOWYYGWZfbEVZWYpbhv98K1wosFaM46iPPEx6cHamMaZldQH2Tqv
         Lt9/Jgz65J6fYfVjUWhYwJzVOG4SUA1taUweE3dNrGZKqNnkMdvciT3LGLhRUoNgwl7T
         bh0t69K2mOqhCv/rEt/tyfjD/O5QKNsBSyPzelvZjsA7Mhw2nT3EnNtt/iuV0TBe5FLM
         cQN+BDqanzYKSSKUau5a843wmHvpCgHq8c/21kGtXvY4qF0uiT5CYopsxXuNuHOlaoPC
         ixEQ==
X-Gm-Message-State: AOAM530lxj4D6JGVVD3GiaqgBY7DSfce4R0NSFqInpW9bBbSL9JoXK1U
        NwQ/hNSbZqDo8YMTKvS5Tcr1q0FMocodHbm/sM0=
X-Google-Smtp-Source: ABdhPJxIfA6nJ+fB73wLKYzfmEtsb3jvthJEue6TzxY17BQ3lnqRMCQVo1ogahEfFKemEotBRuO3RAgP5SE2XBKZvYc=
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr34975701wrr.391.1593755240202;
 Thu, 02 Jul 2020 22:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200627133654.64863-1-changbin.du@gmail.com> <20200627133654.64863-2-changbin.du@gmail.com>
In-Reply-To: <20200627133654.64863-2-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Jul 2020 14:47:09 +0900
Message-ID: <CAM9d7cib3uSvzVbyPh68=i63+_w7Pt1PHRVM-KCCb-XqH20jog@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] perf ftrace: select function/function_graph
 tracer automatically
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Jun 27, 2020 at 10:37 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> The '-g/-G' options have already implied function_graph tracer should be
> used instead of function tracer. So the extra option '--tracer' can be
> killed.
>
> This patch changes the behavior as below:
>   - By default, function tracer is used.
>   - If '-g' or '-G' option is on, then function_graph tracer is used.
>   - The perf configuration item 'ftrace.tracer' is marked as deprecated.
>   - The option '--tracer' is marked as deprecated.
>   - The default filter for -G/-T is to trace all functions.
>
> Here are some examples.
>
> This will start tracing all functions using function tracer:
>   $ sudo perf ftrace
>
> This will trace all functions using function graph tracer:
>   $ sudo perf ftrace -G
>
> This will trace function vfs_read using function graph tracer:
>   $ sudo perf ftrace -G vfs_read

As we support running a new task on the command line, it might
confuse users whether it's an argument of -G option or a task to run.
One can use -- to separate them but it's easy to miss..

Thanks
Namhyung


>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/perf-config.txt |  5 -----
>  tools/perf/Documentation/perf-ftrace.txt |  2 +-
>  tools/perf/builtin-ftrace.c              | 19 ++++++++++++-------
>  3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index c7d3df5798e2..a25fee7de3b2 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -612,11 +612,6 @@ trace.*::
>                 "libbeauty", the default, to use the same argument beautifiers used in the
>                 strace-like sys_enter+sys_exit lines.
>
> -ftrace.*::
> -       ftrace.tracer::
> -               Can be used to select the default tracer. Possible values are
> -               'function' and 'function_graph'.
> -
>  llvm.*::
>         llvm.clang-path::
>                 Path to clang. If omit, search it from $PATH.
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index b80c84307dc9..952e46669168 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -24,7 +24,7 @@ OPTIONS
>
>  -t::
>  --tracer=::
> -       Tracer to use: function_graph or function.
> +       Tracer to use: function_graph or function. This option is deprecated.
>
>  -v::
>  --verbose=::
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 2bfc1b0db536..c5718503eded 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -27,7 +27,6 @@
>  #include "util/cap.h"
>  #include "util/config.h"
>
> -#define DEFAULT_TRACER  "function_graph"
>
>  struct perf_ftrace {
>         struct evlist           *evlist;
> @@ -419,6 +418,7 @@ static int perf_ftrace_config(const char *var, const char *value, void *cb)
>         if (strcmp(var, "ftrace.tracer"))
>                 return -1;
>
> +       pr_warning("Configuration ftrace.tracer is deprecated\n");
>         if (!strcmp(value, "function_graph") ||
>             !strcmp(value, "function")) {
>                 ftrace->tracer = value;
> @@ -459,7 +459,7 @@ int cmd_ftrace(int argc, const char **argv)
>  {
>         int ret;
>         struct perf_ftrace ftrace = {
> -               .tracer = DEFAULT_TRACER,
> +               .tracer = "function",
>                 .target = { .uid = UINT_MAX, },
>         };
>         const char * const ftrace_usage[] = {
> @@ -469,7 +469,7 @@ int cmd_ftrace(int argc, const char **argv)
>         };
>         const struct option ftrace_options[] = {
>         OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
> -                  "tracer to use: function_graph(default) or function"),
> +                  "tracer to use: function or function_graph (This option is deprecated)"),
>         OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
>                    "trace on existing process id"),
>         OPT_INCR('v', "verbose", &verbose,
> @@ -478,12 +478,14 @@ int cmd_ftrace(int argc, const char **argv)
>                     "system-wide collection from all CPUs"),
>         OPT_STRING('C', "cpu", &ftrace.target.cpu_list, "cpu",
>                     "list of cpus to monitor"),
> -       OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
> -                    "trace given functions only", parse_filter_func),
> +       OPT_CALLBACK_DEFAULT('T', "trace-funcs", &ftrace.filters, "func",
> +                            "trace given functions using function tracer",
> +                            parse_filter_func, "*"),
>         OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
>                      "do not trace given functions", parse_filter_func),
> -       OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
> -                    "Set graph filter on given functions", parse_filter_func),
> +       OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
> +                            "trace given functions using function_graph tracer",
> +                            parse_filter_func, "*"),
>         OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
>                      "Set nograph filter on given functions", parse_filter_func),
>         OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
> @@ -505,6 +507,9 @@ int cmd_ftrace(int argc, const char **argv)
>         if (!argc && target__none(&ftrace.target))
>                 ftrace.target.system_wide = true;
>
> +       if (!list_empty(&ftrace.graph_funcs) || !list_empty(&ftrace.nograph_funcs))
> +               ftrace.tracer = "function_graph";
> +
>         ret = target__validate(&ftrace.target);
>         if (ret) {
>                 char errbuf[512];
> --
> 2.25.1
>
