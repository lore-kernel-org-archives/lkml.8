Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C84AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A3420767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594391955;
	bh=QIYHbPSVSGtZDBABBAD04BZAgyeS9ZLXK9NpKGJOnTw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=um7lGGvGtXL9MeU+cvTnMGa8gqlNBAE0QVjacaTHwmuzyzJQ1kw33bLX6TTlJjJyT
	 GrID2Tq/7nmVlIdigSYne2Ku6chmRBUeg+vqY9ZJ6BOb0ey0XkdJfi9bZkN8baoFJV
	 OlM00ri92jY7MlYth1OQgD1UeTU869ETi7MbxDhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGJOjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgGJOjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:39:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86FE5206E2;
        Fri, 10 Jul 2020 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594391952;
        bh=QIYHbPSVSGtZDBABBAD04BZAgyeS9ZLXK9NpKGJOnTw=;
        h=Date:From:To:Cc:Subject:From;
        b=sqGH+z0PQWSNK7ckUPvuSQQd6/G6LxAKtgxwQhbvZjMaIraD1vYN0wtkzRlJz0r6c
         +3mGqyqmICylpiseOU2VPBoAj9kqgU59wUskCO+oFIapG6RpDzdZ/xexWxVUKaHRkG
         JCcMmmgxqm5yVrYTgE2FXeHeaSSTzqswdEdOLDzs=
Date:   Fri, 10 Jul 2020 15:39:08 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20200710143908.GB31036@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this unfortunately large collection of arm64 fixes for -rc5.
Some of this is absolutely trivial, but the alternatives, vDSO and CPU
errata workaround fixes are significant. At least people are finding and
fixing these things, I suppose.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 9b23d95c539ebc5d6d6b5d6f20d2d7922384e76e:

  arm64: Add KRYO4XX silver CPU cores to erratum list 1530923 and 1024718 (2020-07-03 16:39:16 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 5679b28142193a62f6af93249c0477be9f0c669b:

  arm64/alternatives: don't patch up internal branches (2020-07-09 14:57:59 +0100)

----------------------------------------------------------------
arm64 fixes for -rc5

- Fix workaround for CPU erratum #1418040 to disable the compat vDSO

- Fix OOPs when single-stepping with KGDB

- Fix memory attributes for hypervisor device mappings at EL2

- Fix memory leak in PSCI and remove useless variable assignment

- Fix up some comments and asm labels in our entry code

- Fix broken register table formatting in our generated html docs

- Fix missing NULL sentinel in CPU errata workaround list

- Fix patching of branches in alternative instruction sections

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/alternatives: don't patch up internal branches

Florian Fainelli (1):
      arm64: Add missing sentinel to erratum_1463225

Gavin Shan (2):
      drivers/firmware/psci: Fix memory leakage in alloc_init_cpu_groups()
      drivers/firmware/psci: Assign @err directly in hotplug_tests()

Kevin Hao (1):
      arm64: entry: Fix the typo in the comment of el1_dbg()

Marc Zyngier (4):
      arm64: Introduce a way to disable the 32bit vdso
      arm64: arch_timer: Allow an workaround descriptor to disable compat vdso
      arm64: arch_timer: Disable the compat vdso for cores affected by ARM64_WORKAROUND_1418040
      arm64: Rework ARM_ERRATUM_1414080 handling

Suzuki K Poulose (1):
      arm64: Documentation: Fix broken table in generated HTML

Wei Li (1):
      arm64: kgdb: Fix single-step exception handling oops

Will Deacon (2):
      KVM: arm64: Fix definition of PAGE_HYP_DEVICE
      arm64: entry: Tidy up block comments and label numbers

 Documentation/arm64/cpu-feature-registers.rst     |  2 +
 arch/arm64/include/asm/arch_timer.h               |  1 +
 arch/arm64/include/asm/pgtable-prot.h             |  2 +-
 arch/arm64/include/asm/vdso/clocksource.h         |  7 ++-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  8 +++-
 arch/arm64/kernel/alternative.c                   | 16 +------
 arch/arm64/kernel/cpu_errata.c                    |  1 +
 arch/arm64/kernel/entry-common.c                  |  2 +-
 arch/arm64/kernel/entry.S                         | 52 ++++++++++++++---------
 arch/arm64/kernel/kgdb.c                          |  2 +-
 drivers/clocksource/arm_arch_timer.c              | 11 +++++
 drivers/firmware/psci/psci_checker.c              |  8 ++--
 12 files changed, 68 insertions(+), 44 deletions(-)
