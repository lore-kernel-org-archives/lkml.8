Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5B1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74212073E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GbpMWSgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCRA3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:29:02 -0400
Received: from mail-bn7nam10on2129.outbound.protection.outlook.com ([40.107.92.129]:43021
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726991AbgCRA3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAEjW2S175PDc8rQhxJXmmdI0GccGbHTbTYfk7oCrI0eEohTUk9BL4jJ1a680sza9DAIZq6IPqlBVNS4jDDtqVAl7dqzCBdivkMWfWREiSpLyQZnUvVFLa4NKlr8vayjoBixmGx/asgiyV5BrSb4dj457GCNizD4EmLv/hfP/2P658rbREvtyaSmoLQZoDYijWqHvhESgStdIrWUOhUrUNn/grGBkNEEp/o8/zByGQPkp0ejqcCMOFsGkpGAIddZp1rvMnt3DEQ7Jbh1bdsBIrHbk3/SEqTclO2JmG/CjQMbMliwJx6NvXISVV2J5m2rf85EWqbTuA0eXHpIlVHquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3PHiX55SDw/xi6e63/jB5GoM8ng1mVF8ZxftZ6OK6s=;
 b=nx9WUTbJvkz03eJdtfT89kkiAcNA95y4NlGc5MnF2+LwRi9a8+BH+wUAoY8qspuYPXJ0xNKZ7vE7C+KlKPOZBTWtXehhBeOfpADlFgCEErL/git2kxWguKCXw23Ix1vYHXLbmNVSkkiTqBpmCN7lrE+ncfC+yuIJ3PF/Dsc9AtVHNfzs0KFSQrVMbfda060crX8LmIUPMa9rDYk36In7LhjNEEpDV7Hotz3TmJotLuHgMORwwSjp3rIZGDwyyAgsTrN6nEDIfgMNM8rk+QwDW+VdwWUfeTj1CmgvB7ZChuUJeMB2tVpGmz4uKdr0+h2yUW4jQ/fjRX8DTVgHkaP1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3PHiX55SDw/xi6e63/jB5GoM8ng1mVF8ZxftZ6OK6s=;
 b=GbpMWSgsbX4brWvL6EHD3xMeS5bK9PEW5ne8aSTPu5055NJyHSM6EIluDQmHUmtr3axXabVY9JggE677+PccBaQOzDudka2wKeT3R1lJz0P1TKqO1FEeTusK4qfZu4VRzHfcZuqgoTnK3BY1yleyFgI/94D2LPqrApLfYCCUodA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tuanphan@os.amperecomputing.com; 
Received: from MWHPR01MB2317.prod.exchangelabs.com (2603:10b6:300:28::16) by
 MWHPR01MB3232.prod.exchangelabs.com (2603:10b6:300:fc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Wed, 18 Mar 2020 00:28:56 +0000
Received: from MWHPR01MB2317.prod.exchangelabs.com
 ([fe80::5151:bb2b:8ed2:b53c]) by MWHPR01MB2317.prod.exchangelabs.com
 ([fe80::5151:bb2b:8ed2:b53c%12]) with mapi id 15.20.2814.021; Wed, 18 Mar
 2020 00:28:56 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf: arm_dsu: Support DSU ACPI devices.
Date:   Tue, 17 Mar 2020 17:28:43 -0700
Message-Id: <1584491323-31436-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:74::41) To MWHPR01MB2317.prod.exchangelabs.com
 (2603:10b6:300:28::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BYAPR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:74::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.12 via Frontend Transport; Wed, 18 Mar 2020 00:28:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70aa99f7-4718-4d00-b60a-08d7cad357e1
X-MS-TrafficTypeDiagnostic: MWHPR01MB3232:|MWHPR01MB3232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR01MB32323765337C76DD55129610E0F70@MWHPR01MB3232.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(39840400004)(366004)(396003)(199004)(2616005)(6486002)(86362001)(66556008)(66476007)(66946007)(5660300002)(2906002)(109986005)(4326008)(6512007)(956004)(52116002)(478600001)(8936002)(316002)(16526019)(81156014)(6666004)(186003)(54906003)(26005)(6506007)(81166006)(8676002)(266003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB3232;H:MWHPR01MB2317.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqG/2l3dKYXL9StjTL0InLPujXj7Pw2gDnAre+3/1OKuhrhUpA5h6p7Q/HjL7cYOQe2vVxu/GQHWGpjL1MyaO3dLr/FfscQbfpaCE2xBSWlJlAJNlmDrBP8Y3tJOMAWDUJL0xrnskJWt+sZMObtQ3ekjo+ID76zUerQoTZLGeYG+VvusfjlkUF3oFlFb+D1rb+oPhqDhJm+MNK/RHo6qZAmVlodMRiMXSx9qzZy1daaYFO3ddrbwdQ6AAg6necpua72VURSqKrrwbm6ww0IUUnYRMFx9R50fCDTkxuGgmpxZHFGVTP123M++grSV18eO5bB1Cb94JWbtd+x7dyO6GP0UHWm4W5zHB/s8vZ9wwlovj1Ozi8uFGr8mrIEOe+pXrwn4iKPsfuNOgnITHxsx6jV4s6Znlxo4DSwLv8ItOAThsmEo1choHWqZF/uUT0AzCV/A1qZvNjO2STn9FsfQgUTMp3O/IGDuu3X3JGtOxf0=
X-MS-Exchange-AntiSpam-MessageData: V16gagId8587rALLpx38zCAVcaPmb9Ji8aCm2xU7adt1YP/Rm6Q93ainoXhWwXTSZmCcXT31hQnY4OOv+Z2AlxMwK9ij+jyVyG7Hs329jzEKC4EzTMXBaPZ10/Vudcz4zgmzDUecSY65O9JDQe5u6g==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70aa99f7-4718-4d00-b60a-08d7cad357e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 00:28:56.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXhIJbh/iTNDDOkZc4B0CTkHNU0T3E292lierkmgDIkpwLkcgqelWu4uUzuEBojhptHAKky9PP+LIFTls06tspQRw78H6qUmNMcZwL6G669hrK9oAb/PV09ogRe9rPwx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB3232
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing device from ACPI node.
Each DSU ACPI node defines "cpus" package which
each element is the MPIDR of associated cpu.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
 drivers/perf/arm_dsu_pmu.c | 53 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 2622900..6ef762c 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -11,6 +11,7 @@
 #define DRVNAME		PMUNAME "_pmu"
 #define pr_fmt(fmt)	DRVNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -603,18 +604,22 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
 }
 
 /**
- * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
+ * dsu_pmu_get_cpus: Get the list of CPUs in the cluster.
  */
-static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
+static int dsu_pmu_get_cpus(struct platform_device *pdev)
 {
+#ifndef CONFIG_ACPI
+	/* Get the list of CPUs from device tree */
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
@@ -626,9 +631,33 @@ static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
 		 */
 		if (cpu < 0)
 			continue;
-		cpumask_set_cpu(cpu, mask);
+		cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
 	}
 	return 0;
+#else /* CONFIG_ACPI */
+	int i, cpu, ret;
+	const union acpi_object *obj;
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct dsu_pmu *dsu_pmu =
+		(struct dsu_pmu *) platform_get_drvdata(pdev);
+
+	ret = acpi_dev_get_property(adev, "cpus", ACPI_TYPE_ANY, &obj);
+	if (ret < 0)
+		return -EINVAL;
+
+	if (obj->type != ACPI_TYPE_PACKAGE)
+		return -EINVAL;
+
+	for (i = 0; i < obj->package.count; i++) {
+		/* Each element is the MPIDR of associated cpu */
+		for_each_possible_cpu(cpu) {
+			if (cpu_physical_id(cpu) ==
+				obj->package.elements[i].integer.value)
+				cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
+		}
+	}
+	return 0;
+#endif
 }
 
 /*
@@ -683,7 +712,9 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(dsu_pmu))
 		return PTR_ERR(dsu_pmu);
 
-	rc = dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->associated_cpus);
+	platform_set_drvdata(pdev, dsu_pmu);
+
+	rc = dsu_pmu_get_cpus(pdev);
 	if (rc) {
 		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
 		return rc;
@@ -707,7 +738,6 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	}
 
 	dsu_pmu->irq = irq;
-	platform_set_drvdata(pdev, dsu_pmu);
 	rc = cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
 						&dsu_pmu->cpuhp_node);
 	if (rc)
@@ -754,11 +784,19 @@ static const struct of_device_id dsu_pmu_of_match[] = {
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
 	},
 	.probe = dsu_pmu_device_probe,
 	.remove = dsu_pmu_device_remove,
@@ -827,7 +865,6 @@ static void __exit dsu_pmu_exit(void)
 module_init(dsu_pmu_init);
 module_exit(dsu_pmu_exit);
 
-MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
 MODULE_DESCRIPTION("Perf driver for ARM DynamIQ Shared Unit");
 MODULE_AUTHOR("Suzuki K Poulose <suzuki.poulose@arm.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

