Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E14FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A2520721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgEULIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:08:49 -0400
Received: from foss.arm.com ([217.140.110.172]:44554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgEULIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:08:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DFB030E;
        Thu, 21 May 2020 04:08:48 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC8703F68F;
        Thu, 21 May 2020 04:08:46 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] firmware: smccc: Fix missing prototype warning for arm_smccc_version_init
Date:   Thu, 21 May 2020 12:08:36 +0100
Message-Id: <20200521110836.57252-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f2ae97062a48 ("firmware: smccc: Refactor SMCCC specific bits into
separate file") introduced the following build warning:

drivers/firmware/smccc/smccc.c:14:13: warning: no previous prototype for
	function 'arm_smccc_version_init' [-Wmissing-prototypes]
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
             ^~~~~~~~~~~~~~~~~~~~~~

Fix the same by adding the missing prototype in arm-smccc.h

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci/psci.c | 1 -
 include/linux/arm-smccc.h    | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 1330a698a178..92013ecc2d9e 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -79,7 +79,6 @@ static u32 psci_function_id[PSCI_FN_MAX];
 
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
-void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);
 
 static inline bool psci_has_ext_power_state(void)
 {
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index c491d210e3c3..56d6a5c6e353 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -5,6 +5,7 @@
 #ifndef __LINUX_ARM_SMCCC_H
 #define __LINUX_ARM_SMCCC_H
 
+#include <linux/init.h>
 #include <uapi/linux/const.h>
 
 /*
@@ -111,6 +112,8 @@ enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
  */
 u32 arm_smccc_get_version(void);
 
+void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3

base-commit: a4fb17465182c9fc13104e4df04d050892055205
-- 
2.17.1

