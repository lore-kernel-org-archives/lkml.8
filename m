Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ACBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75ED420737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgFINRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgFINRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:17:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D633F20737;
        Tue,  9 Jun 2020 13:17:41 +0000 (UTC)
Date:   Tue, 9 Jun 2020 09:17:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Updates for 5.8
Message-ID: <20200609091740.303dda01@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing updates for 5.8:

No new features this release. Mostly clean ups, restructuring and
documentation.

 - Have ftrace_bug() show ftrace errors before the WARN, as the WARN will
   reboot the box before the error messages are printed if panic_on_warn
   is set.

 - Have traceoff_on_warn disable tracing sooner (before prints)

 - Write a message to the trace buffer that its being disabled when
   disable_trace_on_warning() is set.

 - Separate out synthetic events from histogram code to let it be used by
   other parts of the kernel.

 - More documentation on histogram design.

 - Other small fixes and clean ups.


Please pull the latest trace-v5.8 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.8

Tag SHA1: a9317885fb7c4418fea2588e3fbaeaafd773b106
Head SHA1: 388d8bdb87e01bcea6d0b2bf797b5f6d7b2401fb


Cheng Jian (1):
      ftrace: show debugging information when panic_on_warn set

Julia Lawall (1):
      tracing/probe: reverse arguments to list_add

Masami Hiramatsu (1):
      tools/bootconfig: Add a summary of test cases and return error

Mel Gorman (1):
      tracing: Remove obsolete PREEMPTIRQ_EVENTS kconfig option

Peter Zijlstra (1):
      ftrace,bug: Improve traceoff_on_warn

Steven Rostedt (VMware) (2):
      tracing/doc: Fix typos in histogram-design.rst
      tracing: Add a trace print when traceoff_on_warning is triggered

Tom Zanussi (7):
      tracing: Check state.disabled in synth event trace functions
      tracing: Add histogram-design document
      tracing: Add hist_debug trace event files for histogram debugging
      tracing: Fix events.rst section numbering
      tracing: Move synthetic events to a separate file
      selftests/ftrace: Distinguish between hist and synthetic event checks
      tracing/doc: Fix ascii-art in histogram-design.rst

----
 Documentation/trace/events.rst                     |   28 +-
 Documentation/trace/histogram-design.rst           | 2115 +++++++++++++++++++
 kernel/trace/Kconfig                               |   52 +-
 kernel/trace/Makefile                              |    1 +
 kernel/trace/ftrace.c                              |    8 +-
 kernel/trace/trace.c                               |    5 +-
 kernel/trace/trace.h                               |    1 +
 kernel/trace/trace_events.c                        |    4 +
 kernel/trace/trace_events_hist.c                   | 2193 +++-----------------
 kernel/trace/trace_events_synth.c                  | 1789 ++++++++++++++++
 kernel/trace/trace_probe.c                         |    2 +-
 kernel/trace/trace_synth.h                         |   36 +
 lib/bug.c                                          |    3 +
 tools/bootconfig/test-bootconfig.sh                |    7 +
 .../inter-event/trigger-field-variable-support.tc  |    5 +
 .../trigger-inter-event-combined-hist.tc           |    5 +
 .../inter-event/trigger-multi-actions-accept.tc    |    5 +
 .../inter-event/trigger-onmatch-action-hist.tc     |    5 +
 .../trigger-onmatch-onmax-action-hist.tc           |    5 +
 .../inter-event/trigger-onmax-action-hist.tc       |    5 +
 .../inter-event/trigger-snapshot-action-hist.tc    |    5 +
 .../inter-event/trigger-trace-action-hist.tc       |    5 +
 22 files changed, 4396 insertions(+), 1888 deletions(-)
 create mode 100644 Documentation/trace/histogram-design.rst
 create mode 100644 kernel/trace/trace_events_synth.c
 create mode 100644 kernel/trace/trace_synth.h
---------------------------
