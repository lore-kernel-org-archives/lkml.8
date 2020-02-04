Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A925C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB49021744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mQI/pCcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgBDNl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:41:28 -0500
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:46830
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727369AbgBDNl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:41:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikNl+ZG6DjqdKfvNr9WmM/VSQzCJFnhFmB7LjW7ELBbCN/p5dDbXNRxCDIrevt35ojqGOky7TH2YM0tC2GpWTyij5+Af2ssdxHKLZEZcDhsDlNJ5N9hCRsJGQywuYOX6aWti2NtDeDcf4mgvCNOxDC6FgaiA7VelgMk/RxlG+yXVrLl0Rcu5JZTyCGVh9Tnr80wAt7mf+L8R2eb/jwjEjapNeaB3V0FQ0GPhXbN7dskKSTBl5w6sD31XUewYM5ig9aZVzCAqqOVHIl8DMlA+cOfV9PLSZkq0FCF1kV3QViFbZ5tmAxJw1KZEowWhqUkG1LttU6RHhN4ltf5ls1T4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwQeBUQfJB4vEvPaPWLOwmRp6IYIhy/cz/rkO377RO4=;
 b=ofyvhD4Gy8ZUFnm/r5Q6xRgZAEtomK/FZ2AbjeDBhYJ+KPuPmpRdhFiZAW+b7fublsj4XieF0pAl26hraUS8FyCe/Fm0cLigFLLy69PBJbQ0dEQDMmko3n34tA+v7o6nZfst2MHu8QRK5/Yo79MNG6vIvmmFCNkkHi3lgqcPRg1vKlRqenCOmuPTB5Bp1r0BKTEhXyqFAykd2F+7kk+ySojPTrltVMFQbtU3Sg2atigYlKfpNbEKytOd8pyCL/AovBElh0ifV+Ys57tjhxMm/ut7IenTfuSu47b6TmPQbLKrWPEoFMdrMnfXl6M3ge40QCloON1EBLUfa1m7xRhPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwQeBUQfJB4vEvPaPWLOwmRp6IYIhy/cz/rkO377RO4=;
 b=mQI/pCcIkjjbfbeUOndxBFVTIONsKdmZkk7YrrGzq2pCuUPnvCKKgs6IMmR42QZ6x/Spy95iNlSvB7CGcV4XN+Qh+lePr3Xfb9Thtl2upyD52C6wOkb1ZO3mFP8dNjAhxwKIr0gywp5CLvaKVK4viZ7zpwsLcWAwLYukg6InyVQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4851.eurprd04.prod.outlook.com (20.176.215.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 13:41:22 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 13:41:22 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        abel.vesa@nxp.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/7] clk: imx: pfdv2: determine best parent rate
