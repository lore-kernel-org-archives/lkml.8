Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E040C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0142468E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgANVDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:03:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANVDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E8D24658;
        Tue, 14 Jan 2020 21:03:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLb-000Cz5-MN; Tue, 14 Jan 2020 16:03:35 -0500
Message-Id: <20200114210316.450821675@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/26] tracing: Updates for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 3b42a4c83a31d8f1d8a7cb7eb2f4ee809d42c69d


Masami Hiramatsu (23):
      bootconfig: Add Extra Boot Config support
      bootconfig: Load boot config from the tail of initrd
      tools: bootconfig: Add bootconfig command
      tools: bootconfig: Add bootconfig test script
      proc: bootconfig: Add /proc/bootconfig to show boot config list
      init/main.c: Alloc initcall_command_line in do_initcall() and free it
      bootconfig: init: Allow admin to use bootconfig for kernel command line
      bootconfig: init: Allow admin to use bootconfig for init command line
      Documentation: bootconfig: Add a doc for extended boot config
      tracing: Apply soft-disabled and filter to tracepoints printk
      tracing: kprobes: Output kprobe event to printk buffer
      tracing: kprobes: Register to dynevent earlier stage
      tracing: Accept different type for synthetic event fields
      tracing: Add NULL trace-array check in print_synth_event()
      tracing/boot: Add boot-time tracing
      tracing/boot: Add per-event settings
      tracing/boot Add kprobe event support
      tracing/boot: Add synthetic event support
      tracing/boot: Add instance node support
      tracing/boot: Add cpu_mask option support
      tracing/boot: Add function tracer filter options
      Documentation: tracing: Add boot-time tracing document
      tracing: trigger: Replace unneeded RCU-list traversals

Steven Rostedt (VMware) (3):
      perf: Make struct ring_buffer less ambiguous
      tracing: Rename trace_buffer to array_buffer
      tracing: Make struct ring_buffer less ambiguous

