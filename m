Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E80C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E6920823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590006693;
	bh=2xWXSLA1iPuLF/4U+tLR1D4lYvQG7n2QJePYVkWCJy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JCmjQLcTfbCQF6E/FiQV0tLxPY192c5w7mG+JU9Nvy4iQqls+rZXyzY8vs71EDeac
	 aWJAzIlCKOe4kVhehQl+eB9W3gftjZ/Tcc31RU15dFlzjE2eRVBW5EWs0wwP7EVkou
	 Yp54MDDSqgmSJwoi0sL4N7uIkoSqPrT1HEuiOZw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgETUbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgETUbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:31:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35763207E8;
        Wed, 20 May 2020 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590006691;
        bh=2xWXSLA1iPuLF/4U+tLR1D4lYvQG7n2QJePYVkWCJy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYKlGwVJ9txWCu4XWhddSPDB9OnYexaWYo0MBtiGqs5nZehe8DK+ynPVGqHc/bwc9
         65IEZpPK2mMKQaIHvyug76m1NYbGZVL2pynBTHZLQJeIl/jgBU4M/purLJxD3YuBGO
         hEicNJuiU5nn1FbbljTAhxeeG9qX/08LbqlIXVzw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8F7A040AFD; Wed, 20 May 2020 17:31:28 -0300 (-03)
Date:   Wed, 20 May 2020 17:31:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] perf: ftrace enhancement
Message-ID: <20200520203128.GN32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:09PM +0800, Changbin Du escreveu:
> The perf has basic kernel ftrace support but lack support of most tracing
> options. This serias is target to enhance the perf ftrace functionality so
> that we can make full use of kernel ftrace with only perf.

Quite a lot! Going thru it now.

- Arnaldo
 
> In general, this serias be cataloged into two main changes:
>   1) Improve usability of existing functions. For example, we don't need to type
>      extra option to select the tracer.
>   2) Add new options to support all other ftrace functions.
> 
> Here is a glance of all ftrace functions with this serias:
>   * - improved existing options.
>   + - new added options.
> 
> $ sudo perf ftrace -h
> 
>  Usage: perf ftrace [<options>] [<command>]
>     or: perf ftrace [<options>] -- <command> [<options>]
> 
> *   -a, --all-cpus        system-wide collection from all CPUs
> +   -b, --buffer-size <n>
>                           size of per cpu buffer in kb
>     -C, --cpu <cpu>       list of cpus to monitor
> +   -d, --delay <n>       Wait <n> ms before tracing
>     -D, --graph-depth <n>
>                           Max depth for function graph tracer
> *   -G, --graph-funcs <func>
>                           Set graph filter on given functions (imply to use function_graph tracer)
>     -g, --nograph-funcs <func>
>                           Set nograph filter on given functions (imply to use function_graph tracer)
> +   -L, --list-functions  List available functions to filter
> +   -l, --long-info       Show process names, PIDs, timestamps, irq-info if available
>     -N, --notrace-funcs <func>
>                           do not trace given functions
> +   -P, --no-pager        Do not use pager
>     -p, --pid <pid>       trace on existing process id
> +   -s, --func-stack-trace
>                           Show kernel stack trace for function tracer
> +   -t, --tid <tid>       trace on existing thread id (exclusive to --pid)
>     -T, --trace-funcs <func>
>                           trace given functions only
> +   -u, --userstacktrace  Show stacktrace of the current user space thread
>     -v, --verbose         be more verbose
> +       --funcgraph-tail  Show function tails comment (function_graph only)
> +       --latency-format  displays additional information about the latency (function_graph only)
> +       --nofuncgraph-irqs
>                           Ignore functions that happen inside interrupt (function_graph only)
> +       --nosleep-time    Measure on-CPU time only (function_graph only)
> +       --trace-children  Trace children processes
> +       --tracing-thresh <n>
>                           Only show functions of which the duration is greater than <n>µs
> 
> 
> Changbin Du (19):
>   perf ftrace: trace system wide if no target is given
>   perf ftrace: detect workload failure
>   perf ftrace: select function/function_graph tracer automatically
>   perf ftrace: add support for tracing option 'func_stack_trace'
>   perf ftrace: add option '-l/--list-functions' to list available
>     functions
>   perf ftrace: add support for trace option sleep-time
>   perf ftrace: add support for trace option funcgraph-irqs
>   perf ftrace: add option -l/--long-info to show more info
>   perf ftrace: add support for trace option tracing_thresh
>   perf ftrace: add support for trace option funcgraph-tail
>   perf ftrace: add option '-u/--userstacktrace' to show userspace
>     stacktrace
>   perf ftrace: add support for tracing children processes
>   perf ftrace: add option '-b/--buffer-size' to set per-cpu buffer size
>   perf ftrace: add option -P/--no-pager to disable pager
>   perf ftrace: show trace column header
>   perf ftrace: add option -t/--tid to filter by thread id
>   perf ftrace: add option -d/--delay to delay tracing
>   perf ftrace: add option --latency-format to display more info about
>     delay
>   perf ftrace: add change log
> 
>  tools/perf/Documentation/perf-config.txt |   5 -
>  tools/perf/builtin-ftrace.c              | 388 ++++++++++++++++++++---
>  2 files changed, 345 insertions(+), 48 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 

- Arnaldo
