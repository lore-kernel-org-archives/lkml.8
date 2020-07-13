Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E894C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE537206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594604995;
	bh=6AamBurpy9+AxKfW1gohlKgJ2aljkY8iqEqObLcCJAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zHGJZ3cK0G6eaGEq1opXTnUe/6vwKQXb0iVVI94I+i3h3FkvbY8CEHmRT704Ko7e6
	 EAA9iAV5J3f23UrCg564bO731+R939YYQKhhnYwAl2LsuJUtjQfbJJqbRBMThh8YQE
	 vDSfZ62oTFQuDunw5ml3gX4h4bCkwsCJzpqfC/70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgGMBty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 21:49:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35242 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGMBty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 21:49:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id z2so13001290wrp.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 18:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPCoDa/hl3D7os23tsfhl2dMGhOJx2saiX6o3VaIndM=;
        b=rx5TBS/3ZQd7y5jrIHtbb1UVUjpbcuTZSEqyddv8UZgu1qXxJmPBiDix9NRLEPW5yX
         Nj7zPaMorlbelFfLLwL2tz8jvnijp2/RzlO0xxps9WRbaVibzxWYxE0C4GjNvGISTyCi
         GXN6dPuhH5nM9Dn7pK5IGKyWkoFZPt6tBJKNoP2kUf4EzIQLvZ7kS3odxKjxuFzaiNDU
         M41nOgsPyCuBLH5Ofna24uCsksxYXmyaoqrmOd5d+clZ/UspxbIky3eOCBSx8cOPdOWr
         5es2qNN6G+cIfvBGwmPFRefb84TFEJ9r9oN46iTJt+wCE1hnXoajAVhHiHVhYmapcMcW
         sgHg==
X-Gm-Message-State: AOAM531NmNmLCKlvbZH4OqWFtqGLs5POU9avLNameme246fFkzhLyM0H
        Xla1Arrj8Lcd11fpBGe94lo6PnjqFFq4u36zoLM=
X-Google-Smtp-Source: ABdhPJw6dfHqTrsIZwFz8ax+HmvOqeLyGm9EvQKawugOEXJrtDCqn5Yl4nwJ9Ui4zr410yeakY7rDib/jkz/HvHyBf8=
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr74029766wrx.332.1594604991928;
 Sun, 12 Jul 2020 18:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200711124035.6513-1-changbin.du@gmail.com> <20200711124035.6513-3-changbin.du@gmail.com>
In-Reply-To: <20200711124035.6513-3-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Jul 2020 10:49:40 +0900
Message-ID: <CAM9d7cjdMQzt6RXOnugoZ77Psu4Y=j9w07quxvtWqo0XagxL6A@mail.gmail.com>
Subject: Re: [PATCH v5 02/17] perf ftrace: add option '-F/--funcs' to list
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

Hello,

On Sat, Jul 11, 2020 at 9:42 PM Changbin Du <changbin.du@gmail.com> wrote:
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

As I said before, there's no break in the loop above
so the ret can never be 0.

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
