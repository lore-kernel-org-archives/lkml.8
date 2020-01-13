Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CA7C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DEA2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbgAMEBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:01:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:29568 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbgAMEBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:01:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 20:01:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,427,1571727600"; 
   d="scan'208";a="424184843"
Received: from spandruv-mobl3.jf.intel.com ([10.251.135.218])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2020 20:01:45 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy@infradead.org, dvhart@infradead.org, lenb@kernel.org,
        andy@kernel.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] admin guide/pm: Admin guide for Intel Uncore Frequency limits
Date:   Sun, 12 Jan 2020 20:01:43 -0800
Message-Id: <20200113040143.1419770-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation for the attributes to control uncore frequency
selection.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
 - Split the documentation patch to another patch to merge via different
    tree

 Documentation/admin-guide/pm/intel_uncore.rst | 23 +++++++++++++++++++
 .../admin-guide/pm/working-state.rst          |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/admin-guide/pm/intel_uncore.rst

diff --git a/Documentation/admin-guide/pm/intel_uncore.rst b/Documentation/admin-guide/pm/intel_uncore.rst
new file mode 100644
index 000000000000..d75be65fb16a
--- /dev/null
+++ b/Documentation/admin-guide/pm/intel_uncore.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================================
+Intel® Uncore Frequency Selection
+=========================================================
+
+The uncore frequency in the Intel(R) hardware is selected based on internal heuristics, which uses the current selected performance state and various system power constraints. In majority of the cases this selection is the most optimal, so there is no need for placing external constraints from the Operating System.
+
+But there are some customers who wants less jitters from dynamic uncore frequency selection. For them, power saving is much lower priority than consistent performance. Currently these customers uses MSR 0x620, to place hard limits on the maximum and the minimum uncore frequency. They can now use Linux sysfs to place these limits and also have additional capability to place hard limits under power constraint scenario.
+
+The Uncore frequency section attributes are present under "/sys/devices/system/cpu/intel_uncore_frequency".
+The scope of these attributes is per die in multi-die systems or package wide in non multi-die systems. There is a unique folder for each die or package. For example:
+"package_00_die_00" for package 0 and die 0.
+
+Attributes:
+
+initial_max_freq_khz (READ ONLY): This is the power up value of the maximum uncore frequency in KHz. This is sampled during the driver initialization time. This is not the absolute maximum uncore frequency as there is no capability for the Operating System to read that. This can be used as a reference to roll back settings once user changed this limit.
+
+initial_min_freq_khz (READ ONLY): This is the power up value of the minimum uncore frequency in KHz. This is sampled during the driver initialization time. This is not the absolute minimum uncore frequency. This can be used as a reference to roll back settings once user changed this limit.
+
+max_freq_khz (READ, WRITE): This presents current maximum uncore frequency. User can modify this attribute to change to a new maximum uncore frequency in KHz.
+
+min_freq_khz (READ, WRITE): This presents current minimum uncore frequency. User can modify this attribute to change to a new minimum uncore frequency in KHz.
diff --git a/Documentation/admin-guide/pm/working-state.rst b/Documentation/admin-guide/pm/working-state.rst
index fc298eb1234b..15094cf0a234 100644
--- a/Documentation/admin-guide/pm/working-state.rst
+++ b/Documentation/admin-guide/pm/working-state.rst
@@ -11,3 +11,4 @@ Working-State Power Management
    cpufreq
    intel_pstate
    intel_epb
+   intel_uncore
-- 
2.24.1

