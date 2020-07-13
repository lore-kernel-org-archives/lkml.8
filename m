Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1281FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA922206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594606091;
	bh=Pi6N/zTv9uDUpZSYkTi+4GrzLJQSn6ktj2kp1KjP/Jg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u+NPXNB+AmyqRMutDNITG4ZlFCSQ4vEREMaBwKcZnH/t5JEntgd2X7P41Y6WEjDTk
	 /rTxlIIkm1yENMipMxBcfh6ybyOgErD2/6JMkfBo3bBPNmsDfudj0JUDbDLeIpwHPm
	 f0j1h4NLL4lra1Xfl5Muky0Pm9nCmax7CEjlZwT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgGMCIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:08:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51302 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGMCIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:08:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so11721610wmg.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JqMalK70RTxMXtSwcvKCPNkTTdjYqusM3wuf7O+RAk=;
        b=TPhL/AExsRMs+OABeyfOSLqYFtmosSxuOWm75pDGNa2OGE2vPbY6fT1JAiFFsGK0S2
         je8e9eUWxKYaCNWDRw58NZ3fbb8LHfGUSY7unvqauVQIrMT0wLt4QS/qTGthHEvzWnR9
         pCPq0xVo5torQeTWzEIAAHD5X7f9wBEScSWT0uJUXQeq28HHdiBn/xb1bq0ghehNSrNP
         H6yQzKS+ksNuixJfrb0L+Nxa/9APbe1CJHL//nBudab533jsg0xRz0dck1JL+bU1IgmY
         ZdiAiGDBwyIGJcL3xQOKfGLnDguiqS62z08erJMkhiMH5EndBqC/So9sndPsB15NSiv6
         WUxw==
X-Gm-Message-State: AOAM532ruvKzlyTqgBix1UT/8EvfSwaK8Q0AKv6nz4k0srqT7ok/3zSy
        /Lbe1sVxd9kf1GzmuKc2IbPafDY/BATKOGJKo/k=
X-Google-Smtp-Source: ABdhPJx7pfYk+GmmSXHYNbMeY2Tz9DBw9SO+79C9O/ifZ3UarX6mPnKog4XiPylSbfZR3hWEqT1beuCEtQc3daBDnHs=
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr17518706wmc.154.1594606087718;
 Sun, 12 Jul 2020 19:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200711124035.6513-1-changbin.du@gmail.com> <20200711124035.6513-14-changbin.du@gmail.com>
In-Reply-To: <20200711124035.6513-14-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Jul 2020 11:07:56 +0900
Message-ID: <CAM9d7chXR5nWTvuWA2+XxToyLmmYM-CozXRR9wg3g0if=PK+-g@mail.gmail.com>
Subject: Re: [PATCH v5 13/17] perf ftrace: add option 'verbose' to show more
 info for graph tracer
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

On Sat, Jul 11, 2020 at 9:43 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> Sometimes we want ftrace display more and longer information about
> the trace.
>
> $ sudo perf ftrace -G
>  2)   0.979 us    |  mutex_unlock();
>  2)   1.540 us    |  __fsnotify_parent();
>  2)   0.433 us    |  fsnotify();
>
> $ sudo perf ftrace -G --graph-opts verbose

These -G option usage should be changed..

Thanks
Namhyung


> 14160.770883 |   0)  <...>-47814   |  .... |   1.289 us    |  mutex_unlock();
> 14160.770886 |   0)  <...>-47814   |  .... |   1.624 us    |  __fsnotify_parent();
> 14160.770887 |   0)  <...>-47814   |  .... |   0.636 us    |  fsnotify();
> 14160.770888 |   0)  <...>-47814   |  .... |   0.328 us    |  __sb_end_write();
> 14160.770888 |   0)  <...>-47814   |  d... |   0.430 us    |  fpregs_assert_state_consistent();
> 14160.770889 |   0)  <...>-47814   |  d... |               |  do_syscall_64() {
> 14160.770889 |   0)  <...>-47814   |  .... |               |    __x64_sys_close() {
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  1 +
>  tools/perf/builtin-ftrace.c              | 29 +++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index e6e9564d6c2e..0dd5ef4f9c65 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -107,6 +107,7 @@ OPTIONS
>         List of options allowed to set:
>           nosleep-time - Measure on-CPU time only for function_graph tracer.
>           noirqs       - Ignore functions that happen inside interrupt.
> +         verbose      - Show process names, PIDs, timestamps, etc.
>
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index a5906258c413..d169d6329454 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -45,6 +45,7 @@ struct perf_ftrace {
>         int                     func_irq_info;
>         int                     graph_nosleep_time;
>         int                     graph_noirqs;
> +       int                     graph_verbose;
>  };
>
>  struct filter_entry {
> @@ -205,6 +206,9 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>         write_tracing_option_file("func_stack_trace", "0");
>         write_tracing_option_file("sleep-time", "1");
>         write_tracing_option_file("funcgraph-irqs", "1");
> +       write_tracing_option_file("funcgraph-proc", "0");
> +       write_tracing_option_file("funcgraph-abstime", "0");
> +       write_tracing_option_file("latency-format", "0");
>         write_tracing_option_file("irq-info", "0");
>  }
>
> @@ -420,6 +424,23 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
>         return 0;
>  }
>
> +static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
> +{
> +       if (!ftrace->graph_verbose)
> +               return 0;
> +
> +       if (write_tracing_option_file("funcgraph-proc", "1") < 0)
> +               return -1;
> +
> +       if (write_tracing_option_file("funcgraph-abstime", "1") < 0)
> +               return -1;
> +
> +       if (write_tracing_option_file("latency-format", "1") < 0)
> +               return -1;
> +
> +       return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>         char *trace_file;
> @@ -514,6 +535,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>                 goto out_reset;
>         }
>
> +       if (set_tracing_funcgraph_verbose(ftrace) < 0) {
> +               pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime\n");
> +               goto out_reset;
> +       }
> +
>         if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>                 pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>                 goto out_reset;
> @@ -696,6 +722,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
>         struct sublevel_option graph_tracer_opts[] = {
>                 { .name = "nosleep-time",       .value_ptr = &ftrace->graph_nosleep_time },
>                 { .name = "noirqs",             .value_ptr = &ftrace->graph_noirqs },
> +               { .name = "verbose",            .value_ptr = &ftrace->graph_verbose },
>                 { .name = NULL, }
>         };
>
> @@ -752,7 +779,7 @@ int cmd_ftrace(int argc, const char **argv)
>         OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
>                     "Max depth for function graph tracer"),
>         OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> -                    "graph tracer options, available options: nosleep-time,noirqs",
> +                    "graph tracer options, available options: nosleep-time,noirqs,verbose",
>                      parse_graph_tracer_opts),
>         OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
>                      "size of per cpu buffer", parse_buffer_size),
> --
> 2.25.1
>
