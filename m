Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB45C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2781E227BF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBXRVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgBXRVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2796B20836;
        Mon, 24 Feb 2020 17:21:17 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPv-001AbM-Te; Mon, 24 Feb 2020 12:21:15 -0500
Message-Id: <20200224172022.330525468@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-linus][PATCH 00/15] tracing: Updates coming for 5.6 rc release
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some updates coming with 5.6 rc:

 Change in API of bootconfig (before it comes live in a release)
  - Have a magic value "BOOTCONFIG" in initrd to know a bootconfig exists
  - Set CONFIG_BOOT_CONFIG to 'n' by default
  - Show error if "bootconfig" on cmdline but not compiled in
  - Prevent redefining the same value
  - Have a way to append values

 Synthetic event fixes:
  - Switch to raw_smp_processor_id() for recording CPU value in preempt
    section. (No care for what the value actually is)
  - Fix samples always recording u64 values
  - Fix endianess
  - Check number of values matches number of fields
  - Fix a printing bug

 Fix of trace_printk() breaking postponed start up tests

 Make a function static that is only used in a single file.

Masami Hiramatsu (8):
      tracing: Clear trace_state when starting trace
      bootconfig: Set CONFIG_BOOT_CONFIG=n by default
      bootconfig: Add bootconfig magic word for indicating bootconfig explicitly
      tools/bootconfig: Remove unneeded error message silencer
      bootconfig: Reject subkey and value on same parent key
      bootconfig: Print array as multiple commands for legacy command line
      bootconfig: Prohibit re-defining value on same key
      bootconfig: Add append value operator support

Qiujun Huang (1):
      bootconfig: Mark boot_config_checksum() static

Steven Rostedt (VMware) (2):
      tracing: Have synthetic event test use raw_smp_processor_id()
      tracing: Disable trace_printk() on post poned tests

Tom Zanussi (4):
      tracing: Make sure synth_event_trace() example always uses u64
      tracing: Make synth_event trace functions endian-correct
      tracing: Check that number of vals matches number of synth event fields
      tracing: Fix number printing bug in print_synth_event()

----
 Documentation/admin-guide/bootconfig.rst     |  34 +++++++-
 include/linux/bootconfig.h                   |   3 +
 init/Kconfig                                 |   3 +-
 init/main.c                                  |  38 +++++----
 kernel/trace/Kconfig                         |   3 +-
 kernel/trace/synth_event_gen_test.c          |  44 +++++------
 kernel/trace/trace.c                         |   2 +
 kernel/trace/trace_events_hist.c             | 112 ++++++++++++++++++++++++---
 lib/bootconfig.c                             |  36 ++++++---
 tools/bootconfig/include/linux/printk.h      |   5 +-
 tools/bootconfig/main.c                      |  51 +++++++-----
 tools/bootconfig/samples/bad-mixed-kv1.bconf |   3 +
 tools/bootconfig/samples/bad-mixed-kv2.bconf |   3 +
 tools/bootconfig/samples/bad-samekey.bconf   |   6 ++
 tools/bootconfig/test-bootconfig.sh          |  18 ++++-
 15 files changed, 271 insertions(+), 90 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf
 create mode 100644 tools/bootconfig/samples/bad-samekey.bconf
