Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CDAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B273C20B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgDIQuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:50:54 -0400
Received: from foss.arm.com ([217.140.110.172]:52446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgDIQuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:50:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F0631B;
        Thu,  9 Apr 2020 09:50:54 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC1553F73D;
        Thu,  9 Apr 2020 09:50:53 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:50:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.7-rc1
Message-ID: <20200409165049.GA872@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below (on top of the previous pull request
for 5.7-rc1). Thanks.

The following changes since commit b2a84de2a2deb76a6a51609845341f508c518c03:

  mm/mremap: Add comment explaining the untagging behaviour of mremap() (2020-03-26 11:28:57 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to fc2266011accd5aeb8ebc335c381991f20e26e33:

  arm64: armv8_deprecated: Fix undef_hook mask for thumb setend (2020-04-08 18:19:20 +0100)

----------------------------------------------------------------
arm64 fixes:

- Ensure that the compiler and linker versions are aligned so that ld
  doesn't complain about not understanding a .note.gnu.property section
  (emitted when pointer authentication is enabled).

- Force -mbranch-protection=none when the feature is not enabled, in
  case a compiler may choose a different default value.

- Remove CONFIG_DEBUG_ALIGN_RODATA. It was never in defconfig and rarely
  enabled.

- Fix checking 16-bit Thumb-2 instructions checking mask in the
  emulation of the SETEND instruction (it could match the bottom half of
  a 32-bit Thumb-2 instruction).

----------------------------------------------------------------
Amit Daniel Kachhap (2):
      init/kconfig: Add LD_VERSION Kconfig
      arm64: Kconfig: ptrauth: Add binutils version check to fix mismatch

Ard Biesheuvel (1):
      arm64: remove CONFIG_DEBUG_ALIGN_RODATA feature

Fredrik Strupe (1):
      arm64: armv8_deprecated: Fix undef_hook mask for thumb setend

Mark Brown (1):
      arm64: Always force a branch protection mode when the compiler has one

 arch/arm64/Kconfig                        |  5 ++++-
 arch/arm64/Kconfig.debug                  | 13 -------------
 arch/arm64/Makefile                       |  7 ++++++-
 arch/arm64/include/asm/memory.h           | 12 +-----------
 arch/arm64/kernel/armv8_deprecated.c      |  2 +-
 drivers/firmware/efi/libstub/arm64-stub.c |  8 +++-----
 init/Kconfig                              |  4 ++++
 7 files changed, 19 insertions(+), 32 deletions(-)

-- 
Catalin
