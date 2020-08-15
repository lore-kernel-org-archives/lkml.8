Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F26C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7522BED
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DFNT1/7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgHOVuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgHOVuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20704.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::704])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BE1C06138A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXVf6078HPWZBkgvUZ22Xw5IDyAkVzdshf9voOmQRGEHo1SsnUfH8Xvc4KBFhZhMMaWeYATlBJwmGlMusldbMYA4hE9P4y1RdW54YndWiUKUL/Rxq4Bz/LpegTrB6ux33zE53sW9rU9HbUm0nOz9qfZNGsYXrBcPEStGi8gtc4WJRQ5RgcAMoxlzerH4sqTV8Y16SmA3+97Vb+jOUKpSsdj16FGwWAK41jOLxVRfKk86K7ZJZsWkoFKyOYTC0Ok2QghbjhSBvQDZTOMfKKwYWlcsXPZQQupuPKyvpTlfPqhJRwVtFJhJTSoQARCngBrQdUMgetZMsAeDBhw4ri+oNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=137SJ50EBF1cfZ+AtAVGlHdk+dACIlaqNXN/blB3xPc=;
 b=F5alNfs6gZE4eY0GhDBAaTxgGKUjc0MOeXmLKbp93AAcxNSGxl9PvCewHOA1p/+aEclcJDaQAqFR7tEqqwWAD+fEagY0bDuZJotc+oh/SP2sMZthfKGvZ4w4B+/HHEvQLfmq35cj8jz4E7PFAxUOhSJcAUR57DSQwUyp5nl04EaDf5c3tfv+h7qY+b56zaYMa7blj499h4E73UsLmyyLGbFOk7L2RoBIieN8Zzeox/Z0u1qCcoMnDdsBoihRLUm5nkTfL4FUf/3uSOvyGAWl+pcpjDrA11wtywRh2WwMURIohXD5E4b1rKgjRo2gstmBbEHIIJR1lUO/Uk1S9Ho74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=137SJ50EBF1cfZ+AtAVGlHdk+dACIlaqNXN/blB3xPc=;
 b=DFNT1/7bwYGORWLrEzZrmCqpOlgMfIxVzwFFRQlJd+PZplTjaR9x3eCBZ+XVjFe8cTjGq+/DgKrQry+U0GOA68MLjsoBLMZmueXO4J1rTKrIKmWSxfexyVVPQKsSyzb6rqZ2pA6dVZKGWndw0RQbQhOVHqcD4x+H+S87dsp7guI=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB5094.prod.exchangelabs.com (2603:10b6:a03:7c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Sat, 15 Aug 2020 00:40:16 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::5c26:c6ca:c444:e947]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::5c26:c6ca:c444:e947%3]) with mapi id 15.20.3283.015; Sat, 15 Aug 2020
 00:40:16 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
To:     patches@amperecomputing.com
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] perf: arm_dsu: Support DSU ACPI devices
Date:   Fri, 14 Aug 2020 17:39:40 -0700
Message-Id: <1597451980-11405-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BY5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:1d0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3283.16 via Frontend Transport; Sat, 15 Aug 2020 00:40:15 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b6d82f0-9f5f-4a72-61d0-08d840b3c73c
X-MS-TrafficTypeDiagnostic: BYAPR01MB5094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB5094BDCB541249D4D48F8A48E0410@BYAPR01MB5094.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHyk9QPbekzIGBDwq+xCEXLhkKwowj2vCegazHHBIx13DRE9RkY5AslP6gZ2b+CjWS3yLJu1MBisk2CbpEE5d5icqvqlAQnhoWMo1tH7iAuSj98jnImlnwThHUm3wueiMmLbyl2GlxvgwdK61uA3KSgGYCG0+J4qKntiuM/ZhU9u9bIxJl2zPu2ZQzdUDUMJ9bgBIzpDzU6Xp8Zh/TGhwIoxcI3n4uyftm1LtjHI2+GV7HvyaShUMLBGJHlkNGpkeqS9WBqG0WKBpNk0JrDhLtYDT60e3VW6IgY6S6Fuzt+JUGT4weMs94zr5BhdWqrVjCBTA+mbV27n5CrLLdxiWL3cLFiEsTQEnSym/xGrwb8s9ENO6NYfa0IsAU0nSeZbECSRmmPgaR/nMyLQXjdpsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39840400004)(136003)(396003)(366004)(8936002)(16526019)(8676002)(52116002)(6506007)(6666004)(186003)(6486002)(26005)(2616005)(54906003)(83380400001)(6512007)(478600001)(66556008)(66476007)(66946007)(966005)(956004)(86362001)(4326008)(5660300002)(2906002)(34206002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: o4dexN01K+61LPwxm/9P8s7iboHmRgGjPFHMjH6dKwSsz0Xj/WtCzITIxkhdGX6+GAv67DzClU2K6iILi7CgZZQfEPnqCIbGtga5ohHrIhLAgyPiB7YblwUW3E7BGYM8aKCq8s6fl258Ar2exRPEbgY8MgLiYPNFaXgeqYeks2K9MZJA8V/vBu9fppmpC1C8OQ9RKfz447kV9q9P1Qq4Gj/2jg8ibMMBJiFKRk/C+1KR3Hv5Ze5/UA9ycP6UqhAHL6CM6ZiILJHFHI3dsH2lceCPwtizSfp+Qjdf5r7OBdbeJ3F0GOyRZ+owcXdhX1oKV7qfO94MLGtgkD9bkepxeGbTU4Fu4uqZi6HLXOmqOohXb3HgqqHW8qmOEPi9l03H0NKWkvNIo6W15Y3HmByHa1jtXEwSl1EZsPsxmp1wgms9y8hx+1NDssHPhz0NK0hLgFbef26FaiPKQA82WCtWWYxaRuLdkT//iTfpucNK3R8JgNejXcPQxRXQHmD6qFIf4zwUokrx09NYC9GmCZHhRtgHHPzJXg+0OJ/YpSqBqz1zPtHCyMuqpnJEtaIy2/0ANNqvSvUyHzcmtxI742KSd65hqrCqJoFdnj0smkVyCa3vA4juxdyI3XwoaTJI72AJX8uOK/OE1aHjiD2zCXrvxA==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6d82f0-9f5f-4a72-61d0-08d840b3c73c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2020 00:40:16.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwKtfk2dpKLf2nakHfSajGblJUBfFz7E4z0GLAOItuQcU8cCD9gPlXKmKtuehiuuT6TAJvDfSJ+9lyFVqz6144dAVFCh5BEF/dUcv51dAeKp/4jqxxoe1//qb4YuJCy9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing device from ACPI node.
Each DSU ACPI node and its associated cpus are inside a cluster node.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
Changes in v3:
- Based on the latest ARM ACPI binding at: https://developer.arm.com/documentation/den0093/c/

Changes in v2:
- Removed IRQF_SHARED.
- Fixed ACPI runtime detection.

 drivers/perf/arm_dsu_pmu.c | 68 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 96ed93c..4be355d 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -11,6 +11,7 @@
 #define DRVNAME		PMUNAME "_pmu"
 #define pr_fmt(fmt)	DRVNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -603,18 +604,21 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
 }
 
 /**
- * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
+ * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster
+ * from device tree.
  */
