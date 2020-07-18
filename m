Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB270C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965F52074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVeFCfmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgGRGsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRGst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:48:49 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF7C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:48:49 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p3so7725661pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1UuAz08RN16CRl0yfxGjfW+lc0olfSaTw8kSl/TQtA=;
        b=VVeFCfmvfhde8I9CeRsvRqy0Npb6gOGMwgM1Jev8Lqwa9xNwzeYUeTWe1SlGYRLJSp
         B6T6gSB7WZjWs31QOiiKqWxZOuDCikDzVCrkipZgaB34+O1XqLbh3X3+dWY8fl1OF0rQ
         avNDZDjC9eq8t2hobIETm44rO+lYjtpwANECgTj57/gXWvM9p3bpQfZMTFjf60+zQwtn
         OC2T9ogNg6UrqC3otxZEz/HrFT+tsLczC/EqohC/HRojCRQS3QfssPwwSGBmiG99ktx+
         qZFAPnncOWYh6aMdgUyJDXStjPTUb/x1hFnNyb1LsbWiPlYcGDZWDd4JJduYMZOSKast
         08cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1UuAz08RN16CRl0yfxGjfW+lc0olfSaTw8kSl/TQtA=;
        b=TtYynSiqOW90eilYdoiI7r/w1j9cL8eq2HlsQV1RnojYF19cBzAT7W6HIkLmsoAfOY
         GmxLYjJlLUKgs52EtyT6xZwiEQGQKZo0JMXucma/KoPvC4PZrqK1JoGxgx2tY9Tlgi5q
         XH4UbGugSvoB6HyVqOPyVqsvP3mecDbEgBQBzB8/lIZh+HMPoCe20h44x7av5R9Zzk68
         1zMhecT7cNdBrMZ77wZkouelu0K8TZSgB3kVCh8LaCtYzzd306mBiVZVwjP0gCtN5OF3
         oNlJvwn3SIoQQkb6m6O8EA6Q5pqSlOZWF1z983IvF5JljsW0KbAh6fsRiHYKvLYV+aou
         L4rA==
X-Gm-Message-State: AOAM533SqM+1J762DWR4wybvndAjgHjbIDBh8vyizc4KKcieXv/Wj0fX
        mWAsxrpuyw7oCkAgtVShMNQ=
X-Google-Smtp-Source: ABdhPJyrXcLYL+GHyi5JUhSinMijwbCzrCeebqVJJ1l5x7/Gmg2mTyywjIGFWi3GrX6Ccz/vRQLBsw==
X-Received: by 2002:aa7:8507:: with SMTP id v7mr10928602pfn.218.1595054927617;
        Fri, 17 Jul 2020 23:48:47 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:48:46 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 00/18] perf: ftrace enhancement
Date:   Sat, 18 Jul 2020 14:48:08 +0800
Message-Id: <20200718064826.9865-1-changbin.du@gmail.com>
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
                          tracer to use: function or function_graph (This option is deprecated)
    -v, --verbose         be more verbose
        --func-opts <options>
                          function tracer options, available options: call-graph,irq-info
        --graph-opts <options>
                          graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>
        --inherit         trace children processes
        --tid <tid>       trace on existing thread id (exclusive to --pid)

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

 tools/perf/Documentation/perf-config.txt |   5 -
 tools/perf/Documentation/perf-ftrace.txt |  36 +-
 tools/perf/builtin-ftrace.c              | 415 +++++++++++++++++++++--
 tools/perf/util/Build                    |   1 +
 tools/perf/util/debug.c                  |  61 +---
 tools/perf/util/parse-sublevel-options.c |  70 ++++
 tools/perf/util/parse-sublevel-options.h |  11 +
 7 files changed, 513 insertions(+), 86 deletions(-)
 create mode 100644 tools/perf/util/parse-sublevel-options.c
 create mode 100644 tools/perf/util/parse-sublevel-options.h

-- 
2.25.1

