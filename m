Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714D6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C0F206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594605611;
	bh=n+aQUWiSb6h2BXxXQYkcx0Eplz2u6ntQNT8GPsHaOqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=evdL0dC5tTwz+cUAWpZ48+nJ+5caxriWM4GGhcklDY8KL5uiQySGRBgUJ4AvLGq8h
	 eQVM5GZBjo1fmnrhgMMhAqVdbBJnUx3od+m//S28h+ifYwjAIk+riCooMBktmQe3Mc
	 2C5gepTRVhAgt+G7soAybmwzinSJtE9pDKx2TSrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGMCAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:00:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45525 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGMCAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:00:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id s10so12972104wrw.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOgl4SH27K+97UgMx/iVFLrnmEiMUn5Mog1smCrys0g=;
        b=YivLVJU1vVYavts6sNdChWdEFi0iw6FHfIbGkqFwxtjRSIf5saDk14MsHRbdAWNqhR
         v7ucFaDSpRc0i0ECCqGvoQHvS4SF8AB5e11FBtxizRpNXq/Nni4RxamvReK1+0mL/Yjg
         kNRYzCDe4dIgyom/AoYiZsb2k0CgWxEWGv4f4iGsIzRFMKAznpc9Jgt5nuzrbX6MnLQY
         UlE0Gq9kjPMH8aenJw1TtH3P01sG8L7F91Dg+TZWMlK0A3kshtTknfmgfeP5YY/No/wc
         JY1UnjQg+wAhhyyaIr2wb8Lz6l9CIDGFiNVTnsvqpD7neBTd44QF1CIIxLah0yj7B95V
         wlvQ==
X-Gm-Message-State: AOAM532ims/OT/zHvf+BHa3W4W8lT3LZ2V2m2eRPzjQKQi9oMdciIeCm
        Ala5b3CKY6fDSqGUsOvXJK77ng7NfzQg0FZbRCo=
X-Google-Smtp-Source: ABdhPJznmPa+xG/aLTXTMC8Z/lIamQwbwwtg+rep3pvOAMR+B6wZApYux6VsBeyDvIiM0PYXP81FyC7lQ+OfpXAtsZs=
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr74050306wrx.332.1594605607353;
 Sun, 12 Jul 2020 19:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200711124035.6513-1-changbin.du@gmail.com> <20200711124035.6513-8-changbin.du@gmail.com>
In-Reply-To: <20200711124035.6513-8-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Jul 2020 10:59:56 +0900
Message-ID: <CAM9d7cgBeHW_Ot2nfBAzbV73gNKiOzp7K5KoTO=V4k=MGrZS6Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] perf ftrace: add option '--inherit' to trace
 children processes
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

On Sat, Jul 11, 2020 at 9:42 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This adds an option '--inherit' to allow us trace children
> processes spawned by our target.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
>
> ---
> v2: option name '--trace-children' -> '--inherit'.
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  3 ++
>  tools/perf/builtin-ftrace.c              | 38 ++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 98fe01d354d1..fd632bd9b2c1 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -61,6 +61,9 @@ OPTIONS
>         Set the size of per-cpu tracing buffer, <size> is expected to
>         be a number with appended unit character - B/K/M/G.
>
> +--inherit::
> +       Trace children processes spawned by our target.
> +
>  -T::
>  --trace-funcs=::
>         Only trace functions given by the argument.  Multiple functions
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 887e78b23a82..4efaa7b6a906 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -39,6 +39,7 @@ struct perf_ftrace {
>         struct list_head        nograph_funcs;
>         int                     graph_depth;
>         unsigned long           percpu_buffer_size;
> +       bool                    inherit;
>  };
>
>  struct filter_entry {
> @@ -177,9 +178,27 @@ static int write_tracing_file_int(const char *name, int value)
>         return 0;
>  }
>
> +static int write_tracing_option_file(const char *name, const char *val)
> +{
> +       char *file;
> +       int ret;
> +
> +       if (asprintf(&file, "options/%s", name) < 0)
> +               return -1;
> +
> +       ret = __write_tracing_file(file, val, false);
> +       free(file);
> +       return ret;
> +}
> +
>  static int reset_tracing_cpu(void);
>  static void reset_tracing_filters(void);
>
> +static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> +{
> +       write_tracing_option_file("function-fork", "0");
> +}
> +
>  static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  {
>         if (write_tracing_file("tracing_on", "0") < 0)
> @@ -198,6 +217,7 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>                 return -1;
>
>         reset_tracing_filters();
> +       reset_tracing_options(ftrace);
>         return 0;
>  }
>
> @@ -336,6 +356,17 @@ static int set_tracing_percpu_buffer_size(struct perf_ftrace *ftrace)
>         return 0;
>  }
>
> +static int set_tracing_trace_inherit(struct perf_ftrace *ftrace)
> +{
> +       if (!ftrace->inherit)
> +               return 0;
> +
> +       if (write_tracing_option_file("function-fork", "1") < 0)
> +               return -1;
> +
> +       return 0;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  {
>         char *trace_file;
> @@ -405,6 +436,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>                 goto out_reset;
>         }
>
> +       if (set_tracing_trace_inherit(ftrace) < 0) {
> +               pr_err("failed to set tracing option function-fork\n");
> +               goto out_reset;
> +       }

Can we have set_tracing_options() here instead to make
the __cmd_ftrace() shorter?  It'd set other options added later.
It's also symmetric to reset_tracing_options().

Thanks
Namhyung

> +
>         if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>                 pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
>                 goto out_reset;
> @@ -599,6 +635,8 @@ int cmd_ftrace(int argc, const char **argv)
>                     "Max depth for function graph tracer"),
>         OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
>                      "size of per cpu buffer", parse_buffer_size),
> +       OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
> +                   "trace children processes"),
>         OPT_END()
>         };
>
> --
> 2.25.1
>
