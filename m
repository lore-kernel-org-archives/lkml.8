Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CEB206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuE/b2Wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgGHQqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgGHQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:46:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F721C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:46:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f16so1442390pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJTign6MliNTEWA32StLMXy4e4kp/d+/7WiDwup1TOY=;
        b=EuE/b2WbTAKSka87OF4QGfSu3+Xx9wLSlpsbQil3e4X/7GtvPxuMLzCd2uudXAFu3m
         IM5U+38x+28nAi6o94E31+fv2hK+5nXH5I75O8l5CYpyZMcxMwsdEssyZJaByzTaGMjb
         q2uCbzuNZFX35efOh8gvfD06vuGlTf7oTj0uZgFhuSVvU+at5y2rcqwSEeboWQW0nkmm
         QOcV4O5Gq3cYRAds0EFA4pBP6Kj2iEG9D3UjxhfyvugVrcn7LZWlSZ6D0ut8temxnf2h
         CX+1oBXoxTTEvQziRs5YWlizeL96xBRolSaM0b7BHr+ONK0DcXmD7hPa89TjlHO5Yp1f
         fe7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJTign6MliNTEWA32StLMXy4e4kp/d+/7WiDwup1TOY=;
        b=H0Jy7o72Tq3lUtBu+ACwdKnZaKnbHGnkMjkVIzly0Vjrg448XQRcGXlpClrM4Dcl17
         X4v5qz2D8LSiM4bKAhk1Dwjo1HCg1G0sy3MtPLFMcireaqk8mjsZXacOz7gISG1Uynx1
         wxTHhZyo8cfvBpFFgsTCtSC34Vqcksoh3Nyb8j/po1jxn/MPLMh9pGs8bI7z3B7xMViL
         bV4h8ZdQPh0buh2K3da8Mej0LZz6Qfo2qNCN9/FGfHTVTQw+0CTm9pL1i9ubRq1GV4bv
         Mxp4hBJ8sMZbBe9lzfQjz/Dx98FFRSYbErsaZB0r9S+1Fr4ZpiWGG3aRyuOXVjxycPqh
         lfpw==
X-Gm-Message-State: AOAM532uck6yHkpmnnvMrkpTMQarqLGogtEAn7137e0QzMmmCGjJ2xHw
        9MwqmCBwWtBpvR0r4JXHH2Z8FJivncs=
X-Google-Smtp-Source: ABdhPJzYj/aSHRwu+wSh3YthtkwXxLjTkAxJ718YynBLMr7DOCCaKvwoeVbkwSBozmBBaFmX/PQhIA==
X-Received: by 2002:a17:90b:f16:: with SMTP id br22mr11071885pjb.170.1594226791477;
        Wed, 08 Jul 2020 09:46:31 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:46:30 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 00/17] perf: ftrace enhancement
Date:   Thu,  9 Jul 2020 00:45:48 +0800
Message-Id: <20200708164605.31245-1-changbin.du@gmail.com>
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
    -d, --delay <n>       ms to wait before starting tracing after program start
    -D, --graph-depth <n>
                          Max depth for function graph tracer (This option is deprecated)
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
    -t, --tid <tid>       trace on existing thread id (exclusive to --pid)
    -T, --trace-funcs <func>
                          trace given functions using function tracer
    -t, --tracer <tracer>
                          tracer to use: function or function_graph (This option is deprecated)
    -v, --verbose         be more verbose
        --func-opts <options>
                          function tracer options, available options: call-graph,irq-info
        --graph-opts <options>
                          graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>
        --inherit         trace children processes

v3:
  o add --func-opts and --graph-opts to set tracer specific options.
  o support units as a suffix for option '-m/--buffer-size'.
v2:
  o patches for option '-u/--userstacktrace' and '--no-pager' are dropped.
  o update all related perf documentation.
  o rename some options. Now all funcgraph tracer options are prefixed with
    '--graph-', while all function tracer options are prefixed with '--func-'.
  o mark old options deprecated instead of removing them.

Changbin Du (17):
  perf ftrace: select function/function_graph tracer automatically
  perf ftrace: add option '-F/--funcs' to list available functions
  perf ftrace: add option -t/--tid to filter by thread id
  perf ftrace: add option -d/--delay to delay tracing
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
  perf ftrace: add change log

 tools/perf/Documentation/perf-config.txt |   5 -
 tools/perf/Documentation/perf-ftrace.txt |  38 ++-
 tools/perf/builtin-ftrace.c              | 367 ++++++++++++++++++++++-
 tools/perf/util/debug.c                  |  61 ++--
 tools/perf/util/util.c                   |  56 ++++
 tools/perf/util/util.h                   |   7 +
 6 files changed, 469 insertions(+), 65 deletions(-)

-- 
2.25.1

