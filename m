Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE60BC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE9021D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dk7b3hRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBSIGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:06:34 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:23168
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbgBSIGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEkm5drPMTvxQh4xKdoQYRCQbio6iSS1HpVPvkxoo+NiHFJe2Rn0nLcHsku4bI74fMcas4ZWGdOtZTltaumf5Z1ABPIxHf9F+dx6KSTxWvJqwRpft72jKJFsRGv23NvoIqfpDDQQPXJK5w7LWUEfaUAQydUXZq/s8rPk8M1HaQhTwwOIVj9WSIzo1nRW5vp1Fc6+wD6mlTmf1Pmuq7UlLO1sFNaQAFKjyAemzfyZ04s7xtU9jLn7VeFDzou66u1XrVplKwcxmsGx+ffXfOMO48ByuqOLi8+JHdcDNJ+BPxl0Yvccr95f7YDen+q3U6WdYmwI/SeOrX6ECSPKvExN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdIut4NX8cWlsy4mIEiiwOmKojVdnTPVAQgzkWqe7Qo=;
 b=N1r/nYeXOGbcxNyhyL3LF+cj+qBwadgg8p8LrHYpRj5bXwND+z5OgMbfIjSvCamMUIpbmbj3y9GJxYTUUDXwWoSFTsSQbXC/odi1tUc2dJ3fCZtnG7iiPcBsnsxKfs+UG6Kway61cpYpBov+9tyE3wu1DOWcGtKIFA3YbafVqrXI9xVpMIoSXKkZa2TUG3adx8l41dGGMfX3nqJB1Q7Naw0a7AXzsHZG8HIDiuPcfp8MAEVxmjZE3NIpv7/vi59UvqM3wkgBqEXltiOLAj7Mph39qwq1ZhoP6deGola3S8iCzVXBSMLqKlNVGQ9gJFyHY3VuVrW1+V8t0DgbvKTuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdIut4NX8cWlsy4mIEiiwOmKojVdnTPVAQgzkWqe7Qo=;
 b=dk7b3hRVe6hiW5Gce5g3fNV0qOpnhQlB39KkNum80PgciXezOYUg6iU9wurqvgCiyTGAj0a7IsZ81zyJsIcWHCVCRBr++tP7pKKtSV1ua0LPTiKoj8uCL8mdKJ2kGiZgL5zOtEYiJ1SedT1IVK66tTzgsl5PQo+NCrbPKro2FBo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:06:28 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:28 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 06/14] clk: imx: pllv4: use prepare/unprepare
Date:   Wed, 19 Feb 2020 15:59:49 +0800
Message-Id: <1582099197-20327-7-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5df81ee8-ee69-463f-a631-08d7b5129f41
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:|AM0PR04MB6401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6401627262537640D8C3CCFA88100@AM0PR04MB6401.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(2616005)(81166006)(8676002)(9686003)(4326008)(66476007)(8936002)(478600001)(52116002)(6512007)(6506007)(66556008)(69590400006)(81156014)(316002)(86362001)(66946007)(956004)(6666004)(186003)(5660300002)(26005)(6486002)(36756003)(16526019)(2906002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNHAO0X3bIlMQgAPinc5+UPLNuL2reim16qI8YsnIJFHaYVqFPoLJ8n0nie8kS8SEOsoovcxcBLPagJzZNAU6uewL4H5ocVKUg2HvmPJvep32fxG/zwm/G8SPnZ0BoYXare4yfd9McPhWwNak8IrrpUSbo4GA/W+bcs6Q+KiqoBQjgJMtQs+Fhv7eo9Apes1UgnksruFyUANu1+xX1uooFfumdLTJdW/IDu/h3ndXgGNxwyO8yaO8U4EpsTKFiZVhVFaUEPziqWVEsrII+66wUSKeNV1pSIjVN+3rx1mFFUhZt1AI/pe3z46XxjZm3bUsgNHZ3VVVqc2Pu5XugK5K269cTLaJrYJQFQYBmPsVW79J4Aruc6Il7TPahSZ21g0KCT1pQTerJS8bo/kD/0FE9zebH94c+W2E6KB6/cmUVDaGNfmD5OXNuLo4Web81aF1ZyKGd0SKqiKJa+AeiGlUXFBDMMZIoxrQAXghB2Qzg40X8iGsGASEf3bXyIP7jWMNDP/WSu48l2A1lXHMajcF7oyZuEYK+HG45APaOxJz2I=
X-MS-Exchange-AntiSpam-MessageData: OkAq0JVhDPqThXZwEMO4BstUbR1ayT+so+lnK1+ldCs8cBjsxOY27sCDdk0mEiAWGQJAe1CsqVlXlosUmsdMnZKZk+FLcf3pF4Q4YfhPJzHvr2X9cZXE/YmRcel120qCdHg5A8Y4cJgjsZuRu9FIDw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df81ee8-ee69-463f-a631-08d7b5129f41
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:06:28.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X51Cfrf585GVzyLZ5NeuIqCc8YxVOBX+dmkSZPhFMWOWjIftfmTLjciqaXmCDqkSSPEi0oaDMrdcH4OtWZF75A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is not good to use enable/disable for PLLv4 which needs time to
lock, because enable/disable is expected to be able run in
interrupt context. So use prepare/unprepare.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pllv4.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
index f51a800c268c..a49450431855 100644
--- a/drivers/clk/imx/clk-pllv4.c
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -54,7 +54,7 @@ static inline int clk_pllv4_wait_lock(struct clk_pllv4 *pll)
 				  csr, csr & PLL_VLD, 0, LOCK_TIMEOUT_US);
 }
 
-static int clk_pllv4_is_enabled(struct clk_hw *hw)
+static int clk_pllv4_is_prepared(struct clk_hw *hw)
 {
 	struct clk_pllv4 *pll = to_clk_pllv4(hw);
 
@@ -175,7 +175,7 @@ static int clk_pllv4_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static int clk_pllv4_enable(struct clk_hw *hw)
+static int clk_pllv4_prepare(struct clk_hw *hw)
 {
 	u32 val;
 	struct clk_pllv4 *pll = to_clk_pllv4(hw);
@@ -187,7 +187,7 @@ static int clk_pllv4_enable(struct clk_hw *hw)
 	return clk_pllv4_wait_lock(pll);
 }
 
-static void clk_pllv4_disable(struct clk_hw *hw)
+static void clk_pllv4_unprepare(struct clk_hw *hw)
 {
 	u32 val;
 	struct clk_pllv4 *pll = to_clk_pllv4(hw);
@@ -201,9 +201,9 @@ static const struct clk_ops clk_pllv4_ops = {
 	.recalc_rate	= clk_pllv4_recalc_rate,
 	.round_rate	= clk_pllv4_round_rate,
 	.set_rate	= clk_pllv4_set_rate,
-	.enable		= clk_pllv4_enable,
-	.disable	= clk_pllv4_disable,
-	.is_enabled	= clk_pllv4_is_enabled,
+	.prepare	= clk_pllv4_prepare,
+	.unprepare	= clk_pllv4_unprepare,
+	.is_prepared	= clk_pllv4_is_prepared,
 };
 
 struct clk_hw *imx_clk_hw_pllv4(const char *name, const char *parent_name,
-- 
2.16.4