----
 Documentation/admin-guide/bootconfig.rst           | 186 +++++
 Documentation/admin-guide/index.rst                |   1 +
 Documentation/trace/boottime-trace.rst             | 184 +++++
 Documentation/trace/index.rst                      |   1 +
 MAINTAINERS                                        |   9 +
 drivers/oprofile/cpu_buffer.c                      |   2 +-
 fs/proc/Makefile                                   |   1 +
 fs/proc/bootconfig.c                               |  89 +++
 include/linux/bootconfig.h                         | 224 ++++++
 include/linux/perf_event.h                         |   6 +-
 include/linux/ring_buffer.h                        | 110 +--
 include/linux/trace_events.h                       |   9 +-
 include/trace/trace_events.h                       |   2 +-
 init/Kconfig                                       |  12 +
 init/main.c                                        | 213 +++++-
 kernel/events/core.c                               |  42 +-
 kernel/events/internal.h                           |  34 +-
 kernel/events/ring_buffer.c                        |  54 +-
 kernel/trace/Kconfig                               |   9 +
 kernel/trace/Makefile                              |   1 +
 kernel/trace/blktrace.c                            |   8 +-
 kernel/trace/ftrace.c                              |   8 +-
 kernel/trace/ring_buffer.c                         | 124 ++--
 kernel/trace/ring_buffer_benchmark.c               |   2 +-
 kernel/trace/trace.c                               | 355 ++++-----
 kernel/trace/trace.h                               |  38 +-
 kernel/trace/trace_boot.c                          | 353 +++++++++
 kernel/trace/trace_branch.c                        |   6 +-
 kernel/trace/trace_events.c                        |  21 +-
 kernel/trace/trace_events_hist.c                   |  59 +-
 kernel/trace/trace_events_trigger.c                |  22 +-
 kernel/trace/trace_functions.c                     |   8 +-
 kernel/trace/trace_functions_graph.c               |  14 +-
 kernel/trace/trace_hwlat.c                         |   2 +-
 kernel/trace/trace_irqsoff.c                       |   8 +-
 kernel/trace/trace_kdb.c                           |   8 +-
 kernel/trace/trace_kprobe.c                        |  81 ++-
 kernel/trace/trace_mmiotrace.c                     |  12 +-
 kernel/trace/trace_output.c                        |   2 +-
 kernel/trace/trace_sched_wakeup.c                  |  20 +-
 kernel/trace/trace_selftest.c                      |  26 +-
 kernel/trace/trace_syscalls.c                      |   8 +-
 kernel/trace/trace_uprobe.c                        |   2 +-
 lib/Kconfig                                        |   3 +
 lib/Makefile                                       |   2 +
 lib/bootconfig.c                                   | 803 +++++++++++++++++++++
 tools/Makefile                                     |  11 +-
 tools/bootconfig/.gitignore                        |   1 +
 tools/bootconfig/Makefile                          |  23 +
 tools/bootconfig/include/linux/bootconfig.h        |   7 +
 tools/bootconfig/include/linux/bug.h               |  12 +
 tools/bootconfig/include/linux/ctype.h             |   7 +
 tools/bootconfig/include/linux/errno.h             |   7 +
 tools/bootconfig/include/linux/kernel.h            |  18 +
 tools/bootconfig/include/linux/printk.h            |  17 +
 tools/bootconfig/include/linux/string.h            |  32 +
 tools/bootconfig/main.c                            | 353 +++++++++
 .../samples/bad-array-space-comment.bconf          |   5 +
 tools/bootconfig/samples/bad-array.bconf           |   2 +
 tools/bootconfig/samples/bad-dotword.bconf         |   4 +
 tools/bootconfig/samples/bad-empty.bconf           |   1 +
 tools/bootconfig/samples/bad-keyerror.bconf        |   2 +
 tools/bootconfig/samples/bad-longkey.bconf         |   1 +
 tools/bootconfig/samples/bad-manywords.bconf       |   1 +
 tools/bootconfig/samples/bad-no-keyword.bconf      |   2 +
 tools/bootconfig/samples/bad-nonprintable.bconf    |   2 +
 tools/bootconfig/samples/bad-spaceword.bconf       |   2 +
 tools/bootconfig/samples/bad-tree.bconf            |   5 +
 tools/bootconfig/samples/bad-value.bconf           |   3 +
 tools/bootconfig/samples/escaped.bconf             |   3 +
 .../samples/good-array-space-comment.bconf         |   4 +
 .../samples/good-comment-after-value.bconf         |   1 +
 tools/bootconfig/samples/good-printables.bconf     |   2 +
 tools/bootconfig/samples/good-simple.bconf         |  11 +
 tools/bootconfig/samples/good-single.bconf         |   4 +
 .../samples/good-space-after-value.bconf           |   1 +
 tools/bootconfig/samples/good-tree.bconf           |  12 +
 tools/bootconfig/test-bootconfig.sh                | 105 +++
 78 files changed, 3315 insertions(+), 530 deletions(-)
 create mode 100644 Documentation/admin-guide/bootconfig.rst
 create mode 100644 Documentation/trace/boottime-trace.rst
 create mode 100644 fs/proc/bootconfig.c
 create mode 100644 include/linux/bootconfig.h
 create mode 100644 kernel/trace/trace_boot.c
 create mode 100644 lib/bootconfig.c
 create mode 100644 tools/bootconfig/.gitignore
 create mode 100644 tools/bootconfig/Makefile
 create mode 100644 tools/bootconfig/include/linux/bootconfig.h
 create mode 100644 tools/bootconfig/include/linux/bug.h
 create mode 100644 tools/bootconfig/include/linux/ctype.h
 create mode 100644 tools/bootconfig/include/linux/errno.h
 create mode 100644 tools/bootconfig/include/linux/kernel.h
 create mode 100644 tools/bootconfig/include/linux/printk.h
 create mode 100644 tools/bootconfig/include/linux/string.h
 create mode 100644 tools/bootconfig/main.c
 create mode 100644 tools/bootconfig/samples/bad-array-space-comment.bconf
 create mode 100644 tools/bootconfig/samples/bad-array.bconf
 create mode 100644 tools/bootconfig/samples/bad-dotword.bconf
 create mode 100644 tools/bootconfig/samples/bad-empty.bconf
 create mode 100644 tools/bootconfig/samples/bad-keyerror.bconf
 create mode 100644 tools/bootconfig/samples/bad-longkey.bconf
 create mode 100644 tools/bootconfig/samples/bad-manywords.bconf
 create mode 100644 tools/bootconfig/samples/bad-no-keyword.bconf
 create mode 100644 tools/bootconfig/samples/bad-nonprintable.bconf
 create mode 100644 tools/bootconfig/samples/bad-spaceword.bconf
 create mode 100644 tools/bootconfig/samples/bad-tree.bconf
 create mode 100644 tools/bootconfig/samples/bad-value.bconf
 create mode 100644 tools/bootconfig/samples/escaped.bconf
 create mode 100644 tools/bootconfig/samples/good-array-space-comment.bconf
 create mode 100644 tools/bootconfig/samples/good-comment-after-value.bconf
 create mode 100644 tools/bootconfig/samples/good-printables.bconf
 create mode 100644 tools/bootconfig/samples/good-simple.bconf
 create mode 100644 tools/bootconfig/samples/good-single.bconf
 create mode 100644 tools/bootconfig/samples/good-space-after-value.bconf
 create mode 100644 tools/bootconfig/samples/good-tree.bconf
 create mode 100755 tools/bootconfig/test-bootconfig.sh
