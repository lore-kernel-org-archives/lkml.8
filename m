Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938FAC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB802075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s1HEL93e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgG1Iao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:30:44 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:1953
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727808AbgG1Ian (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:30:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReKViLx6KfOzj4THm3APcQNSeq+TTxW/rlVwwEZIOjCW8A4+akttKwwM0G5ifLbJthgBe6NlInQQ42aUDS/fNA9zx4M3C+QGnQf7iLdDNgf828E1bTn2d9hCIVUAcVuUzJEsbOoyz0cT1t4zREm5MPMWW+hwjSF7/4kNTsUdYGZUePLKXMXc31eroWncJSRCrov2eC0QLpXldkphldxWOTICN1NtAHIpGcy88ri8ZEUuJpsXzNbwSJe5IoQlOXrxxmDhtXPGjJovp83PyNG0PsftnXB3ToDKiGlgoqgVSJMvcHFC4jE2D+Vy0xErdBO/lkYDNX/EmSDKMgZcLwkjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJF4nmMrCimFmSbEujZe47VpOQtYz+QKdoxLdXMbvgE=;
 b=A0Oqn+c5UAY68Kz+5XOwHRqPIWZglkGHRj+fYmmGSCzABL9cBhOd5mkljuBpbeV9QvtduAyqg03ngZgTiU5d+Y2j5hCOZ2MzX8hChXmMrB9OP/MIG2cx2D1So8Joe0Gk4BRxsEwLG8YlFOForW6YmvapdL2Z2zuhHtL8Rzb+ODLsl11FvXuL9pho5IHc7klM02N2gpHw3nfRy/3Cm1qaOK6jQGmaYu1pOSNn8/+qQ0iNnKj1a+AXsal2xBOSh0eqKCSPWELwXBAPhzN68U1b7DB23FRuX7FqK2q+iiH8G/Q47cnSmW95wuOMwncsspqlCCXziIPwSOaUVIIcxFycJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJF4nmMrCimFmSbEujZe47VpOQtYz+QKdoxLdXMbvgE=;
 b=s1HEL93eCs0w84u51Nfo2SgjHfMLCcSREpDqPuVBnjFuYibkxNWQaE8U4Ar8vzSs6DKHZYifJ+P8BbEmy4vFCtDdz98MWXlwF52xNNOto/DYrdQ6djfdQWD6XIuNVoKg8013+T/CNcEfbFnv5NLk3REwZGsCE+tDM9xGqqZJLz4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM5PR12MB1468.namprd12.prod.outlook.com (2603:10b6:4:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Tue, 28 Jul
 2020 08:30:40 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e%10]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 08:30:40 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, rafael@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [v3 4/4] clk: x86: Support RV architecture
Date:   Tue, 28 Jul 2020 13:58:56 +0530
Message-Id: <20200728082857.10829-5-akshu.agrawal@amd.com>
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
Received: from local.mshome.net (122.171.179.172) by MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 08:30:38 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92d94503-5747-4c53-0d24-08d832d082c3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB146849EE0457DBAF65C5E97BF8730@DM5PR12MB1468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPqhn2Sw5TCjiK94ZZAsAR4aC+FmIJbchk5PU7pT/MAINVkY0nL8SdqZdsvpsLtDwtK/IglU108Hb1T8WpfNqvKqym+A4iovY936GddfxaBfvYCj1pV2i5/1Wg73bBUd1HVEKTatl1G3I6qp7c3ZmpJodSLbC1KByUKH6c8gjgD06JOem3H4t0PbzP78W5OX7N2OWhGRi6frkjx8QXr/I5eis/IMlCpiN86rWrqK++Xyshv2Z6YewuWinxT+hfadif5tcXQmzNE/8/P35h6sTX+1nNgMJzoBPKgzY58+metOwdhQksG93EYyTfTuL93FRXvTBDo4nhCb5suguqaAcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(956004)(2616005)(8936002)(44832011)(5660300002)(36756003)(316002)(6512007)(66476007)(6666004)(478600001)(34206002)(37006003)(6486002)(66946007)(86362001)(66556008)(26005)(186003)(2906002)(8676002)(16526019)(52116002)(4326008)(83380400001)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SlSXSO/UbQowtsdJcv5NjsMW7DqaZ1snSQAXzPSTNk+3jTqVu4D14RGPBHqwB6MGrp6J2yRev7F96vjt+kVjl3tBmtBtuL0w5s7jakwj32ZRbsU5W/3DsO7W6ilMCERGoTMBi1SmSshsuJhXX01tLQcD2dRLj8ZIP+7ypBm6XgqzIlBp5rXEwK5XrKr7VBlqjrsGpLSLH/zrHRtYjVLY99JeVuy+Dx7tzTv3deyQc3gKy21cktfert7zubcp4qqbGl+e3u1lnVF/HQkqZJ5FlvBeFdYGHtFAvIfjGLS57coXALEYlORDzHs0Lyq3k4wBr/9ckMuPJwDrdonQiN2OLUtRwLIP3hov0RzFyG3gGrmosZQqbPc7nRs8Q61M0L7ThcKek1zKcIqL6ahN+Dr36fiIJU1CGdCPJOcfcHQOvv0jMfgkt+4OHfDyVRjrCVNJLKya05N7MyKcGyPbztq1zl1aio6qPw1lDc66lFLb5dg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d94503-5747-4c53-0d24-08d832d082c3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 08:30:40.5480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73KVX+A8h/+XMT7IHBtX/iKMj/cI+2RPaevSQcpQHfkSPHHQfS7wmdndeU4tIt6ysfQouWXlLTBnTuNtgscKfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1468
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
v3: Removed negation in condition to make it simple

 drivers/clk/x86/clk-fch.c | 53 ++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index b252f0cf0628..8f7c5142b0f0 100644
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
+	clks = fch_data->is_rv ? RV_MAX_CLKS : ST_MAX_CLKS;
+
+	for (i = 0; i < clks; i++)
 		clk_hw_unregister(hws[i]);
+
 	return 0;
 }
 
-- 
2.20.1

