Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385B9C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1656720780
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684199;
	bh=QotbvpR+ipa9WO0KVHtHpisc4gu+Geq5eDDff4yyXaw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0gsjw45Yy2sFs0EeSOCkGxB390LHwOTIJeKPcV9DOfOpIoFxv9Ei8GP0C/kP7uw0O
	 xaWS2KrWu+fsSFt+QxZ+avyn6b46IQlD1SUNgkiS0+CG1H3xWz8P1m5QBKrIqBcUUK
	 LS/3+uk9pTm1LDZUX3pFvplgHRwpYAtKomjqEm04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgDWXWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgDWXWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A0CA2077D;
        Thu, 23 Apr 2020 23:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684131;
        bh=QotbvpR+ipa9WO0KVHtHpisc4gu+Geq5eDDff4yyXaw=;
        h=From:To:Cc:Subject:Date:From;
        b=nHLB5/apYOfrVUc5/SaqYvmsoMFu97LT0cCsvHGI7QT83Qp7Ur6t4do6jabWrI4Lb
         MeF2F278ba7t1nzxgJ4+6tFY3DIKQiksQ+fHwpMTudptvx+aaT5zmWAS67eCIb3Ebl
         YaPuQ0q7kpLebLIoMOvAnGrBPexMPUc4ftZAl5Is=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 00/18] Enable FSGSBASE instructions
Date:   Thu, 23 Apr 2020 19:21:49 -0400
Message-Id: <20200423232207.5797-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benefits:
Currently a user process that wishes to read or write the FS/GS base must
make a system call. But recent X86 processors have added new instructions
for use in 64-bit mode that allow direct access to the FS and GS segment
base addresses.  The operating system controls whether applications can
use these instructions with a %cr4 control bit.

In addition to benefits to applications, performance improvements to the
OS context switch code are possible by making use of these instructions. A
third party reported out promising performance numbers out of their
initial benchmarking of the previous version of this patch series [9].

Enablement check:
The kernel provides information about the enabled state of FSGSBASE to
applications using the ELF_AUX vector. If the HWCAP2_FSGSBASE bit is set in
the AUX vector, the kernel has FSGSBASE instructions enabled and
applications can use them.

Kernel changes:
Major changes made in the kernel are in context switch, paranoid path, and
ptrace. In a context switch, a task's FS/GS base will be secured regardless
of its selector. In the paranoid path, GS base is unconditionally
overwritten to the kernel GS base on entry and the original GS base is
restored on exit. Ptrace includes divergence of FS/GS index and base
values.

Security:
For mitigating the Spectre v1 SWAPGS issue, LFENCE instructions were added
on most kernel entries. Those patches are dependent on previous behaviors
that users couldn't load a kernel address into the GS base. These patches
change that assumption since the user can load any address into GS base.
The changes to the kernel entry path in this patch series take account of
the SWAPGS issue.

Changes from v9:

 - Rebase on top of v5.7-rc1 and re-test.
 - Work around changes in 2fff071d28b5 ("x86/process: Unify
   copy_thread_tls()").
 - Work around changes in c7ca0b614513 ("Revert "x86/ptrace: Prevent
   ptrace from clearing the FS/GS selector" and fix the test").

 

Andi Kleen (2):
  x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
  x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2

Andy Lutomirski (4):
  x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
  x86/entry/64: Clean up paranoid exit
  x86/fsgsbase/64: Use FSGSBASE in switch_to() if available
  x86/fsgsbase/64: Enable FSGSBASE on 64bit by default and add a chicken
    bit

Chang S. Bae (9):
  x86/ptrace: Prevent ptrace from clearing the FS/GS selector
  selftests/x86/fsgsbase: Test GS selector on ptracer-induced GS base
    write
  x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
  x86/entry/64: Introduce the FIND_PERCPU_BASE macro
  x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
  x86/entry/64: Document GSBASE handling in the paranoid path
  x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
  x86/fsgsbase/64: Use FSGSBASE instructions on thread copy and ptrace
  selftests/x86/fsgsbase: Test ptracer-induced GS base write with
    FSGSBASE

Sasha Levin (1):
  x86/fsgsbase/64: move save_fsgs to header file

Thomas Gleixner (1):
  Documentation/x86/64: Add documentation for GS/FS addressing mode

Tony Luck (1):
  x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation

 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/x86/entry_64.rst                |   9 +
 Documentation/x86/x86_64/fsgs.rst             | 199 ++++++++++++++++++
 Documentation/x86/x86_64/index.rst            |   1 +
 arch/x86/entry/calling.h                      |  40 ++++
 arch/x86/entry/entry_64.S                     | 131 +++++++++---
 arch/x86/include/asm/fsgsbase.h               |  45 +++-
 arch/x86/include/asm/inst.h                   |  15 ++
 arch/x86/include/uapi/asm/hwcap2.h            |   3 +
 arch/x86/kernel/cpu/bugs.c                    |   6 +-
 arch/x86/kernel/cpu/common.c                  |  22 ++
 arch/x86/kernel/process.c                     |  10 +-
 arch/x86/kernel/process.h                     |  69 ++++++
 arch/x86/kernel/process_64.c                  | 142 +++++++------
 arch/x86/kernel/ptrace.c                      |  17 +-
 tools/testing/selftests/x86/fsgsbase.c        |  24 ++-
 16 files changed, 606 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/x86/x86_64/fsgs.rst

-- 
2.20.1

