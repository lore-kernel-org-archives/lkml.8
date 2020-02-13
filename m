Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1BEC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7351A206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581613808;
	bh=VpkWJb4isxHvmOg1Hu6QcydGX0DlgRZPbNjqdx6Ddug=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=YR7dIMER+bPQz4xxS4EVwXwFudzpgW94K15NIrJZq7COm788niqJkcV3tMmyj+XQs
	 gPz0sLZKcyToLnm9UyhnyO6JuJ3eGDI9u8jWvLU3Xzwkv5fqyV3/FCU9I8jPiW9/qS
	 0zB4h/oooOj772jdM1XyIs0pvyQtuH0uEGyV7dQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgBMRKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbgBMRKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:10:07 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E91206DB;
        Thu, 13 Feb 2020 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581613807;
        bh=VpkWJb4isxHvmOg1Hu6QcydGX0DlgRZPbNjqdx6Ddug=;
        h=Date:From:To:Cc:Subject:From;
        b=MHQKhHNxZDfm29u+C1w5r5D1GRNZK5aog7ONSslDSc3VVxe/iOPrJSR2V2Es1Uq8s
         AjdknZzRYqYRN236MJM3oR1mjy8Ub25czZbUVjmhoWZ3jKnp2wzjSA4s/ZHjhup2gt
         2uMiqC2KzIxwfvfNGqq43hQadHA9LmePB73SRuko=
Date:   Thu, 13 Feb 2020 17:10:02 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc2
Message-ID: <20200213171002.GA8807@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc2. Summary in the tag, but it's all
reasonably straightforward. There are some more fixes on the horizon,
but nothing disastrous yet.

Cheers,

Will

--->8

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to d91771848f0ae2eec250a9345926a1a3558fa943:

  arm64: time: Replace <linux/clk-provider.h> by <linux/of_clk.h> (2020-02-12 17:26:38 +0000)

----------------------------------------------------------------
arm64 fixes for -rc2

- Fix build when KASLR is enabled but CONFIG_ARCH_RANDOM is not set

- Fix context-switching of SSBS state on systems that implement it

- Fix spinlock compiler warning introduced during the merge window

- Fix incorrect header inclusion (linux/clk-provider.h)

- Use SYSCTL_{ZERO,ONE} instead of rolling our own static variables

- Don't scream if optional SMMUv3 PMU irq is missing

- Remove some unused function prototypes

----------------------------------------------------------------
Anshuman Khandual (1):
      arm64: Drop do_el0_ia_bp_hardening() & do_sp_pc_abort() declarations

Geert Uytterhoeven (1):
      arm64: time: Replace <linux/clk-provider.h> by <linux/of_clk.h>

John Garry (1):
      perf/smmuv3: Use platform_get_irq_optional() for wired interrupt

Matteo Croce (1):
      arm64: use shared sysctl constants

Qian Cai (1):
      arm64/spinlock: fix a -Wunused-function warning

Robin Murphy (1):
      arm64: Fix CONFIG_ARCH_RANDOM=n build

Will Deacon (1):
      arm64: ssbs: Fix context-switch when SSBS is present on all CPUs

 arch/arm64/include/asm/exception.h |  4 ----
 arch/arm64/include/asm/spinlock.h  |  6 +++++-
 arch/arm64/kernel/kaslr.c          |  1 +
 arch/arm64/kernel/process.c        | 13 +++++++++----
 arch/arm64/kernel/time.c           |  2 +-
 drivers/perf/arm_smmuv3_pmu.c      |  2 +-
 6 files changed, 17 insertions(+), 11 deletions(-)
