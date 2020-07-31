Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733AFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DD92083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AScF1t99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbgGaRfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732970AbgGaRft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:35:49 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:35:49 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so9953464plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VcO97KiNQ57vQLDytlgFQo02u8DyBACQIA2jsBc3GOY=;
        b=AScF1t99iyqzlHsSSNHl6NgK4CUk9FOl2bLkUT34rlkXHPyhsulWMSfAwgMbXTTpL1
         fTSY78+pJKT9XovDMqONCcLnk1/D14sqJ3GT//hhWqFNKCirnVhSMVaNAf0HQLhX4VDi
         YAbwXSqTGMxhPz+d6KimWBmdv1/OELdO0sb0yv9YGK+9LsTTOYFSKLyQKcUv/Tpin+Re
         tA9ZlYExz1ppt3UK/zuBRPL9RpVEsUHAzXKtFqFnBCzSFA/QryTOoOJtZlmczFvGi4qa
         EI/4wV1BGm7gFUs/bZgkYuquWcyzc8zJV5PUoYngbmRW+EQ19ijqmjd1/G2CoNrrib3z
         aHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VcO97KiNQ57vQLDytlgFQo02u8DyBACQIA2jsBc3GOY=;
        b=D6xvB8kYsLhxYV98NVXUgqtxNUXldckFtAE1wp7CxyXSo/UMNKXn5Ikqi6UJfzDK37
         lKknfsw7cPflNT2SK5CBox5H2RmT/iAwut9RdJAyJMSTQDQAy0sKq7bBNbs/btkurQfl
         N3YK7lYf7qJbjayRuIU5oAvbstq59p9AAViCL/9N9JRlJTMFg1ndImwWcVbMyEkGkNv1
         KWm4SL62DIrv4k8nQUIW5unAqS47frJ4XUrD9NP4X0VKgpme3Vqj1ojOkrA0XDoC7T5n
         QZ+9tzJTmjvix7Zb6j+tOJp2bxWAAuRrcLQ8V8TS0KJ5fHu5GLlSWIZQHWq+Th8/1/94
         vuDw==
X-Gm-Message-State: AOAM532kuEvHEURuIY4vaASe2+c1dq5Dbv0I+uvv6U2iebIDZ4G2sldG
        TQZbqHkdWrit2UZE+JKJ8ew=
X-Google-Smtp-Source: ABdhPJzl+vM0VT1edrfjKKLtwrmx7aowWI5RLQTaewg9lltoLt7+l+E3mX0zSJzD0r4OWUNPxkzinA==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr4399388ply.140.1596216949033;
        Fri, 31 Jul 2020 10:35:49 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id u14sm10422774pgf.51.2020.07.31.10.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 10:35:48 -0700 (PDT)
Date:   Sat, 1 Aug 2020 01:35:20 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/18] perf: ftrace enhancement
Message-ID: <20200731173520.x3edhuk73zt7tyuo@mail.google.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,
Are we ready to merge this serias now? Thanks. :)

On Sat, Jul 18, 2020 at 02:48:08PM +0800, Changbin Du wrote:
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

-- 
Cheers,
Changbin Du
