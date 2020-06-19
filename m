Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4B5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0906F207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592570606;
	bh=yShNM0K+JKgCUomMvzFARdYyLeLf+SbVL45AMI9mrf4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=scKmBZbjxt8tSh3K3bniEf+yh2mp6fvUpsSpYSLCSo5zZVFqt7n1I+hEP4BE5GGNj
	 gq6mh1kEgknxVsy/8R/OZlqM+h6IZbpyMV/5Z83SyHqbLPnfvl/IE8FtbAwyYj7R7D
	 +KmX+8mr0jdqYwnxfVJcIbf2WYSQQalHzkjcGhqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgFSMnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbgFSMnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:43:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363EC207E8;
        Fri, 19 Jun 2020 12:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592570603;
        bh=yShNM0K+JKgCUomMvzFARdYyLeLf+SbVL45AMI9mrf4=;
        h=Date:From:To:Cc:Subject:From;
        b=YBTWoDZrVnqLmMfBX4qNgSyMX0wTWJ03UHeUMb/y5/pbI8t0by3WtlngCEL8vAxXJ
         2tOYpLeYMUcywa4Yv/rHG3piCWRTl6iDLPhDAFpTTfOMxy+e1GS/oQpezALGPZnqGu
         +1DcN4Zog7klZO9Slkh7BaYjt84NPkFKKmeHbUYc=
Date:   Fri, 19 Jun 2020 13:43:18 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc2
Message-ID: <20200619124318.GA6925@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc2. Unfortunately, we still have a
number of outstanding issues so there will be more fixes to come, but
this lot are a good start.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 24ebec25fb270100e252b19c288e21bd7d8cc7f7:

  arm64: hw_breakpoint: Don't invoke overflow handler on uaccess watchpoints (2020-06-18 11:10:00 +0100)

----------------------------------------------------------------
arm64 fixes for -rc2

- Fix handling of watchpoints triggered by uaccess routines

- Fix initialisation of gigantic pages for CMA buffers

- Raise minimum clang version for BTI to avoid miscompilation

- Fix data race in SVE vector length configuration code

- Ensure address tags are ignored in kern_addr_valid()

- Dump register state on fatal BTI exception

- kexec_file() cleanup to use struct_size() macro

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: remove TEXT_OFFSET randomization

Barry Song (1):
      arm64: mm: reserve hugetlb CMA after numa_init

Dave Martin (2):
      docs/arm64: Fix typo'd #define in sve.rst
      arm64/sve: Eliminate data races on sve_default_vl

Gustavo A. R. Silva (1):
      arm64: kexec_file: Use struct_size() in kmalloc()

Shyam Thombre (1):
      arm64: mm: reset address tag set by kasan sw tagging

Will Deacon (5):
      arm64: traps: Dump registers prior to panic() in bad_mode()
      arm64: pgtable: Clear the GP bit for non-executable kernel pages
      arm64: sve: Fix build failure when ARM64_SVE=y and SYSCTL=n
      arm64: bti: Require clang >= 10.0.1 for in-kernel BTI support
      arm64: hw_breakpoint: Don't invoke overflow handler on uaccess watchpoints

 Documentation/arm64/sve.rst            |  6 ++---
 arch/arm64/Kconfig                     |  2 ++
 arch/arm64/Kconfig.debug               | 15 ------------
 arch/arm64/Makefile                    |  6 -----
 arch/arm64/include/asm/pgtable.h       |  2 +-
 arch/arm64/kernel/fpsimd.c             | 31 ++++++++++++++++--------
 arch/arm64/kernel/hw_breakpoint.c      | 44 ++++++++++++++++++++--------------
 arch/arm64/kernel/machine_kexec_file.c |  3 +--
 arch/arm64/kernel/traps.c              |  1 +
 arch/arm64/mm/init.c                   | 15 ++++++++----
 arch/arm64/mm/mmu.c                    |  1 +
 11 files changed, 66 insertions(+), 60 deletions(-)

