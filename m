Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32A6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D972075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404341AbgE1PV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:21:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:30135 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404290AbgE1PVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:21:18 -0400
IronPort-SDR: MRJbJ1tn7XNByalsxpVOdwtboMij+yOpKZYuIPn9XOPTdPGddy3er8wjsX22aj3F1zEnDHx7sP
 fZEfS/wsXHdA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:21:18 -0700
IronPort-SDR: C1qRLtjYKRU1b7lYDMVUeGxjKvoQGGEO4ce4DRrs/hLp1gmye4F6KRZ0EScA+45Fgn0mX5tkeV
 6tidSVMJVE3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="292031381"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga004.fm.intel.com with ESMTP; 28 May 2020 08:21:18 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, David.Laight@ACULAB.COM,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 3/3] perf/x86/intel/uncore: Validate MMIO address before accessing
Date:   Thu, 28 May 2020 08:19:29 -0700
Message-Id: <1590679169-61823-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590679169-61823-1-git-send-email-kan.liang@linux.intel.com>
References: <1590679169-61823-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

An oops will be triggered, if perf tries to access an invalid address
which exceeds the mapped area.

Check the address before the actual access to MMIO sapce of an uncore
unit.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V2:
- Rename is_valid_mmio_offset() to uncore_mmio_is_valid_offset()
- Swap over the sequence of conditional check
- Dump invalid offset

 arch/x86/events/intel/uncore.c       |  3 +++
 arch/x86/events/intel/uncore.h       | 12 ++++++++++++
 arch/x86/events/intel/uncore_snbep.c |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index cf76d66..1c339ca 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -132,6 +132,9 @@ u64 uncore_mmio_read_counter(struct intel_uncore_box *box,
 	if (!box->io_addr)
 		return 0;
 
+	if (!uncore_mmio_is_valid_offset(box, event->hw.event_base))
+		return 0;
+
 	return readq(box->io_addr + event->hw.event_base);
 }
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c2e5725..1de7cc3 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -197,6 +197,18 @@ static inline bool uncore_pmc_freerunning(int idx)
 	return idx == UNCORE_PMC_IDX_FREERUNNING;
 }
 
+static inline bool uncore_mmio_is_valid_offset(struct intel_uncore_box *box,
+					       unsigned long offset)
+{
+	if (offset < box->pmu->type->mmio_map_size)
+		return true;
+
+	pr_warn_once("perf uncore: Invalid offset 0x%lx exceeds mapped area of %s.\n",
+		     offset, box->pmu->type->name);
+
+	return false;
+}
+
 static inline
 unsigned int uncore_mmio_box_ctl(struct intel_uncore_box *box)
 {
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index bffb755..045c2d2 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4483,6 +4483,9 @@ static void snr_uncore_mmio_enable_event(struct intel_uncore_box *box,
 	if (!box->io_addr)
 		return;
 
+	if (!uncore_mmio_is_valid_offset(box, hwc->config_base))
+		return;
+
 	writel(hwc->config | SNBEP_PMON_CTL_EN,
 	       box->io_addr + hwc->config_base);
 }
@@ -4495,6 +4498,9 @@ static void snr_uncore_mmio_disable_event(struct intel_uncore_box *box,
 	if (!box->io_addr)
 		return;
 
+	if (!uncore_mmio_is_valid_offset(box, hwc->config_base))
+		return;
+
 	writel(hwc->config, box->io_addr + hwc->config_base);
 }
 
-- 
2.7.4

