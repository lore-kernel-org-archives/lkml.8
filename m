Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E1DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEB220885
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QZGy/+IO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgETC7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:59:34 -0400
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:39045
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbgETC7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:59:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BodrMynLNd/06xyJLFNGKzlgagfyWRUd9LRu4lStAa2Wis1IwgFrjwd2Df5LsPZHtY6NzNRgxTWYK9K85+39xRqNPu9Y+UE3j2k/RitJslZVDj+SnGkwONZf1N/o9wABXfB01E09MUDRSkvBigGqziA6OnfYt5rT/mWxMighn06XMp5UBTeSZzyo7+b/b3RPBzGgxstYhvNj1U30nkwtrtJhYdF2yC+PPcx8MWVTXFJADIjxzCUmz7t5FhxvjLjVlJ4n+1k6xzM6LV5PqpfVJaqZ3GeHrHyKYUK+jhcsVnL2lANwBhGXt8blpbCVfD8U7co+7Gk2Yw81Yf5++j2wRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEGsCpOy3etkzy1XeQgJjouVhubNgqAGDo4ExtLZTF0=;
 b=V9QB8/SBByQgQ8HRPAiKUAeo/9OCxogmUqpdhPFcagG52TLzhz69zWJvzkvkImqsyPhJUpNskrOKGfDpQfnqbwQWThpCJbL7xgxs3rWb4lJ+YnqbV/EPdVmk1UbQD8gfSPP2YTq7elLufwD+zoyALz0SiY/QivziZKPhaMQxoP2dOLq40KbfcfnsICmLKq9nBoTwJmeuP4bW3mi75wt1zaCcBoV7RXPOfoio6RWlfN6swUsMJ+OnpcaMjpC3IiPycPl5SU8YERgFWkcjcxLMKqYQIPosnh8nUY6SWlitgoQXqDLZr9gfpdCwPpM32uxAefHZNPoPxkDa/l7ZVLAl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEGsCpOy3etkzy1XeQgJjouVhubNgqAGDo4ExtLZTF0=;
 b=QZGy/+IObabbPSlqcJD/wgVSZKBt8UWlVBRCuYItEE+ov91lvVD8GfdomA28MDNCUv2tTL17hs7fdEz12+d2WD+SX1K/9cb7yKhTAVXQUxd50TDTXtzMzK4lNou+rNu/WCtCshOLkNqnGctq4crvuFKiH2P93xKBZ+ot7obvHaU=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6634.eurprd04.prod.outlook.com (2603:10a6:10:10e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 02:59:28 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 02:59:28 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] perf/imx_ddr: Add system PMU identifier for userspace
