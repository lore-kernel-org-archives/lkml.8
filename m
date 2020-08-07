Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E462AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D952086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgHGV2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGV2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:28:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B7D2086A;
        Fri,  7 Aug 2020 21:28:05 +0000 (UTC)
Date:   Fri, 7 Aug 2020 17:28:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] tracing: Updates for 5.9
Message-ID: <20200807172804.031b9241@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ This time Cc'ing LKML ]

Linus,

Tracing updates for 5.9

 - The biggest news in that the tracing ring buffer can now time events that
   interrupted other ring buffer events. Before this change, if an interrupt
   came in while recording another event, and that interrupt also had an
   event, those events would all have the same time stamp as the event it
   interrupted. Now, with the new design, those events will have a unique time
   stamp and rightfully display the time for those events that were recorded
   while interrupting another event.

 - Bootconfig how has an "override" operator that lets the users have a
   default config, but then add options to override the default.

 - A fix was made to properly filter function graph tracing to the ftrace
   PIDs. This came in at the end of the -rc cycle, and needs to be backported.

 - Several clean ups, performance updates, and minor fixes as well.


Please pull the latest trace-v5.9 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.9

Tag SHA1: d262bb9817f9f28ef4370c2de8a2a6058e25ed87
Head SHA1: 38ce2a9e33db61a3041840310077072d6210ead4


Chengming Zhou (2):
      ftrace: Setup correct FTRACE_FL_REGS flags for module
      ftrace: Do not let direct or IPMODIFY ftrace_ops be added to module and set trampolines

Josef Bacik (1):
      ftrace: Fix ftrace_trace_task return value

Kevin Hao (2):
      tracing/hwlat: Drop the duplicate assignment in start_kthread()
      tracing/hwlat: Honor the tracing_cpumask

Masami Hiramatsu (5):
      kprobes: Remove show_registers() function prototype
      lib/bootconfig: Add override operator support
      tools/bootconfig: Add testcases for value override operator
      Documentation: bootconfig: Add bootconfig override operator
      bootconfig: Fix to find the initargs correctly

Muchun Song (2):
      kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler
      kprobes: Fix compiler warning for !CONFIG_KPROBES_ON_FTRACE

Nicholas Piggin (1):
      ring-buffer: speed up buffer resets by avoiding synchronize_rcu for each CPU

Nick Desaulniers (2):
      tracepoint: Mark __tracepoint_string's __used
      tracepoint: Use __used attribute definitions from compiler_attributes.h

Peng Fan (1):
      tracing/uprobe: Remove dead code in trace_uprobe_register()

Steven Rostedt (VMware) (15):
      tracing: Only allow trace_array_printk() to be used by instances
      x86/ftrace: Make non direct case the default in ftrace_regs_caller
      x86/ftrace: Only have the builtin ftrace_regs_caller call direct hooks
      x86/ftrace: Do not jump to direct code in created trampolines
      tracing: Move pipe reference to trace array instead of current_tracer
      ring-buffer: Have nested events still record running time stamp
      ring-buffer: Incorporate absolute timestamp into add_timestamp logic
      ring-buffer: Add rb_time_t 64 bit operations for speeding up 32 bit
      ring-buffer: Mark the !tail (crossing a page) as unlikely
      ring-buffer: Consolidate add_timestamp to remove some branches
      ring-buffer: Move the add_timestamp into its own function
      ring-buffer: Call trace_clock_local() directly for RETPOLINE kernels
      ring-buffer: Do not trigger a WARN if clock going backwards is detected
      tracing: Use trace_sched_process_free() instead of exit() for pid tracing
      tracing: Add trace_array_init_printk() to initialize instance trace_printk() buffers

Vincent Whitchurch (1):
      tracing: Remove outdated comment in stack handling

Wei Yang (6):
      tracing: not necessary to undefine DEFINE_EVENT again
      tracing: not necessary re-define DEFINE_EVENT_PRINT
      tracing: define DEFINE_EVENT_PRINT not related to DEFINE_EVENT
      tracing: not necessary to define DEFINE_EVENT_PRINT to be empty again
      tracing: Simplify defining of the next event id
      tracing: Save one trace_event->type by using __TRACE_LAST_TYPE

Zhaoyang Huang (1):
      trace : Have tracing buffer info use kvzalloc instead of kzalloc

----
 Documentation/admin-guide/bootconfig.rst     |  11 +
 arch/x86/kernel/ftrace.c                     |  14 +-
 arch/x86/kernel/ftrace_64.S                  |  29 +-
 include/linux/kprobes.h                      |   1 -
 include/linux/ring_buffer.h                  |   1 +
 include/linux/trace.h                        |   1 +
 include/linux/tracepoint.h                   |  11 +-
 include/trace/trace_events.h                 |  19 +-
 init/main.c                                  |  14 +-
 kernel/kprobes.c                             |  24 +-
 kernel/trace/ftrace.c                        |  34 +-
 kernel/trace/ring_buffer.c                   | 694 +++++++++++++++++++++------
 kernel/trace/trace.c                         |  80 ++-
 kernel/trace/trace.h                         |   9 +-
 kernel/trace/trace_events.c                  |   4 +-
 kernel/trace/trace_hwlat.c                   |   6 +-
 kernel/trace/trace_output.c                  |  14 +-
 kernel/trace/trace_uprobe.c                  |   1 -
 lib/bootconfig.c                             |  33 +-
 tools/bootconfig/samples/bad-override.bconf  |   3 +
 tools/bootconfig/samples/bad-override2.bconf |   3 +
 tools/bootconfig/samples/good-override.bconf |   6 +
 tools/bootconfig/test-bootconfig.sh          |  13 +
 23 files changed, 775 insertions(+), 250 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-override.bconf
 create mode 100644 tools/bootconfig/samples/bad-override2.bconf
 create mode 100644 tools/bootconfig/samples/good-override.bconf
---------------------------
