Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C778C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79432166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JeFZimdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgIIR3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:29:04 -0400
Received: from mail-co1nam11on2103.outbound.protection.outlook.com ([40.107.220.103]:13632
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbgIIR27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:28:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNmsI4YoZSXBzKtwnlpX5C5rnzACTk/MQt5fC3msbzFV6O1/EtZXegCF41/4ehRsrJf0GA/WaTmrwiNqPZWcOSX5RV+3T/vQr66WJRhLbXnVw2UdUMHs/PIHQCZ80FiiFG929i/Nfj+1RQvWL9ZwhWvXFKXDC8DKwJgNjKRO4izSAY62XG6yI6oN9qzuU3YpjOSX7CUPqDz2+obS83EiNlE0OoqBS12nAIcGpFmQ5TrOO0YZgSJdhSgzsKHxQXhFM+wM0LnqQ+ILd3RcYr3NQWBDIayc58ekRnjo8NfnReoKFzBQwQS8Asi3+uNUh/UcPb3WcZHH4YKj56fvVZlv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5AMy2r9VXqM2SdUiggisZT54K8jejladwrn7gQ8OMI=;
 b=DaGPWKZwQOiQjnEg/1C6dbT0Xs2OOke/mOme5TL/i/NeXxHttiP2eeSeETo/dhHJg1tUjnkmmw6160EADnPT/YepfaZn9pO/UVYJdZIrtO6U/hV0muGzGXhNpKlC1GoJCOgYlgoQV9QDtET0Js/85JCYK4KhPpurYfRvSoJyYK96z/g6xuvduUL8v9+nN8G+lsj2v/yJl4iager22tBf6km1eVP+g7jIVtfkc75oBElEKeyM8xmJUXxWgjYw5xm2X0r6gh5Yv0tssr9XV76k6xDmJXa2gIoe6aP5tqHzqIcIMuFZkEGyXH+ShfMqLge7QFZG+LlW0/WPGp0woGeS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5AMy2r9VXqM2SdUiggisZT54K8jejladwrn7gQ8OMI=;
 b=JeFZimdbvizCx/Tjid0jPx08OiD+00d/AEvBwLfrsc+n8JSPmg3nufX2HULeZ6hNuVrkItN8p80NPgtKRQlxy5etQGFu/jvR1+W7A+kcaDzfqmq5LxYG5RcEAe9qNvwuGvkzV9gksLBDIhJFd58SogWWMV7GV++2ulgpkdOQV+A=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB5270.prod.exchangelabs.com (2603:10b6:a03:87::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 9 Sep 2020 17:28:56 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29%4]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 17:28:56 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, suzuki.poulose@arm.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] perf: arm_dsu: Support DSU ACPI devices
