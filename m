Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30022C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52D32074A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgIDMci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:32:38 -0400
Received: from elvis.franken.de ([193.175.24.41]:52961 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDMce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:32:34 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kEAtJ-0005xV-00; Fri, 04 Sep 2020 14:32:29 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 79461C00F2; Fri,  4 Sep 2020 14:32:23 +0200 (CEST)
Date:   Fri, 4 Sep 2020 14:32:23 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v5.9
Message-ID: <20200904123223.GA18627@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_fixes_5.9_1

for you to fetch changes up to baf5cb30fbd1c22f6aa03c081794c2ee0f5be4da:

  MIPS: SNI: Fix SCSI interrupt (2020-09-03 12:00:23 +0200)

----------------------------------------------------------------
A few MIPS fixes:

- fallthrough fallout fix
- BMIPS fixes
- MSA fix to avoid leaking MSA register contents
- Loongson perf and cpu feature fix
- SNI interrupt fix

----------------------------------------------------------------
Florian Fainelli (2):
      MIPS: mm: BMIPS5000 has inclusive physical caches
      MIPS: BMIPS: Also call bmips_cpu_setup() for secondary cores

He Zhe (1):
      mips/oprofile: Fix fallthrough placement

Huang Pei (1):
      MIPS: add missing MSACSR and upper MSA initialization

Jiaxun Yang (1):
      MIPS: Loongson64: Do not override watch and ejtag feature

Thomas Bogendoerfer (1):
      MIPS: SNI: Fix SCSI interrupt

Tiezhu Yang (1):
      MIPS: perf: Fix wrong check condition of Loongson event IDs

WANG Xuerui (1):
      MIPS: Loongson64: Remove unnecessary inclusion of boot_param.h

 .../mips/include/asm/mach-loongson64/cpu-feature-overrides.h |  2 --
 arch/mips/include/asm/mach-loongson64/irq.h                  |  2 --
 arch/mips/include/asm/mach-loongson64/mmzone.h               |  1 -
 arch/mips/kernel/perf_event_mipsxx.c                         |  4 ++--
 arch/mips/kernel/smp-bmips.c                                 |  2 ++
 arch/mips/kernel/traps.c                                     | 12 ++++++++++++
 arch/mips/mm/c-r4k.c                                         |  4 ++++
 arch/mips/oprofile/op_model_mipsxx.c                         |  4 +++-
 arch/mips/sni/a20r.c                                         |  4 ++--
 9 files changed, 25 insertions(+), 10 deletions(-)
-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
