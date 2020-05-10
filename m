Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52098C47257
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E46F20A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N9t5Vnk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgEJBst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 21:48:49 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:59387 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgEJBsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 21:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589075327; x=1620611327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=f42SAWEpwqudHXonrKA4kH+lQCUO1YP3xrO+LV4WQhs=;
  b=N9t5Vnk7cta4Vd6w8tDAi3smLvgetsCjbwcvuH3FAs1O1C5M/Oi4SeGk
   Y4riS+wkM6+lr3RNbqUwaf+qGGBHJ8up6Bpi8hX3kl4gDZvJhqm1N+MR0
   tzA6uZKTE9zIAN0HML57YlbIGR39eQ56zDmqVYm22noDMSPNkSHWNoVKj
   w=;
IronPort-SDR: lA0ZfCYa/1xFI06L8kwsY3tB3770Wc644mw9Fi2afp1+tnsidULe3zGW8MXZjse7OPrQ8oQAvf
 aOAeV0yZmLeA==
X-IronPort-AV: E=Sophos;i="5.73,373,1583193600"; 
   d="scan'208";a="29400617"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 10 May 2020 01:48:44 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id C1544A1E67;
        Sun, 10 May 2020 01:48:40 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 01:48:24 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 01:48:23 +0000
Received: from localhost (10.85.6.121) by mail-relay.amazon.com (10.43.62.224)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Sun, 10 May
 2020 01:48:22 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v6 6/6] Documentation: Add L1D flushing Documentation
Date:   Sun, 10 May 2020 11:48:03 +1000
Message-ID: <20200510014803.12190-7-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200510014803.12190-1-sblbir@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com>
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

