Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36477C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18ACE2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgGQIv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:51:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgGQIv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:51:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6FF65E2A077F0E7EE8A1;
        Fri, 17 Jul 2020 16:51:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 16:51:12 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <john.garry@huawei.com>, <zhangshaokun@hisilicon.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] drivers/perf: Prevent forced unbinding of PMU drivers
Date:   Fri, 17 Jul 2020 16:49:23 +0800
Message-ID: <1594975763-32966-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forcefully unbinding PMU drivers during perf sampling will lead to
a kernel panic, because the perf upper-layer framework call a NULL
pointer in this situation.

To solve this issue, "suppress_bind_attrs" should be set to true, so
that bind/unbind can be disabled via sysfs and prevent unbinding PMU
drivers during perf sampling.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/arm-cci.c                        | 1 +
 drivers/perf/arm-ccn.c                        | 1 +
 drivers/perf/arm_dsu_pmu.c                    | 1 +
 drivers/perf/arm_smmuv3_pmu.c                 | 1 +
 drivers/perf/arm_spe_pmu.c                    | 1 +
 drivers/perf/fsl_imx8_ddr_perf.c              | 1 +
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 1 +
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 1 +
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 1 +
 drivers/perf/qcom_l2_pmu.c                    | 1 +
 drivers/perf/qcom_l3_pmu.c                    | 1 +
 drivers/perf/thunderx2_pmu.c                  | 1 +
 drivers/perf/xgene_pmu.c                      | 1 +
 13 files changed, 13 insertions(+)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 1b8e337..87c4be9 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1718,6 +1718,7 @@ static struct platform_driver cci_pmu_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = arm_cci_pmu_matches,
+		   .suppress_bind_attrs = true,
 		  },
 	.probe = cci_pmu_probe,
 	.remove = cci_pmu_remove,
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index d50edef..7b7d23f 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1545,6 +1545,7 @@ static struct platform_driver arm_ccn_driver = {
 	.driver = {
 		.name = "arm-ccn",
 		.of_match_table = arm_ccn_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = arm_ccn_probe,
 	.remove = arm_ccn_remove,
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 518d060..96ed93c 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -757,6 +757,7 @@ static struct platform_driver dsu_pmu_driver = {
 	.driver = {
 		.name	= DRVNAME,
 		.of_match_table = of_match_ptr(dsu_pmu_of_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = dsu_pmu_device_probe,
 	.remove = dsu_pmu_device_remove,
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 90caba56..4cdb35d 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -860,6 +860,7 @@ static void smmu_pmu_shutdown(struct platform_device *pdev)
 static struct platform_driver smmu_pmu_driver = {
 	.driver = {
 		.name = "arm-smmu-v3-pmcg",
+		.suppress_bind_attrs = true,
 	},
 	.probe = smmu_pmu_probe,
 	.remove = smmu_pmu_remove,
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d80f487..e51ddb6 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1226,6 +1226,7 @@ static struct platform_driver arm_spe_pmu_driver = {
 	.driver	= {
 		.name		= DRVNAME,
 		.of_match_table	= of_match_ptr(arm_spe_pmu_of_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe	= arm_spe_pmu_device_probe,
 	.remove	= arm_spe_pmu_device_remove,
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 2aed2d9..397540a 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -707,6 +707,7 @@ static struct platform_driver imx_ddr_pmu_driver = {
 	.driver         = {
 		.name   = "imx-ddr-pmu",
 		.of_match_table = imx_ddr_pmu_dt_ids,
+		.suppress_bind_attrs = true,
 	},
 	.probe          = ddr_perf_probe,
 	.remove         = ddr_perf_remove,
diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 71587f1..5e3645c 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -419,6 +419,7 @@ static struct platform_driver hisi_ddrc_pmu_driver = {
 	.driver = {
 		.name = "hisi_ddrc_pmu",
 		.acpi_match_table = ACPI_PTR(hisi_ddrc_pmu_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = hisi_ddrc_pmu_probe,
 	.remove = hisi_ddrc_pmu_remove,
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index c199de7..5eb8168 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -431,6 +431,7 @@ static struct platform_driver hisi_hha_pmu_driver = {
 	.driver = {
 		.name = "hisi_hha_pmu",
 		.acpi_match_table = ACPI_PTR(hisi_hha_pmu_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = hisi_hha_pmu_probe,
 	.remove = hisi_hha_pmu_remove,
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 567d7e6..3e8b5ea 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -421,6 +421,7 @@ static struct platform_driver hisi_l3c_pmu_driver = {
 	.driver = {
 		.name = "hisi_l3c_pmu",
 		.acpi_match_table = ACPI_PTR(hisi_l3c_pmu_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = hisi_l3c_pmu_probe,
 	.remove = hisi_l3c_pmu_remove,
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 21d6991..4da37f6 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -1028,6 +1028,7 @@ static struct platform_driver l2_cache_pmu_driver = {
 	.driver = {
 		.name = "qcom-l2cache-pmu",
 		.acpi_match_table = ACPI_PTR(l2_cache_pmu_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = l2_cache_pmu_probe,
 	.remove = l2_cache_pmu_remove,
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 656e830..9ddb577 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -814,6 +814,7 @@ static struct platform_driver qcom_l3_cache_pmu_driver = {
 	.driver = {
 		.name = "qcom-l3cache-pmu",
 		.acpi_match_table = ACPI_PTR(qcom_l3_cache_pmu_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = qcom_l3_cache_pmu_probe,
 };
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 51b31d6..aac9823 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -1017,6 +1017,7 @@ static struct platform_driver tx2_uncore_driver = {
 	.driver = {
 		.name		= "tx2-uncore-pmu",
 		.acpi_match_table = ACPI_PTR(tx2_uncore_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = tx2_uncore_probe,
 	.remove = tx2_uncore_remove,
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 46ee680..edac28c 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1975,6 +1975,7 @@ static struct platform_driver xgene_pmu_driver = {
 		.name		= "xgene-pmu",
 		.of_match_table = xgene_pmu_of_match,
 		.acpi_match_table = ACPI_PTR(xgene_pmu_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 };

--
2.7.4

