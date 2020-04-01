Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEC7C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C88620772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbgDARv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:51:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:55330 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgDARv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:51:26 -0400
IronPort-SDR: X4vOJ2hSEf405UHGHiez0fhrKjQfFcNn5nryZnlnOr3UgGqypBdd28nvZaJTIJD+wXK+Him888
 Lnt7sGlqfMuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 10:51:25 -0700
IronPort-SDR: 8kI36UCptIK/9RC+rcbxFdsTnrUhkSGiT/+Pxm7DPNFTThd8gUN2kBtYSSDWVbcF+cRiaEtX1u
 Bf+9Y0o0mvOw==
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="422809389"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 10:51:24 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 0/2] x86/resctrl: Support wider MBM counters
Date:   Wed,  1 Apr 2020 10:51:00 -0700
Message-Id: <cover.1585763047.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory Bandwidth Monitoring (MBM) is an Intel Resource Director
Technology (RDT) feature that tracks Total and Local bandwidth
generated which misses the L3 cache.

The original Memory Bandwidth Monitoring (MBM) architectural
definition defines counters of up to 62 bits and the first-generation
MBM implementation uses 24 bit counters. Software is required to poll
at 1 second or faster to ensure that data is retrieved before a counter
rollover occurs more than once under worst conditions.

As system bandwidths scale the software requirement is maintained with
the introduction of a per-resource enumerable MBM counter width.

This series adds support for the new enumerable MBM counter width.

Details about the feature can be found in Chapter 9 of the most
recent Intel ISE available from
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

Reinette Chatre (2):
  x86/resctrl: Maintain MBM counter width per resource
  x86/resctrl: Support CPUID enumeration of MBM counter width

 arch/x86/include/asm/processor.h          |  1 +
 arch/x86/kernel/cpu/common.c              |  5 +++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  8 ++++---
 arch/x86/kernel/cpu/resctrl/internal.h    | 15 ++++++++++---
 arch/x86/kernel/cpu/resctrl/monitor.c     | 27 ++++++++++++++++-------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 6 files changed, 43 insertions(+), 15 deletions(-)

-- 
2.21.0

