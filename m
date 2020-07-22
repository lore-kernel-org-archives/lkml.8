Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEB6C433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE2520781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbgGVRVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:21:30 -0400
Received: from foss.arm.com ([217.140.110.172]:60002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731906AbgGVRVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:21:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB7D7113E;
        Wed, 22 Jul 2020 10:21:06 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E70943F66F;
        Wed, 22 Jul 2020 10:21:05 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 10/14] coresight: etm4x: Define DEVARCH register fields
Date:   Wed, 22 Jul 2020 18:20:36 +0100
Message-Id: <20200722172040.1299289-11-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the fields of the DEVARCH register for identifying
a component as an ETMv4.x unit.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c |  4 ++--
 drivers/hwtracing/coresight/coresight-etm4x.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index e37aababa4c9..776a59f62710 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1624,8 +1624,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 static struct amba_cs_uci_id uci_id_etm4[] = {
 	{
 		/*  ETMv4 UCI data */
-		.devarch	= 0x47704a13,
-		.devarch_mask	= 0xfff0ffff,
+		.devarch	= ETM_DEVARCH_ETMv4x_ARCH,
+		.devarch_mask	= ETM_DEVARCH_ID_MASK,
 		.devtype	= 0x00000013,
 	}
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index f5d708206339..ab3d1c195387 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -519,6 +519,22 @@
 					 ETM_MODE_EXCL_KERN | \
 					 ETM_MODE_EXCL_USER)
 
+#define ETM_DEVARCH_ARCHITECT_MASK		GENMASK(31, 21)
+#define ETM_DEVARCH_ARCHITECT_ARM		((0x4 << 28) | (0b0111011 << 21))
+#define ETM_DEVARCH_PRESENT			BIT(20)
+#define ETM_DEVARCH_ARCHID_MASK			GENMASK(15, 0)
+#define ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT	12
+#define ETM_DEVARCH_ARCHID_ARCH_VER(x)		\
+	(((x) & 0xfUL) << ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT)
+#define ETM_DEVARCH_ARCHID_ARCH_PART(x)		((x) & 0xfffUL)
+#define ETM_DEVARCH_ARCHID_ETMv4		\
+	(ETM_DEVARCH_ARCHID_ARCH_VER(4) | ETM_DEVARCH_ARCHID_ARCH_PART(0xA13))
+
+#define ETM_DEVARCH_ID_MASK						\
+	(ETM_DEVARCH_ARCHITECT_MASK | ETM_DEVARCH_ARCHID_MASK | ETM_DEVARCH_PRESENT)
+#define ETM_DEVARCH_ETMv4x_ARCH						\
+	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETMv4 | ETM_DEVARCH_PRESENT)
+
 #define TRCSTATR_IDLE_BIT		0
 #define TRCSTATR_PMSTABLE_BIT		1
 #define ETM_DEFAULT_ADDR_COMP		0
-- 
2.24.1

