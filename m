Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F7FC4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BA024656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgBZATa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgBZATa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:19:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C554324656;
        Wed, 26 Feb 2020 00:19:28 +0000 (UTC)
Date:   Tue, 25 Feb 2020 19:19:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [GIT PULL] tracing/bootconfig: Fixes and changes to bootconfig
 before it goes live in a release
Message-ID: <20200225191927.3cbaa0db@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing updates:

 Change in API of bootconfig (before it comes live in a release)
  - Have a magic value "BOOTCONFIG" in initrd to know a bootconfig exists
  - Set CONFIG_BOOT_CONFIG to 'n' by default
  - Show error if "bootconfig" on cmdline but not compiled in
  - Prevent redefining the same value
  - Have a way to append values
  - Added a SELECT BLK_DEV_INITRD to fix a build failure

 Synthetic event fixes:
  - Switch to raw_smp_processor_id() for recording CPU value in preempt
    section. (No care for what the value actually is)
  - Fix samples always recording u64 values
  - Fix endianess
  - Check number of values matches number of fields
  - Fix a printing bug

 Fix of trace_printk() breaking postponed start up tests

 Make a function static that is only used in a single file.


Please pull the latest trace-v5.6-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.6-rc2

Tag SHA1: b50d255b6c6f55384c40bbac65fd5d5d4529a8ba
Head SHA1: 2910b5aa6f545c044173a5cab3dbb7f43e23916d


Masami Hiramatsu (9):
      tracing: Clear trace_state when starting trace
      bootconfig: Set CONFIG_BOOT_CONFIG=n by default
      bootconfig: Add bootconfig magic word for indicating bootconfig explicitly
      tools/bootconfig: Remove unneeded error message silencer
      bootconfig: Reject subkey and value on same parent key
      bootconfig: Print array as multiple commands for legacy command line
      bootconfig: Prohibit re-defining value on same key
      bootconfig: Add append value operator support
      bootconfig: Fix CONFIG_BOOTTIME_TRACING dependency issue

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
 init/Kconfig                                 |   5 +-
 init/main.c                                  |  38 +++++----
 kernel/trace/Kconfig                         |   4 +-
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
 15 files changed, 272 insertions(+), 92 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf
 create mode 100644 tools/bootconfig/samples/bad-samekey.bconf
---------------------------
