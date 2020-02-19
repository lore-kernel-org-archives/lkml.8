Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AE9C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7097E24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hm/EdXSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgBSIGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:06:31 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:23168
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbgBSIG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiQXHJg8JMCWjXRdNDVblIc5Dv8Yp28RIXu5rFS3s084EAjvBpfmbb5lzydTirP08PRrPd9qdqimLHXL5Cqxu1ab2YaGLqk/cMDoBXbAf66U9k9aJaMZYB3z000iyfhm1RjosL2eQ0mPFTBGt1SOY6fNqZ14wY++QOsV7muK91G/C49UpgbNe2u2n9F+7Gl8VNcSfpteERB4bJONM6NhsZyCcWZDykINsnfoF8RgNle1RX251xwMQ8TVgxOfNmdAgvqh/Mp9rSJxnY4n93RZc9R7y3c21v9S4rPzwIvDWY3ufysG8ht6K9kbu0xACPQIKHg5rLJwOA6tcTGTiOyjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwQeBUQfJB4vEvPaPWLOwmRp6IYIhy/cz/rkO377RO4=;
 b=V+oLBc0JovvWLHNaZMeln00AIGbGgpNJ26nw/kd5KfOqrPyRrMggJsxmGUAPBwJqZZ4Pda7swDSktSrEh+ORMfS8MkKOkQe3YdhKPjlfqlxNIpiakXrbmamPi0ZMmLDNgyJGZ4lhC0f6UQY3I+0rN2I7L/hj/T/dmvvLaafqxY7eOdWUuRBaE+tCSTzkEw5jbkH2oXb6g7m43PY/IpzrqW6zL0SnJv3WeR37ea47Wk+mOl7wo6HvKyv57ULUgkWv688Pid28620Y5drmFqNmzK6LON3MUxDKaZQ6QpMxWNLw43Mao9WlG+XMt5vP3q6XIrCUp+Vyj1XqBjzCRHjt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwQeBUQfJB4vEvPaPWLOwmRp6IYIhy/cz/rkO377RO4=;
 b=hm/EdXSRX/IwOVlRKVH9a8AxRUbZYiGX7FNz0cgNQ4oaqKwGDf8NpQstIKcIhl2TanDUBqKZA6I/6Fa03IMkvRjpbNa8xJDmLYEadKY5wuY3nOt982GHOUE0xQJGG+7SEdj2RZuLBW8Vu5w5angxm5lRreQ3I/CYumr8L6LvxXg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:06:24 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:24 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 05/14] clk: imx: pfdv2: determine best parent rate
Date:   Wed, 19 Feb 2020 15:59:48 +0800
Message-Id: <1582099197-20327-6-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:20 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 413c04c8-30f7-4618-e014-08d7b5129cb5
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:|AM0PR04MB6401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6401FBDB935120008FEE587388100@AM0PR04MB6401.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(2616005)(81166006)(8676002)(9686003)(4326008)(66476007)(8936002)(478600001)(52116002)(6512007)(6506007)(66556008)(69590400006)(81156014)(316002)(86362001)(66946007)(956004)(6666004)(186003)(5660300002)(26005)(6486002)(36756003)(16526019)(2906002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfhCbB8XLwbhPe6lE2ma0mKm2U/D8IgAH73k2MaXbDVJBAkoBuugaCoU1vYHEVegPh6Cio4f4auLocruRmbCcdXxqs7NR97deGqnPUwN5qjUNtTJiQYXfPLI8EPBBu+jXBJyW03QGz+XXkt1Q+QgNLOFb4Woa+FbXXChP6FLVY+IghtXRvDG9ub7G5p2DLawbGUIToo1Do8gYu5u08BKBXs9sdeCXBra8XWsGLFrgeAIPkd2wJTZNly3OBKWqK0bIxVBxMIIwRxXNLqUDnk8E3LUbKEHx/RVln92FLWgtZWbHXyOWtp3ufl+fXF+3Sldk7AdKwlEObm7sh6B7j6DWlgDMgtvM7y4AEJQVjABMRB88tdXqsXMDZMdvgILILZOuRe6YoSj2ahbkRlod3PyGjn/Hl1GrrU3y+oD/qTRtMSE1BaPL4V9DLoJEloCFQB2X7pgiIPbwkcaBIlqXLkdoMjx54DyPF/5Ktkxu0vOwOmNowiNrUW2DQluBP0ARnCqnqBOKq3BpW/eo4zrzvyiDaRWf/P/8x0/1UbfnS/XAFc=
X-MS-Exchange-AntiSpam-MessageData: nSSr4V2dW6W21EDWc3Ahzba+czuNpxD9v0JUaQ3hQgJT1hSJABlwU6KkwHFAgK5kBRza1ovkE63rJB2nhmeb+loTGIT1uB/C9RaAoqEDr/G7XbBDVoQi9uP0FVHWMkD4jxt9Mggfs8i6CoEZGS8EXQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413c04c8-30f7-4618-e014-08d7b5129cb5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:06:24.1167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUx+oOKyHuZGe7HNGifCqCPiUKMfwtBs+sQPgDJv0HvaEcCK652tbrce1gEdl2rt0cf6/kkh3ZQvLbdj8q1LEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
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

