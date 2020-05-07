Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4051CC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17EC420643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEGOtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:49:14 -0400
Received: from foss.arm.com ([217.140.110.172]:33192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgEGOtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:49:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDBE9D6E;
        Thu,  7 May 2020 07:49:12 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B65283F68F;
        Thu,  7 May 2020 07:49:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] firmware: arm_scmi: fix psci dependency
Date:   Thu,  7 May 2020 15:49:05 +0100
Message-Id: <20200507144905.11397-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ARM_PSCI_FW is disabled but CONFIG_HAVE_ARM_SMCCC is enabled,
arm-scmi runs into a link failure:

arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/smc.o: in function `smc_send_message':
smc.c:(.text+0x200): undefined reference to `arm_smccc_1_1_get_conduit'

Change from HAVE_ARM_SMCCC to ARM_PSCI_FW config dependency for now.
We rely on PSCI bindings anyways for the conduit and this should be
fine.

Fixes: 1dc6558062da ("firmware: arm_scmi: Add smc/hvc transport")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/Makefile | 2 +-
 drivers/firmware/arm_scmi/driver.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Hi Arnd,

I am planning to push this patch in favour of [1]. Once we have a
separate config[2] for SMCCC v1.1+, I will change to use it instead of
ARM_PSCI_FW.

Regards,
Sudeep

[1] https://lore.kernel.org/r/20200505140820.536615-1-arnd@arndb.de
[2] https://lore.kernel.org/r/20200506164411.3284-1-sudeep.holla@arm.com/


diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 11b238f81923..1cad32b38b29 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -4,6 +4,6 @@ scmi-bus-y = bus.o
 scmi-driver-y = driver.o
 scmi-transport-y = shmem.o
 scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
-scmi-transport-$(CONFIG_HAVE_ARM_SMCCC) += smc.o
+scmi-transport-$(CONFIG_ARM_PSCI_FW) += smc.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index fec308e47b9d..7483cacf63f9 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -901,7 +901,7 @@ ATTRIBUTE_GROUPS(versions);
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
 	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
-#ifdef CONFIG_HAVE_ARM_SMCCC
+#ifdef CONFIG_ARM_PSCI_FW
 	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
 #endif
 	{ /* Sentinel */ },
-- 
2.17.1

