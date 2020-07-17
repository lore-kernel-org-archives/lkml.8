Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA499C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC82E2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGQDEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:04:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:14919 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgGQDEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:30 -0400
IronPort-SDR: b3blxDvRhfJHNUTWuTdPHLPiBNJ0g3hLtG8K8IEXthPr97TmtYzFVD4b+r374VSFEjBcdGp7qJ
 uisAPJp9Et+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="211069863"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="211069863"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:29 -0700
IronPort-SDR: nTyYsXHs1ccWJhVZoUr8ico2KHUgm+9UgLYhZmUZdJ3K/MDlYJGfmOi3p2Z0530AAQM5EgqY1J
 IdiukOIk1LQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="282657992"
Received: from pgerasim-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.34.31])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2020 20:04:27 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v4 0/7] arch/x86: kprobes: Remove MODULES dependency
Date:   Fri, 17 Jul 2020 06:04:14 +0300
Message-Id: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove MODULES dependency by migrating from module_alloc() to the new
text_alloc() API. Essentially these changes provide preliminaries for
allowing to compile a static kernel with a proper tracing support.

The same API can be used later on in other sites that allocate space for
trampolines, and trivially scaled to other arch's. An arch can inform
with CONFIG_ARCH_HAS_TEXT_ALLOC that it's providing implementation for
text_alloc().

I tested this by creating a trivial (x86_64_defconfig) kernel and initrd
(BusyBox) and then run the most basic kprobe:

# ./kprobe p:do_sys_open
Tracing kprobe do_sys_open. Ctrl-C to end.
             cat-1018  [000] ....   277.635966: do_sys_open: (do_sys_open+0x0/0x80)
             cat-1018  [000] ....   277.635966: do_sys_open: (do_sys_open+0x0/0x80)
             cat-1018  [000] ....   277.636966: do_sys_open: (do_sys_open+0x0/0x80)
             cat-1018  [000] ....   277.636966: do_sys_open: (do_sys_open+0x0/0x80)
             cat-1018  [000] ....   277.636966: do_sys_open: (do_sys_open+0x0/0x80)
             cat-1018  [000] ....   277.636966: do_sys_open: (do_sys_open+0x0/0x80)
             cat-1018  [000] ....   277.636966: do_sys_open: (do_sys_open+0x0/0x80)
             cat-1018  [000] ....   277.636966: do_sys_open: (do_sys_open+0x0/0x80)
             cat-1018  [000] ....   277.636966: do_sys_open: (do_sys_open+0x0/0x80)
             cat-1018  [000] ....   277.640966: do_sys_open: (do_sys_open+0x0/0x80)
             cat-1018  [000] ....   277.654963: do_sys_open: (do_sys_open+0x0/0x80)

I did only "sed -i 's/=m/=y/' .config" and disabled CONFIG_MODULES. The
test was run under QEMU:

qemu-system-x86_64 -kernel output/images/bzImage  \
-m 1G -initrd output/images/rootfs.cpio \
-append "root=/dev/sda rw console=ttyS0,115200 acpi=off nokaslr" \
-serial stdio -display none

v3:
* Make text_alloc() API disjoint.
* Remove all the possible extra clutter not absolutely required and
  split into more logical pieces.

Jarkko Sakkinen (7):
  module: Add lock_modules() and unlock_modules()
  kprobes: Use lock_modules() and unlock_modules()
  vmalloc: Add text_alloc() and text_free()
  arch/x86: Implement text_alloc() and text_free()
  arch/x86: kprobes: Use text_alloc() in alloc_insn_page()
  kprobes: Use text_alloc() and text_free()
  kprobes: Flag out CONFIG_MODULES dependent code

 arch/Kconfig                   |  2 +-
 arch/x86/Kconfig               |  3 ++
 arch/x86/kernel/Makefile       |  1 +
 arch/x86/kernel/kprobes/core.c |  8 +----
 arch/x86/kernel/text_alloc.c   | 41 ++++++++++++++++++++++++
 include/linux/module.h         | 32 ++++++++++++++-----
 include/linux/vmalloc.h        | 23 ++++++++++++++
 kernel/kprobes.c               | 57 +++++++++++++++++++++-------------
 kernel/trace/trace_kprobe.c    | 20 +++++++++---
 9 files changed, 146 insertions(+), 41 deletions(-)
 create mode 100644 arch/x86/kernel/text_alloc.c

-- 
2.25.1