-static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
+static int dsu_pmu_dt_get_cpus(struct platform_device *pdev)
 {
 	int i = 0, n, cpu;
 	struct device_node *cpu_node;
+	struct dsu_pmu *dsu_pmu =
+		(struct dsu_pmu *) platform_get_drvdata(pdev);
 
-	n = of_count_phandle_with_args(dev, "cpus", NULL);
+	n = of_count_phandle_with_args(pdev->dev.of_node, "cpus", NULL);
 	if (n <= 0)
 		return -ENODEV;
 	for (; i < n; i++) {
-		cpu_node = of_parse_phandle(dev, "cpus", i);
+		cpu_node = of_parse_phandle(pdev->dev.of_node, "cpus", i);
 		if (!cpu_node)
 			break;
 		cpu = of_cpu_node_to_id(cpu_node);
@@ -626,11 +630,51 @@ static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
 		 */
 		if (cpu < 0)
 			continue;
-		cpumask_set_cpu(cpu, mask);
+		cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
 	}
 	return 0;
 }
 
+/**
+ * dsu_pmu_acpi_get_cpus: Get the list of CPUs in the cluster
+ * from ACPI.
+ */
+static int dsu_pmu_acpi_get_cpus(struct platform_device *pdev)
+{
+	int cpu;
+	struct dsu_pmu *dsu_pmu = (struct dsu_pmu *) platform_get_drvdata(pdev);
+
+	/*
+	 * A dsu pmu node is inside a cluster parent node along with cpu nodes.
+	 * We need to find out all cpus that have the same parent with this pmu.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct acpi_device *acpi_dev = ACPI_COMPANION(get_cpu_device(cpu));
+
+		if (acpi_dev &&
+			acpi_dev->parent == ACPI_COMPANION(&pdev->dev)->parent)
+			cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
+	}
+
+	return 0;
+}
+
+static int dsu_pmu_platform_get_cpus(struct platform_device *pdev)
+{
+	int ret = -ENOENT;
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
+
+	if (IS_ERR_OR_NULL(fwnode))
+		return ret;
+
+	if (is_of_node(fwnode))
+		ret = dsu_pmu_dt_get_cpus(pdev);
+	else if (is_acpi_device_node(fwnode))
+		ret = dsu_pmu_acpi_get_cpus(pdev);
+
+	return ret;
+}
+
 /*
  * dsu_pmu_probe_pmu: Probe the PMU details on a CPU in the cluster.
  */
@@ -683,7 +727,9 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(dsu_pmu))
 		return PTR_ERR(dsu_pmu);
 
-	rc = dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->associated_cpus);
+	platform_set_drvdata(pdev, dsu_pmu);
+
+	rc = dsu_pmu_platform_get_cpus(pdev);
 	if (rc) {
 		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
 		return rc;
@@ -705,7 +751,6 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	}
 
 	dsu_pmu->irq = irq;
-	platform_set_drvdata(pdev, dsu_pmu);
 	rc = cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
 						&dsu_pmu->cpuhp_node);
 	if (rc)
@@ -752,11 +797,19 @@ static const struct of_device_id dsu_pmu_of_match[] = {
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
@@ -826,7 +879,6 @@ static void __exit dsu_pmu_exit(void)
 module_init(dsu_pmu_init);
 module_exit(dsu_pmu_exit);
 
-MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
 MODULE_DESCRIPTION("Perf driver for ARM DynamIQ Shared Unit");
 MODULE_AUTHOR("Suzuki K Poulose <suzuki.poulose@arm.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

