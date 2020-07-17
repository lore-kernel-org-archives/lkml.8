Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB856C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C07A20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKBmke/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgGQN6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQN6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:58:49 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E700C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:58:49 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t6so5475016plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0yc0MQzf+aR4c3kpqn6zKq+wL53e9ydsRsO1HQgCARc=;
        b=sKBmke/3eukk/6ewyzLkzBaS5s6MlT0Lo3BG2KEvEkNbpwrqDGvVt+gPRtVTeGCNlO
         jg/HP/JNS2YE2n4DzIjijUU52pwnZRDlP6UHdi0p3H9yaqWfSLM69hfFcJBFgQP5xvA/
         SRsk0Xn8z/3NjdlN66jWgiMzVCDX4Wa0dZ7Lmmsad+tqz2o+70KLE5vKm5mEUPILtghb
         oSjn0k8lmMyKO548havmnn0LNuA1UN+XDMXXppwvf0obECP4ya+T2HITpl4rfEckwIpg
         xnpP/fdQ0Q+dzy/+pdom++fa2voMqQZS+/wEZyHT1Y78UEcM5XCGpSZefxVljqZp881F
         hhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0yc0MQzf+aR4c3kpqn6zKq+wL53e9ydsRsO1HQgCARc=;
        b=Mc+uv9hM1W75Y+iotfj9DTWb8lRxPgvbXrkQYxTrq1NepOcKot3UgVm4QfNdLGN9Cr
         JiqAHTw/ERXrnUfiSa7lZgfx73E/AK8cM41OIeDxUF9N/UUVQx1HXaN2XVgtTniWFDVL
         Y6QdovGTduhp3RUP1dZoBfYvT1T1Y5lF24oGq3FVpKqAtg2cmq6GpSFM2oOiJnEzlL/T
         WtAeC0o6r+CjIjiHclaFKB8qKysPgn9pX5xKsXj1GS3XtMcLEgsAR36N1UwzcF1xtA9V
         v7W07rFP1rUEPMTpq79LfgDYjS96uH1nfof9tBnbFU7vMJzTv18qCr7awsp++ynJKFg4
         mmow==
X-Gm-Message-State: AOAM530iZTw3tsUoQ1qzmK52ptrUkiWxNIjiRVhb3QuEF0MzPyuT2w3k
        myLbOCX9fMsicWaAwSkxc00=
X-Google-Smtp-Source: ABdhPJw2fWUXn1hFsQSzz5uCj1nqsuJOAjXj1Hz6rh9fGkxVJnHtLfsaG6ds+7AhE/f5XNt1Ujp/bQ==
X-Received: by 2002:a17:90b:194f:: with SMTP id nk15mr10271270pjb.189.1594994328869;
        Fri, 17 Jul 2020 06:58:48 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a33sm7885213pgl.75.2020.07.17.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:58:48 -0700 (PDT)
Date:   Fri, 17 Jul 2020 21:58:38 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/17] perf ftrace: add option '-F/--funcs' to list
 available functions
Message-ID: <20200717135838.b2sch4sulsdptc6u@mail.google.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
 <20200711124035.6513-3-changbin.du@gmail.com>
 <CAM9d7cjdMQzt6RXOnugoZ77Psu4Y=j9w07quxvtWqo0XagxL6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjdMQzt6RXOnugoZ77Psu4Y=j9w07quxvtWqo0XagxL6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 10:49:40AM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Sat, Jul 11, 2020 at 9:42 PM Changbin Du <changbin.du@gmail.com> wrote:
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
> > index 5f53da87040d..244cc8e6bd60 100644
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
> As I said before, there's no break in the loop above
> so the ret can never be 0.
>
I see now. Just fixed it as:
        while (true) {
                int n = read(fd, buf, sizeof(buf));
-               if (n <= 0)
+               if (n == 0)
+                       break;
+               else if (n < 0)
                        goto out_close;
+

Thanks!

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
