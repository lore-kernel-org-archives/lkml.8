Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C0C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9980224658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="shvOWKDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBSKAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:00:17 -0500
Received: from mail-am6eur05on2060.outbound.protection.outlook.com ([40.107.22.60]:22785
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbgBSKAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:00:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRgSXu7+D2HNLjkvica3zOoswzyuGlz9uOsn7ikcQfnRe+3/+p2OJ4wWZLeQQS4KbuCcLhMbsy0EwgoqxgIlSS0QxEGphWn79zzVN483BYQssnhYcU3M/anGLrDNgzYOfXwB/7vohovI4ui4tEK1uIi9Ea/k2H5KK9/ieYRqTkVvVPHGrDCphFt+NySmLoMa4yKBS4rtC6jo25NRzBEgKzssomVg8Y2bSTdZ0cA2IKh0M3rhYiJOV/WMzxaGvPpgtNgq0+ETDl6FhJTWk0dJjtVCjznGpWHTkBkOQnMK8ApG1a76sU1DLlfoCLTsAiVY4uCbf5PB6lXAaHapWC5bTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnIP/LvffcyQRkVUHMCeJcefBacRUeRSPqlu5t1wdIc=;
 b=bYLAHOMOMxPleIkPaB+rRXXnVPlwbUbrLhhL32AkAAZrw0UIg5+EEDHEWvpYpmiJOjIcJX9pJuz9mcqq3qjgqt8Aio7+0L+GjKkeKVSWlj/aYOw11kZXJYu7H0QzVVVpWi47KY1bZYTRMh/ohq6mCOJ1JMLKkz7g54oUUncW0RzdFWHnpjWghhl2aSQvjqUMzawZAJIiMnn6k8PBTzcr8tE4R+Fs2f8x9uxudq5RQIp+Y8TUTd6lGbICOQ+kVvwovxst4y9QSk44rO31JuiiokcBijXihHqNH1YSEEn9i+ebdrs54EfcGsx51fnmGb3Uq7tSVPcZDl5dC/00A4FXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnIP/LvffcyQRkVUHMCeJcefBacRUeRSPqlu5t1wdIc=;
 b=shvOWKDqqJT3fsmWN/4oLTeIqr/cUWbDnbQE7qYELohvnu8LvMGqKU8HrLDWV4ToMFkobtSNzr4Vq0291hxWqeOCB5yh6sz1dhvcoSGzy0qr2JNA9qYMHa8vIPoFlvxmYQd40JRkUb7Yu2LU/HzfXineoIX3uSLZ7tpJshP493Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6514.eurprd04.prod.outlook.com (20.179.254.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 10:00:13 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:00:13 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/4] clk: imx: imx8mn: use imx8m_clk_hw_composite_core
Date:   Wed, 19 Feb 2020 17:53:41 +0800
Message-Id: <1582106022-20926-8-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
References: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.8 via Frontend Transport; Wed, 19 Feb 2020 10:00:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25fd5413-824e-4ac9-482a-08d7b522831a
X-MS-TrafficTypeDiagnostic: AM0PR04MB6514:|AM0PR04MB6514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6514D2D3BBACBBCB9213A71B88100@AM0PR04MB6514.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(4326008)(2616005)(956004)(6512007)(5660300002)(8936002)(9686003)(16526019)(186003)(478600001)(81166006)(81156014)(8676002)(36756003)(2906002)(6486002)(6506007)(86362001)(66946007)(52116002)(69590400006)(66556008)(66476007)(316002)(6666004)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6514;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcy4GhvawcAn3/UjkaHLwT8e8mY0Z5G6IdbHjB3s+JVry7o+XEDGzaFK9Tuza65/FsAZOk5LxSGlWiWoePCna4JLdpHrz1mGFg2Ffa6nvvZvWQN1W4GIxxkt+8Uqb1BhWlS1V9+3VB1SHVBca9490wXOz3xYKDPL9SBW2ZHCXySDmjvLKEweemmufJlSlcW89SN8gTpxwmu5oUunFgxiWRt2w8Z9Uqyp4L14jfw1DDz7O/fSEuC/Ky1f2ktwEYe55AsCKTRZKQJSuxDVO8ooLHQkOjsBIXDLuQ6nYc6fStVd1g07+RB7pmfG8keuhWHuET8kViYpB92fSDZ/ucTzTyk6ySHoREgt6oBSJJefo4Cr4jTZAzrvqpH97C8PViYqY0l7HlOD/44GUvnJPiLS/iuHRN/nnUvX3ZZ9kJurC6CyqIEhZUA5hEMZkl9PiTwfXhSNU2LxKfCwW1/O7OTMZKc+TkzhskGdmB3I1cquU1w3DcQ1kNsO9b9Xi51FanWs0462hN3CiMAWuDpdIEkp2LUq31/c0N7rnlS13X68g11GxGh5ddpy9gVuZ0LkQZig
X-MS-Exchange-AntiSpam-MessageData: NJpYp7jxQ8dvvlvww036xzhhuDdm72f5jwHzmecEhVB4dOrIioT/TeQCGaRoXCObrAkTyIxzhTP8JTN/PWIDdyYlFgdqmaYZ3wRcMjT1wMDhREjL+JmjLjnNLLsTgReNQJwH33VpdHQs1jRQyJfmGA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fd5413-824e-4ac9-482a-08d7b522831a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 10:00:13.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+fEwVWglCgxiMueub66Dfr6djRkxMZiFCLbL/OuGPgu+7HcG8/HcyNLoogmlMKeAiNsU2knMCfGPfUHkt/MMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use imx8m_clk_hw_composite_core to simplify code.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index c5e7316b4c66..ce2ba3dce483 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -413,15 +413,11 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 
 	/* CORE */
 	hws[IMX8MN_CLK_A53_SRC] = imx_clk_hw_mux2("arm_a53_src", base + 0x8000, 24, 3, imx8mn_a53_sels, ARRAY_SIZE(imx8mn_a53_sels));
-	hws[IMX8MN_CLK_GPU_CORE_SRC] = imx_clk_hw_mux2("gpu_core_src", base + 0x8180, 24, 3,  imx8mn_gpu_core_sels, ARRAY_SIZE(imx8mn_gpu_core_sels));
-	hws[IMX8MN_CLK_GPU_SHADER_SRC] = imx_clk_hw_mux2("gpu_shader_src", base + 0x8200, 24, 3, imx8mn_gpu_shader_sels,  ARRAY_SIZE(imx8mn_gpu_shader_sels));
 	hws[IMX8MN_CLK_A53_CG] = imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28);
