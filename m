Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE724C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCB12173E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="er9l+VTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgAaTJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:09:13 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:47848 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbgAaTJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:09:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580497751; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=aRwX1jcVN/JyxVj3dlueMTh7f3R8MmKjYZHHaruUc7A=; b=er9l+VTtczwpj3V4ZeFEu3X5fYanC+6ZLY58u99fn46Tx+jYh62Z9SSgNQ8hkP3s0ZLIv1AB
 gsNcWLlMokOBYyx3Y98GyTSyXL8IQk9tLh5K9n3k1s8qXcJkd1u60kfH/3M4dg0LCuohWG1j
 lp3lnhLgYspk0W0ma1BuEYTJuoY=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e347b52.7f41f5844ce0-smtp-out-n02;
 Fri, 31 Jan 2020 19:09:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40249C447AA; Fri, 31 Jan 2020 19:09:06 +0000 (UTC)
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D746C447AD;
        Fri, 31 Jan 2020 19:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D746C447AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 2/3] firmware: psci: Add support for dt-supplied SYSTEM_RESET2 type
Date:   Fri, 31 Jan 2020 11:08:50 -0800
Message-Id: <1580497731-9845-3-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580497731-9845-1-git-send-email-eberman@codeaurora.org>
References: <1580497731-9845-1-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some implementors of PSCI may relax the requirements of the PSCI
architectural warm reset. In order to comply with PSCI specification, a
different reset_type value must be used. The alternate PSCI
SYSTEM_RESET2 may be used in all warm/soft reboot scenarios, replacing
the architectural warm reset.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/psci/psci.c | 21 +++++++++++++++++----
 include/linux/psci.h         |  1 +
 include/uapi/linux/psci.h    |  2 ++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2937d44..75e6a38 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -55,6 +55,7 @@ bool psci_tos_resident_on(int cpu)
 struct psci_operations psci_ops = {
 	.conduit = SMCCC_CONDUIT_NONE,
 	.smccc_version = SMCCC_VERSION_1_0,
+	.sys_reset2_reset_type = PSCI_1_1_SYSTEM_RESET2_SYSTEM_WARM_RESET,
 };
 
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
@@ -272,11 +273,10 @@ static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
 		/*
-		 * reset_type[31] = 0 (architectural)
-		 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
 		 * cookie = 0 (ignored by the implementation)
 		 */
-		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), 0, 0, 0);
+		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
+			       psci_ops.sys_reset2_reset_type, 0, 0);
 	} else {
 		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 	}
@@ -493,6 +493,7 @@ typedef int (*psci_initcall_t)(const struct device_node *);
 static int __init psci_0_2_init(struct device_node *np)
 {
 	int err;
+	u32 param;
 
 	err = get_set_conduit_method(np);
 	if (err)
@@ -505,7 +506,19 @@ static int __init psci_0_2_init(struct device_node *np)
 	 * can be carried out according to the specific version reported
 	 * by firmware
 	 */
-	return psci_probe();
+	err = psci_probe();
+	if (err)
+		return err;
+
+	if (psci_system_reset2_supported &&
+	    !of_property_read_u32(np, "arm,psci-sys-reset2-type", &param)) {
+		if ((s32)param > 0)
+			pr_warn("%08x is an invalid architectural reset type.\n",
+				param);
+		psci_ops.sys_reset2_reset_type = param;
+	}
+
+	return 0;
 }
 
 /*
diff --git a/include/linux/psci.h b/include/linux/psci.h
index a67712b..1959a80 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -37,6 +37,7 @@ struct psci_operations {
 	int (*migrate_info_type)(void);
 	enum arm_smccc_conduit conduit;
 	enum smccc_version smccc_version;
+	u32 sys_reset2_reset_type;
 };
 
 extern struct psci_operations psci_ops;
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 2fcad1d..d786ec8 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -55,6 +55,8 @@
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
 #define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
 
+#define PSCI_1_1_SYSTEM_RESET2_SYSTEM_WARM_RESET	0
+
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
 #define PSCI_0_2_POWER_STATE_ID_SHIFT		0
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
