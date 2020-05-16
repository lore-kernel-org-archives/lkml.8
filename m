Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA342C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E35207D5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iPmDYyKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgEPKfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 06:35:00 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:39985 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgEPKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 06:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589625298; x=1621161298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=cVDMJB0V69N/ERG1QjOibR3boSPJLVANnsa6lUHRia0=;
  b=iPmDYyKnF6DQf+Cu/vP90jPiQjECZxcV2Y4jyBrflpy4yY8Etp5I5hpo
   rXMJt717I3uBp4VWqbIgF9P6Bqi5Avwapl9lkwAt5mNtLp89sA2HxPygS
   8jyW/wBVxLNXENd3gVAdoESEH4cr9aQSdZujCamwfjhKY/4z+YFgfkVWs
   g=;
IronPort-SDR: NKhafI7VX0wXECoSUxVeij0Q/LKQnWx2NeHwWSnaHPX9QhBVxXfQqpf2bKXVmiLXAOuV2MB2/6
 RKnH/BODUqJg==
X-IronPort-AV: E=Sophos;i="5.73,398,1583193600"; 
   d="scan'208";a="43784268"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 16 May 2020 10:34:57 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 267EFA16E3;
        Sat, 16 May 2020 10:34:56 +0000 (UTC)
Received: from EX13D01UWA004.ant.amazon.com (10.43.160.99) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 16 May 2020 10:34:55 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA004.ant.amazon.com (10.43.160.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 16 May 2020 10:34:55 +0000
Received: from localhost (10.85.1.185) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 May 2020 10:34:54 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v7 3/3] Documentation: Add L1D flushing Documentation
Date:   Sat, 16 May 2020 20:34:30 +1000
Message-ID: <20200516103430.26527-4-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200516103430.26527-1-sblbir@amazon.com>
References: <20200516103430.26527-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of l1d flushing, explain the need for the
feature and how it can be used.

[tglx: Reword the documentation]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/hw-vuln/index.rst   |  1 +
 .../admin-guide/hw-vuln/l1d_flush.rst         | 51 +++++++++++++++++++
 Documentation/userspace-api/spec_ctrl.rst     |  7 +++
 3 files changed, 59 insertions(+)
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
index 000000000000..530a1e0ffbd3
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -0,0 +1,51 @@
+L1D Flushing for the paranoid
+=============================
+
+With an increasing number of vulnerabilities being reported around data
+leaks from the Level 1 Data cache (L1D) the kernel provides an opt-in
+mechanism to flush the L1D cache on context switch.
+
+This mechanism can be used to address e.g. CVE-2020-0550. For paranoid
+applications the mechanism keeps them safe from any yet to be discovered
+vulnerabilities, related to leaks from the L1D cache.
+
+
+Related CVEs
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
+
+Please see document: :ref:`Documentation/userspace-api/spec_ctrl.rst` for
+details.
+
+**NOTE**: The feature is disabled by default, applications need to
+specifically opt into the feature to enable it.
+
+Mitigation
+----------
+
+When PR_SET_L1D_FLUSH is enabled for a task a flush of the L1D cache is
+performed when the task is scheduled out and the incoming task belongs to a
+different process and therefore to a different address space.
+
+If the underlying CPU supports L1D flushing in hardware, the hardware
+mechanism is used, otherwise a software fallback, similar to the L1TF
+mitigation, is invoked.
+
+Limitations
+-----------
+
+The mechanism does not mitigate L1D data leaks between tasks belonging to
+different processes which are concurrently executing on sibling threads of
+a physical CPU core when SMT is enabled on the system.
+
+This can be addressed by controlled placement of processes on physical CPU
+cores or by disabling SMT. See the relevant chapter in the L1TF mitigation
+document: :ref:`Documentation/admin-guide/hw-vuln/l1tf.rst <smt_control>`.
diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 7ddd8f667459..b40afe97dbfb 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -106,3 +106,10 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
+
+- PR_SPEC_L1D_FLUSH_OUT: Flush L1D Cache on context switch out of the task
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, PR_SPEC_DISABLE, 0, 0);
-- 
2.17.1

