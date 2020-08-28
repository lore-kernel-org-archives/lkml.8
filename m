Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC39C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A4620872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgH1R0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgH1R0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:26:01 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2A3220872;
        Fri, 28 Aug 2020 17:25:59 +0000 (UTC)
Date:   Fri, 28 Aug 2020 18:25:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.9-rc3
Message-ID: <20200828172555.GA31202@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 71a7f8cb1ca4ca7214a700b1243626759b6c11d4:

  KVM: arm64: Set HCR_EL2.PTW to prevent AT taking synchronous exception (2020-08-28 15:27:47 +0100)

----------------------------------------------------------------
- Fix kernel build with the integrated LLVM assembler which doesn't
  see the -Wa,-march option.

- Fix "make vdso_install" when COMPAT_VDSO is disabled.

- Make KVM more robust if the AT S1E1R instruction triggers an exception
  (architecture corner cases).

----------------------------------------------------------------
Frank van der Linden (1):
      arm64: vdso32: make vdso32 install conditional

James Morse (3):
      KVM: arm64: Add kvm_extable for vaxorcism code
      KVM: arm64: Survive synchronous exceptions caused by AT instructions
      KVM: arm64: Set HCR_EL2.PTW to prevent AT taking synchronous exception

Sami Tolvanen (1):
      arm64: use a common .arch preamble for inline assembly

 arch/arm64/Makefile                     | 14 +++++--
 arch/arm64/include/asm/compiler.h       |  6 +++
 arch/arm64/include/asm/kvm_arm.h        |  3 +-
 arch/arm64/include/asm/kvm_asm.h        | 43 ++++++++++++++++++++++
 arch/arm64/include/asm/tlbflush.h       |  6 ++-
 arch/arm64/kernel/image-vars.h          |  4 ++
 arch/arm64/kernel/vmlinux.lds.S         |  8 ++++
 arch/arm64/kvm/hyp/entry.S              | 15 +++++---
 arch/arm64/kvm/hyp/hyp-entry.S          | 65 +++++++++++++++++++++------------
 arch/arm64/kvm/hyp/include/hyp/switch.h | 39 ++++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/switch.c        |  5 +++
 arch/arm64/kvm/hyp/vhe/switch.c         |  5 +++
 12 files changed, 172 insertions(+), 41 deletions(-)

-- 
Catalin
