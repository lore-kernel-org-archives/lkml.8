Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F35FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072F0206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PRBN4Jm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgGMBCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 21:02:22 -0400
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:43169
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbgGMBCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 21:02:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhp/BNkufHMCxpUIy6t/aIl+8wnU3B+Dcq2Di1OnocFjw2q8GBlGGrt+FnO+Bc70Oj/u1/6Uru/ih5WpgwWMbpHCqp6GQZh05++mkyYmc+B+IPo3aLAc9RozS0EcSrjDa05NBbGI/TLnQdv2ENeNDTLa2JbEODz26R456OA1k0PLzchXUPlJ1u97K1BkZkez354SVYo4lXVUxjfbvZMrg8DekzWUMl4HpsSrRxkfnMe4v4a6zKZJmkxj9Eg6KqJ3tPzP0maEbiG4GGJ5RVwNQpocWselzb7V1ciIvR0wwCth5E0aF6EJjFg/aePtmsnAkYakGluDdmgXWBmQXYyYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RXym5GdcMdYlUPqs250F52UawgGfJ5MNazCXgGbSvE=;
 b=UwYeMVu8Y0nl8lzL6S+0oy5ht8tLbuEt5wHO50l9btt7xSrfozlI5S5D9reaQ9fY26FNuyN4lPyhL2QNbRXInaNyc5QEpVSylEOrETgUhgRdbBNfJAvn6TYou5YmsV+Vg5S49oCYZf76iL8sEz0nDRF325gvxpqhas1vjWD5wpDAL/l7KWBY8HZ8bhl3jzx/yVVPpkq41fV52vMPMgWx2e1PfMRvZBLf0qvwzmChgqpJvXmohwMWS6ng6IBz2FLBNdR1lk1v8MBgFHcJrJdprzIafUzd1dnd/IYCJpKN13N/f0i/lfOAvaBSDsMALjhFmAxwEoaL7lisDTao20tj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RXym5GdcMdYlUPqs250F52UawgGfJ5MNazCXgGbSvE=;
 b=PRBN4Jm0dKQ6I8ifR/JDpAlkvNxubrR6Y1JxYrMiPWyvWS0+pnuZd7Njou3t2sBq1hF+SqN+Os3DTMzjghPU97EUINUnwsDRl5l6gqAcgYUuCVd6Jpz2c54lz9emwKVHYDziSPl2WjTgl3VpGcxh5dfZjJX5X8T67Cn3iiwg/FA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1600.namprd12.prod.outlook.com (2603:10b6:301:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 01:02:19 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3174.025; Mon, 13 Jul
 2020 01:02:18 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] clk: x86: Support RV architecture
Date:   Mon, 13 Jul 2020 06:29:52 +0530
Message-Id: <20200713010001.18976-4-akshu.agrawal@amd.com>
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
Received: from local.mshome.net (122.167.38.75) by MAXPR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Mon, 13 Jul 2020 01:02:16 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.167.38.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8bd550f6-776c-46a1-40d1-08d826c863e7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB16008EAC02C8A1B14BCFD462F8600@MWHPR12MB1600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deGG4i/RxM0Ql5SNaJbflsxiPyZrfrg/WTBAI3vR7GFyzihNU69I6Y3w5U4JorIW+uc+GU4L04QBTz5ldoAVhu8r3EJPyIJaLpb9uwQWppkTNJ7pCGULWSSyZToZDPrjxWe9F3X0GpOlf8GZ0Nq5xLZ2fKAQGEoZVE38HOW8Dxmnrpw/tjVPuGBUBMzGvFhBWPcFZivDz9to/iJ5TIQiz1bdouMP3VpjRLKAPEOypyQAOS0QAk4MNUAAPalwzjAAQgeBKtvUImX02lLCfxP09zlLLuj++mXv5PZ9bL6/7w44fEkhXGXyqGuKhQ0NuK1Rp0y3Ak/aBAMa7IsfbEJEJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(52116002)(478600001)(2906002)(1076003)(316002)(6666004)(34206002)(4326008)(8936002)(6506007)(37006003)(5660300002)(186003)(956004)(83380400001)(2616005)(16526019)(44832011)(6512007)(36756003)(26005)(66556008)(66476007)(86362001)(66946007)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: o2rtTkqxj44QJBPPxf0dGapEfhMLZHH1p+8nsMbSxr4MSZysFFeblhcxIYZSYrQCVBDZwb/qGIvakzyRtzp1eR0E8i0Y2i+Zg+QyZz6cqgYvjsPph7qoKd3YtjG9+AoAjVqLkbRiAZFhX63Gbg2rpqBERvGsf7LgwG14JobtPfcwqQ6KEGdZ3G6mc/eiEfAAqNbyBAT8B0/QxaOvryebIVGwN0UynTBs7EKCsqRoAoA54ZtLvb6yIhcXqTvOZhvXhF83SXQZRi+88dguw+kW/quYYxJ0qzUsHECvkpVdHuZFGPicwen8WC2WMG1yYPp2kqTbiaYTgdTylePml7wjaOjFwUsB7ffqC0w6F3TpGPGoJG1I3n20iiuMJ21iKxejynUkQx7B5yNQydrMvvCg/+VChX08xvGoKUyMzFAtS+Wx2W3adFkRLDKflfEKuzaiNAb2IkLxvPb0ejd0y8s4oAEucFgGkzkWaDRmGuDP5lg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd550f6-776c-46a1-40d1-08d826c863e7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 01:02:18.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecIDYDnpOXfFfOgj6B76hJRl5YTZ65SxgONBYbwgbBicYHYiWxVX75sAlxh9nq8nL3Ma6Su8f/2HY9Id8f6PgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is minor difference between previous family of SoC and
the current one. Which is the there is only 48Mh fixed clk.
There is no mux and no option to select another freq as there in previous.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
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

