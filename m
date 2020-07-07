Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72DAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC8E20663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8V/2Meg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgGGPQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgGGPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:16:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D89C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:16:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so13282636pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v+GP/QfgjGR3mjxU9s42DqxMpQEDri5uHWLzxTvF4II=;
        b=a8V/2Megc0AlbIJy0BpS4/HUT4ZrPEDL7dS41uTS9obgKmvWjnxedjcHCNbxg8m04U
         vgxo1QlMfZcIziru05ft0EwjYTF4Wt8mNH7Cnu4LVs8QvoBjL3Tosg5gOEOeBXOAddB4
         54uP0IrrVNB0KND2cUhamY5Iunf4Qb5pdxIJFxlbxliXPgHD6s1ZQGNL3zsqs/rszhyg
         yxlQT0ewFZPHQy95JIRj5kF+HzW9lCTLeBupvqyO9X6sAH3YMvwXkw2CHNTEuvsXjVdT
         BX1ev+dTLA7wikmQmGtKzmjFWp5QmwWC4VbABNjIKypILdarHgjbAiN8CjhqOgY+icbr
         xUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v+GP/QfgjGR3mjxU9s42DqxMpQEDri5uHWLzxTvF4II=;
        b=qRR2JaPfYH4cPA26PaotxVUfwtHIj0atEBEyjo6ASSonQv172r+3RqyoNDd9ivWFIC
         c6nGomFxLtqVDmi5cYbK81ShRyb5ytgNBAcppOZIDd6heUsFcOM1Qwc/C7/CIeqow54R
         vzOuhwdQpIiKKkQLx5sqxi8rvIMtAYsTFvhk6NdkYLiHR4nJktsrWI5WyHP35lKdxn4t
         NFZTZSAshVEmjhKfZibhofYY1WtOqg827SuJ54x9mv7j3CobZxX/f08w8Ug2aVxAfvoW
         T70DnYfhdIIteeVMKiU51oWhUwiY0XsW9+ckgTT4mKuTYJsVeWxiC5lQayCpSvJKtls7
         WcmA==
X-Gm-Message-State: AOAM532i2+SwYZi0kKe+sGbCT+z2FbwK6Yky3iZfyvc0FRdPH3LI2YEW
        rD8ZRm8acAHCbn4Ni59gavI=
X-Google-Smtp-Source: ABdhPJzIQU08zY/vwhj5vkqtlNcOPrKuwA8GEKqF+ctz9lRxShzJxVZwubE4tzMQYQcC9OEg/iVx1w==
X-Received: by 2002:a62:cfc1:: with SMTP id b184mr12171884pfg.153.1594134959979;
        Tue, 07 Jul 2020 08:15:59 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id m92sm2978112pje.13.2020.07.07.08.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:15:59 -0700 (PDT)
Date:   Tue, 7 Jul 2020 23:15:38 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/15] perf ftrace: add option '-F/--funcs' to list
 available functions
Message-ID: <20200707151538.ga65xtkwhqegckud@mail.google.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
 <20200627133654.64863-3-changbin.du@gmail.com>
 <CAM9d7cikz4U2E2Kgj8WXx4MNvj9odJQKWf9KLRFD2mos35DJ2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cikz4U2E2Kgj8WXx4MNvj9odJQKWf9KLRFD2mos35DJ2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 02:58:19PM +0900, Namhyung Kim wrote:
> On Sat, Jun 27, 2020 at 10:37 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > This adds an option '-F/--funcs' to list all available functions to trace,
> > which is read from tracing file 'available_filter_functions'.
> >
> > $ sudo ./perf ftrace -F | head
> > trace_initcall_finish_cb
> > initcall_blacklisted
> > do_one_initcall
> > do_one_initcall
> > trace_initcall_start_cb
> > run_init_process
> > try_to_run_init_process
> > match_dev_by_label
> > match_dev_by_uuid
> > rootfs_init_fs_context
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >
> > ---
> > v2: option name '-l/--list-functions' -> '-F/--funcs'
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt |  4 +++
> >  tools/perf/builtin-ftrace.c              | 43 ++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index 952e46669168..d79560dea19f 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -30,6 +30,10 @@ OPTIONS
> >  --verbose=::
> >          Verbosity level.
> >
> > +-F::
> > +--funcs::
> > +        List all available functions to trace.
> > +
> >  -p::
> >  --pid=::
> >         Trace on existing process id (comma separated list).
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index c5718503eded..e793118e83a9 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -32,6 +32,7 @@ struct perf_ftrace {
> >         struct evlist           *evlist;
> >         struct target           target;
> >         const char              *tracer;
> > +       bool                    list_avail_functions;
> >         struct list_head        filters;
> >         struct list_head        notrace;
> >         struct list_head        graph_funcs;
> > @@ -127,6 +128,43 @@ static int append_tracing_file(const char *name, const char *val)
> >         return __write_tracing_file(name, val, true);
> >  }
> >
> > +static int read_tracing_file_to_stdout(const char *name)
> > +{
> > +       char buf[4096];
> > +       char *file;
> > +       int fd;
> > +       int ret = -1;
> > +
> > +       file = get_tracing_file(name);
> > +       if (!file) {
> > +               pr_debug("cannot get tracing file: %s\n", name);
> > +               return -1;
> > +       }
> > +
> > +       fd = open(file, O_RDONLY);
> > +       if (fd < 0) {
> > +               pr_debug("cannot open tracing file: %s: %s\n",
> > +                        name, str_error_r(errno, buf, sizeof(buf)));
> > +               goto out;
> > +       }
> > +
> > +       /* read contents to stdout */
> > +       while (true) {
> > +               int n = read(fd, buf, sizeof(buf));
> > +               if (n <= 0)
> > +                       goto out_close;
> > +               if (fwrite(buf, n, 1, stdout) != 1)
> > +                       goto out_close;
> > +       }
> > +       ret = 0;
> 
> It seems the return value cannot be 0?
>
If all above success, the return value is 0.

> Thanks
> Namhyung
> 
> > +
> > +out_close:
> > +       close(fd);
> > +out:
> > +       put_tracing_file(file);
> > +       return ret;
> > +}
> > +
> >  static int reset_tracing_cpu(void);
> >  static void reset_tracing_filters(void);
> >
> > @@ -301,6 +339,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >         signal(SIGCHLD, sig_handler);
> >         signal(SIGPIPE, sig_handler);
> >
> > +       if (ftrace->list_avail_functions)
> > +               return read_tracing_file_to_stdout("available_filter_functions");
> > +
> >         if (reset_tracing_files(ftrace) < 0) {
> >                 pr_err("failed to reset ftrace\n");
> >                 goto out;
> > @@ -470,6 +511,8 @@ int cmd_ftrace(int argc, const char **argv)
> >         const struct option ftrace_options[] = {
> >         OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
> >                    "tracer to use: function or function_graph (This option is deprecated)"),
> > +       OPT_BOOLEAN('F', "funcs", &ftrace.list_avail_functions,
> > +                   "Show available functions to filter"),
> >         OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
> >                    "trace on existing process id"),
> >         OPT_INCR('v', "verbose", &verbose,
> > --
> > 2.25.1
> >

-- 
Cheers,
Changbin Du
