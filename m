Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BBFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E32E206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgA3OtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgA3OsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A179B206D3;
        Thu, 30 Jan 2020 14:48:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB74-001CJe-BX; Thu, 30 Jan 2020 09:48:10 -0500
Message-Id: <20200130144743.527378179@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:47:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/21] tracing: Some more last minute updates for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami Hiramatsu (2):
      tracing/boot: Include required headers and sort it alphabetically
      tracing/boot: Move external function declarations to kernel/trace/trace.h

Mathieu Desnoyers (1):
      tracing: Fix sched switch start/stop refcount racy updates

Steven Rostedt (VMware) (4):
      tracing: Move all function tracing configs together
      tracing: Move tracing test module configs together
      tracing: Move mmio tracer config up with the other tracers
      tracing: Move tracing selftests to bottom of menu

Tom Zanussi (11):
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

Vasily Averin (3):
      ftrace: fpid_next() should increase position index
      tracing: eval_map_next() should always increase position index
      trigger_next should increase position index

----
 Documentation/trace/events.rst       | 515 ++++++++++++++++++++
 include/linux/trace_events.h         | 124 +++++
 kernel/trace/Kconfig                 | 369 +++++++-------
 kernel/trace/Makefile                |   2 +
 kernel/trace/ftrace.c                |   5 +-
 kernel/trace/kprobe_event_gen_test.c | 225 +++++++++
 kernel/trace/synth_event_gen_test.c  | 523 ++++++++++++++++++++
 kernel/trace/trace.c                 |  47 +-
 kernel/trace/trace.h                 |  19 +
 kernel/trace/trace_boot.c            |  59 +--
 kernel/trace/trace_dynevent.c        | 240 ++++++++++
 kernel/trace/trace_dynevent.h        |  33 ++
 kernel/trace/trace_events.c          |  85 ++++
 kernel/trace/trace_events_hist.c     | 897 ++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_events_trigger.c  |   5 +-
 kernel/trace/trace_kprobe.c          | 160 ++++++-
 kernel/trace/trace_sched_switch.c    |   4 +-
 17 files changed, 3065 insertions(+), 247 deletions(-)
 create mode 100644 kernel/trace/kprobe_event_gen_test.c
 create mode 100644 kernel/trace/synth_event_gen_test.c
