Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB0AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1307208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599774670;
	bh=25yF4owqwsNmk0585dW0SJNvLjTvEMmT7IVp5jr06sY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XWtSfSzbtMVu84a3ylSK7jd3j+Eqg3HY0iv8Fg9K9quh7o0rA3yGrcsST/ikXB+8d
	 ib+n0kOnMN8WVVfN2juWT7Fl6dsuP1mLHIpYpzLyEfbJrlCksJO0f1icPDyWA6wObJ
	 tPK7TWDl6kKSkLa1tprFmxkTZLXfUQ073XXi6Qnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgIJVvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbgIJMi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:38:57 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3F020BED;
        Thu, 10 Sep 2020 12:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599741513;
        bh=25yF4owqwsNmk0585dW0SJNvLjTvEMmT7IVp5jr06sY=;
        h=From:To:Cc:Subject:Date:From;
        b=P4dQWQ+RzLMAgZubY437m5CwR67a8KNPsAPj1xpF8rh7DA1hk0UDyIR6mZ1tFPlRt
         BC4INL14GIIJDmaxyN31haAuZQ+yYp2bYlZ6GKTNsRKbdNRdtGtrcGoX1uRWvg+RGJ
         UDqyOJYFexPYcYd8wm/UKwhp49B6eDs//2F5XMbQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/6] tracing/boot: Start boot-time tracing in earlier stage
Date:   Thu, 10 Sep 2020 21:38:29 +0900
Message-Id: <159974150897.478751.17933810682730471522.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a series of patches which starts the boot-time tracing earlier,
core_initcall_sync, so that we can start tracing from postcore_initcall
instead of device_initcall.

The boot-time tracing is useful for debugging kernel drivers which are
embedded in the kernel. Since most of the drivers are initialized in the
device_initcall, the boot-time tracing which starts in fs_initcall, can
trace them. However, many frameworks and platform drivers are initialized
in subsys_initcall or arch_initcall and the boot-time tracing still
misses it.

This series will improve the boot-time tracing to trace those events.

- Move kprobes initialization into early_initcall from subsys_initcall
  as same as jump_label and dynamic_debug.
  Previously arm64 didn't allow it, but commit b322c65f8ca3 ("arm64:
  Call debug_traps_init() from trap_init() to help early kgdb") fixed it.
- Fixes tracing init routines to decouple the tracefs entry creation
  and the data-structure allocation/initialization.
- Move dynamic-events initialization to core_initcall and call boot-time
  tracing in core_initcall_sync (the core_initcall_sync is called after
  all core_initcall functions are done).

Thank you,

---

Masami Hiramatsu (6):
      kprobes: Init kprobes in early_initcall
      tracing: Define event fields early stage
      tracing: Enable adding dynamic events early stage
      tracing: Enable creating new instance early boot
      tracing/boot,kprobe,synth: Initialize boot-time tracing earlier
      Documentation: tracing: Add the startup timing of boot-time tracing


 Documentation/trace/boottime-trace.rst |   14 ++++
 kernel/kprobes.c                       |    2 -
 kernel/trace/trace.c                   |   53 +++++++++++++----
 kernel/trace/trace.h                   |    7 ++
 kernel/trace/trace_boot.c              |    7 ++
 kernel/trace/trace_events.c            |  101 ++++++++++++++++++++------------
 kernel/trace/trace_events_synth.c      |   22 +++++--
 kernel/trace/trace_functions.c         |   22 ++++---
 kernel/trace/trace_kprobe.c            |    6 +-
 9 files changed, 165 insertions(+), 69 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
