Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906D1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABB721D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VPlGjP6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgIJCxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbgIJB5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:57:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::70d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67103C0617A4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 16:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKcoj+6EoWVH+QNCscEI5P4ulLHEg/QxjBlBMzTwlQeeI40jG9MalN7qNpgIdlhAc86M2OdhLS/l11C0qvxshq8gJSTujWZYogI+RgHDnUliaFRGWZvxeRZRFQNQWIS5dFpHp6hX/m/eNhBGuZL6n7oxMKPHxLsLThdypzVNk1vlVwXDa+6cvEoZRXHT9NtvHcS8Mvis2gWqK4hWcp7bq+kJj6luDT56bEiLIkfAFE3tr3efRK8+Cxa4kFabBZnbhI86KmpkpXdZl7+QBk8T8qJO8wXZwn2cOQF/k5kdYm6MeAMuMQ6BoWwrCA5MQ9Of9Am539T36LoTnEZuuK/VeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+FOCyBQm+nAJpex75lVnuBFIN/TiF/UNojFI8JnQGU=;
 b=LY2J8B7E55vS7+QvcMGH1OnoogpjSvzMkkz/xl7DczL7G/DGl644eRp5tE4yGv4CW1VgX2ezYeC+iF3XyN/Cwf6Sq3G1miPkFBA+z3yXSj/qCny/7K58SXuICpwqqqDGHT8ij3sfucguMhaNQA0eaSCgd861G8EjPy467cFYOeUIOgWdTdREbW1g4pUMcThJ21/S6OjmBm+C87lJhUT+uG5Et2F6poUwthsM5TIMceCFPcxYCyLVKtB7/GmUq2M9nUmTWxfiszmfrrS+SrFKIlGQwwmkoe2jNxXbCjJQO/2lCEAdrgC6yVlAN6pG2IXf1+Zl6MuCqYIhRxfXuKKxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+FOCyBQm+nAJpex75lVnuBFIN/TiF/UNojFI8JnQGU=;
 b=VPlGjP6BSC5DUvaHZ6yxAYPcHtBYisQR0fmcU6gl26p1eJyxV/kltMD8Kp9ISedYWrX37l7T6L/QOmwJ3hE6EyRTH0AA6ziXd8XO6SIURXvs6/mFw28sJRKyWF26/E4Q+WXHtZZX8VmFvRaztGItDDFHUOUzNyA4aIuBEGpRKjs=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4213.prod.exchangelabs.com (2603:10b6:a03:13::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Wed, 9 Sep 2020 23:29:09 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29%4]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 23:29:09 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, suzuki.poulose@arm.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] perf: arm_dsu: Support DSU ACPI devices
Date:   Wed,  9 Sep 2020 16:29:00 -0700
Message-Id: <1599694141-16056-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BYAPR21CA0025.namprd21.prod.outlook.com (2603:10b6:a03:114::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3391.3 via Frontend Transport; Wed, 9 Sep 2020 23:29:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f33bd65d-e15d-44f9-c61b-08d85518267d
X-MS-TrafficTypeDiagnostic: BYAPR01MB4213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB4213C145B51600330DF60884E0260@BYAPR01MB4213.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wntox5GWOxrW6Zj+jVb7MqAdGZert08X91KxBmhgn7558wPeMb+VYvPkBB/2XaPObQAyolHHyLV2lKGwZfF2b6GIvVO+FXD39v5Jt0SYI55tnEOPxW87GLxSdES+urwhd9MG5eidnizQPyCXha1kQpPCgqAL4VvPaHEah28eQlbQeG39eRUE/GJ/HUs9ozJ5ZwJEdf7FxZuPa8W3ZkL0Xy+3h1LRYA2HMIm7Dyh2Svc4t2hT4vD2CcA996tOOyABuJk3W79mXrNX1DRsOsdl54P5tdrsE/OsTB6jsoXJr78Ee6RA0fqI3xQU5DTY8Y3W0emPzGSZGX9i2LcJgzFLLCsB2ucwOe0Dek9kFcyO7iZCzUKjCmgXqM+O6FjAQFIOzXMPKgNRhjZ8jtiSlqqvsSYKSUdx2jTwgn/7QYn+oA5cR6c07uvBqjL1rIkvJ5mZZAa9vzaKTbV0sW13MW6Mdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39850400004)(366004)(376002)(8936002)(6486002)(2616005)(478600001)(956004)(16526019)(316002)(8676002)(109986005)(966005)(83380400001)(4326008)(26005)(186003)(6506007)(6666004)(52116002)(6512007)(5660300002)(66946007)(86362001)(66476007)(2906002)(54906003)(66556008)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FAlllZ6LJ3B6rs+duAHm+ECIgE6Qzrk3x5/y9xuV8Xc7ZY9B4ae/m/QPyK4wah/7g7zqpHaZErK4OvSrYQlO9JMmgGTY8dCfh2VC7PC51m9jbcfeMR/jB3SKpjnMIP4EpxevMhsbuhRlq99zHffj/dV7asdLba5mnGvnytx3xsxH0TxrSRqKlGQBzKNthJpbYnP5VnkynGpheSvI0o+EG2Y+PKokIKU9k+jU7OZCVzClS/OAZ4+J3rDkglbPHr+MpNhzwW1H8j3ZWvLT3uDz6685jJqcIlWJpEbZF1U5/PI4CvzF4VBBHTo9dyUTqjZDUeMP+VoBIVv36K+GVoAJ+dpFKchNuQY8F1ro/U+EO7JXq1YwLdLRoH8KRtmrPozavdl2kSbYCBKVyjS3RG51PwUlWyrwvOo9LlFq/X004MhKjeKHmyxZcJ707ppGlSMq9pNCFNKjpMknHRXvextf/GjVL5b1xlMFMQqvbU4bjt7M8IEwnOyP9MQ+urpFNsNuOFs9WXtvIIMKdZWgVmOjOBzdzZQZmTObCEZr4vdFY5dKbl9AYhlB8cTa25L7URcpXN+PT4uGmRJPs1MEBq6E8flo3Dg9Fw0xhfUR/m51zdki/EhkdWTavhGXqriMdwgFv/S5LptAtE8wzpE6i5ZZSg==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33bd65d-e15d-44f9-c61b-08d85518267d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 23:29:08.9566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LilwY3ZVDbu4X2pZSF921Wm0Werv67dGC+u4pTKZMoDzaAekda6ojsjgtJUWPNp53ozBNNIBayxSsC8tXZtjXw6a6gZNZ5dHGfiTrsMCTz1mZ0/vIa2Zonx3Bj0iegXQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4213
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing device from ACPI node.
Each DSU ACPI node and its associated cpus are inside a cluster node.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
Changes in v5:
- Used CONFIG_ACPI to fix compiling issue.

