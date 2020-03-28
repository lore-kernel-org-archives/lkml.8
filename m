Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F99C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1383D20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UOAD95Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgC1Ice (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:32:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44840 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgC1Icd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:32:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585384353; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=OKvsYu4u3rT/AdiRCKhuZKpl2MbRGsAeeYZDJ6dusnc=; b=UOAD95ZvljwsN7h6qX2l/mkAQaoyVIK7k5+r5n7pfN0rSkVUPSyd8tIhfErKLlsXYnukSnX7
 r9Y6Zm503zn1pKmdGLNTrSHuQP5O+g7J0wJbZYpLUVvqzPPeUpT0p3lOxvEv+6VuxwseyyKJ
 OodLxVoo80zwWCh+OcjhlSmYlbM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7f0b98.7fa0eb122308-smtp-out-n03;
 Sat, 28 Mar 2020 08:32:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 748FDC43636; Sat, 28 Mar 2020 08:32:24 +0000 (UTC)
Received: from ecbld-sh028-lnx.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53950C433F2;
        Sat, 28 Mar 2020 08:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53950C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: hw_breakpoint: don't clear debug registers in halt mode
Date:   Sat, 28 Mar 2020 16:32:09 +0800
Message-Id: <20200328083209.21793-1-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If external debugger sets a breakpoint for one Kernel function
when device is in bootloader mode and loads Kernel, this breakpoint
will be wiped out in hw_breakpoint_reset(). To fix this, check
MDSCR_EL1.HDE in hw_breakpoint_reset(). When MDSCR_EL1.HDE is
0b1, halting debug is enabled. Don't reset debug registers in this case.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/kernel/hw_breakpoint.c       | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 7619f473155f..8dc2c28791a0 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -18,6 +18,7 @@
 
 /* MDSCR_EL1 enabling bits */
 #define DBG_MDSCR_KDE		(1 << 13)
+#define DBG_MDSCR_HDE		(1 << 14)
 #define DBG_MDSCR_MDE		(1 << 15)
 #define DBG_MDSCR_MASK		~(DBG_MDSCR_KDE | DBG_MDSCR_MDE)
 
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 0b727edf4104..0180306f74d7 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -927,6 +927,17 @@ void hw_breakpoint_thread_switch(struct task_struct *next)
 				    !next_debug_info->wps_disabled);
 }
 
+/*
+ * Check if halted debug mode is enabled.
+ */
+static u32 hde_enabled(void)
+{
+	u32 mdscr;
+
+	asm volatile("mrs %0, mdscr_el1" : "=r" (mdscr));
+	return (mdscr & DBG_MDSCR_HDE);
+}
+
 /*
  * CPU initialisation.
  */
@@ -934,6 +945,14 @@ static int hw_breakpoint_reset(unsigned int cpu)
 {
 	int i;
 	struct perf_event **slots;
+
+	/*
+	 * When halting debug mode is enabled, break point could be already
+	 * set be external debugger. Don't reset debug registers here to
+	 * reserve break point from external debugger.
+	 */
+	if (hde_enabled())
+		return 0;
 	/*
 	 * When a CPU goes through cold-boot, it does not have any installed
 	 * slot, so it is safe to share the same function for restoring and
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
