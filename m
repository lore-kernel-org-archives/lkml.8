Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51361C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F41D206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DLRmMjNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCLKi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:38:28 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:44622
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbgCLKi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:38:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWtXfmhW/LeevTtEFiE8ETZhLb1sWCXqlE0KGgbu9gAlE6wHo2n3rPaTzxmZaoT+UtXvDoebk7Zh80geHwr6vYFOpMTQ78y6m/cYOW7mexisvFfUL1tXRB69yklVrtw1GKRhPkKYqpt9yjlfc+M7KzNulMOlP/5PKaCvvpWqfeQqoPCcB26uoijQp+XgAChyiZx7FrygGSspVBbPOnJLydi8bI2sC8ep7Es+V4dbxs/obNfjcUM1GZA9FoVdfP76Xs4SVWS5XvZj26b0kkEAFXFXNtVEGLvkoWnpwdAJ9xBqtAj5va5z5+bpoNe8CQbGibMQr6N7rQ9NV1zjD7rZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy/0Q9FFPaAVyvTIWabjuhpaz5X4iUeyBu4+M6IsrsY=;
 b=Xq06GDVyiJpj2agKWxtDnZei3YnGiuWVVk8kp4W718bPLR6KHDAKeFpmZBzkF8tEjuEfG3+NIUTUiHp4fpNVe3fwoZo2cxurMoKVwVCAhskv6ar4FXl/5VtaltYITAduO5dYp8k11U4VWL8RAS2AAJPdAS12uvs9gC5cLeA8PHpXsvDJY1dGyTwTkigvrxyVemyUVsSP6DS7bxv26HDKuZFggW302Z/cDiSTDjubToGwpCA+wxwFnNUr3PB7gmORHZSsHcaynVIGU8siiD2ZDRmaoQKg3K42LrrMYjAJymm9kKHHq0NW6KyectRYlf2CNb4N99hpIc81EwAYyKfDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy/0Q9FFPaAVyvTIWabjuhpaz5X4iUeyBu4+M6IsrsY=;
 b=DLRmMjNHU0w62oak2K6EiD6SdSIYzfOZAmwFblCAV7pcndTiKqwX1KspWcRb6e+tVJj6lTRTbvMvpV2s2fwGqu2jRANaVE8LPN082JYASH8Y9fYBIV6GbLr/jMdfHJRr0jfQTMYTYJNXscpDTk3PZ7+gHgcbfiDMk63WL9uuzU4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB3054.eurprd04.prod.outlook.com (10.170.225.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.20; Thu, 12 Mar 2020 10:38:21 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 10:38:20 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Date:   Thu, 12 Mar 2020 18:38:04 +0800
Message-Id: <20200312103804.24174-1-peter.chen@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To VI1PR04MB5327.eurprd04.prod.outlook.com (2603:10a6:803:5c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29397-desktop.ap.freescale.net (119.31.174.66) by SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Thu, 12 Mar 2020 10:38:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e047c0c5-0718-4739-0d79-08d7c6717bbe
X-MS-TrafficTypeDiagnostic: VI1PR04MB3054:|VI1PR04MB3054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3054E48078B407A1439A6D9F8BFD0@VI1PR04MB3054.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(2906002)(36756003)(2616005)(956004)(1076003)(8936002)(86362001)(186003)(316002)(478600001)(81166006)(81156014)(8676002)(26005)(44832011)(16526019)(6512007)(4326008)(66556008)(66476007)(52116002)(66946007)(6506007)(5660300002)(6666004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3054;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ou4jTG2rIfQHZfZGq1zJ8NPzHw1XbXl808h/O30x31SwN8qrszrveU8eAcffUm435y3M+pQWE6mXvkUonE7dl6PspX2Lj6q+BP7tiLjhYzXjimNDszcRjjKNyGJXAK+0FHl6YM10nYaGWUL9qu8xMNz18VXtvIXhOZDzfkoe4cQJzfwKVJud8Px0gu7eSgUNeR7RZJFzPgaCDQYoLD0YFCTE0oucvj63tYhJhH7j7QA08nIxfy3RYgwCUSTEoGzT3OjdAZgtQJJAZRPqMizWXRnqxwBQv0kg9fIGmPG3hoqC2AJ0dJASN4g2iiOouyfq21R4B/y9rwz57e0KHxV+QgC9/oj/5n1VVRwdUmuX3f+fBeYdQ767Mb5TdA3py+pm7hH6JSvelrkthqdB+8m7FxyeTigcM/jF4edOMSVw43v6oNWIkcnRERcMfXCXvWQR
X-MS-Exchange-AntiSpam-MessageData: eh9GqI1+3T2wmyrKaPRhxl9IrMfCqp8v+mwNWYwtBEAMP0cShamLq+jU8inwLqcxS+qHrKadvOboowE8Xvm4p8Ro6Hg3sY3tQgfR191nghdnsP5+5L6xr4OEbr1JIA43SJJjhX4y1CQyzw3LeNqzFg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e047c0c5-0718-4739-0d79-08d7c6717bbe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 10:38:20.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/hG7u8vzgTZK/dMwIu/PpuOwSQ84OJsAGSCAQdOT4T+qWp/eOAl5EJtNvfBdj/fPekmc3Y0d5vayzegzos+IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At some systems, the pinctrl setting will be lost and needs to
set as "sleep" state to save power consumption after system
enters suspend. So, we need to configure pinctrl as "sleep" state
when system enters suspend, and set it as "default" state after
system resume. In this way, the pinctrl value can be recovered
as "default" state after resuming.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
This patch at NXP local tree serveral years, and fixed the
pinctrl value lost issue at some boards.

 drivers/regulator/fixed.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index bc0bbd99e98d..29bb93c04b03 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -27,7 +27,7 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/clk.h>
-
+#include <linux/pinctrl/consumer.h>
 
 struct fixed_voltage_data {
 	struct regulator_desc desc;
@@ -275,11 +275,32 @@ static const struct of_device_id fixed_of_match[] = {
 MODULE_DEVICE_TABLE(of, fixed_of_match);
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int reg_fixed_voltage_suspend(struct device *dev)
+{
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+static int reg_fixed_voltage_resume(struct device *dev)
+{
+	pinctrl_pm_select_default_state(dev);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops reg_fixed_voltage_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(reg_fixed_voltage_suspend,
+		reg_fixed_voltage_resume)
+};
+
 static struct platform_driver regulator_fixed_voltage_driver = {
 	.probe		= reg_fixed_voltage_probe,
 	.driver		= {
 		.name		= "reg-fixed-voltage",
 		.of_match_table = of_match_ptr(fixed_of_match),
+		.pm = &reg_fixed_voltage_pm_ops,
 	},
 };
 
-- 
2.17.1

