Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53349C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD1F208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593758639;
	bh=v1FMDcY5Pi9fs6iVelxUUQh7Wuc4woj4RWY6/kUjJOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HOI7ZPMncKHOvM2BdhLrL71r37inYpIkINyhpNUuvHsalffcm/Cnp2Pp8lRTRhSzW
	 QBqb3gqNCzZlh2TrrPMXY1pNWL6HR0KBMcKrjmkiguJFu5zDQR9nK+arCmHDs2srgd
	 1XJd+gWGA0kmjNJzuDPh//eDp16aV9nFbkxJPx08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgGCGn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:43:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40106 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCGn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:43:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id f2so3475430wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZq9MpoAdPD5UWC2CLSSHKSsbw3XN/pMdjELns1KMFw=;
        b=sEI8wb0hQJcZPG9WsqrQS5qN++mvDXOlA9DGBKG9FXAKqMJpCG7LgrFaxB0EDYGzxj
         Tc7zZYg2VCch5o0fJg21MmzFiqGSkO+dkU6xo9LlXYj8JrmtGDniWbZjyOJhm0pMTOSY
         uOemfL4wHAh/TAKCEWKMa3ca3FuywBxanJH/BfpgmAyduWQFk0qTcI3Z9EfileeyLjvJ
         c6hEjReVYvmqPaxbC4JvGTA3Tvj+xSedyK+9l//9ABTbgkj7lPywNvua6gytPGDsWUeR
         Bs+bvZ+avsELrlSxm8ON8sw8i1fXKUFJcpi2MVF+aWpW9aA/doaOJGL4dPZS5ZtoKGK/
         5Vog==
X-Gm-Message-State: AOAM531/69o8tBGG9vwNlfqT5q8jFjilG/ajHw5Zo588pM6Y5eduiJaq
        O8i3azOg9mydhB98ZphWzg7krjzTRnIhWnavKxM=
X-Google-Smtp-Source: ABdhPJxuhT9W2xGcHsDH1JWwuABOtsDWSgcmlBIq3P3mL01+aHBdqvcPuCv03qdlhFQg8mSUXnCvUy4dfBbE8UiEiP8=
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr39041360wrs.60.1593758635438;
 Thu, 02 Jul 2020 23:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200627133654.64863-1-changbin.du@gmail.com> <20200627133654.64863-12-changbin.du@gmail.com>
In-Reply-To: <20200627133654.64863-12-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Jul 2020 15:43:38 +0900
Message-ID: <CAM9d7ciOwcviSnDra4WL2d3CrF6FsReuxz8VEZszJvqnNGPRjQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] perf ftrace: add support for trace option funcgraph-irqs
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

On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This adds an option '--graph-noirqs' to filter out functions executed
> in irq context.

Ditto.

>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
>
> ---
> v2: option name '--nofuncgraph-irqs' -> '--graph-noirqs'.
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  3 +++
>  tools/perf/builtin-ftrace.c              | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index a3000436f80b..b616e05d5156 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -107,6 +107,9 @@ OPTIONS
>  --graph-nosleep-time::
>         Measure on-CPU time only for function_graph tracer.
>
> +--graph-noirqs::
> +       Ignore functions that happen inside interrupt for function_graph tracer.
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-trace[1]
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index eba125a60820..876c8e800425 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -43,6 +43,7 @@ struct perf_ftrace {
>         bool                    inherit;
>         bool                    func_stack_trace;
>         bool                    graph_nosleep_time;
> +       bool                    graph_noirqs;
>  };
>
>  struct filter_entry {
> @@ -202,6 +203,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
>         write_tracing_option_file("function-fork", "0");
>         write_tracing_option_file("func_stack_trace", "0");
>         write_tracing_option_file("sleep-time", "1");
> +       write_tracing_option_file("funcgraph-irqs", "1");
>  }
>
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> @@ -393,6 +395,17 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
>         return 0;
>  }
>
> +static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
> +{
> +       if (!ftrace->graph_noirqs)
> +               return 0;
> +
> +       if (write_tracing_option_file("funcgraph-irqs", "0") < 0)
> +               return -1;
> +
> +       return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>         char *trace_file;
> @@ -477,6 +490,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>                 goto out_reset;
>         }
>
> +       if (set_tracing_funcgraph_irqs(ftrace) < 0) {
> +               pr_err("failed to set tracing option funcgraph-irqs\n");
> +               goto out_reset;
> +       }

Why not add set_tracing_options() which calls these individual functions
to handle option processing altogether?  It seems consistent to its
'reset' counterpart.

Thanks
Namhyung


> +
>         if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>                 pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>                 goto out_reset;
> @@ -658,6 +676,8 @@ int cmd_ftrace(int argc, const char **argv)
>                     "trace children processes"),
>         OPT_BOOLEAN(0, "graph-nosleep-time", &ftrace.graph_nosleep_time,
>                     "measure on-CPU time only for function_graph tracer"),
> +       OPT_BOOLEAN(0, "graph-noirqs", &ftrace.graph_noirqs,
> +                   "ignore functions that happen inside interrupt for function_graph tracer"),
>         OPT_END()
>         };
>
> --
> 2.25.1
>
