Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F663C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D03020B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ub5f1Fpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGQRjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgGQRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:39:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C47C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:39:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so12006311wrv.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbXMr0S/ud09cdSS/2r1T0rVG/5Q5RAmNmmbToZt4wk=;
        b=Ub5f1Fptnr+ceG1dnofcAs0ZUjoEKyb4d4AW9WZo6uqUv7EpZZjUU0SyeOIuT1CfRX
         BelO5hD6BXYRArS4xn5CcdjiALDf4/MF9gzHVggSclXDIWLKj8NGO86JWrOIUv1BNekN
         pM9CBTKnIaoHREb6AOeb9CicxjKj3Us3IdMO/Kk/b0Sy3VhalIK6mDqSm8bfMiK/EfEU
         OqM0ubOaqmW9oQHV9z1FHniqKbmLqo57GLcuQJrI6BWPm73O1W7t0kHWsBNNnzDBVvp6
         24mMQ6ypAd8u/F+PTRwyMOnxMbuCOBqPMJ45h8ZHy7OL+iTzp1xFUdieVx/f7aaQ5dd8
         SI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbXMr0S/ud09cdSS/2r1T0rVG/5Q5RAmNmmbToZt4wk=;
        b=YVnVTjqsARe7wv1fTuvcg1b3QKKUcjeuOzTwL0oBROxpmG9jbuYQ7aDZFFWs2l2ku8
         EoTvtVHfHqJef+dhU4wDGZuRFOKjAEa4fDz0xWCNfe4fxxhFDAEeiQ2tdhFUUZiK33dX
         K2wVB6ml3GNiO1PdGV9GcsA0hsQ6FTTT5zMLL5XKfKtVgIS5+ZYbmfW6qAlNfC/+4Ese
         iByKcHxAtV+luCIK8SX9VMA1Mxc890JzF+KXi9MVKSREG4K1DabOmPRRSafliWCYW0/J
         /bfMbDMfV3FIisogb6z22X9gmsRmYQ3S+TaxmmjXc9AL3lH6SJeUl8f6mqCOmUEl4Uyo
         L9zA==
X-Gm-Message-State: AOAM530RzHe+fv9zfQpGmQ2rI9VYscqq5MCVU/Ns8lGUIAYXSDFDX93s
        L5o/YMWiCVEZDOG14ty9nnuylzYUxgH/S7MTDOcGtA==
X-Google-Smtp-Source: ABdhPJwHiNUVXyXPbg67awBI8FI7tayKQ3nVPhJCzajqwSH2RZGViknVGJ0nMoyEXalzyoReZu3iQKfI9nNPP24ta44=
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr11159713wrm.282.1595007556552;
 Fri, 17 Jul 2020 10:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200711124035.6513-1-changbin.du@gmail.com> <20200711124035.6513-3-changbin.du@gmail.com>
In-Reply-To: <20200711124035.6513-3-changbin.du@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Jul 2020 10:39:05 -0700
Message-ID: <CAP-5=fVJcpyKGNzkNwZ55w7JH9Jn2OLtuUAPJuzGCrCcTJF6pw@mail.gmail.com>
Subject: Re: [PATCH v5 02/17] perf ftrace: add option '-F/--funcs' to list
 available functions
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 5:42 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> This adds an option '-F/--funcs' to list all available functions to trace,
> which is read from tracing file 'available_filter_functions'.
>
> $ sudo ./perf ftrace -F | head
> trace_initcall_finish_cb
> initcall_blacklisted
> do_one_initcall
> do_one_initcall
> trace_initcall_start_cb
> run_init_process
> try_to_run_init_process
> match_dev_by_label
> match_dev_by_uuid
> rootfs_init_fs_context
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
>
> ---
> v2: option name '-l/--list-functions' -> '-F/--funcs'
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  4 +++
>  tools/perf/builtin-ftrace.c              | 43 ++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 952e46669168..d79560dea19f 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -30,6 +30,10 @@ OPTIONS
>  --verbose=::
>          Verbosity level.
>
> +-F::
> +--funcs::
> +        List all available functions to trace.
> +

Does "perf list tracepoint" contain this information? Perhaps add a
note to clarify.

Thanks,
Ian

>  -p::
>  --pid=::
>         Trace on existing process id (comma separated list).
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 5f53da87040d..244cc8e6bd60 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -32,6 +32,7 @@ struct perf_ftrace {
>         struct evlist           *evlist;
>         struct target           target;
>         const char              *tracer;
> +       bool                    list_avail_functions;
>         struct list_head        filters;
>         struct list_head        notrace;
>         struct list_head        graph_funcs;
> @@ -127,6 +128,43 @@ static int append_tracing_file(const char *name, const char *val)
>         return __write_tracing_file(name, val, true);
>  }
>
> +static int read_tracing_file_to_stdout(const char *name)
> +{
> +       char buf[4096];
> +       char *file;
> +       int fd;
> +       int ret = -1;
> +
> +       file = get_tracing_file(name);
> +       if (!file) {
> +               pr_debug("cannot get tracing file: %s\n", name);
> +               return -1;
> +       }
> +
> +       fd = open(file, O_RDONLY);
> +       if (fd < 0) {
> +               pr_debug("cannot open tracing file: %s: %s\n",
> +                        name, str_error_r(errno, buf, sizeof(buf)));
> +               goto out;
> +       }
> +
> +       /* read contents to stdout */
> +       while (true) {
> +               int n = read(fd, buf, sizeof(buf));
> +               if (n <= 0)
> +                       goto out_close;
> +               if (fwrite(buf, n, 1, stdout) != 1)
> +                       goto out_close;
> +       }
> +       ret = 0;
> +
> +out_close:
> +       close(fd);
> +out:
> +       put_tracing_file(file);
> +       return ret;
> +}
> +
>  static int reset_tracing_cpu(void);
>  static void reset_tracing_filters(void);
>
> @@ -301,6 +339,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>         signal(SIGCHLD, sig_handler);
>         signal(SIGPIPE, sig_handler);
>
> +       if (ftrace->list_avail_functions)
> +               return read_tracing_file_to_stdout("available_filter_functions");
> +
>         if (reset_tracing_files(ftrace) < 0) {
>                 pr_err("failed to reset ftrace\n");
>                 goto out;
> @@ -470,6 +511,8 @@ int cmd_ftrace(int argc, const char **argv)
>         const struct option ftrace_options[] = {
>         OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
>                    "tracer to use: function or function_graph (This option is deprecated)"),
> +       OPT_BOOLEAN('F', "funcs", &ftrace.list_avail_functions,
> +                   "Show available functions to filter"),
>         OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
>                    "trace on existing process id"),
>         OPT_INCR('v', "verbose", &verbose,
> --
> 2.25.1
>
