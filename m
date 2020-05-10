Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74ADC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB7520735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyLeqJdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgEJPGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgEJPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:06:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73685C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:06:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq3so6522015pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Cxj8lcHsS/+kBeZtbBYJ1GBSZzCTGYQX2ru9hFa8G8=;
        b=RyLeqJdTsX8gRi0JgXj67zKVvEAH7xedIMgAmhLBrUL81MfTPIw7kAPAbHLHkA0otC
         2+Gr68lC+WvaKTlKXjDgiX2BNE9qcX7NPw7+5MhyECXkD5DO8OkiovyFPwuw3faQQHHK
         esF/wZqfL60yZeYKVRjrgbTsVtoQQGQtxo7352sNsAlqULLoxHs7Hfndj/tFlKevV2wU
         sJFFNEhI8QXzWcAt/h5brJ56euXBA5PoxAA4GenEux4ev/3Kbvqg4T7ZiWJlo9EMshiN
         0GzFdUojv0uwYGvDPx2yb7YnW/WfwtHZFHZcJOLOHEdTj2+gVilMBRb5gQ79DUcWZvr+
         eYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Cxj8lcHsS/+kBeZtbBYJ1GBSZzCTGYQX2ru9hFa8G8=;
        b=YOl8G6RCBQbBJLYkrmlWG7lpC1npNws9F/ELOuMglMR8sC7ZaDX7BoasmII+Kn24ZU
         yg/+PKjlFCWNx9xie8rf0AOstDLl+aYcq+jMBta8+ixDIQP5sC+oJ1nm3ra8gZql55sf
         zBSwauwlAmVFrFXECUMU5B4PSLpnTBr1/Oqbn6/YI9EVpddtuYGa4Ricctes6Lt7J+J6
         ujI9oVimnx29oozSkyvqJxEDgTCzbC3ehmrEX6evnC/KOmJYCqvKiOGoy+YyyyPAWwi/
         lLkJQR5MniHeQFxEYg/xZs9wN1qAqheOmJzgBsWOQ4BjHKbHwG70AvYJuBe7f9e1BQpm
         mSew==
X-Gm-Message-State: AGi0PuYfoy0SEiqKyA+ylHmRsUDDYg4KIOlh/A+DEUrwO6OTBbr2A0sL
        NKIfgCPjxmzKGY3RL4T6mlw=
X-Google-Smtp-Source: APiQypKZ2tmSemi+ppBHJPqt+WwUBTCcERwDontVpDLjHoSo8cm5L1JknJAFHcyQRDmdMSUOXykUPw==
X-Received: by 2002:a17:902:207:: with SMTP id 7mr10868604plc.331.1589123208775;
        Sun, 10 May 2020 08:06:48 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:06:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 00/19] perf: ftrace enhancement
Date:   Sun, 10 May 2020 23:06:09 +0800
Message-Id: <20200510150628.16610-1-changbin.du@gmail.com>
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
that we can make full use of kernel ftrace with only perf.

In general, this serias be cataloged into two main changes:
  1) Improve usability of existing functions. For example, we don't need to type
     extra option to select the tracer.
  2) Add new options to support all other ftrace functions.

Here is a glance of all ftrace functions with this serias:
  * - improved existing options.
  + - new added options.

$ sudo perf ftrace -h

 Usage: perf ftrace [<options>] [<command>]
    or: perf ftrace [<options>] -- <command> [<options>]

*   -a, --all-cpus        system-wide collection from all CPUs
+   -b, --buffer-size <n>
                          size of per cpu buffer in kb
    -C, --cpu <cpu>       list of cpus to monitor
+   -d, --delay <n>       Wait <n> ms before tracing
    -D, --graph-depth <n>
                          Max depth for function graph tracer
*   -G, --graph-funcs <func>
                          Set graph filter on given functions (imply to use function_graph tracer)
    -g, --nograph-funcs <func>
                          Set nograph filter on given functions (imply to use function_graph tracer)
+   -L, --list-functions  List available functions to filter
+   -l, --long-info       Show process names, PIDs, timestamps, irq-info if available
    -N, --notrace-funcs <func>
                          do not trace given functions
+   -P, --no-pager        Do not use pager
    -p, --pid <pid>       trace on existing process id
+   -s, --func-stack-trace
                          Show kernel stack trace for function tracer
+   -t, --tid <tid>       trace on existing thread id (exclusive to --pid)
    -T, --trace-funcs <func>
                          trace given functions only
+   -u, --userstacktrace  Show stacktrace of the current user space thread
    -v, --verbose         be more verbose
+       --funcgraph-tail  Show function tails comment (function_graph only)
+       --latency-format  displays additional information about the latency (function_graph only)
+       --nofuncgraph-irqs
                          Ignore functions that happen inside interrupt (function_graph only)
+       --nosleep-time    Measure on-CPU time only (function_graph only)
+       --trace-children  Trace children processes
+       --tracing-thresh <n>
                          Only show functions of which the duration is greater than <n>µs


Changbin Du (19):
  perf ftrace: trace system wide if no target is given
  perf ftrace: detect workload failure
  perf ftrace: select function/function_graph tracer automatically
  perf ftrace: add support for tracing option 'func_stack_trace'
  perf ftrace: add option '-l/--list-functions' to list available
    functions
  perf ftrace: add support for trace option sleep-time
  perf ftrace: add support for trace option funcgraph-irqs
  perf ftrace: add option -l/--long-info to show more info
  perf ftrace: add support for trace option tracing_thresh
  perf ftrace: add support for trace option funcgraph-tail
  perf ftrace: add option '-u/--userstacktrace' to show userspace
    stacktrace
  perf ftrace: add support for tracing children processes
  perf ftrace: add option '-b/--buffer-size' to set per-cpu buffer size
  perf ftrace: add option -P/--no-pager to disable pager
  perf ftrace: show trace column header
  perf ftrace: add option -t/--tid to filter by thread id
  perf ftrace: add option -d/--delay to delay tracing
  perf ftrace: add option --latency-format to display more info about
    delay
  perf ftrace: add change log

 tools/perf/Documentation/perf-config.txt |   5 -
 tools/perf/builtin-ftrace.c              | 388 ++++++++++++++++++++---
 2 files changed, 345 insertions(+), 48 deletions(-)

-- 
2.25.1

