Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C74C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D39E22CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QKDribCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgGTFGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:06:37 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:18017
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbgGTFGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:06:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkJwd0rmWip0LVzALUFOM/sJyQgWhtYDG227xuS+3QPzHN1Do/icvUCnPPsWFcIioaosPAN2npSJgTMKeX0Es5c8wKvstJ8YPHVWzVxgSn65gd/Bx6pcdiWn4ZYUGT98WCY9q4JHei3QwHqhkOwGsL3EP+TiJ9sieN4u4eNvtm6g99iEkuDTzWTfkNgMugQVwT0OlgI/1vPJ9BrguxyFD+y4nVfkK6ZU2kYenLPRMBzY3cU7agpq+rkEsmcYSIh8gBSL8bAyyz06SJV9mZNvwHVbXqY0q1SQIOXihZnwhTCA2yFbSN/TZP9gUU7HIf+DDDmVc2Mre/Z6dC+Zqu6sKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJDIJHSv8NNOP6rfXrBdJql4WP3ft5kHjqj6B/Qn/eA=;
 b=QmG3G1pNRTixSsVntznJsuUVnl+TxVW40WrVF1hOPHfxaEZVmXankIGzNm4tda+p24WP18CfytUL8qhOlbc25y96ni4ZIOyH4YCogag2f6iPw5HYn4Q1SFuan3gJc44wBwV1TmO4cHnYG6nCyeThY9uK96LB5GiUheQJToUeY/Qe1QDJLm3XiqKD3vSxAanPuxzZj/Z1CYmUhjIBodvBiKNd34TvDpYiYtnV5PalNpHPbObk9HSpssQxiJZxfJuohTXuLD+5uP6c6d5lOi3I+zTUHGtn1aezQHwSiNzkJcQve/z4R/PalbWAdRx70eJ0b1ubnIXlnvQ0R1qL+N11sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJDIJHSv8NNOP6rfXrBdJql4WP3ft5kHjqj6B/Qn/eA=;
 b=QKDribCjN1qpZRV20wOmZLh+LgzREjBHdYGsI73of3bQ/yNEiVEKSFQsp8ieXzr/TQoyKAKo6N6tSuYSKYxopi6WXBqAtis9sY42qVyzhlqJgxt59D++5+l60MldX6Xr7izhn1HKY65SDFNQxh/CPtM/kRQmvEK7ykdrC9Dwn/c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 05:06:33 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 05:06:33 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] clk: x86: Change name from ST to FCH
Date:   Mon, 20 Jul 2020 10:34:57 +0530
Message-Id: <20200720050500.23357-3-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720050500.23357-1-akshu.agrawal@amd.com>
References: <20200720050500.23357-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::16) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.171.179.172) by MAXPR0101CA0054.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 05:06:31 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09912e63-f0d2-442a-f866-08d82c6aaba3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB18533B55F03B33A8F0A547EDF87B0@MWHPR12MB1853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKJih2QK86hLOjpv1v/9AvRo44yjvtQoycKN1KXCohCh5DCSn5svcDszc5Hlyq9wUmvmLM+vh/CkvbButWkRwWQVQqgOGQQOYKoUCSSMTtGixqrY7bYYhdSabRivgRTWx2/uGzjMt6b57kQ5YZ/uujCJw1ZAfwrEV4S3/4QDc5inUOyXRylqB6Z97sJ/2/RecEiw+njhDjO3Nx2XfADdT7qubjIlAT5xHYtTXPLkKVQmsnjsyoTJ0/BLvcs2f+Iz4DQfoIer3btySM3j6UlZcw5QiERRF5N9Rh4qaGxM7wJmx7/m+wsXpK9hwl683/Z+pW01wbzkJJ4ss0thllvCrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(6486002)(26005)(36756003)(478600001)(2906002)(8936002)(5660300002)(66946007)(66556008)(66476007)(6512007)(6506007)(86362001)(6666004)(37006003)(186003)(83380400001)(52116002)(316002)(1076003)(956004)(2616005)(8676002)(34206002)(4326008)(16526019)(44832011)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nGqocgKNWHcAuHoP1uKQVqo0/lKhuB19a11FZ1IWtqSlxBc6o2vshrMT/Zijc/fWQO9Cv1wBh+foz00Ripzx3raRFZVfAkXHs+sxF6yj4eK+KJ9JYTuwQaf6wk32s9wV53ygOsPuDW9lXX2eDTzZ87a17WTD9HpfJUoqCRokslBbJBpMH7kXLBDcYaCXOnDAdw/LEPc9I3LcjbvqlVL3mu0ItmOW7rMLrx4kRoypbQkVjbaPEdYd8DCC98xbZ+90H202xGIofOWnbWtkNjWXoyY7SUTC3tHQNXzfw2epGhl9E/5oOUWsXm7AmE+EYuhxNv6QI79SHIqSaRP9G9eVI+pLoqUIFwho76kG5QJjPFeNMielcS3kDfdEJtTsfSgirY1EhD3KKfTt+ADp91gGR2WOnujoq+Hc4bmRkRKjWiillyOS0lPxUDA3B0q7hyxrld17ho7bY6Moq0FMWKJEF3WjH+e8PWihJUXZdL/g3GA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09912e63-f0d2-442a-f866-08d82c6aaba3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 05:06:33.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plPVgy++wDQzh2AmqGbJd+N2p2/v3VZ4fOs8dTcf1jkgEFc9c84PRJBUxWoJk0loIW+d0oS6N75OOQaaBIU9pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1853
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

