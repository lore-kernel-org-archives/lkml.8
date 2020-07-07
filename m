Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1375C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF6B206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KGA2Ejvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgGGKHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:07:45 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:40992
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbgGGKHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:07:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bublNzoHBCfLgqVlpGsvwCT188bXvujPnsCM88YzgVbUMhm2ot3hySjrA9lX/tKo5J5Caz3jlm1qADukxBRoiwPXUAdPDwZtI5HcgqNcXthG3vlhMFNgxROroL+es+ZqhpqPy8LHktlaidQXZslx0zHFpqQerEkjf8noawq/GE5rW/Nk85Gj764M3l0qej8GHuGvCZbbJYlmrNjKcD5MAxxhUQ51GydMREa7blH/EEqdYYHWlEKihL5FDcDxqqo9qpVeqU6I8UlgA9vuq2/aQu8fUVw7rJT4ZaQ4MA139iKPRGG5i/RjY3uw0lG3EcQ19dFK+koBW1rr5ZhNmHcyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZdsuHwKgICPN4wmQjs0x1IdRACwZTOzGPey7x4jBSQ=;
 b=VDqT2AVIZZBYl+kzXojrEGhskvkl3R8+adjaGxcmfMx2vKNbGRg1iimdAUnwb3PLvtRx+1uwGrTqE+D1StjD6MBijE9p0zq1a+H8NQxSR9fOzgNxmH8r6i/hUZAfi72wrGY16JKWKupI3iPyW+8AvV5ioJrhpvxr+YH2FsbR/LVQDrVGpBYZVuWMC/WUjWUTctY0iBy680dL2YmWUQFJuHwCf3xIc12g4dWgzKjlt6rTqdDmwxs8a3SiWnvOPAYRJIlt/uFNuwX0tGIyr1+OvMjpTxfpDjTI/iqJ4OFKhTd5OGK3I/5opJAZV4fawJkH4DW0+SG1lXeumzGGc5Ji9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZdsuHwKgICPN4wmQjs0x1IdRACwZTOzGPey7x4jBSQ=;
 b=KGA2Ejvpgo5JQ7z47gpG9Y0j3GxtJlQYeeNNKmKpVnaWcFy3D93o2xxjcvIC0VeJx0oSmYww2C7+kh0LULXjxXK67MkUnNRhWVKsGLjdEObOEYeXt3VX5VSP2vFXphkwPzMtGgKFAWAut4P8+kYxComPqe0N0sQyRo1xDDOR7aM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 10:07:41 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 10:07:41 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] clk: x86: Change name from ST to FCH
Date:   Tue,  7 Jul 2020 15:36:59 +0530
Message-Id: <20200707100714.24720-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::27) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from akshu-HP-EliteBook-745-G2.mshome.net (122.167.38.75) by MAXPR0101CA0041.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Tue, 7 Jul 2020 10:07:38 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.167.38.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 217eac5d-b4d0-4130-4f59-08d8225d9550
X-MS-TrafficTypeDiagnostic: MWHPR12MB1440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1440F3E01C7F5A40BF623035F8660@MWHPR12MB1440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9r5G5prN9jaSAac1YQ6wBNp6ZUE9iiH33S0h90DgRtXL2Djb1Llo0JVqURyNZCWcaBNgMxI/ihup3zjVNaFweEi4JRNZmCrqJE2FUf+/3Ambi9hqgBIVeuVU/9yjL0MIdz99zFLxRj7jc+VDiYJYfNWvJNiAGaqO6H1G/zi/+0RrvsObaV742DdriyO3R+L9ATMoQ7cMC6RmoBviYHV137JPz9rqBuBJ38airwxzvgEMfqZKE/x6gsP2YlJKwQS1Dw6OllbbQMxD0/Dr/44t05NLUenT/LXQLmORhkqSGUZhFa8sUgbxQqc1dOzkGR3Xz01qEJSfbxm9rbrrJvfpL0kRHqn1Xba50dhszj+t0vijRNwPpYmClIkhf8dIC6i4z7iFfT7rAyMWfiwa2UKjzNcn9Ykt5cgGY4BP+L5VLaDV98UTl9DaJluZ24LlfC03
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(6666004)(5660300002)(8676002)(186003)(16526019)(44832011)(52116002)(36756003)(4326008)(316002)(66476007)(66556008)(6486002)(86362001)(26005)(54906003)(6506007)(956004)(2616005)(8936002)(83380400001)(66946007)(2906002)(6512007)(1076003)(478600001)(109986005)(966005)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kKbng9DjrQWLw6VHQbJMseMVrJU+f8SXoQV03uVG15OmQ1Rloe6oTG2ngIwQtJoNBuyMqFGtGAMdN3GqtIOzn1xVQfjy8K3JpIalaKzr+IsnJUVJhh57QLvVeVnLaKTwtkW9QjKaiJnPOsnsniqGDEXZHJI7q1ToIXfUdpiNft5QDtWRsWKkCXw7v4Je8sEyJhxtaG0TcbjVylnLX0vq4HQOArKQt8RwL8VCVkzI1IueUzx9c99402FRA9RMKh7ZU7rwRRbZp3+OdZIZxG3EwfExfenNPwzRJ9S8vnnT/6R1TuR3t7+Zn0AyJQuEG1Ejn8n6ixtcjaCpUjPVCGXIoU5VhSthwJiRSfCnQ8MsQiMdBhznPCGeZm+kZbufD6AQ5mEntmlFoZn7mhmP+M3ggotQ1rPQu/QaxWB/23TbTBHczpqI2pV4i0FlKoiYt/aBdJnRlv8YX6e+BN7okpGz+Mvpy5K2WLD+7xoCYvc4zJc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217eac5d-b4d0-4130-4f59-08d8225d9550
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 10:07:40.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQhGvo7b1AIUqOxzCr1q1+KEiWAOEPvrRnLNlI2d4ePRHxRJRWrd22kDf3oRWXeywR23gk8WIFHbUOYQTfc3Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SoC general pupose clk is present in new platforms with
minor differences. We can reuse the same clk driver for other
platforms. Hence, changing name from ST(SoC) to FCH(IP)

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
This patch is dependant on https://patchwork.kernel.org/patch/11648129/

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

