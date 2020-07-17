Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57361C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3C820734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjjDNDR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGQON7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgGQON6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:13:58 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E489C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:13:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so6728289pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zvZ07QUbw1KAtqrM8eISqeV5WX1gbSQeNVkVM1NHWio=;
        b=gjjDNDR4utp9lQM0WvDgN45t4Sc9WixyWpXemWBnN5LOgPQikMep0mnZwC8ObmHf5Z
         7s+QeEYgQL58jXQLJILx7mHeWjqmZWeuUpSxGOgPogXqApIVTz6UCXbWDNvcqKc6oUYg
         gU6aWifVlmrY0qjT4OLbu2+V8kOptNwzVsxIeuBe7u+ikMN/EegVLhl2+YJoxtTVx640
         6NHMBgXHH/bo1Vf1vdzSGDC2Lhl+RrM6+zrdnueueK5k81omQWIAlGwXEei9en4IVrVG
         WgFJOCklfKCReOYgRiE43vKoyYGdBIfWmjFVRcXSQIHg/fV+unElQLpeqqYwS90WgT49
         yLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zvZ07QUbw1KAtqrM8eISqeV5WX1gbSQeNVkVM1NHWio=;
        b=RfRQrzo0ENvShNzwyvZEzPauDMAUBLsH8qDV+z8kt5mKXars2ggwUSqT4EWa1EpcgP
         KDeZrgIsX49uowaVtDmtf6+VfMtxabsbLukVnUpRM0p5U2IWcImhyqdUxCWnt236yvHO
         x3Ctfs7KWN4RBFMmAtrcPrhPqM5Q2YAUhMbmgY9trKRm3k1be/iEPVKjdrh/FfsNAGz1
         w4lM8ZIqcsFovgN1hjVv7ELPUvVbtSrG28+sDdxi/G/z43k62VXFaZLwkoBz93RUWkyB
         VU192ZZPqox5rLEhNB1iq0P/zRLxOy+mZJiiREghxnqEtfsmcsfhrCnINPJMlUY6ot14
         CTKA==
X-Gm-Message-State: AOAM531Ixzt8xJN8Gowkt0rvqIOwsZ3WE6jysR5K6tbm7q/A9YrulzWb
        WBbsGpp1fF55W1gEBrPQnKM=
X-Google-Smtp-Source: ABdhPJzqxA8CaHhEstL1wrHIcfMA+uUNDQ/SZkSr4c1b298qJ1ldxtaPLFvQf7COPkIGfgekFe/MZQ==
X-Received: by 2002:a63:308:: with SMTP id 8mr9382313pgd.112.1594995237846;
        Fri, 17 Jul 2020 07:13:57 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id b6sm8343152pfp.0.2020.07.17.07.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:13:55 -0700 (PDT)
Date:   Fri, 17 Jul 2020 22:13:45 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/17] perf ftrace: add option 'verbose' to show more
 info for graph tracer
Message-ID: <20200717141345.3u2mptgv5aaksxag@mail.google.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
 <20200711124035.6513-14-changbin.du@gmail.com>
 <CAM9d7chXR5nWTvuWA2+XxToyLmmYM-CozXRR9wg3g0if=PK+-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chXR5nWTvuWA2+XxToyLmmYM-CozXRR9wg3g0if=PK+-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 11:07:56AM +0900, Namhyung Kim wrote:
> On Sat, Jul 11, 2020 at 9:43 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Sometimes we want ftrace display more and longer information about
> > the trace.
> >
> > $ sudo perf ftrace -G
> >  2)   0.979 us    |  mutex_unlock();
> >  2)   1.540 us    |  __fsnotify_parent();
> >  2)   0.433 us    |  fsnotify();
> >
> > $ sudo perf ftrace -G --graph-opts verbose
> 
> These -G option usage should be changed..
>
The commit mesge is update now. Thanks.

