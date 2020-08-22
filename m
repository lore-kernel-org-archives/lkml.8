Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D46BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0712078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgHVPbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 11:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgHVPbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 11:31:21 -0400
Received: from gaia (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A44192078D;
        Sat, 22 Aug 2020 15:31:20 +0000 (UTC)
Date:   Sat, 22 Aug 2020 16:31:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.9-rc2
Message-ID: <20200822153116.GA8696@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates below. Thanks.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 8d75785a814241587802655cc33e384230744f0c:

  ARM64: vdso32: Install vdso32 from vdso_install (2020-08-21 19:11:44 +0100)

----------------------------------------------------------------
- Allow booting of late secondary CPUs affected by erratum 1418040
  (currently they are parked if none of the early CPUs are affected by
  this erratum).

- Add the 32-bit vdso Makefile to the vdso_install rule so that 'make
  vdso_install' installs the 32-bit compat vdso when it is compiled.

- Print a warning that untrusted guests without a CPU erratum workaround
  (Cortex-A57 832075) may deadlock the affected system.

----------------------------------------------------------------
Marc Zyngier (2):
      arm64: Move handling of erratum 1418040 into C code
      arm64: Allow booting of late CPUs affected by erratum 1418040

Rob Herring (1):
      KVM: arm64: Print warning when cpu erratum can cause guests to deadlock

Stephen Boyd (1):
      ARM64: vdso32: Install vdso32 from vdso_install

 arch/arm64/Makefile               |  1 +
 arch/arm64/kernel/cpu_errata.c    |  2 ++
 arch/arm64/kernel/entry.S         | 21 ---------------------
 arch/arm64/kernel/process.c       | 34 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/vdso32/Makefile |  2 +-
 arch/arm64/kvm/arm.c              |  4 ++++
 6 files changed, 42 insertions(+), 22 deletions(-)

-- 
Catalin
