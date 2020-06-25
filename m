Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70923C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6282070A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403988AbgFYKTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:19:41 -0400
Received: from foss.arm.com ([217.140.110.172]:57100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403975AbgFYKTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:19:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A99881FB;
        Thu, 25 Jun 2020 03:19:39 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DEB0F3F73C;
        Thu, 25 Jun 2020 03:19:38 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] firmware: arm_scmi: Use HAVE_ARM_SMCCC_DISCOVERY instead of ARM_PSCI_FW
Date:   Thu, 25 Jun 2020 11:19:37 +0100
Message-Id: <20200625101937.51939-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e5bfb21d98b6 ("firmware: smccc: Add HAVE_ARM_SMCCC_DISCOVERY to
identify SMCCC v1.1 and above") introduced new config option to identify
the availability of SMCCC discoverability of version and features
transparently hiding the indirect dependency on ARM_PSCI_FW.

Commit 5a897e3ab429 ("firmware: arm_scmi: fix psci dependency") just
worked around the build dependency making SCMI SMC/HVC transport depend
on ARM_PSCI_FW at the time. Since it really just relies on SMCCC directly
and not on ARM_PSCI_FW, let us move to use CONFIG_HAVE_ARM_SMCCC_DISCOVERY
instead of CONFIG_ARM_PSCI_FW.

Cc: Peng Fan <peng.fan@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/Makefile | 2 +-
 drivers/firmware/arm_scmi/driver.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 1cad32b38b29..70c5a8c986a5 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -4,6 +4,6 @@ scmi-bus-y = bus.o
 scmi-driver-y = driver.o
 scmi-transport-y = shmem.o
 scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
-scmi-transport-$(CONFIG_ARM_PSCI_FW) += smc.o
+scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 7483cacf63f9..38e71a2c4fbb 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -901,7 +901,7 @@ ATTRIBUTE_GROUPS(versions);
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
 	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
-#ifdef CONFIG_ARM_PSCI_FW
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
 	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
 #endif
 	{ /* Sentinel */ },
-- 
2.17.1

