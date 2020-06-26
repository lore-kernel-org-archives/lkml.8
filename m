Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9DCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3924E2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593177699;
	bh=Yuu27O3cGM+oVV8EJpqBsCHR3fqy5evaivCR9Hq+UPc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RWPWXOWyslc+rPMcetGmo102ptXYOH3x7JG8ejDnoDLhamb01wNugfqL8yXCyXN2c
	 SkbuJCL3av0Cjq8kRBtRVBMiZ5mgPeB5cor/DxbriCNu+gx16N4JgH5OVeYJDP+w7/
	 2ZPkvW03CHfVPe4ojnqxg+oYBjuIHpBQYFucP9Fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgFZNVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgFZNVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:21:37 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 654FA2075D;
        Fri, 26 Jun 2020 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593177696;
        bh=Yuu27O3cGM+oVV8EJpqBsCHR3fqy5evaivCR9Hq+UPc=;
        h=Date:From:To:Cc:Subject:From;
        b=e6WKxY4b4Y8FEccwwo5l9eexcUxRYmEcdycBViJHwIOsrow+yvWUS0cC2E1mD46EA
         OWrfa7o3HQ9/1fAY/moAqhfidwYK71inloiGl/TnCgzUyNJITWo/pzn3+ziebXzBKq
         6ET4skFrFLpC8t1MikoxCZHlEkYw/nKPpfQiGx00=
Date:   Fri, 26 Jun 2020 14:21:32 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20200626132131.GA9750@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc3. The big fix here is to our vDSO
sigreturn trampoline as, after a painfully long stint of debugging, it
turned out that fixing some of our CFI directives in the merge window lit up
a bunch of logic in libgcc which has been shown to SEGV in some cases during
asynchronous pthread cancellation. It looks like we can fix this by
extending the directives to restore most of the interrupted register state
from the sigcontext, but it's risky and hard to test so we opted to remove
the CFI directives for now and rely on the unwinder fallback path like we
used to.

Cheers,

Will

--->8

The following changes since commit 24ebec25fb270100e252b19c288e21bd7d8cc7f7:

  arm64: hw_breakpoint: Don't invoke overflow handler on uaccess watchpoints (2020-06-18 11:10:00 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 108447fd0d1a34b0929cd26dc637c917a734ebab:

  arm64: Add KRYO{3,4}XX silver CPU cores to SSB safelist (2020-06-25 20:18:57 +0100)

----------------------------------------------------------------
arm64 fixes for -rc3

- Fix unwinding through vDSO sigreturn trampoline

- Fix build warnings by raising minimum LD version for PAC

- Whitelist some Kryo Cortex-A55 derivatives for Meltdown and SSB

- Fix perf register PC reporting for compat tasks

- Fix 'make clean' warning for arm64 signal selftests

- Fix ftrace when BTI is compiled in

- Avoid building the compat vDSO using GCC plugins

----------------------------------------------------------------
Alexander Popov (1):
      arm64: vdso: Don't use gcc plugins for building vgettimeofday.c

Jean-Philippe Brucker (1):
      arm64: Don't insert a BTI instruction at inner labels

Jiping Ma (1):
      arm64: perf: Report the PC value in REGS_ABI_32 mode

Mark Brown (2):
      arm64: Depend on newer binutils when building PAC
      kselftest: arm64: Remove redundant clean target

Sai Prakash Ranjan (2):
      arm64: kpti: Add KRYO{3, 4}XX silver CPU cores to kpti safelist
      arm64: Add KRYO{3,4}XX silver CPU cores to SSB safelist

Will Deacon (5):
      arm64: vdso: Disable dwarf unwinding through the sigreturn trampoline
      arm64: compat: Allow 32-bit vdso and sigpage to co-exist
      arm64: compat: Always use sigpage for sigreturn trampoline
      arm64: compat: Remove 32-bit sigreturn code from the vDSO
      arm64: vdso: Only pass --no-eh-frame-hdr when linker supports it

 arch/arm64/Kconfig                            |  4 +-
 arch/arm64/include/asm/linkage.h              |  6 ---
 arch/arm64/include/asm/mmu.h                  |  3 ++
 arch/arm64/kernel/Makefile                    |  2 -
 arch/arm64/kernel/cpu_errata.c                |  2 +
 arch/arm64/kernel/cpufeature.c                |  2 +
 arch/arm64/kernel/perf_regs.c                 | 25 +++++++++--
 arch/arm64/kernel/signal32.c                  | 27 +-----------
 arch/arm64/kernel/vdso.c                      | 61 ++++++++++++---------------
 arch/arm64/kernel/vdso/Makefile               |  7 +--
 arch/arm64/kernel/vdso/sigreturn.S            | 54 +++++++++++++++---------
 arch/arm64/kernel/vdso32/Makefile             |  1 -
 arch/arm64/kernel/vdso32/sigreturn.S          | 58 -------------------------
 arch/arm64/kernel/vdso32/vdso.lds.S           | 12 ------
 tools/testing/selftests/arm64/signal/Makefile |  4 --
 15 files changed, 98 insertions(+), 170 deletions(-)
 delete mode 100644 arch/arm64/kernel/vdso32/sigreturn.S
