Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E95C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13722495A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgEDJ33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:29:29 -0400
Received: from foss.arm.com ([217.140.110.172]:40568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbgEDJ3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:29:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6067111D4;
        Mon,  4 May 2020 02:29:18 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C8233F305;
        Mon,  4 May 2020 02:29:17 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
Subject: [PATCH v2 4/5] firmware: psci: Add function to fetch SMCCC version
Date:   Mon,  4 May 2020 10:29:04 +0100
Message-Id: <20200504092905.10580-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504092905.10580-1-sudeep.holla@arm.com>
References: <20200504092905.10580-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For backward compatibility reasons, PSCI maintains SMCCC version as
SMCCC didn't provide ARM_SMCCC_VERSION_FUNC_ID until v1.1

Let us provide accessors to fetch the SMCCC version in PSCI so that
other SMCCC v1.1+ features can use it.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci/psci.c | 5 +++++
 include/linux/arm-smccc.h    | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 6a56d7196697..04426e16fee6 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -65,6 +65,11 @@ enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
 	return psci_ops.conduit;
 }
 
+u32 arm_smccc_get_version(void)
+{
+	return psci_ops.smccc_version;
+}
+
 typedef unsigned long (psci_fn)(unsigned long, unsigned long,
 				unsigned long, unsigned long);
 static psci_fn *invoke_psci_fn;
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 9d9a2e42e919..d6b0f4acc707 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -98,6 +98,15 @@ enum arm_smccc_conduit {
  */
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
 
+/**
+ * arm_smccc_get_version()
+ *
+ * Returns the version to be used for SMCCCv1.1 or later.
+ *
+ * When SMCCCv1.1 or above is not present, assumes and returns SMCCCv1.0.
+ */
+u32 arm_smccc_get_version(void);
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
-- 
2.17.1