Changes in v4:
- Addressed Will's comments.

Changes in v3:
- Based on the latest ARM ACPI binding at: https://developer.arm.com/documentation/den0093/c/

Changes in v2:
- Removed IRQF_SHARED.
- Fixed ACPI runtime detection.

 drivers/perf/arm_dsu_pmu.c | 61 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 96ed93c..68d2891 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -11,6 +11,7 @@
 #define DRVNAME		PMUNAME "_pmu"
 #define pr_fmt(fmt)	DRVNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -603,18 +604,19 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
 }
 
 /**
- * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
+ * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster
+ * from device tree.
  */
-static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
+static int dsu_pmu_dt_get_cpus(struct device *dev, cpumask_t *mask)
 {
 	int i = 0, n, cpu;
 	struct device_node *cpu_node;
 
-	n = of_count_phandle_with_args(dev, "cpus", NULL);
+	n = of_count_phandle_with_args(dev->of_node, "cpus", NULL);
 	if (n <= 0)
 		return -ENODEV;
 	for (; i < n; i++) {
-		cpu_node = of_parse_phandle(dev, "cpus", i);
+		cpu_node = of_parse_phandle(dev->of_node, "cpus", i);
 		if (!cpu_node)
 			break;
 		cpu = of_cpu_node_to_id(cpu_node);
@@ -631,6 +633,36 @@ static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
 	return 0;
 }
 
+/**
+ * dsu_pmu_acpi_get_cpus: Get the list of CPUs in the cluster
+ * from ACPI.
+ */
+static int dsu_pmu_acpi_get_cpus(struct device *dev, cpumask_t *mask)
+{
+#ifdef CONFIG_ACPI
+	int cpu;
+
+	/*
+	 * A dsu pmu node is inside a cluster parent node along with cpu nodes.
+	 * We need to find out all cpus that have the same parent with this pmu.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct acpi_device *acpi_dev;
+		struct device *cpu_dev = get_cpu_device(cpu);
+
+		if (!cpu_dev)
+			continue;
+
+		acpi_dev = ACPI_COMPANION(cpu_dev);
+		if (acpi_dev &&
+			acpi_dev->parent == ACPI_COMPANION(dev)->parent)
+			cpumask_set_cpu(cpu, mask);
+	}
+#endif
+
+	return 0;
+}
+
 /*
  * dsu_pmu_probe_pmu: Probe the PMU details on a CPU in the cluster.
  */
@@ -676,6 +708,7 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 {
 	int irq, rc;
 	struct dsu_pmu *dsu_pmu;
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
 	char *name;
 	static atomic_t pmu_idx = ATOMIC_INIT(-1);
 
@@ -683,7 +716,16 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(dsu_pmu))
 		return PTR_ERR(dsu_pmu);
 
-	rc = dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->associated_cpus);
+	if (IS_ERR_OR_NULL(fwnode))
+		return -ENOENT;
+
+	if (is_of_node(fwnode))
+		rc = dsu_pmu_dt_get_cpus(&pdev->dev, &dsu_pmu->associated_cpus);
+	else if (is_acpi_device_node(fwnode))
+		rc = dsu_pmu_acpi_get_cpus(&pdev->dev, &dsu_pmu->associated_cpus);
+	else
+		return -ENOENT;
+
 	if (rc) {
 		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
 		return rc;
@@ -752,11 +794,19 @@ static const struct of_device_id dsu_pmu_of_match[] = {
 	{ .compatible = "arm,dsu-pmu", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
+
+static const struct acpi_device_id dsu_pmu_acpi_match[] = {
+	{ "ARMHD500", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, dsu_pmu_acpi_match);
 
 static struct platform_driver dsu_pmu_driver = {
 	.driver = {
 		.name	= DRVNAME,
 		.of_match_table = of_match_ptr(dsu_pmu_of_match),
+		.acpi_match_table = ACPI_PTR(dsu_pmu_acpi_match),
 		.suppress_bind_attrs = true,
 	},
 	.probe = dsu_pmu_device_probe,
@@ -826,7 +876,6 @@ static void __exit dsu_pmu_exit(void)
 module_init(dsu_pmu_init);
 module_exit(dsu_pmu_exit);
 
-MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
 MODULE_DESCRIPTION("Perf driver for ARM DynamIQ Shared Unit");
 MODULE_AUTHOR("Suzuki K Poulose <suzuki.poulose@arm.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

