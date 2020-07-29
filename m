Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F0C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18A2207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EKEAcqZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgG2ALw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:11:52 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:61343 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbgG2ALw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595981511; x=1627517511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gza8Fo6cIgyJiH1Oi8vSL5WIzUCIejc3j8cr8d5XhKI=;
  b=EKEAcqZgoauu0THKef6G1VLBr/HpXLX+ADdvIlPvrGTkDj7HS9tGU48T
   QSGtcJt1GtXuH2OtTFHl53GbVxmPNd44Fuj8hhhR4+BGNifgayLh368Lo
   de5xzprmW/nGX3OZh7FMGL0YzxVuAz1aEd7qPga5b6uvrNoCuBbH98OGU
   0=;
IronPort-SDR: Ho9+Rw4VhqeDHDG1JirI6bBmXq7ZYNbCZMPi81qXyqdjn+P/PIs6OmTMQDUelgqjGkGHIL1HL/
 NqOug2P2CbLw==
X-IronPort-AV: E=Sophos;i="5.75,408,1589241600"; 
   d="scan'208";a="44618332"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 29 Jul 2020 00:11:44 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 16052A1DEC;
        Wed, 29 Jul 2020 00:11:40 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 00:11:40 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 00:11:39 +0000
Received: from localhost (10.143.192.232) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 00:11:38 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        <mingo@kernel.org>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v2 5/5] Documentation: Add L1D flushing Documentation
Date:   Wed, 29 Jul 2020 10:11:03 +1000
Message-ID: <20200729001103.6450-6-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729001103.6450-1-sblbir@amazon.com>
References: <20200729001103.6450-1-sblbir@amazon.com>
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
 .../admin-guide/hw-vuln/l1d_flush.rst         | 70 +++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         | 17 +++++
 Documentation/userspace-api/spec_ctrl.rst     |  8 +++
 4 files changed, 96 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index ca4dbdd9016d..21710f8609fe 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -15,3 +15,4 @@ are configurable at compile, boot or run time.
    tsx_async_abort
    multihit.rst
    special-register-buffer-data-sampling.rst
+   l1d_flush.rst
diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
new file mode 100644
index 000000000000..adc4ecc72361
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -0,0 +1,70 @@
+L1D Flushing
+============
+
+With an increasing number of vulnerabilities being reported around data
+leaks from the Level 1 Data cache (L1D) the kernel provides an opt-in
+mechanism to flush the L1D cache on context switch.
+
+This mechanism can be used to address e.g. CVE-2020-0550. For applications
+the mechanism keeps them safe from vulnerabilities, related to leaks
+(snooping of) from the L1D cache.
+
+
+Related CVEs
+------------
+The following CVEs can be addressed by this
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
+mechanism is used, software fallback for the mitigation, is not supported.
+
+Mitigation control on the kernel command line
+---------------------------------------------
+
+The kernel command line allows to control the L1D flush mitigations at boot
+time with the option "l1d_flush_out=". The valid arguments for this option are:
+
+  ============  =============================================================
+  off		Disables the prctl interface, applications trying to use
+                the prctl() will fail with an error
+  ============  =============================================================
+
+By default the API is enabled and applications opt-in by by using the prctl
+API.
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
+
+**NOTE** : Checks have been added to ensure that the prctl API associated
+with the opt-in will work only when the task affinity of the task opting
+in, is limited to cores running in non-SMT mode. The same checks are made
+when L1D is flushed.  Changing the affinity after opting in, would result
+in flushes not working on cores that are in non-SMT mode.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..59ea09095b7c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2272,6 +2272,23 @@
 			feature (tagged TLBs) on capable Intel chips.
 			Default is 1 (enabled)
 
+	l1d_flush_out=	[X86,INTEL]
+			Control mitigation for L1D based snooping vulnerability.
+
+			Certain CPUs are vulnerable to an exploit against CPU
+			internal buffers which can forward information to a
+			disclosure gadget under certain conditions.
+
+			In vulnerable processors, the speculatively
+			forwarded data can be used in a cache side channel
+			attack, to access data to which the attacker does
+			not have direct access.
+
+			This parameter controls the mitigation. The
+			options are:
+
+			off        - Unconditionally disable the mitigation
+
 	l1tf=           [X86] Control mitigation of the L1TF vulnerability on
 			      affected CPUs
 
diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 7ddd8f667459..f39744ef8810 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -106,3 +106,11 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
+
+- PR_SPEC_L1D_FLUSH_OUT: Flush L1D Cache on context switch out of the task
+                        (works only when tasks run on non SMT cores)
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, PR_SPEC_DISABLE, 0, 0);
-- 
2.17.1

