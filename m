Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEEBC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60703217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBEW3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgBEW3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:29:20 -0500
Received: from oasis.local.home (unknown [81.144.254.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4FC214AF;
        Wed,  5 Feb 2020 22:29:17 +0000 (UTC)
Date:   Wed, 5 Feb 2020 17:29:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL v2] tracing: Changes for 5.6
Message-ID: <20200205172914.3d4b831f@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing updates:

 - Added new "bootconfig".
   Looks for a file appended to initrd to add boot config options.
   This has been discussed thoroughly at Linux Plumbers.
   Very useful for adding kprobes at bootup.
   Only enabled if "bootconfig" is on the real kernel command line.

 - Created dynamic event creation.
   Merges common code between creating synthetic events and
     kprobe events.

 - Rename perf "ring_buffer" structure to "perf_buffer"

 - Rename ftrace "ring_buffer" structure to "trace_buffer"
   Had to rename existing "trace_buffer" to "array_buffer"

 - Allow trace_printk() to work withing (some) tracing code.

 - Sort of tracing configs to be a little better organized

 - Fixed bug where ftrace_graph hash was not being protected properly

 - Various other small fixes and clean ups


Please pull the latest trace-v5.6-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.6-2

Tag SHA1: c2a3faac204bfa981938ad503b9283aecdee212e
Head SHA1: a00574036c261421721fa770ccd21a1012e1fbbd


Alex Shi (5):
      ftrace: Remove abandoned macros
      ftrace: Remove NR_TO_INIT macro
      ring-buffer: Remove abandoned macro RB_MISSED_FLAGS
      tracing: Remove unused TRACE_SEQ_BUF_USED
      trace/kprobe: Remove unused MAX_KPROBE_CMDLINE_SIZE

Amol Grover (2):
      tracing: Annotate ftrace_graph_hash pointer with __rcu
      tracing: Annotate ftrace_graph_notrace_hash pointer with __rcu

Colin Ian King (1):
      tools: bootconfig: Fix spelling mistake "faile" -> "failed"

Dan Carpenter (2):
      tracing/boot: Fix an IS_ERR() vs NULL bug
      tracing: Remove unneeded NULL check

Fabian Frederick (1):
      ring-bufer: kernel-doc warning fixes

Hou Pengyang (1):
      tracing: Fix comments about trace/ftrace.h

Josef Bacik (1):
      tracing: Set kernel_stack's caller size properly

Luis Henriques (1):
      tracing: Fix tracing_stat return values in error handling paths

Masami Hiramatsu (32):
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
      bootconfig: Fix Kconfig help message for BOOT_CONFIG
      Documentation: bootconfig: Fix typos in bootconfig documentation
      Documentation: tracing: Fix typos in boot-time tracing documentation
      tracing/boot: Include required headers and sort it alphabetically
      tracing/boot: Move external function declarations to kernel/trace/trace.h
      bootconfig: Use bootconfig instead of boot config
      bootconfig: Add more parse error messages
      tools/bootconfig: Show the number of bootconfig nodes
      bootconfig: Show the number of nodes on boot message

Mathieu Desnoyers (1):
      tracing: Fix sched switch start/stop refcount racy updates

Mauro Carvalho Chehab (1):
      docs: tracing: Fix a broken label

Steven Rostedt (VMware) (16):
      perf: Make struct ring_buffer less ambiguous
      tracing: Rename trace_buffer to array_buffer
      tracing: Make struct ring_buffer less ambiguous
      ring-buffer: Fix kernel doc for rb_update_event()
      tracing: Allow trace_printk() to nest in other tracing code
      tracing: Fix uninitialized buffer var on early exit to trace_vbprintk()
      tracing: Fix very unlikely race of registering two stat tracers
      tracing: Decrement trace_array when bootconfig creates an instance
      tracing: Use pr_err() instead of WARN() for memory failures
      tracing: Move all function tracing configs together
      tracing: Move tracing test module configs together
      tracing: Move mmio tracer config up with the other tracers
      tracing: Move tracing selftests to bottom of menu
      bootconfig: Only load bootconfig if "bootconfig" is on the kernel cmdline
      ftrace: Add comment to why rcu_dereference_sched() is open coded
      ftrace: Protect ftrace_graph_hash with ftrace_sync

Tom Zanussi (21):
      tracing: Simplify assignment parsing for hist triggers
      tracing: Add hist trigger error messages for sort specification
      tracing: Add 'hist:' to hist trigger error log error string
      tracing: Add new testcases for hist trigger parsing errors
      tracing: Add trace_array_find/_get() to find instance trace arrays
      tracing: Add trace_get/put_event_file()
      tracing: Add synth_event_delete()
      tracing: Add dynamic event command creation interface
      tracing: Add synthetic event command generation functions
      tracing: Add synth_event_trace() and related functions
      tracing: Add synth event generation test module
      tracing: Add kprobe event command generation functions
      tracing: Change trace_boot to use kprobe_event interface
      tracing: Add kprobe event command generation test module
      tracing: Documentation for in-kernel synthetic event API
      tracing: Change trace_boot to use synth_event interface
      tracing: Fix now invalid var_ref_vals assumption in trace action
      tracing: Consolidate some synth_event_trace code
      tracing: Remove check_arg() callbacks from dynevent args
      tracing: Remove useless code in dynevent_arg_pair_add()
      tracing: Use seq_buf for building dynevent_cmd string

Vasily Averin (3):
      ftrace: fpid_next() should increase position index
      tracing: eval_map_next() should always increase position index
      trigger_next should increase position index

----
 Documentation/admin-guide/bootconfig.rst           |  190 ++++
 Documentation/admin-guide/index.rst                |    1 +
 Documentation/admin-guide/kernel-parameters.txt    |    6 +
 Documentation/trace/boottime-trace.rst             |  184 ++++
 Documentation/trace/events.rst                     |  515 ++++++++++
 Documentation/trace/index.rst                      |    1 +
 Documentation/trace/kprobetrace.rst                |    1 +
 MAINTAINERS                                        |    9 +
 drivers/oprofile/cpu_buffer.c                      |    2 +-
 fs/proc/Makefile                                   |    1 +
 fs/proc/bootconfig.c                               |   89 ++
 include/linux/bootconfig.h                         |  224 ++++
 include/linux/perf_event.h                         |    6 +-
 include/linux/ring_buffer.h                        |  110 +-
 include/linux/trace_events.h                       |  131 ++-
 include/trace/trace_events.h                       |   11 +-
 init/Kconfig                                       |   14 +
 init/main.c                                        |  229 ++++-
 kernel/events/core.c                               |   42 +-
 kernel/events/internal.h                           |   34 +-
 kernel/events/ring_buffer.c                        |   54 +-
 kernel/trace/Kconfig                               |  360 ++++---
 kernel/trace/Makefile                              |    3 +
 kernel/trace/blktrace.c                            |    8 +-
 kernel/trace/ftrace.c                              |   37 +-
 kernel/trace/kprobe_event_gen_test.c               |  225 ++++
 kernel/trace/ring_buffer.c                         |  135 +--
 kernel/trace/ring_buffer_benchmark.c               |    2 +-
 kernel/trace/synth_event_gen_test.c                |  523 ++++++++++
 kernel/trace/trace.c                               |  453 +++++----
 kernel/trace/trace.h                               |   98 +-
 kernel/trace/trace_boot.c                          |  334 ++++++
 kernel/trace/trace_branch.c                        |    6 +-
 kernel/trace/trace_dynevent.c                      |  212 ++++
 kernel/trace/trace_dynevent.h                      |   32 +
 kernel/trace/trace_entries.h                       |    2 +-
 kernel/trace/trace_events.c                        |  106 +-
 kernel/trace/trace_events_hist.c                   | 1071 ++++++++++++++++++--
 kernel/trace/trace_events_trigger.c                |   27 +-
 kernel/trace/trace_functions.c                     |    8 +-
 kernel/trace/trace_functions_graph.c               |   14 +-
 kernel/trace/trace_hwlat.c                         |    2 +-
 kernel/trace/trace_irqsoff.c                       |    8 +-
 kernel/trace/trace_kdb.c                           |    8 +-
 kernel/trace/trace_kprobe.c                        |  238 ++++-
 kernel/trace/trace_mmiotrace.c                     |   12 +-
 kernel/trace/trace_output.c                        |    2 +-
 kernel/trace/trace_sched_switch.c                  |    4 +-
 kernel/trace/trace_sched_wakeup.c                  |   20 +-
 kernel/trace/trace_selftest.c                      |   26 +-
 kernel/trace/trace_seq.c                           |    3 -
 kernel/trace/trace_stat.c                          |   31 +-
 kernel/trace/trace_syscalls.c                      |    8 +-
 kernel/trace/trace_uprobe.c                        |    2 +-
 lib/Kconfig                                        |    3 +
 lib/Makefile                                       |    2 +
 lib/bootconfig.c                                   |  814 +++++++++++++++
 tools/Makefile                                     |   11 +-
 tools/bootconfig/.gitignore                        |    1 +
 tools/bootconfig/Makefile                          |   23 +
 tools/bootconfig/include/linux/bootconfig.h        |    7 +
 tools/bootconfig/include/linux/bug.h               |   12 +
 tools/bootconfig/include/linux/ctype.h             |    7 +
 tools/bootconfig/include/linux/errno.h             |    7 +
 tools/bootconfig/include/linux/kernel.h            |   18 +
 tools/bootconfig/include/linux/printk.h            |   17 +
 tools/bootconfig/include/linux/string.h            |   32 +
 tools/bootconfig/main.c                            |  354 +++++++
 .../samples/bad-array-space-comment.bconf          |    5 +
 tools/bootconfig/samples/bad-array.bconf           |    2 +
 tools/bootconfig/samples/bad-dotword.bconf         |    4 +
 tools/bootconfig/samples/bad-empty.bconf           |    1 +
 tools/bootconfig/samples/bad-keyerror.bconf        |    2 +
 tools/bootconfig/samples/bad-longkey.bconf         |    1 +
 tools/bootconfig/samples/bad-manywords.bconf       |    1 +
 tools/bootconfig/samples/bad-no-keyword.bconf      |    2 +
 tools/bootconfig/samples/bad-nonprintable.bconf    |    2 +
 tools/bootconfig/samples/bad-spaceword.bconf       |    2 +
 tools/bootconfig/samples/bad-tree.bconf            |    5 +
 tools/bootconfig/samples/bad-value.bconf           |    3 +
 tools/bootconfig/samples/escaped.bconf             |    3 +
 .../samples/good-array-space-comment.bconf         |    4 +
 .../samples/good-comment-after-value.bconf         |    1 +
 tools/bootconfig/samples/good-printables.bconf     |    2 +
 tools/bootconfig/samples/good-simple.bconf         |   11 +
 tools/bootconfig/samples/good-single.bconf         |    4 +
 .../samples/good-space-after-value.bconf           |    1 +
 tools/bootconfig/samples/good-tree.bconf           |   12 +
 tools/bootconfig/test-bootconfig.sh                |  105 ++
 .../test.d/trigger/trigger-hist-syntax-errors.tc   |   32 +
 90 files changed, 6535 insertions(+), 852 deletions(-)
 create mode 100644 Documentation/admin-guide/bootconfig.rst
 create mode 100644 Documentation/trace/boottime-trace.rst
 create mode 100644 fs/proc/bootconfig.c
 create mode 100644 include/linux/bootconfig.h
 create mode 100644 kernel/trace/kprobe_event_gen_test.c
 create mode 100644 kernel/trace/synth_event_gen_test.c
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
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
---------------------------
