Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3665CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FD92076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8nSsKrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGKMmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:42:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19410C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:10 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn17so3754843pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZztSM6Av0ybGIiM16abqPooibGAiF7/cKiz34nTmzbg=;
        b=Y8nSsKrKf2ZsksmfsqmVyl65o4r9VpiVKtcEb8JcFaPPdvufOHJL64cJ+s5BPpTK/9
         8sgXDg66XV0d8rbefjpzx4G1JmXOIAJTvSN+7cKIEGca+HXCPPpFpu11ngT4DHXdpidf
         ASg/CmmUFw3QfZkitk5ql0qgzHkt0AlmHerHKEna01CsxsUkBck1h5fAIoRCdxNInVRK
         uiMuhZQ2L5i1spTc9c1bkIa3Jvjd/vaQggitAEWl+T38j00npHGDt25CLOCDo8yIrLFL
         Rli9SrEa93IeId8jDnXv4zcaDaxks2IZ4ZRnwHwoLdnlZSvI0V3AuYnLgs+nH2rMb98u
         VSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZztSM6Av0ybGIiM16abqPooibGAiF7/cKiz34nTmzbg=;
        b=jHVwKnqjWO85Ec5VqsNiPjhBQx2eHi+6Tf9vRreENrHvlQ5yAc+ISigzLvAu9oJjxi
         z4VcKArKaFgLyduTTSZuUQtnLuSu399u4GUB+JtUGEAqBheKtIU5hL/E5iUzhvm3/x4e
         NFGC1PCskffqwVIGnPi7HgRak52rv7/DdiA5B3CMY863fqNBqG58fQ3nB8W0+KC+h7tZ
         cdSp1PHjA9FU6m5SoJ4i+4Da0tPR8V1TXtIhfHV4myozy3cTlTG/3MUY5L//o0LTjusJ
         XgQKfRxnz7S2qpLoVnmoVuU9xiovwGe819Jql5RorhQXwFfNFHma4GTt5aZdQ2UoAPmw
         y/5g==
X-Gm-Message-State: AOAM532ePYf5aJJUMojxQTgTAc7fkDB1pNTESNyBkL8KrqS7qAOQIt1G
        mG+6JxTIQCmGUXbiFkEcCpQ=
X-Google-Smtp-Source: ABdhPJzGifKIFkIUUkTF125OAG+z3vtecUTy7Ry04u/19KThOfF1N47IpGGgN11vG9Vl9rVOJb3IgA==
X-Received: by 2002:a17:90a:c28c:: with SMTP id f12mr10627367pjt.224.1594471329555;
        Sat, 11 Jul 2020 05:42:09 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:42:08 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 00/17] perf: ftrace enhancement
Date:   Sat, 11 Jul 2020 20:40:18 +0800
Message-Id: <20200711124035.6513-1-changbin.du@gmail.com>
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


Changbin Du (17):
  perf ftrace: select function/function_graph tracer automatically
  perf ftrace: add option '-F/--funcs' to list available functions
  perf ftrace: add option -t/--tid to filter by thread id
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
  perf ftrace: add change log

 tools/perf/Documentation/perf-config.txt |   5 -
 tools/perf/Documentation/perf-ftrace.txt |  37 ++-
 tools/perf/builtin-ftrace.c              | 367 ++++++++++++++++++++++-
 tools/perf/util/Build                    |   1 +
 tools/perf/util/debug.c                  |  61 ++--
 tools/perf/util/parse-sublevel-options.c |  70 +++++
 tools/perf/util/parse-sublevel-options.h |  11 +
 7 files changed, 484 insertions(+), 68 deletions(-)
 create mode 100644 tools/perf/util/parse-sublevel-options.c
 create mode 100644 tools/perf/util/parse-sublevel-options.h

-- 
2.25.1

