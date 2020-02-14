Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F046FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52972168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405516AbgBNSYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:24:30 -0500
Received: from foss.arm.com ([217.140.110.172]:43190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390737AbgBNSY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:24:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0151328;
        Fri, 14 Feb 2020 10:24:26 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 978A83F68E;
        Fri, 14 Feb 2020 10:24:25 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 00/10] x86/resctrl: Misc cleanup
Date:   Fri, 14 Feb 2020 18:23:51 +0000
Message-Id: <20200214182401.39008-1-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

These are the miscellaneous cleanup patches that floated to the top of
the MPAM tree. (more on that story later).

The only interesting thing are the patches to make the AMD/Intel
differences something resctrl understands, instead of just 'happening'
because of the different function pointers.
This will become more important once MPAM support is added. parse_bw()
and friends are what enforces resctrl's ABI resctrl. Allowing an
architecture/platform to provide a subtly different function here would
be bad for user-space.

MPAM would set arch_has_sparse_bitmaps, but not arch_needs_linear.

Nothing in this series should change any behaviour.
This series is based on v5.6-rc1.


Thanks,

James Morse (10):
  x86/resctrl: Nothing uses struct mbm_state chunks_bw
  x86/resctrl: Remove max_delay
  x86/resctrl: Fix stale comment
  x86/resctrl: use container_of() in delayed_work handlers
  x86/resctrl: Include pid.h
  x86/resctrl: Use is_closid_match() in more places
  x86/resctrl: Add arch_needs_linear to explain AMD/Intel MBA difference
  x86/resctrl: Merge AMD/Intel parse_bw() calls
  x86/resctrl: Add arch_has_sparse_bitmaps to explain AMD/Intel CAT
    difference
  cacheinfo: Move resctrl's get_cache_id() to the cacheinfo header file

 arch/x86/kernel/cpu/resctrl/core.c        | 36 ++++------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 87 +++--------------------
 arch/x86/kernel/cpu/resctrl/internal.h    | 19 ++---
 arch/x86/kernel/cpu/resctrl/monitor.c     | 15 +---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 32 ++++-----
 include/linux/cacheinfo.h                 | 18 +++++
 include/linux/resctrl.h                   |  2 +
 7 files changed, 67 insertions(+), 142 deletions(-)

-- 
2.24.1

