Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1260FC2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E087120768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oSXlxd0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgDHJDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:03:08 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:26841 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgDHJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586336587; x=1617872587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5qCpvPW1FTnWyJFzXG8fIzft16iLqTfuHYxmGpAAwDo=;
  b=oSXlxd0AK7RuK/zqJhAe/hYRZQNT2Emk2EDpT5ApHcWewfecESCNtjTE
   WZHCzRtL02RJqIlXY5GvoQGlcpbXHL5FDPza6CtAgxgFbiI5M6Rae89hW
   nzKiq2eIhJWS5Yogb6fwSwUmXUhqm50UlI9DqrxQlHBa5mqeiJdOb5i23
   U=;
IronPort-SDR: DCFeKtUu9ilBreICB13Oh/Zhb5hZSIvq+YJkPAwdpXzceCYA9aRJxuxhbZuyWLIneLQN1OdUHm
 qECqENbWwTqA==
X-IronPort-AV: E=Sophos;i="5.72,357,1580774400"; 
   d="scan'208";a="37342120"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 08 Apr 2020 09:03:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id DD724A3D25;
        Wed,  8 Apr 2020 09:03:05 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 09:02:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 09:02:56 +0000
Received: from localhost (10.85.0.235) by mail-relay.amazon.com (10.43.61.169)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Wed, 8 Apr
 2020 09:02:55 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v3 5/5] arch/x86: Add L1D flushing Documentation
Date:   Wed, 8 Apr 2020 19:02:29 +1000
Message-ID: <20200408090229.16467-6-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408090229.16467-1-sblbir@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com>
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

