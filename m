Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2281EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0941D208CA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgEFQon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:44:43 -0400
Received: from foss.arm.com ([217.140.110.172]:41052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730140AbgEFQo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:44:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BC2CD6E;
        Wed,  6 May 2020 09:44:27 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C7753F305;
        Wed,  6 May 2020 09:44:26 -0700 (PDT)
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
Subject: [PATCH v3 6/7] firmware: smccc: Add function to fetch SMCCC version
Date:   Wed,  6 May 2020 17:44:10 +0100
Message-Id: <20200506164411.3284-7-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506164411.3284-1-sudeep.holla@arm.com>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For backward compatibility reasons, PSCI maintains SMCCC version as
SMCCC didn't provide ARM_SMCCC_VERSION_FUNC_ID until v1.1

Let us provide accessors to fetch the SMCCC version in PSCI so that
other SMCCC v1.1+ features can use it.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/smccc/smccc.c | 4 ++++
 include/linux/arm-smccc.h      | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index 488699aae24f..672974df0dfe 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -24,3 +24,7 @@ enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
 	return smccc_conduit;
 }
 
+u32 arm_smccc_version_get(void)
+{
+	return smccc_version;
+}
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 11fb20bfa8f7..8dd54dad1ec5 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -109,6 +109,15 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);
  */
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
 
+/**
+ * arm_smccc_version_get()
+ *
+ * Returns the version to be used for SMCCCv1.1 or later.
+ *
+ * When SMCCCv1.1 or above is not present, assumes and returns SMCCCv1.0.
+ */
+u32 arm_smccc_version_get(void);
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
-- 
2.17.1

