Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D48C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C98206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HtXfbCF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGMBBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 21:01:33 -0400
Received: from mail-eopbgr770050.outbound.protection.outlook.com ([40.107.77.50]:50687
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728010AbgGMBBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 21:01:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggN5o0ODNDbm1OGcYrCgKRMBgFblpW3rXe3t+Z6seUsikmYShuQYhoGj+w0u0HeyOBTeIXSXEHMxBXQrB/km6/9ubSUhE0zmZYm5Q7ZIDqOsEFQ96a6ZbsDdgpTftQA6KlM64Hvt+sQLHiXJvRC0CHNzVHQEUTNDI+cYC7iSn6pKXHh1udYADhgoGyxdVz51YPidNCiZqe/24rxaDCn4iCoaIl7A8BRXnl2qbjX4f+loppNTMP/PR1DlLtjWoi8y6kIgermHvmmVkCvpCJbBQX8lB+IOtjrJPhBLf3ggern+d8Q8mvlY5kUBjpxpxi2nQ+a7wXWl+xZiBid8UMPWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJDIJHSv8NNOP6rfXrBdJql4WP3ft5kHjqj6B/Qn/eA=;
 b=Ni5gqwQLcfCzx4FVp0wiXkHP/1U6k7VqxRQR95grW6KrERSJ+NIBCzkPjXF97X6a7dY0m8gHhMJtIiflruW7CbDJHEvJzJMdifo1Vodvfa24fiLQkMgPGvFJ4b/J8LEL4wu3LoHORWEfU7KRRjyEvG9k3yuIWULwN12aQIWTFoWtSVxfN00FGqmeA6ZkSrXQ/pUxiZxaJWENB1Gce4TyP1SOXbmlXL/a2No5yqKAAkY3NW4e7eYGyeEJ5zsHg9bAlai23b91H/YBJ2eEOuMzc40mQQ0sAFvWRBZE6uiToBf1hw7cVFwdDn4FmkMv8eqg1/xAJUlfUHxxf4wEbCjTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJDIJHSv8NNOP6rfXrBdJql4WP3ft5kHjqj6B/Qn/eA=;
 b=HtXfbCF5r+Pdf+/4F5w4OqNR3sjlj10ETG7FRHHS7fh9oZVc2iTvsUncd/mDaprnQTzoRImEHKZgFoUyCz2+R7w/zy/P229xUWVsMqcyZ5OcJt+dpM0RMRY19mw4VwXalXzar5dca1aN/gldlzt8EFVLIoHwbdxJn3duoJP25c0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1600.namprd12.prod.outlook.com (2603:10b6:301:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 01:01:29 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3174.025; Mon, 13 Jul
 2020 01:01:29 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] clk: x86: Change name from ST to FCH
Date:   Mon, 13 Jul 2020 06:29:50 +0530
Message-Id: <20200713010001.18976-2-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713010001.18976-1-akshu.agrawal@amd.com>
References: <20200713010001.18976-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::18) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.167.38.75) by MAXPR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Mon, 13 Jul 2020 01:01:26 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.167.38.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7d1300f-9250-4857-5a04-08d826c8464e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB16003D6147CCA5A44BF3552BF8600@MWHPR12MB1600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4457Ix8Eyha7SwIn9Y8aoCWaOdWBuhNmKVL0KpBkODtA+u+yTxCpt9rQbLbBuF1bYqqasj2mz2l3/GEp1TlQ4OvWPlSxe3foRoWTI8LPHaGvOsDeu4+TphUkxAIj0S0AdxyBkb0VDAha976sMQEQdfuO6q5hZupFZEWXs4XrzbbJae9HU17aBNVN5oVFaVjVYeFDkZjrYVOJDgpD+lpv9HmbxB4NQsr7AKMEoMSiEmB7cmgJNv6htXIPdXjJfQAT4wftWs7s7w//ootdi6Em5wxYsXPGfUUboD/GyFI+Bswrw6x5GpvdJmzJ/IY5zuhHmOVTsnmwkYQn8oxCFxK6/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(52116002)(478600001)(2906002)(1076003)(54906003)(316002)(6666004)(34206002)(4326008)(8936002)(6506007)(37006003)(5660300002)(186003)(956004)(83380400001)(2616005)(16526019)(44832011)(6512007)(36756003)(26005)(66556008)(66476007)(86362001)(66946007)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: odZiyuz4Cxv7kp5n8h3GmX/Z+8Ihe06FvUonWwIgnk3HJjwqaf20XRsQsC3RwVg+SU+A6qXYEA55+4o2SkW2gOqI/8QzswvvGjbc+KEiJZdDzpJrzgB0SG5rW4Wvu1qNMgBW5QMmFUSi3stuAVYAF/nEHToC9SSJzI7eygejsbgtx9F3nPlO56MKEExLoG+/Ma42FuAZJNIRptGN4eYMFlZ9+BIKkbNlIEO1zRwmDdbTg0zinYY8z6slgQ5vhUByifux8i8BOaPmzeUQKy+5R1Tz8hFY6m0EVjKif4wmJt6wEY0nipVpZQtYmqgpNCBb0VbbPCougZz4o+cwRgOcCf5FjQkYDmRTiy2rcO7D2XM/b/+KbVQA/ADhr762YStXUF/r0oeG/dwnHF62iK92R1G5wxJEfNfRgIFv+1kJW5UJ0hpnul8EqhTohwz8JNGbmuEA3WaWcTmtiq8cxDI6E/wtYQFQYdXykbX9zv2Prn8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d1300f-9250-4857-5a04-08d826c8464e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 01:01:29.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEFe9iJ2YHbEpshD0Iw1Z09L/ngljJalm1LXpEqmf0tNrBFcu9jkIAGB/AYdzpAM5FqyiBuLYcayOrpwJMkrFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SoC general pupose clk is present in new platforms with
minor differences. We can reuse the same clk driver for other
platforms. Hence, changing name from ST(SoC) to FCH(IP)

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 drivers/clk/x86/Makefile                |  2 +-
 drivers/clk/x86/{clk-st.c => clk-fch.c} | 26 ++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)
 rename drivers/clk/x86/{clk-st.c => clk-fch.c} (73%)

diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
index 7c774ea7ddeb..18564efdc651 100644
--- a/drivers/clk/x86/Makefile
+++ b/drivers/clk/x86/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
-obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
+obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-fch.o
 clk-x86-lpss-objs		:= clk-lpt.o
 obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
 obj-$(CONFIG_CLK_LGM_CGU)	+= clk-cgu.o clk-cgu-pll.o clk-lgm.o
diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-fch.c
similarity index 73%
rename from drivers/clk/x86/clk-st.c
rename to drivers/clk/x86/clk-fch.c
index 25d4b97aff9b..b252f0cf0628 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -8,7 +8,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
-#include <linux/platform_data/clk-st.h>
+#include <linux/platform_data/clk-fch.h>
 #include <linux/platform_device.h>
 
 /* Clock Driving Strength 2 register */
@@ -29,12 +29,12 @@
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
 
-static int st_clk_probe(struct platform_device *pdev)
+static int fch_clk_probe(struct platform_device *pdev)
 {
-	struct st_clk_data *st_data;
+	struct fch_clk_data *fch_data;
 
-	st_data = dev_get_platdata(&pdev->dev);
-	if (!st_data || !st_data->base)
+	fch_data = dev_get_platdata(&pdev->dev);
+	if (!fch_data || !fch_data->base)
 		return -EINVAL;
 
 	hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
@@ -44,12 +44,12 @@ static int st_clk_probe(struct platform_device *pdev)
 
 	hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
 		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
-		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
+		0, fch_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
 
 	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
 
 	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
-		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
+		0, fch_data->base + MISCCLKCNTL1, OSCCLKENB,
 		CLK_GATE_SET_TO_DISABLE, NULL);
 
 	devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE], "oscout1",
@@ -58,7 +58,7 @@ static int st_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int st_clk_remove(struct platform_device *pdev)
+static int fch_clk_remove(struct platform_device *pdev)
 {
 	int i;
 
@@ -67,12 +67,12 @@ static int st_clk_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver st_clk_driver = {
+static struct platform_driver fch_clk_driver = {
 	.driver = {
-		.name = "clk-st",
+		.name = "clk-fch",
 		.suppress_bind_attrs = true,
 	},
-	.probe = st_clk_probe,
-	.remove = st_clk_remove,
+	.probe = fch_clk_probe,
+	.remove = fch_clk_remove,
 };
-builtin_platform_driver(st_clk_driver);
+builtin_platform_driver(fch_clk_driver);
-- 
2.20.1

