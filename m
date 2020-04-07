Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C635EC2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8F0206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586223858;
	bh=3+tHQVEncy03fAPy6cGpXt1PwXxP/KJ+2lPLc1M873E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=e6h8CeEjfvLa4ZcLjUi686yI1A8Gj5+ubG9PGuUb+qROi/+VbxgKQokp43OqkLmL7
	 Bhd97O1/Mh8CY/gQTwFl3BoXFQa/eXJmSLFhDWtmyOCHKq9WwxWv6WpjlyRJeZVbhr
	 dVFnr3uQa6I5JpaGMfJz1rRpR0kG12pwrGdZjr30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDGBoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgDGBoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:44:17 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D64B320644;
        Tue,  7 Apr 2020 01:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586223856;
        bh=3+tHQVEncy03fAPy6cGpXt1PwXxP/KJ+2lPLc1M873E=;
        h=From:To:Cc:Subject:Date:From;
        b=qUcpUBX9TKPXqzRhDXcfiiV7Jhoay9tHKZX05fagWH1mOqBPECCbsrnJ4fVNu6uJ+
         DDduf6zY1V+SZN2EMNmKrugv+RIIB9CHy8+yTaOfsslGPVc/mpuqusmAKOb4OAfcx2
         1DGcUfRvXaxw5c8dYgWZyt8WFyRr25n9HF9ugonc=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        guoren@kernel.org
Subject: [GIT PULL] csky updates for v5.7-rc1
Date:   Tue,  7 Apr 2020 09:44:08 +0800
Message-Id: <20200407014408.5136-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the changes for v5.7-rc1. There are some features and fixups in
this round.

Best Regards
 Guo Ren

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.7-rc1

for you to fetch changes up to aefd9461d34a1b0a2acad0750c43216c1c27b9d4:

  csky: Fixup cpu speculative execution to IO area (2020-04-03 12:40:07 +0800)

----------------------------------------------------------------
csky updates for 5.7-rc1

 - Add kproobes/uprobes support
 - Add lockdep, rseq, gcov support
 - Fixup init_fpu
 - Fixup ftrace_modify deadlock
 - Fixup speculative execution on IO area

----------------------------------------------------------------
Guo Ren (10):
      csky: Fixup init_fpu compile warning with __init
      csky: Implement ptrace regs and stack API
      csky: Add support for restartable sequence
      csky: Implement ftrace with regs
      csky/ftrace: Fixup ftrace_modify_code deadlock without CPU_HAS_ICACHE_INS
      csky: Fixup get wrong psr value from phyical reg
      csky: Enable LOCKDEP_SUPPORT
      csky: Add kprobes supported
      csky: Add uprobes support
      csky: Fixup cpu speculative execution to IO area

Ma Jun (1):
      csky: Enable the gcov function

 arch/csky/Kconfig                            |  13 +
 arch/csky/abiv1/inc/abi/entry.h              |   5 +-
 arch/csky/abiv2/fpu.c                        |   5 -
 arch/csky/abiv2/inc/abi/entry.h              |  67 +++-
 arch/csky/abiv2/inc/abi/fpu.h                |   3 +-
 arch/csky/abiv2/mcount.S                     |  48 +++
 arch/csky/include/asm/Kbuild                 |   1 -
 arch/csky/include/asm/ftrace.h               |   2 +
 arch/csky/include/asm/kprobes.h              |  48 +++
 arch/csky/include/asm/probes.h               |  24 ++
 arch/csky/include/asm/processor.h            |   1 +
 arch/csky/include/asm/ptrace.h               |  43 +++
 arch/csky/include/asm/thread_info.h          |   2 +
 arch/csky/include/asm/uprobes.h              |  33 ++
 arch/csky/kernel/Makefile                    |   1 +
 arch/csky/kernel/asm-offsets.c               |   1 +
 arch/csky/kernel/entry.S                     |  18 +-
 arch/csky/kernel/ftrace.c                    |  42 +++
 arch/csky/kernel/head.S                      |   5 +
 arch/csky/kernel/probes/Makefile             |   7 +
 arch/csky/kernel/probes/decode-insn.c        |  49 +++
 arch/csky/kernel/probes/decode-insn.h        |  20 ++
 arch/csky/kernel/probes/ftrace.c             |  66 ++++
 arch/csky/kernel/probes/kprobes.c            | 499 +++++++++++++++++++++++++++
 arch/csky/kernel/probes/kprobes_trampoline.S |  19 +
 arch/csky/kernel/probes/simulate-insn.c      | 398 +++++++++++++++++++++
 arch/csky/kernel/probes/simulate-insn.h      |  49 +++
 arch/csky/kernel/probes/uprobes.c            | 150 ++++++++
 arch/csky/kernel/ptrace.c                    | 103 ++++++
 arch/csky/kernel/setup.c                     |  63 +---
 arch/csky/kernel/signal.c                    |   6 +
 arch/csky/kernel/smp.c                       |   6 +
 arch/csky/kernel/traps.c                     |  29 +-
 arch/csky/mm/cachev2.c                       |  45 ++-
 arch/csky/mm/fault.c                         |  11 +
 35 files changed, 1807 insertions(+), 75 deletions(-)
 create mode 100644 arch/csky/include/asm/kprobes.h
 create mode 100644 arch/csky/include/asm/probes.h
 create mode 100644 arch/csky/include/asm/uprobes.h
 create mode 100644 arch/csky/kernel/probes/Makefile
 create mode 100644 arch/csky/kernel/probes/decode-insn.c
 create mode 100644 arch/csky/kernel/probes/decode-insn.h
 create mode 100644 arch/csky/kernel/probes/ftrace.c
 create mode 100644 arch/csky/kernel/probes/kprobes.c
 create mode 100644 arch/csky/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/csky/kernel/probes/simulate-insn.c
 create mode 100644 arch/csky/kernel/probes/simulate-insn.h
 create mode 100644 arch/csky/kernel/probes/uprobes.c
