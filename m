Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A1BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEB620708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YCcrzksE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGGKH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:07:56 -0400
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:13793
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbgGGKHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:07:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVTlIcOoWG1L5Hz+ViXtGiyrRyQW6HYorHCiEADpX3RnETN4wGEXREoKult+LUBv0qm1c+4i0cFI5J68ZOwgxc9DGuXVKBDyUp8oQ8VXP6mVHH2832eVxPUYUcMOuXTlEDzRsRqDNtZjWxFbPNsbkTLVEnYq8tPQo16NL39ZqFSRzI6jziGCL5t3FEgxa2pu7B35dKd2Ugu8T1hzwRiIOAFwCf1LJ8H63v4wfrShT/TwtPJ86iT2WPqKVLRWVwVkJkNSzxQ2zDVEVdc+Jwm+AeF/BWema0XyVEUDB/3JOEjfS0h2u6FK+c/a7qUxT41GRMjoKHrbtAVem+OtXhpCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUlg9LAnKOuYAEeVjzt1tHJTm4OWi0Ey3PoRho0Z32g=;
 b=SWQ4jGjRgGUOdJdHKrb955a4yW3U5UNHOIMfxOf6iX4GiE8N9P1NFCGfdEO5rSlgYN9tcLwm6U9JWUY0Po4l8oqmXJcs8zsdntVapvxQImC3lc5eikZKxE8U+rYlPRj7eIug3Zxh4VIyrt6jrh/Zejh6/ZZ55tuSjAGl5VHtgLYYaAHgcu44CG1+1A2CbcbipNw0AsaIBOHJ4HjzZqtuLXS4Vf+neYN8nZ55G6hi19seKvMeAx3ukH1pcvj91SlFaP0fsM6T2DneXEIGfYHWCf8dQRiMctfxgW45IWGv+glG3grj4ruStHj39rwLe59q6DLOInpl/2O8g7MXq5PV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUlg9LAnKOuYAEeVjzt1tHJTm4OWi0Ey3PoRho0Z32g=;
 b=YCcrzksEQ9wfJ0GSFchoBXGm4fhTL2ZJE7mscFKt4UpDdbg8aUqX/N2Rfm+LS/+4AyBBd2XH/QD3stTsTMH0hLsBv3ooG5qf9Rv10HBWlCYeDGuH+7BDchdmexsENtwGSyHRo9FIutmc0gR5XUXOdiEbltliittbGPAtc/knA+Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 10:07:53 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 10:07:53 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] clk: x86: Support RV architecture