> Thanks
> Namhyung
> 
> 
> > 14160.770883 |   0)  <...>-47814   |  .... |   1.289 us    |  mutex_unlock();
> > 14160.770886 |   0)  <...>-47814   |  .... |   1.624 us    |  __fsnotify_parent();
> > 14160.770887 |   0)  <...>-47814   |  .... |   0.636 us    |  fsnotify();
> > 14160.770888 |   0)  <...>-47814   |  .... |   0.328 us    |  __sb_end_write();
> > 14160.770888 |   0)  <...>-47814   |  d... |   0.430 us    |  fpregs_assert_state_consistent();
> > 14160.770889 |   0)  <...>-47814   |  d... |               |  do_syscall_64() {
> > 14160.770889 |   0)  <...>-47814   |  .... |               |    __x64_sys_close() {
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt |  1 +
> >  tools/perf/builtin-ftrace.c              | 29 +++++++++++++++++++++++-
> >  2 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index e6e9564d6c2e..0dd5ef4f9c65 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -107,6 +107,7 @@ OPTIONS
> >         List of options allowed to set:
> >           nosleep-time - Measure on-CPU time only for function_graph tracer.
> >           noirqs       - Ignore functions that happen inside interrupt.
> > +         verbose      - Show process names, PIDs, timestamps, etc.
> >
> >  SEE ALSO
> >  --------
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index a5906258c413..d169d6329454 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -45,6 +45,7 @@ struct perf_ftrace {
> >         int                     func_irq_info;
> >         int                     graph_nosleep_time;
> >         int                     graph_noirqs;
> > +       int                     graph_verbose;
> >  };
> >
> >  struct filter_entry {
> > @@ -205,6 +206,9 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> >         write_tracing_option_file("func_stack_trace", "0");
> >         write_tracing_option_file("sleep-time", "1");
> >         write_tracing_option_file("funcgraph-irqs", "1");
> > +       write_tracing_option_file("funcgraph-proc", "0");
> > +       write_tracing_option_file("funcgraph-abstime", "0");
> > +       write_tracing_option_file("latency-format", "0");
> >         write_tracing_option_file("irq-info", "0");
> >  }
> >
> > @@ -420,6 +424,23 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
> >         return 0;
> >  }
> >
> > +static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
> > +{
> > +       if (!ftrace->graph_verbose)
> > +               return 0;
> > +
> > +       if (write_tracing_option_file("funcgraph-proc", "1") < 0)
> > +               return -1;
> > +
> > +       if (write_tracing_option_file("funcgraph-abstime", "1") < 0)
> > +               return -1;
> > +
> > +       if (write_tracing_option_file("latency-format", "1") < 0)
> > +               return -1;
> > +
> > +       return 0;
> > +}
> > +
> >  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  {
> >         char *trace_file;
> > @@ -514,6 +535,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >                 goto out_reset;
> >         }
> >
> > +       if (set_tracing_funcgraph_verbose(ftrace) < 0) {
> > +               pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime\n");
> > +               goto out_reset;
> > +       }
> > +
> >         if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
> >                 pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
> >                 goto out_reset;
> > @@ -696,6 +722,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
> >         struct sublevel_option graph_tracer_opts[] = {
> >                 { .name = "nosleep-time",       .value_ptr = &ftrace->graph_nosleep_time },
> >                 { .name = "noirqs",             .value_ptr = &ftrace->graph_noirqs },
> > +               { .name = "verbose",            .value_ptr = &ftrace->graph_verbose },
> >                 { .name = NULL, }
> >         };
> >
> > @@ -752,7 +779,7 @@ int cmd_ftrace(int argc, const char **argv)
> >         OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
> >                     "Max depth for function graph tracer"),
> >         OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> > -                    "graph tracer options, available options: nosleep-time,noirqs",
> > +                    "graph tracer options, available options: nosleep-time,noirqs,verbose",
> >                      parse_graph_tracer_opts),
> >         OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
> >                      "size of per cpu buffer", parse_buffer_size),
> > --
> > 2.25.1
> >

-- 
Cheers,
Changbin Du
