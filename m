Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0812C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2988222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582300892;
	bh=BEciPzHo8CuryHbvE/f20uJHph4MuYVHw/4AtR5NS6Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RkMqXRGgnTxOGRV+dt/qqsx/Az1X6wc7nImFETApm+Aob3hEvr5X1nytAwl5Qefy2
	 QVDcLlJHEJ57PDx5u4pQSdpuBZtvenrkxYSS6kacmuKilRVy9p6bidqqnSyknV/xLF
	 aP5/tpwn/git9juvBYmqCCh54qnv0SbPHzsopSu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgBUQBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728822AbgBUQBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:01:31 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFB522067D;
        Fri, 21 Feb 2020 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582300890;
        bh=BEciPzHo8CuryHbvE/f20uJHph4MuYVHw/4AtR5NS6Y=;
        h=Date:From:To:Cc:Subject:From;
        b=zRPNlg7ZZCCwC9ptj3GpudDZKoPg1f9V2n2HZeKl9vgYeepePq5DIXqB73FhrYWwN
         YiF/OSuRz9WVxGVhbrToyAkJm3HpDI3KrayiuJ0U/dPL7O/NWcME7JlAjmS/OybVXw
         1u3gsYqp4h8gZC+LJxp6AYEvrxmsyjJKubdcZhs4=
Date:   Fri, 21 Feb 2020 16:01:26 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20200221160126.GB19330@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc3.

It's all straightforward apart from the changes to mmap()/mremap() in
relation to their handling of address arguments from userspace with
non-zero tag bits in the upper byte. The change to brk() is necessary
to fix a nasty user-visible regression in malloc(), but we tightened up
mmap() and mremap() at the same time because they also allow the user to
create virtual aliases by accident. It's much less likely than brk() to
matter in practice, but enforcing the principle of "don't permit the
creation of mappings using tagged addresses" leads to a straightforward
ABI without having to worry about the "but what if a crazy program did
foo?" aspect of things.

That said, this is core code and I know you'd prefer to limit the change
to brk(), so the patch is sitting on top of the branch in case you prefer
not to include it. If you decide to tweak it manually, please can you
update the docs at the same time?

Cheers,

Will

--->8

The following changes since commit d91771848f0ae2eec250a9345926a1a3558fa943:

  arm64: time: Replace <linux/clk-provider.h> by <linux/of_clk.h> (2020-02-12 17:26:38 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to dcde237319e626d1ec3c9d8b7613032f0fd4663a:

  mm: Avoid creating virtual address aliases in brk()/mmap()/mremap() (2020-02-20 10:03:14 +0000)

----------------------------------------------------------------
arm64 fixes for -rc3

- Fix regression in malloc() caused by ignored address tags in brk()

- Add missing brackets around argument to untagged_addr() macro

- Fix clang build when using binutils assembler

- Fix silly typo in virtual memory map documentation

----------------------------------------------------------------
Catalin Marinas (1):
      mm: Avoid creating virtual address aliases in brk()/mmap()/mremap()

Scott Branden (1):
      docs: arm64: fix trivial spelling enought to enough in memory.rst

Vincenzo Frascino (1):
      arm64: lse: Fix LSE atomics with LLVM

Will Deacon (1):
      arm64: memory: Add missing brackets to untagged_addr() macro

 Documentation/arm64/memory.rst             |  2 +-
 Documentation/arm64/tagged-address-abi.rst | 11 +++++++++--
 arch/arm64/include/asm/lse.h               |  2 +-
 arch/arm64/include/asm/memory.h            |  2 +-
 mm/mmap.c                                  |  4 ----
 mm/mremap.c                                |  1 -
 6 files changed, 12 insertions(+), 10 deletions(-)
