Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C55CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6767E22CF8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EChFkq3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgHHCb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHHCb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:31:58 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604E4C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:31:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d14so3472193qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hmga3mx1C8J3sa8hBc1ezX7zAKTPj1W6lBvrwWvCgRw=;
        b=EChFkq3P4KA7OIjRV1wf5khDW0xZYMtalzw8liHk9+gEIupdJA1YmK/kuI+W2B74my
         DRI9wM/o4t0S06v1KLsui+3ecUsaJSn5A6Q5v+l6i4hfCH+6y7SGSm9QAY9ld2/KgCEv
         Uc5Nt4dD+tkq5JynZTECBktAAO+BSMUe4JVxlp/WtybHscoU1QvEXfRHIorfxFrFMBX7
         9+8dobqcW1tSgMPGaTvUBcfY2gnNqnT3qh3+wrPtfCBUdIa4oPDHsiHSTQIUdnVBf1W6
         YV0xOkSa02ufKAiQh8dT+4FyVbJxBcFIk7W2wH6wqPEq4eBTiU1uvZKk9l+NWTGPcDTy
         WnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hmga3mx1C8J3sa8hBc1ezX7zAKTPj1W6lBvrwWvCgRw=;
        b=e2LR7AgS9+GHZeRy+sK6MfTICQp2/9xGpQNqRNwYWbO1/BD7acc3OvE/QPSAaX32L2
         oz6x932A930YV3d4rRaYkKgiDA0bwsFlXSPlVgjKeeNj/LMsPqdsVeVBujRD/+JSOIyr
         agl8I+m3DaMhfA3ZJOQefMvPqlw/uaDcvK2lbEQ0UGLLq+CZirspbcgtvcpmUBSbsM7h
         ui2wWnJ+HId7Fzd+/giq9UtGG6n6u9LbiloORt24Iej3rLZURT5iYU05L6ZxQcRHcdmh
         E/p0tRazt9XYE6xELMVSzh2r51nbYwfJA38xJvJIlp+JHHoHVRrriRdVNwewKV+yFxPR
         CizQ==
X-Gm-Message-State: AOAM530P5tYPeALLdxPyMYvDBDg1LDgYm3fzuXnj3Inltd6oAsosJTzI
        IezTlVlvkyKd6f4uOgf/rOc=
X-Google-Smtp-Source: ABdhPJw4IykXO/C48vs2NnQEQZa5/fHvZH3amVudHBxIwDJiQ6aca6HElOyNK85jZU1Rr+Rwsj1c/g==
X-Received: by 2002:a37:a495:: with SMTP id n143mr16463711qke.330.1596853917277;
        Fri, 07 Aug 2020 19:31:57 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:31:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 00/18] [PATCH v7 00/18] perf: ftrace enhancement
Date:   Sat,  8 Aug 2020 10:31:23 +0800
Message-Id: <20200808023141.14227-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
    -D, --delay <n>       ms to wait before starting tracing after program start
    -F, --funcs           Show available functions to filter
    -G, --graph-funcs <func>
                          trace given functions using function_graph tracer
    -g, --nograph-funcs <func>
                          Set nograph filter on given functions
    -m, --buffer-size <size>
                          size of per cpu buffer
    -N, --notrace-funcs <func>
                          do not trace given functions
    -p, --pid <pid>       trace on existing process id
    -T, --trace-funcs <func>
                          trace given functions using function tracer
    -t, --tracer <tracer>
                          tracer to use: function_graph(default) or function
    -v, --verbose         be more verbose
        --func-opts <options>
                          function tracer options, available options: call-graph,irq-info
        --graph-opts <options>
                          graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>
        --inherit         trace children processes
        --tid <tid>       trace on existing thread id (exclusive to --pid)

v8:
  o change tracer selection policy ([PATCH 01/18]).
v7:
  o add back '--tid <tid>'.
v6:
  o fix return value of read_tracing_file_to_stdout().
  o make __cmd_ftrace() shorter.
  o remove option '-t, --tid <tid>'.
v5:
  o trivial fixes.
v4:
  o add util/parse-sublevel-options.c
  O remove -D/--graph-depth
v3:
  o add --func-opts and --graph-opts to set tracer specific options.
  o support units as a suffix for option '-m/--buffer-size'.
v2:
  o patches for option '-u/--userstacktrace' and '--no-pager' are dropped.
  o update all related perf documentation.
  o rename some options. Now all funcgraph tracer options are prefixed with
    '--graph-', while all function tracer options are prefixed with '--func-'.
  o mark old options deprecated instead of removing them.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Changbin Du (18):
  perf ftrace: select function/function_graph tracer automatically
  perf ftrace: add option '-F/--funcs' to list available functions
  perf ftrace: factor out function write_tracing_file_int()
  perf ftrace: add option '-m/--buffer-size' to set per-cpu buffer size
  perf ftrace: show trace column header
  perf ftrace: add option '--inherit' to trace children processes
  perf: util: add general function to parse sublevel options
  perf ftrace: add support for tracing option 'func_stack_trace'
  perf ftrace: add support for trace option sleep-time
  perf ftrace: add support for trace option funcgraph-irqs
  perf ftrace: add support for tracing option 'irq-info'
  perf ftrace: add option 'verbose' to show more info for graph tracer
  perf ftrace: add support for trace option tracing_thresh
  perf: ftrace: allow set graph depth by '--graph-opts'
  perf ftrace: add option -D/--delay to delay tracing
  perf ftrace: add option --tid to filter by thread id
  perf: ftrace: Add set_tracing_options() to set all trace options
  perf ftrace: add change log

 tools/perf/Documentation/perf-config.txt |   5 +-
 tools/perf/Documentation/perf-ftrace.txt |  75 ++--
 tools/perf/builtin-ftrace.c              | 424 +++++++++++++++++++++--
 tools/perf/util/Build                    |   1 +
 tools/perf/util/debug.c                  |  61 +---
 tools/perf/util/parse-sublevel-options.c |  70 ++++
 tools/perf/util/parse-sublevel-options.h |  11 +
 7 files changed, 550 insertions(+), 97 deletions(-)
 create mode 100644 tools/perf/util/parse-sublevel-options.c
 create mode 100644 tools/perf/util/parse-sublevel-options.h

-- 
2.25.1

