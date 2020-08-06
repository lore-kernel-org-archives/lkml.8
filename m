Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CABC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0657522CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596672619;
	bh=iU0ZUkOjTpHNy95m8ekQCDxNWW2NYU6kn26pzXQoobQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cZ+B1UNV3FXz49YFTV9GKAKhsQ2nzqcpFN5x0unjoZrMSBcJwUpFtk/LS/KBxwQBC
	 w41DK/VfXcSex0Jdow2Tun/axjZJHAeSqJpn1tgBl43jWJulKRoz+iPosHlD47jDEp
	 yNrOTvKD6H31Klagxs5Lr8YdrqfxsO0+QE4M5f+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgHFAKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgHFAKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:10:14 -0400
Received: from guoren-Inspiron-7460.lan (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A089B22CA1;
        Thu,  6 Aug 2020 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596672613;
        bh=iU0ZUkOjTpHNy95m8ekQCDxNWW2NYU6kn26pzXQoobQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Mmt0yIpqytj8FppbALT5zLqthA8Qey1R/hquzYIcyx20zy0N08Zf9vYvMegcOWV1H
         7DDm6+Iocg7fXDNg7hr/C+Vc4XPGeWVi0WSCBfO7w4VXzRRcUrt15H3BNRL4EpW6RM
         QmVKplVmse1UAQwRn6dNLWz14pnSSC0hE4oolqog=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky updates for v5.9-rc1
Date:   Thu,  6 Aug 2020 08:10:01 +0800
Message-Id: <1596672601-8227-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull csky updates for v5.9-rc1:

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.9-rc1

for you to fetch changes up to bdcd93ef9afb42a6051e472fa62c693b1f9edbd8:

  csky: Add context tracking support (2020-08-01 08:17:51 +0000)

----------------------------------------------------------------
arch/csky patches for 5.9-rc1

Features:
 - seccomp-filter
 - err-injection
 - top-down&random mmap-layout
 - irq_work
 - show_ipi
 - context-tracking)

Fixup & Optimize:
 - kprobe_on_ftrace
 - optimize panic print

----------------------------------------------------------------
Guo Ren (12):
      csky: Add SECCOMP_FILTER supported
      csky: Add cpu feature register hint for smp
      csky: Fixup duplicated restore sp in RESTORE_REGS_FTRACE
      csky: Fixup kprobes handler couldn't change pc
      csky: Add support for function error injection
      csky: Optimize the trap processing flow
      csky: Use top-down mmap layout
      csky: Set CONFIG_NR_CPU 4 as default
      csky: Fixup warning by EXPORT_SYMBOL(kmap)
      csky: Add irq_work support
      csky: Add arch_show_interrupts for IPI interrupts
      csky: Add context tracking support

Tobias Klauser (1):
      csky: remove unusued thread_saved_pc and *_segments functions/macros

 arch/csky/Kconfig                             |  29 +++-
 arch/csky/abiv2/inc/abi/entry.h               |   3 -
 arch/csky/abiv2/mcount.S                      |   4 +-
 arch/csky/include/asm/Kbuild                  |   1 +
 arch/csky/include/asm/bug.h                   |   3 +-
 arch/csky/include/asm/irq_work.h              |  11 ++
 arch/csky/include/asm/processor.h             |   6 -
 arch/csky/include/asm/ptrace.h                |   7 +
 arch/csky/include/asm/thread_info.h           |   2 +-
 arch/csky/kernel/entry.S                      |  28 ++++
 arch/csky/kernel/process.c                    |  10 --
 arch/csky/kernel/ptrace.c                     |  37 +----
 arch/csky/kernel/smp.c                        |  62 ++++++-
 arch/csky/kernel/traps.c                      | 223 +++++++++++++++++---------
 arch/csky/lib/Makefile                        |   1 +
 arch/csky/lib/error-inject.c                  |  10 ++
 arch/csky/mm/fault.c                          |  10 +-
 arch/csky/mm/highmem.c                        |   2 -
 tools/testing/selftests/seccomp/seccomp_bpf.c |  13 +-
 19 files changed, 319 insertions(+), 143 deletions(-)
 create mode 100644 arch/csky/include/asm/irq_work.h
 create mode 100644 arch/csky/lib/error-inject.c
