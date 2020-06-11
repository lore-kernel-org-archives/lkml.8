Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9640AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63874206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591896859;
	bh=lRxzRoRx1R56qcKxTnghzBRhR4dShjejgWX5UzFaEn4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bF9orD7rh+kzPBM9iDWWFGyhfbdx8NEZUrKvE3hjNm4HVvIP7ksUdtXjQRvy8GOHJ
	 Jrltp57o1tLS1f9JFtGsIWkIW56OD3mlYRoTZ1lhaDKVZCtrjynUouhVBhFRLbNRMM
	 G3xE+XvUAkUmMn4/d2P64pj7u9u3LJe/FBKx55Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgFKReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFKReR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:34:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD0AB206DC;
        Thu, 11 Jun 2020 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591896856;
        bh=lRxzRoRx1R56qcKxTnghzBRhR4dShjejgWX5UzFaEn4=;
        h=Date:From:To:Cc:Subject:From;
        b=0C3UzX+gJ9FwLRBsHwAl75kNB74VEqgUz3rv37qAoV4Y5XVSxIilem/0fIxR2pb1m
         0lfAh3WQRuEXyYnqrFEv9aUaDbnS1euTWJiUMWJs8Z4OSoBi183iTfopa83zwcHp0F
         4wvUV9fR5OS+7TgEhi1k8NFxqwih52D2qFkWLbE0=
Date:   Thu, 11 Jun 2020 18:34:12 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Subject: [GIT PULL] arm64 merge window fixes for -rc1
Message-ID: <20200611173412.GA9575@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes that came in during the merge window. They'll
probably be more to come, but it doesn't seem like it's worth me sitting
on these in the meantime.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 082af5ec5080b028f7d0846a6c27cbb87f288205:

  Merge branch 'for-next/scs' into for-next/core (2020-05-28 18:03:40 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to dd4bc60765873445893037ae73a5f75398a8cd19:

  arm64: warn on incorrect placement of the kernel by the bootloader (2020-06-11 14:13:13 +0100)

----------------------------------------------------------------
arm64 merge window fixes for -rc1

- Fix SCS debug check to report max stack usage in bytes as advertised
- Fix typo: CONFIG_FTRACE_WITH_REGS => CONFIG_DYNAMIC_FTRACE_WITH_REGS
- Fix incorrect mask in HiSilicon L3C perf PMU driver
- Fix compat vDSO compilation under some toolchain configurations
- Fix false UBSAN warning from ACPI IORT parsing code
- Fix booting under bootloaders that ignore TEXT_OFFSET
- Annotate debug initcall function with '__init'

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: warn on incorrect placement of the kernel by the bootloader

Christophe JAILLET (1):
      arm64: debug: mark a function as __init to save some memory

Joe Perches (1):
      arm64: ftrace: Change CONFIG_FTRACE_WITH_REGS to CONFIG_DYNAMIC_FTRACE_WITH_REGS

Nick Desaulniers (2):
      arm64: vdso32: add CONFIG_THUMB2_COMPAT_VDSO
      arm64: acpi: fix UBSAN warning

Shaokun Zhang (1):
      drivers/perf: hisi: Fix wrong value for all counters enable

Will Deacon (1):
      scs: Report SCS usage in bytes rather than number of entries

 arch/arm64/Kconfig                           | 11 ++++++++++-
 arch/arm64/include/asm/acpi.h                |  5 +++--
 arch/arm64/kernel/debug-monitors.c           |  2 +-
 arch/arm64/kernel/ftrace.c                   |  3 ++-
 arch/arm64/kernel/setup.c                    |  4 ++++
 arch/arm64/kernel/vdso32/Makefile            |  8 ++++++++
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c |  2 +-
 kernel/scs.c                                 |  2 +-
 8 files changed, 30 insertions(+), 7 deletions(-)
