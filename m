Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8166FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC6A20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgFAM2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgFAM2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:28:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 025312077D;
        Mon,  1 Jun 2020 12:28:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jfjXz-00273d-0u; Mon, 01 Jun 2020 08:28:07 -0400
Message-ID: <20200601122729.727113609@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 01 Jun 2020 08:27:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/12] tracing: Updates for 5.8 (finally finished testing them)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: c200784a08d4ea82f82a30678955b7f2c7550af4


Cheng Jian (1):
      ftrace: show debugging information when panic_on_warn set

Julia Lawall (1):
      tracing/probe: reverse arguments to list_add

Masami Hiramatsu (1):
      tools/bootconfig: Add a summary of test cases and return error

Peter Zijlstra (1):
      ftrace,bug: Improve traceoff_on_warn

Steven Rostedt (VMware) (2):
      tracing/doc: Fix typos in histogram-design.rst
      tracing: Add a trace print when traceoff_on_warning is triggered

Tom Zanussi (6):
      tracing: Check state.disabled in synth event trace functions
      tracing: Add histogram-design document
      tracing: Add hist_debug trace event files for histogram debugging
      tracing: Fix events.rst section numbering
      tracing: Move synthetic events to a separate file
      selftests/ftrace: Distinguish between hist and synthetic event checks

----
 Documentation/trace/events.rst                     |   28 +-
 Documentation/trace/histogram-design.rst           | 2115 +++++++++++++++++++
 kernel/trace/Kconfig                               |   43 +-
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
 22 files changed, 4396 insertions(+), 1879 deletions(-)
 create mode 100644 Documentation/trace/histogram-design.rst
 create mode 100644 kernel/trace/trace_events_synth.c
 create mode 100644 kernel/trace/trace_synth.h
