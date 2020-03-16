Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DC2C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615D120658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J3cgiWiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgCPJCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:02:54 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:41344
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730152AbgCPJCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:02:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnBMJdjVDNKzHBJvd0DtPxJmyGeoDU4dY3h+S7Rx38L0MTY+B8tXa8a/ZF8WQqDWTPWpbrExhRk/s1CzInBhE/eeiEF3gTGwImrlmbHY54OxGdJviQaU0H6JIPdjesD6TDcD9ms2vG1PupjdOsMphrT0pvGrykaNj8mDWPIBg4v99WbSMNqnZNTRUazgAiQIkl5EpJ7kCV4WVY1G3MykCpXl0ymvyCEtCESkRQm+UpbnqApwgS55qrjLf/cnd6VaC4z11o5fsCRaqs8Z2rEKj+rZdaU+rKZHLa+NWi4zL9VIvGxM35EH5FvlRjzdAEaAk/tgjW/zzeFlv+0cUJBucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N3jlyXvxOlDecD/ueX61aTQqPGAd8m1kZmTdqIbWfY=;
 b=aGrwvWKVcuvTr915ZuzZQygYEHhu6bMAi5ymSktg3dyoZtxu0lDsoQyTD7hKMTBThJD/TLkbx3EUL1cV0NFOeItwBjLyGna6h5MrXSave8sXl1X+QE0D74Wxwq4Pc6M+IhtF93FC/UO1LSI9+lUGz0TSDY3WuPt4vRPMyokUq1tGxCeYKX749kGuuhOT6gbwUBKD/hoL5dTcv48OX5xBcAhlAQ4Yx7J/YS3x4Yxy/FcCYf+HaGJZ8PoUJfTjbwVur79AWpxFy4y1jroqYXaDtE9gPBVdSCQQ1eJ6EZcztPSYYPkLepSuQ5a409xExlXQLjlv3uS+rFVAzStnlnIKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N3jlyXvxOlDecD/ueX61aTQqPGAd8m1kZmTdqIbWfY=;
 b=J3cgiWiPrX2qWAGTGf0k3GQlIrbtYabkjYCpzTKuxDaGUIrJ80gP+UwqLI9Z+T+CLhiq12yksizqceVLFcU8W7NgPRIUdOr3xTAzXl92CQecYDi5X+0lxh+gEJ6eqG2FYis3LL23vBHBhSKyi1aI6gLkxZyyGK1kkcNjyuqaEqU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7169.eurprd04.prod.outlook.com (10.186.130.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Mon, 16 Mar 2020 09:02:51 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 09:02:51 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/4] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN
Date:   Mon, 16 Mar 2020 16:55:44 +0800
Message-Id: <1584348944-19633-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584348944-19633-1-git-send-email-peng.fan@nxp.com>
References: <1584348944-19633-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0126.apcprd06.prod.outlook.com
 (2603:1096:1:1d::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0126.apcprd06.prod.outlook.com (2603:1096:1:1d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.18 via Frontend Transport; Mon, 16 Mar 2020 09:02:47 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc1537d1-7fad-4502-ab36-08d7c988ce33
X-MS-TrafficTypeDiagnostic: AM0PR04MB7169:|AM0PR04MB7169:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB71696C3F1C8F183EABF9A30F88F90@AM0PR04MB7169.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(9686003)(6512007)(4326008)(16526019)(8936002)(81156014)(81166006)(8676002)(2906002)(86362001)(316002)(26005)(186003)(956004)(2616005)(69590400007)(6666004)(36756003)(6506007)(66946007)(66556008)(66476007)(478600001)(5660300002)(52116002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7169;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2fqTUGX9fgt7HQdfIpyfTS+H6L812TcO0uYvDueygW2vxIPJXjclib8Tt76eE1lMHmle/Vmhlj/+HYegMHdIg0QlSSHBjImRuCg1zc4UGhQQ6OWcKDToKORzS6wlypTMzHJVJOSemXeavoCJ1/q9azFcakntQYnYpssMLFy9ZWW0egITsTiKjDiLuvvzTAYYY8vAbtpp624PIyh0doTn3Pdd1uxdo27jjxtOxrfq03CRFh3y983ePIgdwRrE6qMg5EJ30kOap5BYG3trdcF/wuX4zDlR8Jsar4Hrgr0xzo0B1IxlZU3daIuNAh8LPKBliNqCGVlMkDDEyuPqGCQJOTlmEY8Y/TLLVyr+P3cTiBWwq3ytQ7Q0EvhsgJvbU+Zs62xyA0blDC4cH0+NjYoJ3uu934z+VDxxWroYpCAGiLyHzp5LEEfh3m7yxB2CuoLiHq/daa3r/pOzW4w9VQaOdqIhNxKyUHizQ3kA6R+Dr7G67SBEPCV8vzsF7SH+ppn
X-MS-Exchange-AntiSpam-MessageData: UcpVY8bcwQ9bspqcqgs9EaNezEpp0MSPs/rOzGM4hfV7OdOPaJGsTblRiwm7Af5zzpJ9rW2ScEJ8So2KbiFkxCIvat0MVCvptWwsTxKyaE+h8nUuHpLYQOUuSZ46yzi/DD1fJJ4n96x/P+ts4Jil9Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1537d1-7fad-4502-ab36-08d7c988ce33
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 09:02:51.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSHS4Y+FDv3J/EqnrDHDY36mKf+7YUPRnKtdRVgI166cTOWsoJqS9Cb3ZQMTb3LL7TWJOkNU5VxbaBQOry3tpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When cpu runs in HSRUN mode, cpuidle is not allowed to run into
Stop mode. So add imx7ulp_get_mode to get thr cpu run mode,
and use WAIT mode instead, when cpu in HSRUN mode.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/common.h          |  1 +
 arch/arm/mach-imx/cpuidle-imx7ulp.c | 14 +++++++++++---
 arch/arm/mach-imx/pm-imx7ulp.c      | 10 ++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 72c3fcc32910..707ac650f1c2 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -103,6 +103,7 @@ void imx6_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
 int imx_mmdc_get_ddr_type(void);
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode);
+u32 imx7ulp_get_mode(void);
 
 void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-imx/cpuidle-imx7ulp.c b/arch/arm/mach-imx/cpuidle-imx7ulp.c
index ca86c967d19e..e7009d10b331 100644
--- a/arch/arm/mach-imx/cpuidle-imx7ulp.c
+++ b/arch/arm/mach-imx/cpuidle-imx7ulp.c
@@ -15,10 +15,18 @@
 static int imx7ulp_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	if (index == 1)
+	u32 mode;
+
+	if (index == 1) {
 		imx7ulp_set_lpm(ULP_PM_WAIT);
-	else
-		imx7ulp_set_lpm(ULP_PM_STOP);
+	} else {
+		mode = imx7ulp_get_mode();
+
+		if (mode == 3)
+			imx7ulp_set_lpm(ULP_PM_WAIT);
+		else
+			imx7ulp_set_lpm(ULP_PM_STOP);
+	}
 
 	cpu_do_idle();
 
diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 393faf1e8382..1410ccfc71bd 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -63,6 +63,16 @@ int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
 	return 0;
 }
 
+u32 imx7ulp_get_mode(void)
+{
+	u32 mode;
+
+	mode = readl_relaxed(smc1_base + SMC_PMCTRL) & BM_PMCTRL_RUNM;
+	mode >>= BP_PMCTRL_RUNM;
+
+	return mode;
+}
+
 void __init imx7ulp_pm_init(void)
 {
 	struct device_node *np;
-- 
2.16.4

