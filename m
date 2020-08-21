Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B648C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B4822EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHUS2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:28:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:19170 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgHUS2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:28:30 -0400
IronPort-SDR: DMsWvog6fm0FUBSWQDni6eB4AgNJp7wFwXwFZhG5FaU/147HEOth2Dycyp9dDuD6gU8pdxznfm
 K/76hBkATaBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="240431692"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="240431692"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 11:25:25 -0700
IronPort-SDR: GQ6rC2WZaG3VkXyiNLl+Lsii5jmmhwvHQAMfHFcA5pUozCZbiqM2WLGvzcnRr0X5rDuYLJ2jLO
 PD22isfgKE5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="337723367"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 21 Aug 2020 11:25:24 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 0/2] x86/resctrl: Enable user to view thread or core throttling mode
Date:   Fri, 21 Aug 2020 11:25:15 -0700
Message-Id: <1598034317-122771-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enumerates Memory Bandwidth Allocation (MBA) per-thread
feature and introduces a new resctrl file "thread_throttle_mode".
The file shows either "per-thread" on newer systems that implement the MBA
per-thread feature or "max" on other systems that allocate maximum
throttling per-core.

Details about the feature can be found in the commit description and
in Chapter 9 of the most recent Intel ISE available from
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

This series replaces the original MBA thread throttling patch series
found at
https://lore.kernel.org/lkml/cover.1592841671.git.reinette.chatre@intel.com/

This is a simplified version of the previous series that skips the
min/max mode and just provides the per-core vs. per-thread indicator.

Change Log:
v2:
- Rename "arch_throttle_mode" to "throttle_mode" and
  "rdtgroup_rftype_by_name()" to "rdtgroup_rftype_get_by_name()" (Boris).

Fenghua Yu (2):
  x86/resctrl: Enumerate per-thread MBA
  x86/resctrl: Enable user to view thread or core throttling mode

 Documentation/x86/resctrl_ui.rst       | 18 ++++++++-
 arch/x86/include/asm/cpufeatures.h     |  1 +
 arch/x86/kernel/cpu/cpuid-deps.c       |  1 +
 arch/x86/kernel/cpu/resctrl/core.c     | 11 ++++++
 arch/x86/kernel/cpu/resctrl/internal.h | 30 ++++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/scattered.c        |  1 +
 7 files changed, 106 insertions(+), 9 deletions(-)

-- 
2.19.1