-	hws[IMX8MN_CLK_GPU_CORE_CG] = imx_clk_hw_gate3("gpu_core_cg", "gpu_core_src", base + 0x8180, 28);
-	hws[IMX8MN_CLK_GPU_SHADER_CG] = imx_clk_hw_gate3("gpu_shader_cg", "gpu_shader_src", base + 0x8200, 28);
-
 	hws[IMX8MN_CLK_A53_DIV] = imx_clk_hw_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3);
-	hws[IMX8MN_CLK_GPU_CORE_DIV] = imx_clk_hw_divider2("gpu_core_div", "gpu_core_cg", base + 0x8180, 0, 3);
-	hws[IMX8MN_CLK_GPU_SHADER_DIV] = imx_clk_hw_divider2("gpu_shader_div", "gpu_shader_cg", base + 0x8200, 0, 3);
+
+	hws[IMX8MN_CLK_GPU_CORE_DIV] = imx8m_clk_hw_composite_core("gpu_core_div", imx8mn_gpu_core_sels, base + 0x8180);
+	hws[IMX8MN_CLK_GPU_SHADER_DIV] = imx8m_clk_hw_composite_core("gpu_shader_div", imx8mn_gpu_shader_sels, base + 0x8200);
 
 	/* BUS */
 	hws[IMX8MN_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mn_main_axi_sels, base + 0x8800);
-- 
2.16.4

