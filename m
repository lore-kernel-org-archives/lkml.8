Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F428C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A6E2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbgAXPR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:17:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbgAXPR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822BC20709;
        Fri, 24 Jan 2020 15:17:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i4-000qAl-Dm; Fri, 24 Jan 2020 10:17:24 -0500
Message-Id: <20200124151651.852781301@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:16:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/14] tracing: More updates for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Shi (5):
      ftrace: Remove abandoned macros
      ftrace: Remove NR_TO_INIT macro
      ring-buffer: Remove abandoned macro RB_MISSED_FLAGS
      tracing: Remove unused TRACE_SEQ_BUF_USED
      trace/kprobe: Remove unused MAX_KPROBE_CMDLINE_SIZE

Colin Ian King (1):
      tools: bootconfig: Fix spelling mistake "faile" -> "failed"

Dan Carpenter (1):
      tracing/boot: Fix an IS_ERR() vs NULL bug

Fabian Frederick (1):
      ring-bufer: kernel-doc warning fixes

Masami Hiramatsu (3):
      bootconfig: Fix Kconfig help message for BOOT_CONFIG
      Documentation: bootconfig: Fix typos in bootconfig documentation
      Documentation: tracing: Fix typos in boot-time tracing documentation

Steven Rostedt (VMware) (3):
      ring-buffer: Fix kernel doc for rb_update_event()
      tracing: Allow trace_printk() to nest in other tracing code
      tracing: Fix uninitialized buffer var on early exit to trace_vbprintk()

----
 Documentation/admin-guide/bootconfig.rst | 32 +++++++++++++++++---------------
 Documentation/trace/boottime-trace.rst   | 18 +++++++++---------
 init/Kconfig                             |  4 +++-
 kernel/trace/ftrace.c                    |  5 -----
 kernel/trace/ring_buffer.c               | 11 ++++++-----
 kernel/trace/trace.c                     | 27 +++++++++++++++++++++------
 kernel/trace/trace_boot.c                |  2 +-
 kernel/trace/trace_kprobe.c              |  1 -
 kernel/trace/trace_seq.c                 |  3 ---
 tools/bootconfig/main.c                  |  4 ++--
 10 files changed, 59 insertions(+), 48 deletions(-)
