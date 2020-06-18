Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B13C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C11D20771
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgFRX4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgFRX4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:56:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5201820771;
        Thu, 18 Jun 2020 23:56:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jm4Od-003lLY-9Z; Thu, 18 Jun 2020 19:56:39 -0400
Message-ID: <20200618235556.451120786@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 19:55:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/17] tracing: Updates for 5.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a list fixes and clean ups for tracing.

-- Steve
`

Jiri Olsa (1):
      kretprobe: Prevent triggering kretprobe from within kprobe_flush_task

Kaitao Cheng (1):
      ftrace: Fix maybe-uninitialized compiler warning

Kefeng Wang (2):
      sample-trace-array: Fix sleeping function called from invalid context
      sample-trace-array: Remove trace_array 'sample-instance'

Masami Hiramatsu (8):
      kprobes: Suppress the suspicious RCU warning on kprobes
      kprobes: Use non RCU traversal APIs on kprobe_tables if possible
      kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
      kprobes: Remove redundant arch_disarm_kprobe() call
      proc/bootconfig: Fix to use correct quotes for value
      tools/bootconfig: Fix to use correct quotes for value
      tools/bootconfig: Fix to return 0 if succeeded to show the bootconfig
      tools/bootconfig: Add testcase for show-command and quotes test

Sami Tolvanen (1):
      recordmcount: support >64k sections

Steven Rostedt (VMware) (1):
      tracing: Make ftrace packed events have align of 1

Vamshi K Sthambamkadi (1):
      tracing/probe: Fix memleak in fetch_op_data operations

Wei Yang (1):
      trace: Fix typo in allocate_ftrace_ops()'s comment

YangHui (1):
      tracing: Remove unused event variable in tracing_iter_reset

----
 arch/x86/kernel/kprobes/core.c      | 16 ++----
 fs/proc/bootconfig.c                | 15 ++++--
 include/linux/kprobes.h             |  4 ++
 kernel/kprobes.c                    | 61 ++++++++++++++++++-----
 kernel/trace/ftrace.c               | 12 ++++-
 kernel/trace/trace.c                |  3 +-
 kernel/trace/trace.h                |  3 ++
 kernel/trace/trace_entries.h        | 14 +++---
 kernel/trace/trace_export.c         | 16 ++++++
 kernel/trace/trace_functions.c      |  2 +-
 kernel/trace/trace_probe.c          |  4 +-
 samples/ftrace/sample-trace-array.c | 24 ++++++---
 scripts/recordmcount.h              | 98 ++++++++++++++++++++++++++++++++++---
 tools/bootconfig/main.c             | 24 +++++----
 tools/bootconfig/test-bootconfig.sh | 10 ++++
 15 files changed, 239 insertions(+), 67 deletions(-)
