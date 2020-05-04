Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BCBC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 04:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127B0206F1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 04:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mPEo91Lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgEDEOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 00:14:33 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:14448 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgEDEOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 00:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588565672; x=1620101672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=f42SAWEpwqudHXonrKA4kH+lQCUO1YP3xrO+LV4WQhs=;
  b=mPEo91Lt89JNo9I93heNsRvl9ZXaA5o7sxrc8J37OJfu97YXOp6XwkUQ
   p//q2CMtPMGwMoZ5u05RO6AkVuVhEHD4e/qGF9kyeTEpYbOeijMBGQ4h9
   VtiJf8FRSn9N++n/Mdqup3wApIHZBLpyj9K0Fy/hWy+DiC50hGoGMh02p
   g=;
IronPort-SDR: ZNvYprR0WaB4GObqt/IqNihXXySJzjGxi8xQL+tUwJybcIVys81ZtJ5VUOeG6urs2CuUGN/9Jv
 653FroqRJGWQ==
X-IronPort-AV: E=Sophos;i="5.73,350,1583193600"; 
   d="scan'208";a="29830148"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 04 May 2020 04:14:17 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 8EAD9A2702;
        Mon,  4 May 2020 04:14:15 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 4 May 2020 04:14:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 4 May 2020 04:14:05 +0000
Received: from localhost (10.85.6.15) by mail-relay.amazon.com (10.43.61.243)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Mon, 4 May
 2020 04:14:04 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v5 6/6] Documentation: Add L1D flushing Documentation
Date:   Mon, 4 May 2020 14:13:43 +1000
Message-ID: <20200504041343.9651-7-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504041343.9651-1-sblbir@amazon.com>
References: <20200504041343.9651-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of l1d flushing, explain the need for the
feature and how it can be used.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/hw-vuln/index.rst   |  1 +
 .../admin-guide/hw-vuln/l1d_flush.rst         | 40 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index 0795e3c2643f..35633b299d45 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -14,3 +14,4 @@ are configurable at compile, boot or run time.
    mds
    tsx_async_abort
    multihit.rst
+   l1d_flush
diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
new file mode 100644
index 000000000000..7d515b8c29f1
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -0,0 +1,40 @@
+L1D Flushing for the paranoid
+=============================
+
+With an increasing number of vulnerabilities being reported around data
+leaks from L1D, a new user space mechanism to flush the L1D cache on
+context switch is added to the kernel. This should help address
+CVE-2020-0550 and for paranoid applications, keep them safe from any
+yet to be discovered vulnerabilities, related to leaks from the L1D
+cache.
+
+Tasks can opt in to this mechanism by using a prctl (implemented only
+for x86 at the moment).
+
+Related CVES
+------------
+At the present moment, the following CVEs can be addressed by this
+mechanism
+
+    =============       ========================     ==================
+    CVE-2020-0550       Improper Data Forwarding     OS related aspects
+    =============       ========================     ==================
+
+Usage Guidelines
+----------------
+Applications can call ``prctl(2)`` with one of these two arguments
+
+1. PR_SET_L1D_FLUSH - flush the L1D cache on context switch (out)
+2. PR_GET_L1D_FLUSH - get the current state of the L1D cache flush, returns 1
+   if set and 0 if not set.
+
+**NOTE**: The feature is disabled by default, applications to need to specifically
+opt into the feature to enable it.
+
+Mitigation
+----------
+When PR_SET_L1D_FLUSH is enabled for a task, on switching tasks (when
+the address space changes), a flush of the L1D cache is performed for
+the task when it leaves the CPU. If the underlying CPU supports L1D
+flushing in hardware, the hardware mechanism is used, otherwise a software
+fallback, similar to the mechanism used by L1TF is used.
-- 
2.17.1

