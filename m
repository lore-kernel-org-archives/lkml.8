Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA36C2D0F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827D22075E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cE3mPNKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDFDWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 23:22:34 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:60089 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgDFDWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 23:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586143353; x=1617679353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=MWGg3n3VsVybDoCAczham1vrlLq57WQjzTcKy0SHwXE=;
  b=cE3mPNKmRfn3QNS+WBTNiBq06gPmi8prqGtPA0aKU8KrGe6c9WHKIQ5/
   IeBZ0WSAljEESYaw/OfkEXk47/pLHVCh0y1JZsQ32HQUmJgeqDHGYYZdq
   u3K4HFn+ByNcIuflJXjN6a6Tnakr7TENQg3gu9a9mtysmGnUckXXKV0gp
   o=;
IronPort-SDR: pwkin+IQri2xqXZ89mkaEHT8WLSdfYFl2IYQLIZXe8Ud9lRWWqksbweb9or9JJBLhf9n4XG2nP
 kZDVcDVYblpA==
X-IronPort-AV: E=Sophos;i="5.72,349,1580774400"; 
   d="scan'208";a="24331853"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 06 Apr 2020 03:22:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 70F58A2288;
        Mon,  6 Apr 2020 03:22:18 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 03:22:17 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 03:22:17 +0000
Received: from localhost (10.85.6.171) by mail-relay.amazon.com (10.43.60.234)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Mon, 6 Apr
 2020 03:22:15 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v2 4/4] arch/x86: Add L1D flushing Documentation
Date:   Mon, 6 Apr 2020 13:19:46 +1000
Message-ID: <20200406031946.11815-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406031946.11815-1-sblbir@amazon.com>
References: <20200406031946.11815-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of l1d flushing, explain the need for the
feature and how it can be used.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
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
index 000000000000..73ee9e491a74
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
+Tasks can opt in to this mechanism by using an architecture specific
+prctl (x86 only at the moment).
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
+Applications can call ``arch_prctl(2)`` with one of these two arguments
+
+1. ARCH_SET_L1D_FLUSH - flush the L1D cache on context switch (out)
+2. ARCH_GET_L1D_FLUSH - get the current state of the L1D cache flush, returns 1
+   if set and 0 if not set.
+
+**NOTE**: The feature is disabled by default, applications to need to specifically
+opt into the feature to enable it.
+
+Mitigation
+----------
+When ARCH_SET_L1D_FLUSH is enabled for a task, on switching tasks (when
+the address space changes), a flush of the L1D cache is performed for
+the task when it leaves the CPU. If the underlying CPU supports L1D
+flushing in hardware, the hardware mechanism is used, otherwise a software
+fallback, similar to the mechanism used by L1TF is used.
-- 
2.17.1

