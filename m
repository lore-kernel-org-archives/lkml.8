Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6C1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0231C2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgHDU6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgHDU6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18DF42086A;
        Tue,  4 Aug 2020 20:58:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k340i-006H8j-0g; Tue, 04 Aug 2020 16:58:12 -0400
Message-ID: <20200804205743.419135730@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Aug 2020 16:57:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/17] tracing: Last minute fixes for this merge window
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: c58b46cba71750c6e969625abb1cf3ddabb15e06


Chengming Zhou (2):
      ftrace: Setup correct FTRACE_FL_REGS flags for module
      ftrace: Do not let direct or IPMODIFY ftrace_ops be added to module and set trampolines

Josef Bacik (1):
      ftrace: Fix ftrace_trace_task return value

Kevin Hao (2):
      tracing/hwlat: Drop the duplicate assignment in start_kthread()
      tracing/hwlat: Honor the tracing_cpumask

Masami Hiramatsu (4):
      kprobes: Remove show_registers() function prototype
      lib/bootconfig: Add override operator support
      tools/bootconfig: Add testcases for value override operator
      Documentation: bootconfig: Add bootconfig override operator

Muchun Song (1):
      kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler

Nick Desaulniers (2):
      tracepoint: Mark __tracepoint_string's __used
      tracepoint: Use __used attribute definitions from compiler_attributes.h

Peng Fan (1):
      tracing/uprobe: Remove dead code in trace_uprobe_register()

Vincent Whitchurch (1):
      tracing: Remove outdated comment in stack handling

Wei Yang (2):
      tracing: Simplify defining of the next event id
      tracing: Save one trace_event->type by using __TRACE_LAST_TYPE

Zhaoyang Huang (1):
      trace : Have tracing buffer info use kvzalloc instead of kzalloc

----
 Documentation/admin-guide/bootconfig.rst     | 11 ++++++++++
 include/linux/kprobes.h                      |  1 -
 include/linux/tracepoint.h                   | 11 +++++-----
 kernel/kprobes.c                             |  7 ++++++
 kernel/trace/ftrace.c                        | 22 +++++++++++++------
 kernel/trace/trace.c                         | 10 ++-------
 kernel/trace/trace.h                         |  7 +++++-
 kernel/trace/trace_hwlat.c                   |  6 ++---
 kernel/trace/trace_output.c                  | 14 ++++++------
 kernel/trace/trace_uprobe.c                  |  1 -
 lib/bootconfig.c                             | 33 +++++++++++++++++++---------
 tools/bootconfig/samples/bad-override.bconf  |  3 +++
 tools/bootconfig/samples/bad-override2.bconf |  3 +++
 tools/bootconfig/samples/good-override.bconf |  6 +++++
 tools/bootconfig/test-bootconfig.sh          | 13 +++++++++++
 15 files changed, 104 insertions(+), 44 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-override.bconf
 create mode 100644 tools/bootconfig/samples/bad-override2.bconf
 create mode 100644 tools/bootconfig/samples/good-override.bconf
