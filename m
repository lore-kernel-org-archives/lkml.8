Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33719C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188CD20644
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbgDMU6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:58:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:8591 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgDMU6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:58:22 -0400
IronPort-SDR: QYuP59TDzcZMn+8VjanUFqBbPqGzm6ycl4IAn+R1Lp5WuZQ2zMJ78LCme4POGFGXQTqmHsa7fK
 dWBGnggPLhtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 13:58:21 -0700
IronPort-SDR: oa1YgajQmXRj8z50iScEKqqdsdg8+wY7nIw2YG5BQhw+6QTuhRz7hr/FkrOca5h8bNqpZbim3H
 LPbyCrmgZFeQ==
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="453301654"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 13:58:20 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 0/4] x86/resctrl: Enable user to view and select thread throttling mode
Date:   Mon, 13 Apr 2020 13:57:59 -0700
Message-Id: <cover.1586801373.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 upstream submission available from:
https://lore.kernel.org/lkml/cover.1585765499.git.reinette.chatre@intel.com

A notable change since V1 is the inclusion of two additional patches from
Fenghua Yu that introduce the new per-thread MBA feature. These changes are
added to this series because they are small and closely related to the
original submission. The per-thread MBA feature is a hardware advancement
that requires no software interface changes. The patches added just enumerate
the feature and expose it to userspace by showing "per-thread" in the new
resctrl file "thread_throttle_mode" to help user applications fine tune
performance.

There are currently a few resctrl changes outstanding for upstream inclusion.
To support their consideration all outstanding resctrl patches can be
viewed at https://github.com/rchatre/linux.git (branch resctrl/next)

Changes since V1 (also documented within patches to which they apply):
- Rebased on top of James Morse's CDP fix
(https://lore.kernel.org/lkml/20200221162105.154163-1-james.morse@arm.com)
- Remove RF_UNINITIALIZED (having uninitialized be represented with ones
  creates too much confusion), replace with an explicit check of rft->fflags
  in rdtgroup_add_files() (Fenghua Yu)
- Rename MBA_THREAD_THROTTLE_MODE to MBA_THROTTLE_MODE_MASK to clarify its
  use as a mask (Tony Luck)
- Introduce explicit MBA_THROTTLE_MODE_MAX instead of implying it is the
  opposite of min and use these values (min and max) explicitly whenever
  testing/setting the throttle mode value (Tony Luck)
- Add __init attribute to thread_throttle_mode_init_intel_rw() and
  thread_throttle_mode_init_intel_ro() since they are only needed during
  initialization (Fenghua Yu)
- Remove MBA_CFG MSR reads and error checking so that the patch is simpler
  and easier to review (Fenghua Yu)
- Ensure CPU hotplug lock is taken when writing register on multiple CPUs (Fenghua Yu)
- Use CPU mask already maintained as part of domains to determine which
  CPUs to update MBA register on (Fenghua Yu)
- Maintain MBA configuration register contents to support use case when not
  all CPUs of a package are online when configuration is set from user
  space
- Use seq_puts() instead of seq_printf() when simple strings are printed
- Set MBA configuration to default when resctrl is unmounted
- Complete rewrite of "thread_throttle_mode" documentation (Tony Luck)
- Remove unnecessary checks on user input (Andy Shevchenko)
- Change code style surrounding usage of sysfs_match_string() (Andy Shevchenko)

From V1 submission:

The first patch in this series introduces a new resctrl file,
"thread_throttle_mode", on Intel systems that exposes to the
user how per-thread values are allocated to a core. This is added in
support of newer Intel systems that can be configured to allocate
either maximum or minimum throttling of the per-thread CLOS values
to the core.

Details about the feature can be found in the commit description and
in Chapter 9 of the most recent Intel ISE available from
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

The first patch parses user input with the appropriate sysfs API that has
not previously been used in resctrl. The second (in V2 the fourth) patch is
added as a subsequent cleanup that switches existing resctrl string parsing
code to also use this appropriate API.

Fenghua Yu (2):
  x86/resctrl: Enumerate per-thread MBA
  x86/resctrl: Enable per-thread MBA

Reinette Chatre (2):
  x86/resctrl: Enable user to view and select thread throttling mode
  x86/resctrl: Use appropriate API for strings terminated by newline

 Documentation/x86/resctrl_ui.rst       |  16 +-
 arch/x86/include/asm/cpufeatures.h     |   1 +
 arch/x86/kernel/cpu/cpuid-deps.c       |   1 +
 arch/x86/kernel/cpu/resctrl/core.c     |  32 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |  13 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 231 +++++++++++++++++++++++--
 arch/x86/kernel/cpu/scattered.c        |   1 +
 7 files changed, 277 insertions(+), 18 deletions(-)

-- 
2.21.0

