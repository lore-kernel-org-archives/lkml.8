Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE48C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C152065D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594999228;
	bh=g0mnlni9XXk+nL9o5iJbyfC4t1kxF8cB5gGowQN1hjk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=iSt7vtNdbtAumipc0BBadVJOA1i9tpJYQ8hyF/k/tDpe4MlbApAEpZ8mXzcxuOtXH
	 wTZlSEgeCB6bfwiZ1VztgeZFGDAYxNgrI4aTH+Mhc04IjCNMCw2kpvGHey2jnxqcOn
	 HW+qykKoX61FOqAPpvBE0LdMDMFB+YHpWyBp2uLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgGQPU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgGQPU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:20:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC07D2065D;
        Fri, 17 Jul 2020 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594999225;
        bh=g0mnlni9XXk+nL9o5iJbyfC4t1kxF8cB5gGowQN1hjk=;
        h=Date:From:To:Cc:Subject:From;
        b=P4RuzDCvTjCZBGuOszevkAmDZi7N+WfVVzG7RbRYFTBSDmM9WdKmVGKYY0DiXXSz6
         kcXul6gjvXV3Go3ZUUMU9WISbeoJewasQbMuJ35J8c9Mrnkf6bs4AlKMvGw/bXhzmC
         24e5QXGPfRJ28Ik5SrSqfUps+TN6IxfTPL6KQdoQ=
Date:   Fri, 17 Jul 2020 16:20:21 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc6
Message-ID: <20200717152020.GA9056@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this batch of arm64 fixes for -rc6. Although the diffstat is
a bit larger than we'd usually have at this stage, a decent amount of it
is the addition of comments describing our syscall tracing behaviour, and
also a sweep across all the modular arm64 PMU drivers to make them rebust
against unloading and unbinding.

Summary is in the tag. Although there are a couple of minor things kicking
around at the moment (CPU errata and module PLTs for very large modules),
I'm not expecting any significant changes now for us in 5.8

Cheers,

Will

--->8

The following changes since commit 5679b28142193a62f6af93249c0477be9f0c669b:

  arm64/alternatives: don't patch up internal branches (2020-07-09 14:57:59 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to f32ed8eb0e3f0d0ef4ddb854554d60ca5863a9f9:

  drivers/perf: Prevent forced unbinding of PMU drivers (2020-07-17 10:51:44 +0100)

----------------------------------------------------------------
arm64 fixes for -rc6

- Fix kernel text addresses for relocatable images booting using EFI
  and with KASLR disabled so that they match the vmlinux ELF binary.

- Fix unloading and unbinding of PMU driver modules.

- Fix generic mmiowb() when writeX() is called from preemptible context
  (reported by the riscv folks).

- Fix ptrace hardware single-step interactions with signal handlers,
  system calls and reverse debugging.

- Fix reporting of 64-bit x0 register for 32-bit tasks via 'perf_regs'.

- Add comments describing syscall entry/exit tracing ABI.

----------------------------------------------------------------
Qi Liu (2):
      drivers/perf: Fix kernel panic when rmmod PMU modules during perf sampling
      drivers/perf: Prevent forced unbinding of PMU drivers

Will Deacon (9):
      efi/libstub/arm64: Retain 2MB kernel Image alignment if !KASLR
      arm64: ptrace: Consistently use pseudo-singlestep exceptions
      arm64: ptrace: Override SPSR.SS when single-stepping is enabled
      arm64: compat: Ensure upper 32 bits of x0 are zero on syscall return
      arm64: ptrace: Add a comment describing our syscall entry/exit trap ABI
      arm64: syscall: Expand the comment about ptrace and syscall(-1)
      arm64: ptrace: Use NO_SYSCALL instead of -1 in syscall_trace_enter()
      arm64: Use test_tsk_thread_flag() for checking TIF_SINGLESTEP
      asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()

 arch/arm64/include/asm/debug-monitors.h        |  2 ++
 arch/arm64/include/asm/syscall.h               | 12 ++++++-
 arch/arm64/include/asm/thread_info.h           |  1 +
 arch/arm64/kernel/debug-monitors.c             | 24 +++++++++----
 arch/arm64/kernel/ptrace.c                     | 49 +++++++++++++++++++-------
 arch/arm64/kernel/signal.c                     | 11 ++----
 arch/arm64/kernel/syscall.c                    | 21 +++++++++--
 drivers/firmware/efi/libstub/arm64-stub.c      | 25 +++++++------
 drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +-
 drivers/perf/arm-cci.c                         |  1 +
 drivers/perf/arm-ccn.c                         |  1 +
 drivers/perf/arm_dsu_pmu.c                     |  1 +
 drivers/perf/arm_smmuv3_pmu.c                  |  2 ++
 drivers/perf/arm_spe_pmu.c                     |  1 +
 drivers/perf/fsl_imx8_ddr_perf.c               |  2 ++
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c  |  2 ++
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c   |  2 ++
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c   |  2 ++
 drivers/perf/qcom_l2_pmu.c                     |  1 +
 drivers/perf/qcom_l3_pmu.c                     |  1 +
 drivers/perf/thunderx2_pmu.c                   |  1 +
 drivers/perf/xgene_pmu.c                       |  1 +
 include/asm-generic/mmiowb.h                   |  6 ++--
 23 files changed, 127 insertions(+), 44 deletions(-)
