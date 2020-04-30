Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B60C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A997420873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD3REK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:04:10 -0400
Received: from foss.arm.com ([217.140.110.172]:59068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgD3REK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:04:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E2BC101E;
        Thu, 30 Apr 2020 10:04:09 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DACE3F73D;
        Thu, 30 Apr 2020 10:04:08 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2 00/10] x86/resctrl: Misc cleanup
Date:   Thu, 30 Apr 2020 18:03:50 +0100
Message-Id: <20200430170400.21501-1-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

These are the miscellaneous cleanup patches that floated to the top of
the MPAM tree.

The only interesting thing are the patches to make the AMD/Intel
differences something resctrl understands, instead of just 'happening'
because of the different function pointers.
This will become more important once MPAM support is added. parse_bw()
and friends are what enforces resctrl's ABI resctrl. Allowing an
architecture/platform to provide a subtly different function here would
be bad for user-space.

MPAM would set arch_has_sparse_bitmaps, but not arch_needs_linear.

Since [v1], I've picked up all the review feedback and collected the
tags.

Nothing in this series should change any behaviour.
This series is based on v5.7-rc3.

Thanks,

James

[v1] https://lore.kernel.org/lkml/20200214182401.39008-1-james.morse@arm.com/

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

 arch/x86/kernel/cpu/resctrl/core.c        | 35 +++------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 89 +++--------------------
 arch/x86/kernel/cpu/resctrl/internal.h    | 19 ++---
 arch/x86/kernel/cpu/resctrl/monitor.c     | 15 +---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 32 ++++----
 include/linux/cacheinfo.h                 | 21 ++++++
 include/linux/resctrl.h                   |  2 +
 7 files changed, 70 insertions(+), 143 deletions(-)

-- 
2.26.1

