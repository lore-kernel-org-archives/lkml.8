Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65017C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A26221F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGBV6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgGBV6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FA8E20780;
        Thu,  2 Jul 2020 21:58:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7Dz-004Bch-Hf; Thu, 02 Jul 2020 17:58:31 -0400
Message-ID: <20200702215812.428188663@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/18] tracing: Updatse for 5.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 29ce24519c0692ca7d998d7444a9e016a4c44fa7


Nicholas Piggin (1):
      ring-buffer: speed up buffer resets by avoiding synchronize_rcu for each CPU

Steven Rostedt (VMware) (13):
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

Wei Yang (4):
      tracing: not necessary to undefine DEFINE_EVENT again
      tracing: not necessary re-define DEFINE_EVENT_PRINT
      tracing: define DEFINE_EVENT_PRINT not related to DEFINE_EVENT
      tracing: not necessary to define DEFINE_EVENT_PRINT to be empty again

----
 arch/x86/kernel/ftrace.c     |  14 +-
 arch/x86/kernel/ftrace_64.S  |  29 +-
 include/linux/ring_buffer.h  |   1 +
 include/trace/trace_events.h |  19 +-
 kernel/trace/ftrace.c        |   8 +
 kernel/trace/ring_buffer.c   | 694 ++++++++++++++++++++++++++++++++++---------
 kernel/trace/trace.c         |  26 +-
 kernel/trace/trace.h         |   2 +-
 8 files changed, 600 insertions(+), 193 deletions(-)
