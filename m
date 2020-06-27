Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A341EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AAB21582
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y24TpYp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgF0NhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgF0NhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:37:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54404C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:37:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b16so5880992pfi.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMfTKMXJJ+uG9witg1g7+yEtNI0nSxRLJvkxgOHd2N8=;
        b=Y24TpYp7GiL+DBFNE/iAVtB7IJCFgb48A0ppWBEN2UDkgT3NEvo/UGugkKipvjWPdi
         sXw8ZfjaVKIPJJNcvQclefC6y5nHqxqy4iqoov7luIxh74d9G8PnWcwzdmmfFcjjBtlq
         vTLLnyw7cNi0Nkt8hny9KSlfKtlEcx0j56U1wRiJ2isQcnzzWHD61SBDdAnyGm7Hmwgf
         Bu5EVDUeZEel7v4ofraf7jiNTxINvijrrE+T6TgJ6q+Z7aZ+oId0Ex+Jm/XgdIMje8tP
         qSb4UZCoZ1ptB4vmoQDUjaIGq0CzwnyJL3VbJQhyJkP5/tT0SkzNhwzhHp2XQyoF15TA
         oKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMfTKMXJJ+uG9witg1g7+yEtNI0nSxRLJvkxgOHd2N8=;
        b=TrwQFFmrl3yy/CIgVfhBKTDNaf7Ry082SBJL/Zt9ILXSzkThyXWlPeUd941htSmXXw
         Fl6716/GIPoSw0k+p1awmlU3+vgvkgvOpilbGRvuXyX3D1FmDAtM2iS+0x97MqMDj6A2
         K2N+n56f0MN9PDjpXLajxhNMpQaA5g9c87UgtuhdkTynze4z/4kNJrUtjP6ABXL1yB5V
         GZ2mq/kYYsyS41M9i53i4EsgI+kmoSm+AmGLfw5oOyt4CETmQDUtVReTN2BqILHwGN9C
         q2/R4c3mgcZuZt3F2b/uouEqUyhzY4Aod0FxHV/U1Swh14QgMWaZBbltn/HYyIfUoiYR
         FFtQ==
X-Gm-Message-State: AOAM531+br8dQkjLbVoPbjLyKftwe1qDmuKfXfoBHbgnZCuWK+Mk5ziG
        IQklncJZQuJ8WR/9Jp/cm/4=
X-Google-Smtp-Source: ABdhPJxETawAH+Iuo5Ll/j9+6ZlSZprVAIqVYRq1v7a/rdTV/mxI6h/ss6TYFClaVZH2kzrIR4EKfg==
X-Received: by 2002:a62:1d8e:: with SMTP id d136mr7030612pfd.323.1593265031590;
        Sat, 27 Jun 2020 06:37:11 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:37:10 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 00/15] perf: ftrace enhancement
Date:   Sat, 27 Jun 2020 21:36:39 +0800
Message-Id: <20200627133654.64863-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf has basic kernel ftrace support but lack support of most tracing
options. This serias is target to enhance the perf ftrace functionality so
that we can make full use of kernel ftrace with perf.

In general, this serias be cataloged into two main changes:
  1) Improve usability of existing functions. For example, we don't need to type
     extra option to select the tracer.
  2) Add new options to support all other ftrace functions.

Here is a glance of all ftrace functions with this serias:

$ sudo perf ftrace -h
 Usage: perf ftrace [<options>] [<command>]
    or: perf ftrace [<options>] -- <command> [<options>]

    -a, --all-cpus        system-wide collection from all CPUs
    -C, --cpu <cpu>       list of cpus to monitor
    -d, --delay <n>       ms to wait before starting tracing after program start
    -D, --graph-depth <n>
                          Max depth for function graph tracer
    -F, --funcs           Show available functions to filter
    -G, --graph-funcs <func>
                          trace given functions using function_graph tracer
    -g, --nograph-funcs <func>
                          Set nograph filter on given functions
    -m, --buffer-size <n>
                          size of per cpu buffer in kb
    -N, --notrace-funcs <func>
                          do not trace given functions
    -p, --pid <pid>       trace on existing process id
    -t, --tid <tid>       trace on existing thread id (exclusive to --pid)
    -T, --trace-funcs <func>
                          trace given functions using function tracer
    -t, --tracer <tracer>
                          tracer to use: function or function_graph (This option is deprecated)
    -v, --verbose         be more verbose
        --func-call-graph
                          show kernel stack trace for function tracer
        --func-irq-info   display irq info for function tracer
        --graph-noirqs    ignore functions that happen inside interrupt for function_graph tracer
        --graph-nosleep-time
                          measure on-CPU time only for function_graph tracer
        --graph-thresh <n>
                          only show functions of which the duration is greater than <n>µs
        --graph-verbose   show process names, PIDs, timestamps for function_graph tracer
        --inherit         trace children processes

v2:
  o patches for option '-u/--userstacktrace' and '--no-pager' are dropped.
  o update all related perf documentation.
  o rename some options. Now all funcgraph tracer options are prefixed with
    '--graph-', while all function tracer options are prefixed with '--func-'.
  o mark old options deprecated instead of removing them.

Changbin Du (15):
  perf ftrace: select function/function_graph tracer automatically
  perf ftrace: add option '-F/--funcs' to list available functions
  perf ftrace: add option -t/--tid to filter by thread id
  perf ftrace: add option -d/--delay to delay tracing
  perf ftrace: factor out function write_tracing_file_int()
  perf ftrace: add option '-m/--buffer-size' to set per-cpu buffer size
  perf ftrace: show trace column header
  perf ftrace: add option '--inherit' to trace children processes
  perf ftrace: add support for tracing option 'func_stack_trace'
  perf ftrace: add support for trace option sleep-time
  perf ftrace: add support for trace option funcgraph-irqs
  perf ftrace: add support for tracing option 'irq-info'
  perf ftrace: add option '--graph-verbose' to show more info for graph
    tracer
  perf ftrace: add support for trace option tracing_thresh
  perf ftrace: add change log

 tools/perf/Documentation/perf-config.txt |   5 -
 tools/perf/Documentation/perf-ftrace.txt |  39 ++-
 tools/perf/builtin-ftrace.c              | 295 +++++++++++++++++++++--
 3 files changed, 319 insertions(+), 20 deletions(-)

-- 
2.25.1

