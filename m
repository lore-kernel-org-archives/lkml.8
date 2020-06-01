Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3B5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E16206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgFARJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:09:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:36674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbgFARJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:09:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 069A5ABCF;
        Mon,  1 Jun 2020 17:09:10 +0000 (UTC)
Date:   Mon, 1 Jun 2020 19:09:03 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache updates for v5.8
Message-ID: <20200601170903.GC30795@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the resctrl pile for 5.8.

Thx.

---
The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_updates_for_5.8

for you to fetch changes up to 0c4d5ba1b998e713815b7790d3db6ced0ae49489:

  x86/resctrl: Support wider MBM counters (2020-05-06 18:08:32 +0200)

----------------------------------------------------------------
Add support for wider Memory Bandwidth Monitoring counters by querying
their width from CPUID. As a prerequsite, streamline and unify the CPUID
detection of the respective resource control attributes. By Reinette
Chatre.

----------------------------------------------------------------
Reinette Chatre (7):
      x86/resctrl: Rename asm/resctrl_sched.h to asm/resctrl.h
      x86/cpu: Move resctrl CPUID code to resctrl/
      x86/resctrl: Remove unnecessary RMID checks
      x86/resctrl: Query LLC monitoring properties once during boot
      x86/resctrl: Maintain MBM counter width per resource
      x86/resctrl: Support CPUID enumeration of MBM counter width
      x86/resctrl: Support wider MBM counters

 MAINTAINERS                                        |  2 +-
 arch/x86/include/asm/processor.h                   |  3 +-
 .../x86/include/asm/{resctrl_sched.h => resctrl.h} |  9 +++--
 arch/x86/kernel/cpu/amd.c                          |  3 ++
 arch/x86/kernel/cpu/common.c                       | 40 ----------------------
 arch/x86/kernel/cpu/intel.c                        |  7 ++++
 arch/x86/kernel/cpu/resctrl/core.c                 | 32 ++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c          |  8 +++--
 arch/x86/kernel/cpu/resctrl/internal.h             | 15 ++++++--
 arch/x86/kernel/cpu/resctrl/monitor.c              | 27 ++++++++++-----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c          |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             |  4 +--
 arch/x86/kernel/process_32.c                       |  2 +-
 arch/x86/kernel/process_64.c                       |  2 +-
 14 files changed, 91 insertions(+), 65 deletions(-)
 rename arch/x86/include/asm/{resctrl_sched.h => resctrl.h} (92%)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