Date:   Tue,  7 Jul 2020 15:37:00 +0530
Message-Id: <20200707100714.24720-2-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707100714.24720-1-akshu.agrawal@amd.com>
References: <20200707100714.24720-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::27) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from akshu-HP-EliteBook-745-G2.mshome.net (122.167.38.75) by MAXPR0101CA0041.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Tue, 7 Jul 2020 10:07:51 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.167.38.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47dd5ec8-41ed-488d-2971-08d8225d9c77
X-MS-TrafficTypeDiagnostic: MWHPR12MB1440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1440FE716ACBCA5D6E1DF399F8660@MWHPR12MB1440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyO2/vXe5kr9aDMMNr7chOYbzE7mTYliWPTC7EYVO7Y5dy06jG7bBZenMXvc3sKQ2jOPaBQrdtFyrOmphGKGp0XP/n8jY02UJwxiuZAmL9cr9oQrevUTiHg1vmueDxaYMSExMFqty5uv4oSGKo+wMMH+jp1cLRJK4GqdlFgK53qWZlEJoThoY9FJVI65+INMwN1Xaqvwfp8Y/k00dqDa6CV5qM7m0B8EXFC1psgQxP/bH+cAEzPnQRt8tyw8b2KQd4HiHDC82+p64GTJ9ABvqE3WPETFQNDH+e8J/4IG3rxixCQeh6yLJZegduX7j8g0EuQ2x1Ynxc90DyuLvvMQs40uC/EUk6gf8BdQWkmE+4eUjz3fAjTYsdbyzhPlBeWLYgEDVEgV54lSbopVYR8BRLmPbgIHrJSEUsCADTOBBsFplymX5V0wQG5I0N7PRR2W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(6666004)(5660300002)(8676002)(186003)(16526019)(44832011)(52116002)(36756003)(4326008)(316002)(66476007)(66556008)(6486002)(86362001)(26005)(54906003)(6506007)(956004)(2616005)(8936002)(83380400001)(66946007)(2906002)(6512007)(1076003)(478600001)(109986005)(966005)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ygY+16ecpob4Bm2/9KbpVZmXgOa7g986rDo7bVhAU6wotBEH+r+jb/N+SMmn2gxPmQMixM80LAwkoC3FbwlmpYzoEL0GJtyP8QVzh68s7bTL2rV7oOYCZtlHOZf96uJu83ncg2ouXQL0hZ/q2kjwV+IcIaKl/QbfngtKfpkP5gG7UWg5iDzRUTD+/hlG4Ax0HzMAKE1afVoqIgU8WMiVFbauGYb4w1X0geLlkAC56Gq2es42lrpCpAL/jyLwWRRnW4A+65AqMs+AR+JMC4vnOru/kNNLBp6C8vtNNvL8TXZYJHvGh0KRnrxNyjYPI3Gn8jQwuGiaD1e0+GhV9Yj7KLPL2XAjYAVt4z4VcY7huUpqKeJNVHfE+7YJLSAqGc9+j7qxLUFRVy2+hyQIra4PaH8a8OxPMuWu1HvFnOGEo3vTL7QCqlhUPHEUWvIFkFcnErFKZkkesH4kbRF0WLferGWmCB4yd+Sn/kdI6p30/y0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dd5ec8-41ed-488d-2971-08d8225d9c77
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 10:07:52.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlYH4Zq0UZ7SamOnb2T1RTO3U0q2wXW42VOhu2/GdupUGXPk7JhGjGrnPBBkXR9Vj3/FTCWajeQgInzRVUrQfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is minor difference between previous family of SoC and
the current one. Which is the there is only 48Mh fixed clk.
There is no mux and no option to select another freq as there in previous.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
This patch is dependant on https://patchwork.kernel.org/patch/11648131/

 drivers/clk/x86/clk-fch.c | 55 ++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index b252f0cf0628..a8aac71a3b65 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -26,6 +26,10 @@
 #define ST_CLK_GATE	3
 #define ST_MAX_CLKS	4
 
+#define RV_CLK_48M	0
+#define RV_CLK_GATE	1
+#define RV_MAX_CLKS	2
+
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
 
@@ -37,23 +41,36 @@ static int fch_clk_probe(struct platform_device *pdev)
 	if (!fch_data || !fch_data->base)
 		return -EINVAL;
 
-	hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
-						     48000000);
-	hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz", NULL, 0,
-						     25000000);
+	if (!fch_data->is_rv) {
+		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
+			NULL, 0, 48000000);
+		hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
+			NULL, 0, 25000000);
+
+		hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
+			clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
+			0, fch_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0,
+			NULL);
+
+		clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
 
-	hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
-		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
-		0, fch_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
+		hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
+			"oscout1_mux", 0, fch_data->base + MISCCLKCNTL1,
+			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
-	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
+		devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
+			"oscout1", NULL);
+	} else {
+		hws[RV_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
+			NULL, 0, 48000000);
 
-	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
-		0, fch_data->base + MISCCLKCNTL1, OSCCLKENB,
-		CLK_GATE_SET_TO_DISABLE, NULL);
+		hws[RV_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
+			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
+			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
-	devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE], "oscout1",
-				    NULL);
+		devm_clk_hw_register_clkdev(&pdev->dev, hws[RV_CLK_GATE],
+			"oscout1", NULL);
+	}
 
 	return 0;
 }
@@ -61,9 +78,17 @@ static int fch_clk_probe(struct platform_device *pdev)
 static int fch_clk_remove(struct platform_device *pdev)
 {
 	int i;
+	struct fch_clk_data *fch_data;
+
+	fch_data = dev_get_platdata(&pdev->dev);
 
-	for (i = 0; i < ST_MAX_CLKS; i++)
-		clk_hw_unregister(hws[i]);
+	if (!fch_data->is_rv) {
+		for (i = 0; i < ST_MAX_CLKS; i++)
+			clk_hw_unregister(hws[i]);
+	} else {
+		for (i = 0; i < RV_MAX_CLKS; i++)
+			clk_hw_unregister(hws[i]);
+	}
 	return 0;
 }
 
-- 
2.20.1