Date:   Tue,  4 Feb 2020 21:34:33 +0800
Message-Id: <1580823277-13644-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0107.apcprd03.prod.outlook.com (2603:1096:203:b0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2686.28 via Frontend Transport; Tue, 4 Feb 2020 13:41:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b078402-46f4-4641-0936-08d7a977ec3c
X-MS-TrafficTypeDiagnostic: AM0PR04MB4851:|AM0PR04MB4851:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4851D88309CA43C0A099C84F88030@AM0PR04MB4851.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(26005)(956004)(2616005)(316002)(6486002)(186003)(16526019)(8676002)(2906002)(69590400006)(81156014)(36756003)(6506007)(81166006)(86362001)(6666004)(8936002)(478600001)(66946007)(66476007)(66556008)(4326008)(52116002)(9686003)(5660300002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4851;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wS/WT40PMLW/HdoNw8LnyfAhXhf7zM+wr2JdCCI5GOKbb8CCFD5odz69Oc9Lu1Fkxsui0Mh0uraBR5iscqbLgk37mL1e3bAb8ynkTpXWLToiqlNxDFQ6SmSww0HATfADchNpY/enSPWcQ3Geh6TNaEPVU4xXCH1p73FwamKjXH0maNMctaI19mL1V0EQM1h2LSOg44xoylYPXJj9OSshexn29bYYZ8ayDqNCxSDmn3T7pGzB15vxVlxEty+AhL8xhCG1n2+CtQ/uxi0zd8k7H6rneFtmUd/PM2HaR/hG4gKgXvJ91WR8XlvHbABCG6u3p5u13y63nCe4Hg67X2b3pYSDrgERyfZVzhIRm9OnndnUo8bnUWvtlqXQStXcZ9TeA1LnpKrrtDAUmjhVXZY/vuZl1272wsJtFgKYDUDC5MnDi0TT17ogOecS2g53De0AFihRlmjWH1Mh1guzt1AoumWEHJGbeN/6fxpXWftABO6emCH2nRC9bSkuQW0qNdqP9Wzfn7sw9d/vb98TjyljB3SWQA4o5mQUgPqyBkK95UQ=
X-MS-Exchange-AntiSpam-MessageData: t4FMgWgD3bHDR/aKSFu2vRJ9tr3E4m1kcf7+a2HVyPhlgTrXyvwhKmFu/EssIK9RLlaCxXYbvRM+S+rbq5UTbhuOnhJ7slSlCTz/bsON/dWq2yNDz9KtaQtqTqHNFvSD6uU+wgbw+7zlU6V+nVikzw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b078402-46f4-4641-0936-08d7a977ec3c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:41:22.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D00aXIlSZ2iIlF+oziBIwyvmxGQX/GOPYzcDLBl4WT9mbCgS0Jv4NcYVGJg5i0nX4RopddjWek/D4Vy2VLn0aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

pfdv2 is only used in i.MX7ULP. To get best pfd output, the i.MX7ULP
Datasheet defines two best PLL rate and pfd frac.

Per Datasheel
All PLLs on i.MX 7ULP either have VCO base frequency of
480 MHz or 528 MHz. So when determine best rate, we also
determine best parent rate which could match the requirement.

For some reason the current parent might not be 480MHz or 528MHz,
so we still take current parent rate as a choice.

And we also enable flag CLK_SET_RATE_PARENT to let parent rate
to be configured.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pfdv2.c | 50 ++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
index 28b5f208ced9..78e1f7641aaa 100644
--- a/drivers/clk/imx/clk-pfdv2.c
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -101,24 +101,40 @@ static unsigned long clk_pfdv2_recalc_rate(struct clk_hw *hw,
 static int clk_pfdv2_determine_rate(struct clk_hw *hw,
 				    struct clk_rate_request *req)
 {
-	u64 tmp = req->best_parent_rate;
-	u64 rate = req->rate;
+	unsigned long parent_rates[] = {
+					480000000,
+					528000000,
+					req->best_parent_rate
+				       };
+	unsigned long best_rate = -1UL, rate = req->rate;
+	unsigned long best_parent_rate = req->best_parent_rate;
+	u64 tmp;
 	u8 frac;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(parent_rates); i++) {
+		tmp = parent_rates[i];
+		tmp = tmp * 18 + rate / 2;
+		do_div(tmp, rate);
+		frac = tmp;
+
+		if (frac < 12)
+			frac = 12;
+		else if (frac > 35)
+			frac = 35;
+
+		tmp = parent_rates[i];
+		tmp *= 18;
+		do_div(tmp, frac);
+
+		if (abs(tmp - req->rate) < abs(best_rate - req->rate)) {
+			best_rate = tmp;
+			best_parent_rate = parent_rates[i];
+		}
+	}
 
-	tmp = tmp * 18 + rate / 2;
-	do_div(tmp, rate);
-	frac = tmp;
-
-	if (frac < 12)
-		frac = 12;
-	else if (frac > 35)
-		frac = 35;
-
-	tmp = req->best_parent_rate;
-	tmp *= 18;
-	do_div(tmp, frac);
-
-	req->rate = tmp;
+	req->best_parent_rate = best_parent_rate;
+	req->rate = best_rate;
 
 	return 0;
 }
@@ -198,7 +214,7 @@ struct clk_hw *imx_clk_hw_pfdv2(const char *name, const char *parent_name,
 	init.ops = &clk_pfdv2_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
-	init.flags = CLK_SET_RATE_GATE;
+	init.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT;
 
 	pfd->hw.init = &init;
 
-- 
2.16.4

