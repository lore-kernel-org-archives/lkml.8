Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1A1C5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF80F20757
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCQVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCQVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:55:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD1220724;
        Tue, 17 Mar 2020 21:55:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jEKB6-000EtE-FQ; Tue, 17 Mar 2020 17:55:12 -0400
Message-Id: <20200317215455.885042360@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 17:54:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: Updates for 5.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: bbd9d05618a6d608c72640b1d3d651a75913456a


Masami Hiramatsu (2):
      bootconfig: Support O=<builddir> option
      tools/bootconfig: Show line and column in parse error

Steven Rostedt (VMware) (2):
      tracing: Have hwlat ts be first instance and record count of instances
      tracing: Remove unused TRACE_BUFFER bits

Yiwei Zhang (1):
      gpu/trace: add a gpu total memory usage tracepoint

----
 Documentation/trace/ftrace.rst      | 32 ++++++++++++++-------
 drivers/Kconfig                     |  2 ++
 drivers/gpu/Makefile                |  1 +
 drivers/gpu/trace/Kconfig           |  4 +++
 drivers/gpu/trace/Makefile          |  3 ++
 drivers/gpu/trace/trace_gpu_mem.c   | 13 +++++++++
 include/linux/bootconfig.h          |  3 +-
 include/trace/events/gpu_mem.h      | 57 +++++++++++++++++++++++++++++++++++++
 init/main.c                         | 14 ++++++---
 kernel/trace/trace.h                |  7 +----
 kernel/trace/trace_entries.h        |  4 ++-
 kernel/trace/trace_hwlat.c          | 24 +++++++++++-----
 kernel/trace/trace_output.c         |  4 +--
 lib/bootconfig.c                    | 35 +++++++++++++++++------
 tools/bootconfig/Makefile           | 27 +++++++++++-------
 tools/bootconfig/main.c             | 35 ++++++++++++++++++++---
 tools/bootconfig/test-bootconfig.sh | 14 ++++++---
 17 files changed, 221 insertions(+), 58 deletions(-)
 create mode 100644 drivers/gpu/trace/Kconfig
 create mode 100644 drivers/gpu/trace/Makefile
 create mode 100644 drivers/gpu/trace/trace_gpu_mem.c
 create mode 100644 include/trace/events/gpu_mem.h
