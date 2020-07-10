Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A341C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E96207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594390461;
	bh=ShDwfIgYs9zZ3VgzOkVwkZf2LuFON/IGZOcw6LWXTqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HBhAdLYgdrA+6Lx2V/vvVcucXbBIhVzYamhCgmQd/DPEMz0cHWbg7QcTlBkdNJCJv
	 MySzcDG7qK16bzV9p05bFxepy1KqqVQXbyNL3KhBHGOhMorqC4JJh7/Y/y8WFSP3B1
	 7yfUaU7BgVkBL31MIICAPI6gflFsRMCrnKttlzl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgGJOOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:14:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33056 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGJOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:14:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id f18so6141457wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCDDO19SFMMcZT0ta8wWRP3o4PUahr2b5mUeEJKiLxg=;
        b=J0a79lq+vlhTVa9qaXK/3WTWaRDZFzfhw9rGtwL0MKTDBUXHRGZ0kHJlsAaN5p5MHR
         YKQGy6RnbwYCCvViebErT7KxLFDC+RbadNJdF079+KcE12nTm+mcnJqYdNz0+N1ebWWB
         2WvVA3oOP3xVCuI3uv1PHnPzXZIl6RjG164BHH0bPCo8RO1CT3vLkqnuSlIRtFN4QUrH
         cv68oWMZJsIgS/kdLYgkAZXhuZb/NFZW7EKNDNZT+/hVE2zDh1XGZA0/X+Q1VfdEJNrs
         rgCsneLzHuyLrt88upWOUaStnT0uupPzeU7LoxVCv0h5tqeKvFfUraNTA5bjnk2BBOFM
         IUkw==
X-Gm-Message-State: AOAM533UwvqKa94AYbma/h1pm6PY0GlB4SzaZi2uPpTgx8PqxlMIU8I1
        HJhAK27Z1BKudTAXrf8m/Da2sypqUM5VCazE1dU=
X-Google-Smtp-Source: ABdhPJwUnmlTqEPZskLepF+ZTAC5y1MzaQ+EU1F/nNh5NEOr/q2nuKpVps2Nh7QAYB4446+8611bSPgEsoe0KcgpCcU=
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr68080481wrr.391.1594390456674;
 Fri, 10 Jul 2020 07:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200710134322.15400-1-changbin.du@gmail.com> <20200710134322.15400-2-changbin.du@gmail.com>
In-Reply-To: <20200710134322.15400-2-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Jul 2020 23:14:05 +0900
Message-ID: <CAM9d7cgZFrakd5n=ZekQNS2WSa9nrnmaU1FxiRHxVrUEviUD4g@mail.gmail.com>
Subject: Re: [PATCH v4 01/17] perf ftrace: select function/function_graph
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

On Fri, Jul 10, 2020 at 10:43 PM Changbin Du <changbin.du@gmail.com> wrote:
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
>
> Here are some examples.
>
> This will start tracing all functions using function tracer:
>   $ sudo perf ftrace
>
> This will trace all functions using function graph tracer:
>   $ sudo perf ftrace -G

If you removed the default value, this doesn't work, right?

Thanks
Namhyung

>
> This will trace function vfs_read using function graph tracer:
>   $ sudo perf ftrace -G vfs_read
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
>
> ---
> v3: remove default '*' for -G/-T.
> ---
>  tools/perf/Documentation/perf-config.txt |  5 -----
>  tools/perf/Documentation/perf-ftrace.txt |  2 +-
>  tools/perf/builtin-ftrace.c              | 15 ++++++++++-----
>  3 files changed, 11 insertions(+), 11 deletions(-)
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
> index 2bfc1b0db536..5f53da87040d 100644
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
> @@ -479,11 +479,13 @@ int cmd_ftrace(int argc, const char **argv)
>         OPT_STRING('C', "cpu", &ftrace.target.cpu_list, "cpu",
>                     "list of cpus to monitor"),
>         OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
> -                    "trace given functions only", parse_filter_func),
> +                    "trace given functions using function tracer",
> +                    parse_filter_func),
>         OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
>                      "do not trace given functions", parse_filter_func),
>         OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
> -                    "Set graph filter on given functions", parse_filter_func),
> +                    "trace given functions using function_graph tracer",
> +                    parse_filter_func),
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
