Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8D0C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F462075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nBWYF2/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgG1IaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:30:19 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:35296
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727808AbgG1IaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:30:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiKmIvTaRWK8JMIewC7/VG89Xu6HgknsJ3ATvWFgGEQlO3qaJdWcFK9mkReMW7He6DGZ/jEOtX2/EBKPXIcWyl038OEuFHsZEnxPwAe0Oa1pXSyv4aFqcFh6Xa5Yze9E+3F5/B8xvvfOaA86vE55MVA4AO1eBqzjqQlOqYO4YVbFBH3XQrodeHdbRrWjBeZn84cQAFXEgYNGTpW/3XDX8uALHdzpslAW5PZtGkh503IIbSWxekOxuUixtLLHG8bIpSa+mSEd6duoVjDqlQNWCkq+ZOmwu2OCR30hQs8xlduxSS/lmuG/+FdLArpHhcZdEVMU3Tyvb/0FcgiIr/3QLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05udcu8xEzCROjbuKNoBGm6oxaG3BtEwzx5l3q/wNd4=;
 b=mrb40rfdEWziTJHUJdGmC+6+hXeCm3HvRCCTcY2+Z0rcPjqUh+lVsxmCFn7ypMsAOPQtwiX/Y6fmevAtKxlrhO3kgIc5KO3xFDkFKMzjTrgvUd1Qqc6gOFZVutE7ZE0ZoS2YEjNACQjDtY/h2gXqZp9T0o4X03svEGFE+x9Ee3J3l+jxsVuL5o+8/IyJ+iSdugsG15pTAghKvXUXmTwgBlltDK98EgQ8yXA0o9B/gusoAB+CNgKzXBAvm11/RiohVLeTjwW/3cb2OVTNgdepQ6OjlzgDjNpx0iAADul6kGBUIhrZ1aDxpIWLzJ+snrlR97WtsoXIF3fA8valMXG6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05udcu8xEzCROjbuKNoBGm6oxaG3BtEwzx5l3q/wNd4=;
 b=nBWYF2/0mBSw3TMxE8WttreJ+s3eBIcxYXWPc54OpR6XnC0DObOOOZZWMyqT17xKN1Sl6Skag4bmLnenSYIBgutlzLBXchs2Vejc7ic9zroNIzykl5YEt/oMxwkzMK2B7mGOqYNTqV9sNvrxnO/Lj5Oc8KHpdtCK0OZkNezhjQ0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM5PR12MB1468.namprd12.prod.outlook.com (2603:10b6:4:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Tue, 28 Jul
 2020 08:30:15 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e%10]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 08:30:15 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, rafael@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [v2 2/4] clk: x86: Change name from ST to FCH
Date:   Tue, 28 Jul 2020 13:58:54 +0530
Message-Id: <20200728082857.10829-3-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728082857.10829-1-akshu.agrawal@amd.com>
References: <20200728082857.10829-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.171.179.172) by MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 08:30:12 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5840aa2-f677-4aab-269f-08d832d073ef
X-MS-TrafficTypeDiagnostic: DM5PR12MB1468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB146812EF76F553FE282F2F6EF8730@DM5PR12MB1468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/abSDiEZluS/SIyXd5w1oVh0YROdlBHlzdig9fLG0GwS9c4Q2rbZgujZx/ufTw0xYZngn/I7ypKLYDQObS764/GdJyjliNePN/8sexWMSruFHJ5YIbYSWpkofyaXO9mahP6J5A/khTU9/FRNtS5GwBKXzVuGzKF43EjETXEo0h1hmRYz0Uw4zDNm563cjk6EPL/8dpmzqV7HCnJLpGU+uR7vhdW1McOZMc+2pwdm4avv3x8qh+iyzptDbUKDzTFXUf9grmoi2wUBmmugjbtyGvUuKkk5M8DMD+Lnhgks8/98/yLY+rcHw4K7907YDrrqGEpb5/f+FUBy1nXOA7epQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(956004)(2616005)(8936002)(44832011)(5660300002)(36756003)(316002)(6512007)(54906003)(66476007)(6666004)(478600001)(34206002)(37006003)(6486002)(66946007)(86362001)(66556008)(26005)(186003)(2906002)(8676002)(16526019)(52116002)(4326008)(83380400001)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oJ42tFrwOycWO4x6DzXj7GZeeWShXcqTv8IHENCHVdHl3UgxM5lydTbJkc2hTLtf95cRORIG7x/ecEZidEVNSAiIFrES35QPawhZ/ncKeDC4yF4z88wlwpDG/6kzJWeG5Cndrkd74nqZiwXExVg7PwlM07ERTFnSQZwwC3lJQkquoB4Sr/uUgwJPAeRr9w8vj2euEALBVN7ar8Qlk3rub2TcK0S/1jyW98ffP9GRrFN47xCVd9BdZnWaRiWYp+/3rdY9vvTsiYe4gxSEqolltAiGwdrs3MItCw8p/lHRIGQd160VJmhT0L7wkkUoJqcXShyMdzOVAjJsEx8FriZ5mmDl27ZaFIjR5laHbXfqebFqCg5r2ocgyzzWj27JLyES/+iXjSo2KgyEpPIptmFFXZZtvdZbPF20Fhed1sYpHVZHrbxGS49u/RIprxWRFuaCb3cwarhtgSR6wtGttfZblPu5CnV+6wIvqFFqn6D/3uBtaKXggJYlx0UzzlM/jgS3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5840aa2-f677-4aab-269f-08d832d073ef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 08:30:15.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fREjR4b+aBfIooTCXbdAAiamRbYExZdO3NINyGeK8gYI8Kl4YZZQfxTT1pErzm54h1kn3//H3z3nCIfssWO6Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1468
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SoC general pupose clk is present in new platforms with
minor differences. We can reuse the same clk driver for other
platforms. Hence, changing name from ST(SoC) to FCH(IP)

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Moved some changes to acp:apd patch so that individual patches
compile

 drivers/clk/x86/Makefile                |  2 +-
 drivers/clk/x86/{clk-st.c => clk-fch.c} | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/clk/x86/{clk-st.c => clk-fch.c} (75%)

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
similarity index 75%
rename from drivers/clk/x86/clk-st.c
rename to drivers/clk/x86/clk-fch.c
index c2438874d9f2..b252f0cf0628 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -29,12 +29,12 @@
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
 
-static int st_clk_probe(struct platform_device *pdev)
+static int fch_clk_probe(struct platform_device *pdev)
 {
-	struct fch_clk_data *st_data;
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

