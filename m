Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDCBC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE6C22CBB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595338788;
	bh=fTNOXGIa7biqPv6Z2GuhWIBaCeoFIYX81BxPw11/p6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PpUV5VV7oU9JVnjpQAtVmA8v/tS//wxcUFVsm192gnkzKwtU7hFyFiokvAd14mHJJ
	 bwp5we7QzTM4vQOfOx1+b9WXpr1TkzhVIIFxJhxrKr3TIikrzgAV/erHikPA51UK6H
	 puDbN+b1zdpadkm9XaUzZjuAihAd5lrtBoFBfPoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgGUNjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:39:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39551 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgGUNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:39:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5so21239288wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EynrwAgZ+BIcVK8jOHfPKfboNTbROApvtg8PYw4Yzk=;
        b=aa5DXzi4KmKVOZWF8Eypoee/j7sBRa8UFBg2S/TwXg9Phk+m3ApW8eRyApoGfZ7GwP
         J7SAU2g1TZjj1tkZvn9vA3KXeicBw/d+oR+PqKCDb2hdty0ava7lpno4ze/SmISCc0ny
         LVlbKn8uOWP5ZrcUHkHz0otJ7pTowORnCRqbRIkg8BkanruXi+ypTqCD2s7qsi+Ybwmw
         vSGkb/RKKXlQE4QQmHrzd+m4Trb9+2GB8XU7TcslN1w74JuJzJPl6IqgxCsnBgV719VE
         qeXi6nD+qJsbIWybfq8rMHmtj8nsro5eVprmginq2BWUJl0SW6ZyNimllmsPtdzZmCzq
         5TEQ==
X-Gm-Message-State: AOAM530HmL+jFhNSGvX4Z4bIEOe58g7a+KiWaasAHKcEH9xJT3KatoQv
        gfqIe9Nq//CXefOgug0pDqOoJaokkPVmtXk1/0Y=
X-Google-Smtp-Source: ABdhPJxZ6BH20IUKsNG5HXoYCol9gZidHeeK/PC5GK5GkSDZFzeG1La7jzhU7vlR5gRrdfECzw0Rm2bZe/JXb03rE9U=
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr954300wrn.60.1595338785533;
 Tue, 21 Jul 2020 06:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200718064826.9865-1-changbin.du@gmail.com>
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 21 Jul 2020 22:39:34 +0900
Message-ID: <CAM9d7ci_5J-NCo2o0-ALj85A79YFcs1BJCwcXBUY_p8VznmTMQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/18] perf: ftrace enhancement
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

On Sat, Jul 18, 2020 at 3:48 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> The perf has basic kernel ftrace support but lack support of most tracing
> options. This serias is target to enhance the perf ftrace functionality so
> that we can make full use of kernel ftrace with perf.
>
> In general, this serias be cataloged into two main changes:
>   1) Improve usability of existing functions. For example, we don't need to type
>      extra option to select the tracer.
>   2) Add new options to support all other ftrace functions.
>
> Here is a glance of all ftrace functions with this serias:
>
> $ sudo perf ftrace -h
>
>  Usage: perf ftrace [<options>] [<command>]
>     or: perf ftrace [<options>] -- <command> [<options>]
>
>     -a, --all-cpus        system-wide collection from all CPUs
>     -C, --cpu <cpu>       list of cpus to monitor
>     -D, --delay <n>       ms to wait before starting tracing after program start
>     -F, --funcs           Show available functions to filter
>     -G, --graph-funcs <func>
>                           trace given functions using function_graph tracer
>     -g, --nograph-funcs <func>
>                           Set nograph filter on given functions
>     -m, --buffer-size <size>
>                           size of per cpu buffer
>     -N, --notrace-funcs <func>
>                           do not trace given functions
>     -p, --pid <pid>       trace on existing process id
>     -T, --trace-funcs <func>
>                           trace given functions using function tracer
>     -t, --tracer <tracer>
>                           tracer to use: function or function_graph (This option is deprecated)
>     -v, --verbose         be more verbose
>         --func-opts <options>
>                           function tracer options, available options: call-graph,irq-info
>         --graph-opts <options>
>                           graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>
>         --inherit         trace children processes
>         --tid <tid>       trace on existing thread id (exclusive to --pid)
>
> v7:
>   o add back '--tid <tid>'.
> v6:
>   o fix return value of read_tracing_file_to_stdout().
>   o make __cmd_ftrace() shorter.
>   o remove option '-t, --tid <tid>'.
> v5:
>   o trivial fixes.
> v4:
>   o add util/parse-sublevel-options.c
>   O remove -D/--graph-depth
> v3:
>   o add --func-opts and --graph-opts to set tracer specific options.
>   o support units as a suffix for option '-m/--buffer-size'.
> v2:
>   o patches for option '-u/--userstacktrace' and '--no-pager' are dropped.
>   o update all related perf documentation.
>   o rename some options. Now all funcgraph tracer options are prefixed with
>     '--graph-', while all function tracer options are prefixed with '--func-'.
>   o mark old options deprecated instead of removing them.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

>
>
> Changbin Du (18):
>   perf ftrace: select function/function_graph tracer automatically
>   perf ftrace: add option '-F/--funcs' to list available functions
>   perf ftrace: factor out function write_tracing_file_int()
>   perf ftrace: add option '-m/--buffer-size' to set per-cpu buffer size
>   perf ftrace: show trace column header
>   perf ftrace: add option '--inherit' to trace children processes
>   perf: util: add general function to parse sublevel options
>   perf ftrace: add support for tracing option 'func_stack_trace'
>   perf ftrace: add support for trace option sleep-time
>   perf ftrace: add support for trace option funcgraph-irqs
>   perf ftrace: add support for tracing option 'irq-info'
>   perf ftrace: add option 'verbose' to show more info for graph tracer
>   perf ftrace: add support for trace option tracing_thresh
>   perf: ftrace: allow set graph depth by '--graph-opts'
>   perf ftrace: add option -D/--delay to delay tracing
>   perf ftrace: add option --tid to filter by thread id
>   perf: ftrace: Add set_tracing_options() to set all trace options
>   perf ftrace: add change log
>
>  tools/perf/Documentation/perf-config.txt |   5 -
>  tools/perf/Documentation/perf-ftrace.txt |  36 +-
>  tools/perf/builtin-ftrace.c              | 415 +++++++++++++++++++++--
>  tools/perf/util/Build                    |   1 +
>  tools/perf/util/debug.c                  |  61 +---
>  tools/perf/util/parse-sublevel-options.c |  70 ++++
>  tools/perf/util/parse-sublevel-options.h |  11 +
>  7 files changed, 513 insertions(+), 86 deletions(-)
>  create mode 100644 tools/perf/util/parse-sublevel-options.c
>  create mode 100644 tools/perf/util/parse-sublevel-options.h
>
> --
> 2.25.1
>
