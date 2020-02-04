Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D211C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D8C2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gDxDpojQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgBDNlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:41:24 -0500
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:7938
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbgBDNlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:41:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwrK/UAMt5S2x2MkhK+sS/J0hz1GDPaJxiuGnaIxeLyeHgFRxxLdQpJDunZTJ3I58zNHcwa7MdWxUvVLJxw4CuZDaHGHkwZgWp/yPaYbU5c0r67i0VGEwc+ZeLZfiQyPZvGuFCt7NXLN6bWzWR6h9QSGVYy6n9r9HI5ETR73IDcBYcqcu+JQ+1esWa5Og1fnMNqxLPk0YU5iYSkAjinkTnpQqBIlL+uLpIcgDNqi8RIV8mpTJgJXUCf+0XSXGdARZ9O6dvS4ptARM7gMjazOljOTKcGfMTkdK18AGx6XUNTkHOQ78ms45W/PAv63tb5LG69yICqSBn5VHIKl5wICrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUlRr8faB/i66fx3x80G7m9tQuoYyRbLoNWtPavuV8Y=;
 b=YI8TAGYx/sZe4U/XlsCA02QgXppn/RINJ7GPn0tfoQOTdnyPrSn3KF1RIKu7MerqLudRHTxPloa5rwLM0oops5YTGiJxy4XGLnl+K8yDXiTzaPSECDQDP9WiGJXxwiNQEOamsWEEx0peHAs9EZ0sekdeC7qswNbfAHqu5QTgwxck3B8BbuFShGU+q/Z8vUk/EHrGA6XwR/42f6fMTrEngid7SoIqAOgie7lt4hTt0GlQEO+FQ0+GpWrOEmXPIXfoEF1SDZaLJZCEOp2lUD+YQxTAh0R1VP06Ei27ZiOHzXx/pUS6HJ3LB0C/tFhuF6O9RMamCLeOfalg5rLMRwgM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUlRr8faB/i66fx3x80G7m9tQuoYyRbLoNWtPavuV8Y=;
 b=gDxDpojQxtou0jJ2F0yyf/JFNRtHCO4vx6kH9XEzIKYagU2cksO9dLo2e+5/Gnpyz4kX4QFt/4m6wHJATrdZsHEq1ONyvBotXo6t4ekoO8lsKjdiE828aT2W0dEXvBIz+n7GfLBxwk5JGFTVQCUl+fe0/RVRciL8WAATlDU+NTk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4851.eurprd04.prod.outlook.com (20.176.215.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 13:41:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 13:41:18 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        abel.vesa@nxp.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/7] clk: imx: pfdv2: switch to use determine_rate
Date:   Tue,  4 Feb 2020 21:34:32 +0800
Message-Id: <1580823277-13644-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0107.apcprd03.prod.outlook.com (2603:1096:203:b0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2686.28 via Frontend Transport; Tue, 4 Feb 2020 13:41:14 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33823662-8acd-443d-a244-08d7a977e996
X-MS-TrafficTypeDiagnostic: AM0PR04MB4851:|AM0PR04MB4851:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4851F8E7CFCE102FC53C504B88030@AM0PR04MB4851.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(26005)(956004)(2616005)(316002)(6486002)(186003)(16526019)(8676002)(2906002)(69590400006)(81156014)(36756003)(6506007)(81166006)(86362001)(6666004)(8936002)(478600001)(66946007)(66476007)(66556008)(4326008)(52116002)(9686003)(5660300002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4851;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOFaNlzlD+bJQuQgOXr+i+zmZnWnsnhUVrg5ocClv7XE1ArB9SmCe4PhRrFYCBg+n3OxPBhymed3i/P6Zshx7N+8nzDwQILxAq2MQ+EABSuOLCAB2OWnRgXwgIVJTwOcKz8XtAot/fX38fL2C3IgzS13mz+Tfx2iUicCz6uoQ0NjtLULf/ltyO3NWtljCy7IGHu7KyJuQlvPNwml18UeJlC1k1+C36Vmgirpw2agBR2eXOvDterowhw2g0pgA9Vdxsc0r/EDCHm1mXfMlrOKhIO2fgE2ATC4HEQ6y/xjto0J6PQARF2Y09wNtM+ZoKBtsXGQKsEJDQsEZTkg/aERf/v8KNFra893MpoPiE2CqOZu33jOM6UWjPSgbR465kDCiUxr8/jcivhTLUZ+GJog4RLHJQ1WdFV8dqjgodLmy9D5Bz0uRBhRaZuZwwsY4KiQ+xuDpPI9I19TKu0DuAZFx/RYk5PpOogKwMM1tZiyLdS6sigRXh5KXwM5yhvgo1AThDe3j//4tmhxqJrfLlK12JhdCe3qc0Mf9DLt/vU7+68=
X-MS-Exchange-AntiSpam-MessageData: wKFv5zwNx9l1kNYKxFyZTvQvhdWKejGrsJ5ItEnF3PeS/pquUpBk2NoF523NPvUS97CDWC+wC+fyyL4aT18p6Rm6dkXsDNv/9LB8f6EDAhnlA5/UCOKUWxQOQdHDbw69oNX0j9x+iVWLs6+JF3X/iA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33823662-8acd-443d-a244-08d7a977e996
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:41:18.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EngCBdEmtW6+VRpAIrkityBcW/PGi7YQf2Ff1+7ng+qOIhdfdwn1L0EVEbgSHVcPyp8IPJfgUEj6uyuzfBi89w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per clk_ops, compared with round_rate, determine_rate could optionally
support the parent clock that should be used to provide the clock rate.

In this patch, the parent clock is just parent->rate as round_rate.

The following patch will calculate the best parent clock.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pfdv2.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
index f8707278aad9..28b5f208ced9 100644
--- a/drivers/clk/imx/clk-pfdv2.c
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -98,10 +98,11 @@ static unsigned long clk_pfdv2_recalc_rate(struct clk_hw *hw,
 	return tmp;
 }
 
-static long clk_pfdv2_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *prate)
+static int clk_pfdv2_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
 {
-	u64 tmp = *prate;
+	u64 tmp = req->best_parent_rate;
+	u64 rate = req->rate;
 	u8 frac;
 
 	tmp = tmp * 18 + rate / 2;
@@ -113,11 +114,13 @@ static long clk_pfdv2_round_rate(struct clk_hw *hw, unsigned long rate,
 	else if (frac > 35)
 		frac = 35;
 
-	tmp = *prate;
+	tmp = req->best_parent_rate;
 	tmp *= 18;
 	do_div(tmp, frac);
 
-	return tmp;
+	req->rate = tmp;
+
+	return 0;
 }
 
 static int clk_pfdv2_is_enabled(struct clk_hw *hw)
@@ -167,7 +170,7 @@ static const struct clk_ops clk_pfdv2_ops = {
 	.enable		= clk_pfdv2_enable,
 	.disable	= clk_pfdv2_disable,
 	.recalc_rate	= clk_pfdv2_recalc_rate,
-	.round_rate	= clk_pfdv2_round_rate,
+	.determine_rate	= clk_pfdv2_determine_rate,
 	.set_rate	= clk_pfdv2_set_rate,
 	.is_enabled     = clk_pfdv2_is_enabled,
 };
-- 
2.16.4

