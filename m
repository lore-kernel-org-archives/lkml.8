Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361B6C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02074222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H+TOUUaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBSIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:06:40 -0500
Received: from mail-vi1eur05on2056.outbound.protection.outlook.com ([40.107.21.56]:8129
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbgBSIGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKtdhj8i/67wXErYMM42LNMb5ns6RxVJBqim2Dhty8ngOrmyjD7W581BBlh40JIeX6RODDEssiBc9vAuVQGAQgjvaPI25SeiMI4oXp4DH2rb90jz0JscTaI6We+1sAiJTctGBdVtDYI3FwcvnfhNDS8dBmESQQX88uWGJtcxAPmHfbq+NcqF54MKMmfJ8mln8mntgcArhMrPsIj5j+dD9G/BGYvifb1TJO3epkz5cAOBHmLTktSjH9Z57ghgkdicC708iPU5xHEpcM7kUuOdVRNrcNMe5CtBdG9zsuKOmJwKB3ttl9CyhfHEoajtugA1xfwO6/UqkPw3KzWWwSVGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vhp3JGzQ84Yqbwn3J5EtPN4tGcl+fnv68I55x1RLgho=;
 b=YClJVcmDUSsMURC36yNZ4qjLUttn9J6HZQKMfdXS6NhaDSpbX/uiJOOI6Rp+3K6O5zaenytT163SeCo/yujhEsRMs5fAuX3lWwKVwje+eVSQSsAGD1Vpy2hkBoe+mJoOG2QbsBrGW/Jk9BpvBwmMNTuD0OZq0OcOu92D6MnNKkojv9bIm5a3OPfv/gB5Zxm4qfWFd+6Hdmi3EY9QZGHdlQFCuFQQXovIKhLmGHEgKt39GwgnS+BD0T5GjrjOfx/Gsvjse3+AQVbV1hgHcJhz/WNdEXw/9rSUnYStOLNhdIsTLBBILy/V28uAdi5shq0SOA4H2EWJueofRVm6z1xMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vhp3JGzQ84Yqbwn3J5EtPN4tGcl+fnv68I55x1RLgho=;
 b=H+TOUUaC/r022LU06zBZMDcnFvfBM/xQo+QwSkpJkdae0uiRFZwuYCL+LODKRRlsixg1Ta16U3Og0WMxfpc8eWmIKr49eAgQJjpd1NsR1Q52PI1WvgtXW5tmfE0ir/J/dTfbBG8WWxl9HaIvWnWh7+EdXPeUUG2ZgzCAe5UTmF8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:06:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:32 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 07/14] clk: imx7ulp: make it easy to change ARM core clk
