Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10104C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED192207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgERJMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:12:31 -0400
Received: from foss.arm.com ([217.140.110.172]:36352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgERJMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:12:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 477EC11FB;
        Mon, 18 May 2020 02:12:29 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED0C93F68F;
        Mon, 18 May 2020 02:12:27 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com
Subject: [PATCH v4 1/7] firmware: smccc: Add HAVE_ARM_SMCCC_DISCOVERY to identify SMCCC v1.1 and above
Date:   Mon, 18 May 2020 10:12:16 +0100
Message-Id: <20200518091222.27467-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518091222.27467-1-sudeep.holla@arm.com>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMCCC v1.0 lacked discoverability of version and features. To accelerate
adoption of few mitigations and protect systems more rapidly from various
vulnerability, PSCI v1.0 was updated to add SMCCC discovery mechanism
though the PSCI firmware implementation of PSCI_FEATURES(SMCCC_VERSION)
which returns success on firmware compliant to SMCCC v1.1 and above.

This inturn makes SMCCC v1.1 and above dependent on ARM_PSCI_FW for
backward compatibility. Let us introduce a new hidden config for the
same to build more features on top of SMCCC v1.1 and above.

While at it, also sort alphabetically the psci entry.

Tested-by: Etienne Carriere <etienne.carriere@st.com>
Reviewed-by: Etienne Carriere <etienne.carriere@st.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/Kconfig       |  6 ++----
 drivers/firmware/smccc/Kconfig | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100644 drivers/firmware/smccc/Kconfig

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 8007d4aa76dc..4843e94713a4 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -295,15 +295,13 @@ config TURRIS_MOX_RWTM
 	  other manufacturing data and also utilize the Entropy Bit Generator
 	  for hardware random number generation.
 
-config HAVE_ARM_SMCCC
-	bool
-
-source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/imx/Kconfig"
 source "drivers/firmware/meson/Kconfig"
+source "drivers/firmware/psci/Kconfig"
+source "drivers/firmware/smccc/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
 source "drivers/firmware/xilinx/Kconfig"
 
diff --git a/drivers/firmware/smccc/Kconfig b/drivers/firmware/smccc/Kconfig
new file mode 100644
index 000000000000..27b675d76235
--- /dev/null
+++ b/drivers/firmware/smccc/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config HAVE_ARM_SMCCC
+	bool
+	help
+	  Include support for the Secure Monitor Call (SMC) and Hypervisor
+	  Call (HVC) instructions on Armv7 and above architectures.
+
+config HAVE_ARM_SMCCC_DISCOVERY
+	bool
+	depends on ARM_PSCI_FW
+	default y
+	help
+	 SMCCC v1.0 lacked discoverability and hence PSCI v1.0 was updated
+	 to add SMCCC discovery mechanism though the PSCI firmware
+	 implementation of PSCI_FEATURES(SMCCC_VERSION) which returns
+	 success on firmware compliant to SMCCC v1.1 and above.
-- 
2.17.1

