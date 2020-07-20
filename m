Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E78C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B78207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gD9AdZcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGTFHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:07:00 -0400
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:46049
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbgGTFG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:06:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpV4f5s3QSAuPU0j84pWVdYU33H31nv9RTrOZpuSJREJQkgQVLaB5LKiUEd/6bCcvUp2RHTfSnAM725cni79pj+ISGgBJq7HMCRlIgYrbaOjBBAFTUO1BZ5ROfR/1ikw6J+cphY2J5qhzOhfAMd1gnyvdOSaKHUGUOQE7m2lo9MzUzKooVfN6ooEVtObNNU1HhLLlP2P6v6TIOHCCHPlFFRtpT8prcyIykp4USLo8LulcTePaAaCnO1kYcUV0DvgWhKYxTLjTQdq4mx5QjTyZuj7gZsZTp1fqAU7Qe1I+JfkjXXJ7wvUSeQbokczJvqFEH9wW1lcsNSKRuDdFZAX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twvrfswfDYU6++VZizB6yPQWICq6rL1wnHe+si4wPD0=;
 b=YmDAWr6Ihp3uPSNAhkeD8LZLMr4icY+2gKQeFecjffu6mAsdMLDSk0ZWTnUEfAa2IDVuYhdkKt5k6h/7gBT92AdbKq9gBWds8o/zJN/prQ4DmuoaN82F4aq/qTS8+4DjA8Z4atPX7fL32kiShHWGqCXFAMlLGj5DxNtsTEkbGL22pg9FYZSXSVvoxYALRyU+tQLWOquxVnkTNijOY0jrrXDxmh8VuUgK23ATMkLyxbG1pXUjpHkSKpuqJz8l5p355CuwsicMAJtGrlG2OtR8BgrOpFCOBvdppSvqtovEZ9wtVpFWK8YOPUntvxiG9+2egGyKXKDQvFHwylu4VV79wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twvrfswfDYU6++VZizB6yPQWICq6rL1wnHe+si4wPD0=;
 b=gD9AdZcWGyxIzHVbL7puIZ2HLAfM342gWbfv4x0nkVpnh+4TXHFBGSOsh46GDBE0KZAMrRwB4h/s8WO1zbqfQWRnHHu2p028O/LhHyEFoZF0TxhTAF4KYaolj2s6X1X6Jlq+5NmOMLr2ocGY+HHx/tv+jeVRrrCJK4LfLcw6mBE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 05:06:56 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 05:06:56 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [v2 4/4] clk: x86: Support RV architecture
Date:   Mon, 20 Jul 2020 10:34:59 +0530
Message-Id: <20200720050500.23357-5-akshu.agrawal@amd.com>
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
Received: from local.mshome.net (122.171.179.172) by MAXPR0101CA0054.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 05:06:54 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7198c5b0-a6a2-4494-f77c-08d82c6ab95c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1853CE0FABEAB3E4E9DFDA37F87B0@MWHPR12MB1853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4omR5Dvh5uyUxh32BVc2xb6WXcHwP4qoRRaqlEG92AFWERJwwpiRlyUNlc2QcBZCOujyNfCN3/T0ec9wOWIIQbVzWOAd9Yx3nR0nhzlEAYq4CEdxwe2UlGiLGcv03SQuAGB0auHRCio5NfTvbGmcJpRfw3GQAefk5JqBQ2BXvgr9yc4Pd0AnfUZGiTaOnik0XWvVUpyuAv4g/ucuwodFq4JS5+Klszo3Iwn16qoYqzaKUKPKxqepDh/nDhdyAg0UWvomNTAhM2Le9Qr4UONTuadnkcb5EwHFR2YQUBDnHem0kz4g+KFxlvw5rg3HGPUQ4Waz2bnEWQ5qLWV4tNChQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(6486002)(26005)(36756003)(478600001)(2906002)(8936002)(5660300002)(66946007)(66556008)(66476007)(6512007)(6506007)(86362001)(37006003)(186003)(83380400001)(52116002)(316002)(1076003)(956004)(2616005)(8676002)(34206002)(4326008)(16526019)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gyD/OV5XGsHF9HBll1DCUMMnwCjRTH96m8969/+dt4lo5S4zLfvSytTVl3jHCFjsx1SixVGU+MYQAFs8IvABaYkxjoiOAU8ZDKWUg9esn1t3zEEcz+RqCETJ1bFsMB3W2/fvDegbMLQLEIVf7hzDkZzEANa9GvDtDxT4rkWrBqWKFbTt4UtcpkwgCE1UQ/a2GxkWOj6Ou7YTn+dJ4MfIAZlfMAmlF1mw15Jj/qpFohNhfx8+NfjK+MKZqSG0o+Yy1MA42bNLmYAuPcWDunPo8D4nyUNTQmcdf1+ucfGbb1F/y5TsYBBnxJnqhuFwUqtbd3/jI3MRKXJiyS7S1Ih8dN7gefIro2rFreSZwIJEuJ+9DZzrYkuruXPe21go883lI9wORHvXVqqXPmB9Kd3u5+xArIAENZGqUwzi7FhsQX5qL2G5L9B86nMKQV1maEExWWHS40gMBaGxxaJmvcmQYHiSgTtyjWbhc4/QUZ76kf8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7198c5b0-a6a2-4494-f77c-08d82c6ab95c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 05:06:56.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjZQAt/4/2IWH1DpozrGllE2S0grJGbDR201SRrAETNzt+W/7aroXT/UBHYDrfBQYRSQ8fF2SoJzFWVB9ZBzOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is minor difference between previous family of SoC and
the current one. Which is the there is only 48Mh fixed clk.
There is no mux and no option to select another freq as there in previous.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Consolidated the loops in remove.

 drivers/clk/x86/clk-fch.c | 53 ++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index b252f0cf0628..d68bca7b213f 100644
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
 
@@ -37,33 +41,52 @@ static int fch_clk_probe(struct platform_device *pdev)
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
 
-	hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
-		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
-		0, fch_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
+		clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
 
-	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
+		hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
+			"oscout1_mux", 0, fch_data->base + MISCCLKCNTL1,
+			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
-	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
-		0, fch_data->base + MISCCLKCNTL1, OSCCLKENB,
-		CLK_GATE_SET_TO_DISABLE, NULL);
+		devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
+			"oscout1", NULL);
+	} else {
+		hws[RV_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
+			NULL, 0, 48000000);
 
-	devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE], "oscout1",
-				    NULL);
+		hws[RV_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
+			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
+			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
+
+		devm_clk_hw_register_clkdev(&pdev->dev, hws[RV_CLK_GATE],
+			"oscout1", NULL);
+	}
 
 	return 0;
 }
 
 static int fch_clk_remove(struct platform_device *pdev)
 {
-	int i;
+	int i, clks;
+	struct fch_clk_data *fch_data;
 
-	for (i = 0; i < ST_MAX_CLKS; i++)
+	fch_data = dev_get_platdata(&pdev->dev);
+
+	clks = (!fch_data->is_rv) ? ST_MAX_CLKS : RV_MAX_CLKS;
+
+	for (i = 0; i < clks; i++)
 		clk_hw_unregister(hws[i]);
+
 	return 0;
 }
 
-- 
2.20.1