Date:   Wed, 19 Feb 2020 15:59:50 +0800
Message-Id: <1582099197-20327-8-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9eb6c8b-6ca6-442d-a558-08d7b512a1c5
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:|AM0PR04MB6401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB640159D627A7CDFE7F0E0EA388100@AM0PR04MB6401.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(2616005)(81166006)(8676002)(9686003)(4326008)(66476007)(8936002)(478600001)(52116002)(6512007)(6506007)(66556008)(69590400006)(81156014)(316002)(86362001)(66946007)(956004)(6666004)(186003)(5660300002)(26005)(6486002)(36756003)(16526019)(2906002)(7416002)(42463001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBUoaDGBNYQ3M69HnReFIEO0Tdy9uzdPw3mC2k4OGLk3jzITp4l3FRIkxhT5W1Poz/zquMSJomniElXQtbYk+dRa38JmtTHRgOr2NEpyF1rzYThy1urBjJ24ZyS90zf1tTfh/DNdVJm6oeJpUW67rV4L+h4TG7cb6N0dp08noTZEEAAWsUKYD0152HfH7BvqhEy/MOmcobbUXutQdarDmTuC3WuQJcqDpbs48PevPJq2hUfrI5nwfYZ9+Nvm3NyWZWWcLM6szkqNeFMPZEmWsCZIkf3mDnha+Cm1kX955MXwk8fc1jefw4iCFZsZas9VVU/sRmRswTZYi0BQnvv/NXvqfOYkbRvMjdtOQ0hDTOZXKpHo9TDIZjCDN1U8iNlXzCdf88J7p0hWfMC0apv84dfKQp4T4x7pnZf0zlRnDBPWqrH0QurIOH9UoMmdWFdq9kMjkzPx7lKVFSXFuQdWRxl2Ybe7S8shVQSUCTNwJ8Bnv4GEIPgq4iAKHNsZvPgXqgN4Fvaz811Y9AWtS7CYzYpVPeAfVoxxtqJe3C0b8oIfpzlpDcNARBeUEYTqRu7n
X-MS-Exchange-AntiSpam-MessageData: B+/SNxK+XPMzS070J/uk4Idyo70TbKxkp3qCIyTZHRfU+wmUZigOjGeyC+kYm/HlJPcMStkBdD5ZoUxx+b2iDhqpMl7yeiimL9RdePZsIU4qlRcN7FwkjqCaLWdFdVkMoPTt42WauRRZtck7bVwk9Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9eb6c8b-6ca6-442d-a558-08d7b512a1c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:06:32.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKW/27qQMjpMoWNEy6SqVdWv1Uy3xpUXMscqj4NnLttGXI8sVrvFcQSoqcV6JYUPZ/B2fCvyuJDyIpWhCVfJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

ARM clk could only source from divcore or hsrun_divcore.

However when ARM core is running normaly, whether divcore or
hwrun_divcore will finally source from SPLL_PFD0. However SPLL_PFD0
is marked with CLK_SET_GATE, so we need to disable SPLL_PFD0, when
configure the rate. So add CORE and HSRUN_CORE virtual clk to make it
easy to configure the clk using imx_clk_hw_cpu API.

Since CORE and HSRUN_CORE already marked with CLK_IS_CRITICAL, no
need to set ARM as CLK_IS_CRITICAL. And when set the rate of ARM clk,
prograting it the parent with CLK_SET_RATE_PARENT will finally set
the SPLL_PFD0 clk.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7ulp.c             | 6 ++++--
 include/dt-bindings/clock/imx7ulp-clock.h | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 3710aa0dee9b..634c0b6636b0 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -29,7 +29,7 @@ static const char * const ddr_sels[]		= { "apll_pfd_sel", "dummy", "dummy", "dum
 static const char * const nic_sels[]		= { "firc", "ddr_clk", };
 static const char * const periph_plat_sels[]	= { "dummy", "nic1_bus_clk", "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
 static const char * const periph_bus_sels[]	= { "dummy", "sosc_bus_clk", "dummy", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk", };
-static const char * const arm_sels[]		= { "divcore", "dummy", "dummy", "hsrun_divcore", };
+static const char * const arm_sels[]		= { "core", "dummy", "dummy", "hsrun_core", };
 
 /* used by sosc/sirc/firc/ddr/spll/apll dividers */
 static const struct clk_div_table ulp_div_table[] = {
@@ -121,7 +121,9 @@ static void __init imx7ulp_clk_scg1_init(struct device_node *np)
 	hws[IMX7ULP_CLK_DDR_SEL]	= imx_clk_hw_mux_flags("ddr_sel", base + 0x30, 24, 2, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
 
 	hws[IMX7ULP_CLK_CORE_DIV]	= imx_clk_hw_divider_flags("divcore",	"scs_sel",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT);
+	hws[IMX7ULP_CLK_CORE]		= imx_clk_hw_cpu("core", "divcore", hws[IMX7ULP_CLK_CORE_DIV]->clk, hws[IMX7ULP_CLK_SYS_SEL]->clk, hws[IMX7ULP_CLK_SPLL_SEL]->clk, hws[IMX7ULP_CLK_FIRC]->clk);
 	hws[IMX7ULP_CLK_HSRUN_CORE_DIV] = imx_clk_hw_divider_flags("hsrun_divcore", "hsrun_scs_sel", base + 0x1c, 16, 4, CLK_SET_RATE_PARENT);
+	hws[IMX7ULP_CLK_HSRUN_CORE] = imx_clk_hw_cpu("hsrun_core", "hsrun_divcore", hws[IMX7ULP_CLK_HSRUN_CORE_DIV]->clk, hws[IMX7ULP_CLK_HSRUN_SYS_SEL]->clk, hws[IMX7ULP_CLK_SPLL_SEL]->clk, hws[IMX7ULP_CLK_FIRC]->clk);
 
 	hws[IMX7ULP_CLK_DDR_DIV]	= imx_clk_hw_divider_gate("ddr_clk", "ddr_sel", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
 							       0, ulp_div_table, &imx_ccm_lock);
@@ -270,7 +272,7 @@ static void __init imx7ulp_clk_smc1_init(struct device_node *np)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
-	hws[IMX7ULP_CLK_ARM] = imx_clk_hw_mux_flags("arm", base + 0x10, 8, 2, arm_sels, ARRAY_SIZE(arm_sels), CLK_IS_CRITICAL);
+	hws[IMX7ULP_CLK_ARM] = imx_clk_hw_mux_flags("arm", base + 0x10, 8, 2, arm_sels, ARRAY_SIZE(arm_sels), CLK_SET_RATE_PARENT);
 
 	imx_check_clk_hws(hws, clk_data->num);
 
diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindings/clock/imx7ulp-clock.h
index 38145bdcd975..b58370d146e2 100644
--- a/include/dt-bindings/clock/imx7ulp-clock.h
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -58,7 +58,10 @@
 #define IMX7ULP_CLK_HSRUN_SYS_SEL	44
 #define IMX7ULP_CLK_HSRUN_CORE_DIV	45
 
-#define IMX7ULP_CLK_SCG1_END		46
+#define IMX7ULP_CLK_CORE		46
+#define IMX7ULP_CLK_HSRUN_CORE		47
+
+#define IMX7ULP_CLK_SCG1_END		48
 
 /* PCC2 */
 #define IMX7ULP_CLK_DMA1		0
-- 
2.16.4