Date:   Wed,  9 Sep 2020 10:28:48 -0700
Message-Id: <1599672528-23223-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0061.namprd17.prod.outlook.com
 (2603:10b6:a03:167::38) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BY5PR17CA0061.namprd17.prod.outlook.com (2603:10b6:a03:167::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 17:28:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81e28f81-c91c-4088-fad8-08d854e5d40b
X-MS-TrafficTypeDiagnostic: BYAPR01MB5270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB5270B8C12D44A88BB72EE7A4E0260@BYAPR01MB5270.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hizIWfmavMJ6HbX2nKACubVmmiraEDnBGyUoAZFaOPGv2SjAvLCyhhOp+VjiAayMfkgSeQpr7TC7kHlh8GagRHAG12uSnmNAcXUP1WIc88UuBSOTItn2atzVUxVPXRu++7zzwa5jQftfz91/WV341pD6dcEnhFIs5ZykjIjRhQF9iLsdJ+7Bp/54r9iL5W30damgGkYpFgghC7l+iahiSOhWKEOQxK2rYaWOn12Vod7d1V5xuQX2GsXUN5GuV/b0ed3+XbHmPd3DWVbf7ncUO7b2rRrS9bFgf8Qlzy0fQKN/Zpa1xgkdwkHuOv5y5hPWtcl83iT424nhyMmUE0uaKndwZWkgzotw+uMSJyf3MVCrSW3A0SqQ3O/VHUCzlg2FH88+3XMa5m8xlO7/cw+yY2vxBESge0nj/DVqPQyW55wAbGeZBg4uCGKeKtDRJGMhIXq9X87dx0Unrz7GWUgm9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(8676002)(6666004)(52116002)(478600001)(109986005)(66556008)(4326008)(186003)(16526019)(83380400001)(2906002)(966005)(26005)(6512007)(54906003)(5660300002)(8936002)(86362001)(2616005)(956004)(6506007)(66946007)(316002)(6486002)(66476007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NyT1cAobu5FyQGnRNs3xM7osRM77REBJkssDEM1pDmZJbaeOIPEfLDVT6oZLs20Nr4UNEjPlDoZTomuGi01O/ifwh4RPYRmeYPAqUIbr0jVaq10NdU1MZpwgw7keXw+NPZK1DCilh5LwmfHSryOB/ovrouUGICHJHIc6WXgCU0xagS4o4qs+nmvfRTxZ1htpHfAwSNE1rYzIARqe9mLUjPoIsZlqi6G/hLYzNa+ZhnXJxhiSZA1ikzzR3pNtMpMnBWTyAlOEa2noPjC7uWU8KbX67z1iWoBWC5nCMHVMHVUE+USh2MUJdrXP5HjYo6y8B8HR3kbPhkQ1MHdrSfbBfnAodcGmqhNb6HXsRgyiq545O4iRhpAXaBb0n0q/sYcbZ1HVDiC2ouzIp1std0m/bUNx13156Cz5PhDL6hK0L6VdtQ33eXGK7kT612/hzUYCDbfJZfAAIsmX/ligrO08NO6+ukaFYz9u8uBBzwPkOVRzhBPOpdHjYUA4sDo+2kP4EkPGZyWnT1w0xPEP+bSp217pASXte+woENb53g2haZT4kPJSVwaecuyD1WnaIlKHWCRLPqkRpdWNiReq8JThzk1dR3jR19lrsC4KXaQmZhuAEHTJgDt2ngjrMEfVXE8RgTMdY6G0XCDbCVfH1u6UvA==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e28f81-c91c-4088-fad8-08d854e5d40b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 17:28:55.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYoH7cT0m8YBzryIKO4L1eo4Dq+/SLGJ0I/lvRKtl2fmAECpLqaMIZFLlgO6MwV+RUpm/l2oEFWgWOAkrM3vlbhBANMDU5hZvMS41hfwBk43XORnva7Gbs+PeCfhAFap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5270
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing device from ACPI node.
Each DSU ACPI node and its associated cpus are inside a cluster node.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
Changes in v4:
- Addressed Will's comments.

Changes in v3:
- Based on the latest ARM ACPI binding at: https://developer.arm.com/documentation/den0093/c/

Changes in v2:
- Removed IRQF_SHARED.
- Fixed ACPI runtime detection.

 drivers/perf/arm_dsu_pmu.c | 59 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 96ed93c..92c9c9d 100644
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
@@ -631,6 +633,34 @@ static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
 	return 0;
 }
 
+/**
+ * dsu_pmu_acpi_get_cpus: Get the list of CPUs in the cluster
+ * from ACPI.
+ */
+static int dsu_pmu_acpi_get_cpus(struct device *dev, cpumask_t *mask)
+{
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
+
+	return 0;
+}
+
 /*
  * dsu_pmu_probe_pmu: Probe the PMU details on a CPU in the cluster.
  */
@@ -676,6 +706,7 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 {
 	int irq, rc;
 	struct dsu_pmu *dsu_pmu;
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
 	char *name;
 	static atomic_t pmu_idx = ATOMIC_INIT(-1);
 
@@ -683,7 +714,16 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
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
@@ -752,11 +792,19 @@ static const struct of_device_id dsu_pmu_of_match[] = {
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
@@ -826,7 +874,6 @@ static void __exit dsu_pmu_exit(void)
 module_init(dsu_pmu_init);
 module_exit(dsu_pmu_exit);
 
-MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
 MODULE_DESCRIPTION("Perf driver for ARM DynamIQ Shared Unit");
 MODULE_AUTHOR("Suzuki K Poulose <suzuki.poulose@arm.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

