Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D08C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 00:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000DD206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 00:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgDEAH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 20:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDEAH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 20:07:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB016206F5;
        Sun,  5 Apr 2020 00:07:24 +0000 (UTC)
Date:   Sat, 4 Apr 2020 20:07:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Updates for 5.7
Message-ID: <20200404200723.26662e07@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

New tracing features:

 - The ring buffer is no longer disabled when reading the trace file.
   The trace_pipe file was made to be used for live tracing and reading
   as it acted like the normal producer/consumer. As the trace file
   would not consume the data, the easy way of handling it was to just
   disable writes to the ring buffer. This came to a surprise to the
   BPF folks who complained about lost events due to reading.
   This is no longer an issue. If someone wants to keep the old disabling
   there's a new option "pause-on-trace" that can be set.

 - New set_ftrace_notrace_pid file. PIDs in this file will not be traced
   by the function tracer. Similar to set_ftrace_pid, which makes the
   function tracer only trace those tasks with PIDs in the file, the
   set_ftrace_notrace_pid does the reverse.

 - New set_event_notrace_pid file. PIDs in this file will cause events
   not to be traced if triggered by a task with a matching PID.
   Similar to the set_event_pid file but will not be traced.
   Note, sched_waking and sched_switch events may still be trace if
   one of the tasks referenced by those events contains a PID that
   is allowed to be traced.

Tracing related features:

 - New bootconfig option, that is attached to the initrd file.
   If bootconfig is on the command line, then the initrd file
   is searched looking for a bootconfig appended at the end.

 - New GPU tracepoint infrastructure to help the gfx drivers to get
   off debugfs (acked by Greg Kroah-Hartman)

Other minor updates and fixes.


Please pull the latest trace-v5.7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.7

Tag SHA1: 7c483089c1d670b55a9b2d574a74b6c0f6481544
Head SHA1: 8e99cf91b99bb30e16727f10ad6828741c0e992f


Masami Hiramatsu (3):
      bootconfig: Support O=<builddir> option
      tools/bootconfig: Show line and column in parse error
      ftrace/kprobe: Show the maxactive number on kprobe_events

Nathan Chancellor (1):
      tracing: Use address-of operator on section symbols

Steven Rostedt (VMware) (22):
      tracing: Have hwlat ts be first instance and record count of instances
      tracing: Remove unused TRACE_BUFFER bits
      selftest/ftrace: Fix function trigger test to handle trace not disabling the tracer
      tracing: Save off entry when peeking at next entry
      ring-buffer: Have ring_buffer_empty() not depend on tracing stopped
      ring-buffer: Rename ring_buffer_read() to read_buffer_iter_advance()
      ring-buffer: Add page_stamp to iterator for synchronization
      ring-buffer: Have rb_iter_head_event() handle concurrent writer
      ring-buffer: Do not die if rb_iter_peek() fails more than thrice
      ring-buffer: Optimize rb_iter_head_event()
      ring-buffer: Make resize disable per cpu buffer instead of total buffer
      ring-buffer: Do not disable recording when there is an iterator
      tracing: Do not disable tracing when reading the trace file
      ring-buffer/tracing: Have iterator acknowledge dropped events
      tracing: Have the document reflect that the trace file keeps tracing enabled
      ftrace: Make function trace pid filtering a bit more exact
      ftrace: Create set_ftrace_notrace_pid to not trace tasks
      tracing: Create set_event_notrace_pid to not trace tasks
      selftests/ftrace: Add test to test new set_ftrace_notrace_pid file
      selftests/ftrace: Add test to test new set_event_notrace_pid file
      tracing: Add documentation on set_ftrace_notrace_pid and set_event_notrace_pid
      tracing: Do not allocate buffer in trace_find_next_entry() in atomic

Yiwei Zhang (1):
      gpu/trace: add a gpu total memory usage tracepoint

----
 Documentation/trace/ftrace.rst                     |  82 ++++--
 drivers/Kconfig                                    |   2 +
 drivers/gpu/Makefile                               |   1 +
 drivers/gpu/trace/Kconfig                          |   4 +
 drivers/gpu/trace/Makefile                         |   3 +
 drivers/gpu/trace/trace_gpu_mem.c                  |  13 +
 include/linux/bootconfig.h                         |   3 +-
 include/linux/ring_buffer.h                        |   4 +-
 include/linux/trace_events.h                       |   2 +
 include/trace/events/gpu_mem.h                     |  57 +++++
 init/main.c                                        |  14 +-
 kernel/trace/ftrace.c                              | 200 +++++++++++++--
 kernel/trace/ring_buffer.c                         | 239 ++++++++++++------
 kernel/trace/trace.c                               | 110 ++++++--
 kernel/trace/trace.h                               |  39 ++-
 kernel/trace/trace_entries.h                       |   4 +-
 kernel/trace/trace_events.c                        | 280 ++++++++++++++++-----
 kernel/trace/trace_functions_graph.c               |   2 +-
 kernel/trace/trace_hwlat.c                         |  24 +-
 kernel/trace/trace_kprobe.c                        |   2 +
 kernel/trace/trace_output.c                        |  19 +-
 lib/bootconfig.c                                   |  35 ++-
 tools/bootconfig/Makefile                          |  27 +-
 tools/bootconfig/main.c                            |  35 ++-
 tools/bootconfig/test-bootconfig.sh                |  14 +-
 .../selftests/ftrace/test.d/event/event-no-pid.tc  | 125 +++++++++
 .../test.d/ftrace/func-filter-notrace-pid.tc       | 108 ++++++++
 .../test.d/ftrace/func_traceonoff_triggers.tc      |   2 +-
 28 files changed, 1194 insertions(+), 256 deletions(-)
 create mode 100644 drivers/gpu/trace/Kconfig
 create mode 100644 drivers/gpu/trace/Makefile
 create mode 100644 drivers/gpu/trace/trace_gpu_mem.c
 create mode 100644 include/trace/events/gpu_mem.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
---------------------------

