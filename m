Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2846C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D96420771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593755914;
	bh=5+0ZSAe9cuNmrG/7w6RVE0auMBjevxPDzfPDOP6oAtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TOQIm6tPhXmpLw8WuXsx18Xm96FglvaHOrSz6L3gSpwQo0bkIyTNk4irEIKDSKq9E
	 uWtZrl3YjOdpV3Tty3tGRV+J5+y7CBG7Q3xnXyIxnOQddcNHQ1OJq+sdr8KONuELfW
	 IvA7pDkp42syFHmDOJ8ivf3a8BLoOYFqjjmGYGuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGCF6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:58:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42483 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCF6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:58:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id o11so31349070wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 22:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+aPRanIMiQjjns8+RslY/lDrmQZhnXMm0sSLoknRXk=;
        b=o/p1z2gYGfi7/2svx3oqliEO4EFuoXIeBg8eqVq8g1YF8rXgG7D4/AsJQXPfSP780C
         YBts59B8z4oupGbpTgzpmWuB0XfaEADbAlnjttjrC8j2aZPGwdzUfxMIsr1q/0PMqUOU
         ULcFUmjKZY32N3dQjZHUFcY9W9+zjyBFCoNpwbxzy3o8qM+yJlXWvXDqv4nLVypkODbw
         bsyDT2NJDkNEIG+DhOHycwTQoaErlHuRmCCRrceZhwcBfihjlM8GhiVUczzOJHaTrqWK
         rmJfoz3gPYtIRnwY/mocpV0uzfI02V/wXlw+UDZ++jwG4SoFaa1Wg0uSooVb9AWe7KpF
         TPpA==
X-Gm-Message-State: AOAM530/y6ApLE7+D1mKzZtn65OelOzxkct+NgE5tNWhsjHNU1rH8saZ
        tnKV/abg0qiXA3u0URh+PI3gc0657TXlbJDzGj0=
X-Google-Smtp-Source: ABdhPJz6iIPxqmlNgAXX5fDyi72wKHkG6iN4jN5o5dhLvAP75GKSTcyIvHgUnrOaYnc2OeFpBoT0nnuL2qa5i9Y6o3A=
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr35011343wrr.391.1593755910673;
 Thu, 02 Jul 2020 22:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200627133654.64863-1-changbin.du@gmail.com> <20200627133654.64863-3-changbin.du@gmail.com>
In-Reply-To: <20200627133654.64863-3-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Jul 2020 14:58:19 +0900
Message-ID: <CAM9d7cikz4U2E2Kgj8WXx4MNvj9odJQKWf9KLRFD2mos35DJ2A@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] perf ftrace: add option '-F/--funcs' to list
 available functions
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

On Sat, Jun 27, 2020 at 10:37 PM Changbin Du <changbin.du@gmail.com> wrote:
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
>  -p::
>  --pid=::
>         Trace on existing process id (comma separated list).
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index c5718503eded..e793118e83a9 100644
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

It seems the return value cannot be 0?

Thanks
Namhyung

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