Date:   Wed, 20 May 2020 10:56:18 +0800
Message-Id: <20200520025619.687-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520025619.687-1-qiangqing.zhang@nxp.com>
References: <20200520025619.687-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 02:59:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e52fac7e-475b-4541-4a58-08d7fc69cf62
X-MS-TrafficTypeDiagnostic: DB8PR04MB6634:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6634CCDF80A464765EA54DC8E6B60@DB8PR04MB6634.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piKfqpcLu3STl/XPD5B8ev6isnC36YgEHQojdkihwf538NYAwpZZf+zYii5RNVkGY/WK86yKJ28PQ+Ow6nBAkYXYiE210Wtp3nqQBuj0yij/hpsMhSBScKRy1IN0HBX5XYXDHx/PQli+NcBgn7UgNzgsfg2aU+7XRHNzleZXx9SP4/0jBjYDp2oa7mAYPGQTlIcVhSI+wj5+BDMjXdxsfh9ovMkLvNqOy2av5w+jFTr7i68ohGHQyxiU/oLGPgGWYcOUJQZD+cesNueg4585naUEDU+xukj+IeVhEFsu0EE9MHt0FPhYKuDpL06CAxXJ/jFflttRkiiWQQa49c3VC9fwMOEDl9U6QmftPou5z+i7v0cgztFgaAoslH1/B+X49LSx1jPC9upVydPPtLPoq3wWyxE12Iv9lMyoufrR3eCXulU0S9aC8hFdjO2esuMafyr4JbJ6rfvhVIuZeZjOv303XmeoZkmk0xId+rpdoBdoCJsGGn9ixLma9rcACVTa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(8676002)(478600001)(2906002)(6486002)(956004)(8936002)(6666004)(2616005)(36756003)(6506007)(16526019)(5660300002)(66556008)(66476007)(4326008)(26005)(66946007)(1076003)(6512007)(316002)(86362001)(69590400007)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4+sYkLKLXMr4cNpfsU5MgNC7m/vBDkBh75QlZXXmtQRdn8jc69+AFFEd9USs11jaZ8V0D1ZFuQxEj82LP80jxatT4HdrG77qxTMzjKvdIzuN9VCFRrfuksvP1T4voLq9O+b/iKOK2PHf1KdYOA/kVfQScwyUMulMR9EieisRnjb7dY09i/PVFY3eQqXEeFq30QaQJxJZkqmoXiTfIdfatVga4rpjTvlaHVT/hkOYhF7yCz6+DwDkfJDOuki5oPKlxDVnscUwK0iOXv6XAwAP+llQNXJjIqP+jR5KtG2eohrHowO/DCONhBd+yu+YgO9tisaSL+VK0FLLkeeJ8L5F1cd9271H1BWH04lCwTFV7+cwXy2yMbjZy9WPcVVnap6mobG8jT/b84zd4i+erUTezwWDCLRCL9pczzYPo6roTTTVStFMnT3rBQj/CNa094FVFgN76bn8PpVYRDhF7q6zSz5slKK1C4UJ8G2kyCs5Hcc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52fac7e-475b-4541-4a58-08d7fc69cf62
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 02:59:27.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbNWthLNhCP7DwpbNDUI9lbPl214A5ERIfjbT5OsZngBHQ+1p+pGUTQgI2CadVoK7F5J6+kruWAMZZnK22Q4mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DDR Perf for i.MX8 is a system PMU whose axi id would different from
SoC to SoC. Need expose system PMU identifier for userspace which refer
to /sys/bus/event_source/devices/<PMU DEVICE>/identifier.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 90884d14f95f..ba523a94f4d7 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -76,6 +76,7 @@ struct ddr_pmu {
 	unsigned int cpu;
 	struct	hlist_node node;
 	struct	device *dev;
+	const char *identifier;
 	struct perf_event *events[NUM_COUNTERS];
 	int active_events;
 	enum cpuhp_state cpuhp_state;
@@ -84,6 +85,27 @@ struct ddr_pmu {
 	int id;
 };
 
+static ssize_t ddr_perf_identifier_show(struct device *dev,
+					struct device_attribute *attr,
+					char *page)
+{
+	struct ddr_pmu *pmu = dev_get_drvdata(dev);
+
+	return sprintf(page, "%s\n", pmu->identifier);
+}
+
+static struct device_attribute ddr_perf_identifier_attr =
+	__ATTR(identifier, 0444, ddr_perf_identifier_show, NULL);
+
+static struct attribute *ddr_perf_identifier_attrs[] = {
+	&ddr_perf_identifier_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ddr_perf_identifier_attr_group = {
+	.attrs = ddr_perf_identifier_attrs,
+};
+
 enum ddr_perf_filter_capabilities {
 	PERF_CAP_AXI_ID_FILTER = 0,
 	PERF_CAP_AXI_ID_FILTER_ENHANCED,
@@ -237,6 +259,7 @@ static const struct attribute_group *attr_groups[] = {
 	&ddr_perf_format_attr_group,
 	&ddr_perf_cpumask_attr_group,
 	&ddr_perf_filter_cap_attr_group,
+	&ddr_perf_identifier_attr_group,
 	NULL,
 };
 
@@ -601,6 +624,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	struct ddr_pmu *pmu;
 	struct device_node *np;
 	void __iomem *base;
+	const char *identifier = NULL;
 	char *name;
 	int num;
 	int ret;
@@ -620,6 +644,11 @@ static int ddr_perf_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pmu);
 
+	ret = of_property_read_string(np, "identifier", &identifier);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "Failed to get identifier\n");
+	pmu->identifier = identifier;
+
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d",
 			      num);
 	if (!name)
-- 
2.17.1

