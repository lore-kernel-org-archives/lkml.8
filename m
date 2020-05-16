Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C1EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCE320728
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XQ+1f0DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEPKe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 06:34:57 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:39985 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgEPKe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 06:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589625297; x=1621161297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=hdWCke9YSnF3O1SSCcA/pwSp93Txt12YR6yes7emgGA=;
  b=XQ+1f0DIZeqx0/kOVSmqzIBYvpoFjZWq3dMyrmfilVGD1aFpjhcrhIjD
   ZSqV5u7VbWDhhADNwL7Fcm8Bxw8PoiWUxJeA2UuUVUPb+TOPOZP3ZAgwh
   syDOYdLaf4ByHsYiJ76IpCQxh9XlEH8f++dAE2GL3WDrN5xkx7uUObqI/
   U=;
IronPort-SDR: hNvaFiXzYqTsqt8SOf9SOUH7iTsUiY2egtvJoJhvlBEi7hUp/G8+LSIZLd+JRudWvL1rvuXLm2
 sZQWw2IYyNcA==
X-IronPort-AV: E=Sophos;i="5.73,398,1583193600"; 
   d="scan'208";a="43784266"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 16 May 2020 10:34:55 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 57534A170A;
        Sat, 16 May 2020 10:34:54 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 16 May 2020 10:34:53 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 16 May 2020 10:34:53 +0000
Received: from localhost (10.85.1.185) by mail-relay.amazon.com (10.43.61.243)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Sat, 16 May
 2020 10:34:51 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v7 2/3] prctl: Hook L1D flushing in via prctl
Date:   Sat, 16 May 2020 20:34:29 +1000
Message-ID: <20200516103430.26527-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200516103430.26527-1-sblbir@amazon.com>
References: <20200516103430.26527-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing PR_GET/SET_SPECULATION_CTRL API to expose the L1D
flush capability. For L1D flushing PR_SPEC_FORCE_DISABLE and
PR_SPEC_DISABLE_NOEXEC are not supported.

There is also no seccomp integration for the feature.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/kernel/cpu/bugs.c | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ed54b3b21c39..3eb9139fcf50 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1121,6 +1121,19 @@ static void task_update_spec_tif(struct task_struct *tsk)
 		speculation_ctrl_update_current();
 }
 
+static int l1d_flush_out_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		return enable_l1d_flush_for_task(task);
+	case PR_SPEC_DISABLE:
+		return disable_l1d_flush_for_task(task);
+	default:
+		return -ERANGE;
+	}
+	return 0;
+}
+
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
@@ -1206,6 +1219,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 		return ssb_prctl_set(task, ctrl);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_set(task, ctrl);
+	case PR_SPEC_L1D_FLUSH_OUT:
+		return l1d_flush_out_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -1221,6 +1236,17 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 }
 #endif
 
+static int l1d_flush_out_prctl_get(struct task_struct *task)
+{
+	int ret;
+
+	ret = test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
+	if (ret)
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	else
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+}
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -1272,6 +1298,8 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 		return ssb_prctl_get(task);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_get(task);
+	case PR_SPEC_L1D_FLUSH_OUT:
+		return l1d_flush_out_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f8131e36..1e864867a367 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -213,6 +213,7 @@ struct prctl_mm_map {
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
 # define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_L1D_FLUSH_OUT		2
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
-- 
2.17.1

