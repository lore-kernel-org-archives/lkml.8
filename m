Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49576C2D0EE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF11206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgC2SnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbgC2SnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E60206DB;
        Sun, 29 Mar 2020 18:43:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIctv-002FqH-Ko; Sun, 29 Mar 2020 14:43:15 -0400
Message-Id: <20200329184252.289087453@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:42:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/21] tracing: Updates for v5.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 2ab2a0924b9980551ebe1c47d2a402a94efc1835


Masami Hiramatsu (1):
      ftrace/kprobe: Show the maxactive number on kprobe_events

Nathan Chancellor (1):
      tracing: Use address-of operator on section symbols

Steven Rostedt (VMware) (19):
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

----
 Documentation/trace/ftrace.rst                     |  50 +++-
 include/linux/ring_buffer.h                        |   4 +-
 include/linux/trace_events.h                       |   2 +
 kernel/trace/ftrace.c                              | 200 +++++++++++++--
 kernel/trace/ring_buffer.c                         | 239 ++++++++++++------
 kernel/trace/trace.c                               |  91 +++++--
 kernel/trace/trace.h                               |  32 ++-
 kernel/trace/trace_events.c                        | 280 ++++++++++++++++-----
 kernel/trace/trace_functions_graph.c               |   2 +-
 kernel/trace/trace_kprobe.c                        |   2 +
 kernel/trace/trace_output.c                        |  15 +-
 .../selftests/ftrace/test.d/event/event-no-pid.tc  | 125 +++++++++
 .../test.d/ftrace/func-filter-notrace-pid.tc       | 108 ++++++++
 .../test.d/ftrace/func_traceonoff_triggers.tc      |   2 +-
 14 files changed, 954 insertions(+), 198 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
