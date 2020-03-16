Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE56AC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF13F206B1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G1Q3Hy0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgCPIjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:39:25 -0400
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:58406
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730048AbgCPIjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:39:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZSSacCfuX6WRcfEEo+FJMc53jh7keySXsUxqbVtXqJXit4lhZPM5RZDtFW0UPo5vAVg+74CPbNBinzx+Uj9IZRyv0o9hiY3GprJeD8ZN78QLZ5urq4A0ZXpD2lXSL9GJWc5kJ8u1ftQ2RutwNhKBnKoNizhvOMVfwe4CePKnHF4mV3m8qfY0IoisEzPV8KSdup4yVK/RZcl7KlID7NRsndyqzoFTTsxUMgvRWF6C6JLUWlbUtskYo+tai80SHvGXV3cszVEM6ytKrjkKG9wM9tAKOo0Dtpqew+EGGcKhZ4s1izzZPM4TasURCJwqJyCvUhsZziz4XNFe0Tk1JQE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxXIuQfnhyjRgY1e+AmjfKOnrEZ2wrHW4yibiQrcaBI=;
 b=InjCKC14ojADy8aQ1XMIL9cd8MDL83wZUFBzycGHnsdCuXTdUSbxKiWvY3U3HCZZSi8CVf+O3a/ZXTMX414fMMb5bHXfdMqFCHLi5t7ARTLEdtuVCgT4bqfuLxVd+P8zGTZsyjuXt/XE0yIEWQoLiA+KPxN0Zq1zQB9RbBGRziFoL0WNx29mQ8EbhRXq0UzEVAxYwoV4/yCsNWN8swiknfxm7iKd+FspKUfk+cCgzRIEDH45w5xz5yyMIFuW1ssAj+xUjX/44DAqnAXchdF4TFfts00vMlv7BQitjA2YAbbeFHX5prIk+BLJJeOl+2cRTmjef8D0l8nCPBU0OONxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxXIuQfnhyjRgY1e+AmjfKOnrEZ2wrHW4yibiQrcaBI=;
 b=G1Q3Hy0Ze3g1f5TmSH6EZPPC3H+AtrMH8kajc7aE3fsHhqeqLPfR2NLRlJd1sVcxCyC47kBPTvnQe4IDhioEaMQGTEB5CeBtkFQ6HrXCLCaeuksYPkKIpzxDgHkizqqBFWeOHRc3LWdFxUzJf4S7/EqynJQLxQ9t/iKtHzG7Yfc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4164.eurprd04.prod.outlook.com (52.134.126.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Mon, 16 Mar 2020 08:39:19 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 08:39:19 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, sboyd@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, abel.vesa@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] clk: imx7ulp: make it easy to change ARM core clk
Date:   Mon, 16 Mar 2020 16:32:33 +0800
Message-Id: <1584347553-2654-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.13 via Frontend Transport; Mon, 16 Mar 2020 08:39:15 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30631a0c-f758-4a67-bd09-08d7c98584a2
X-MS-TrafficTypeDiagnostic: AM0PR04MB4164:|AM0PR04MB4164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4164FE2CD9E975B531C5CFBA88F90@AM0PR04MB4164.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:197;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(6512007)(9686003)(966005)(186003)(8936002)(478600001)(16526019)(6666004)(4326008)(8676002)(81156014)(26005)(81166006)(6506007)(36756003)(316002)(6486002)(52116002)(66476007)(66946007)(66556008)(69590400007)(2906002)(5660300002)(956004)(86362001)(2616005)(42463001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4164;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4D3Ikne0ObT9hAZN7xl1cm6V0ND6a9cW35cqqhqc579pS4iLu/+gltIztjSmNKaKX8+oyJCUZwiiWVXQ0yIEpCiHPWuPhOUVIFlzpg/W4waNaqgcGETaqj4BJ+xdK60Jj23az32hW6YgKBFSX5hErMm2ZfkUP1c5REOmoVS2+mF3beBngXnkVhrExwiAMRlrgfda7dgoV6ubQGrvq6amjgvh6zrInOB7SnNGIU7WYv16QfCdFMsI2o9GuQdA+dwp+j0fVN8tkwnjOaT8pmHZwYRdq4unRHo2IDp/ebVm9SPG/W0vjnnV3nr8qT6Yo7QRyU4nRGXr5novzU9IEKr0gZjUGl7ttXa+vbtUxmmotIG1uO/zO+ruMWJf7v+gUZythH98nSZnCqADXpr8CQdeXupeL72hQNgZcYhTOkH2dEXQh8+j7PYx4ZAUajWHSkRdlIwpHbMI3PaiQoJiFtBE4ff3Ow3Mp5hseElGovjHT7c6mEDDruDhGxbtqCPPXUyEEFL+WUii95EDe6kH1HAMqbNuF8V2mVlHwlYHLytorjRvDWVT1A2u5SCEyoo9ALLfw4geBniHnZ3Dcb3jpc5MquDM9yWiZocnZz7ZPGGgKo=
X-MS-Exchange-AntiSpam-MessageData: 2yv6+obAZ9LgmfgsNvGJyMBJFw939K4+HgfQf5hIeaDzDWGQkJYf9xjxFSJqVbw7HOrnPVcQ+BI3btkMHURdA/NWCOSbhm4b6aGYNQLWfSkzWR6P3c1fRjNL1HnNR44PeVT6tEhzanpTz3q+IkKP/w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30631a0c-f758-4a67-bd09-08d7c98584a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 08:39:19.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXgT1ZviNJeJh+wZSQtb9WUPA9oEMcmHn/vLpraWx3yCeZ2zMFyjOIJNoZWk0f79pFapeV4oD5J/qbOKNw1vog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

ARM clk could only source from divcore or hsrun_divcore.

Follow what we already used on i.MX7D and i.MX8M SoCs, use
imx_clk_hw_cpu API. When ARM core is running normaly,
whether divcore or hwrun_divcore will finally source
from SPLL_PFD0. However SPLL_PFD0 is marked with CLK_SET_GATE,
so we need to disable SPLL_PFD0, when configure the rate.
So add CORE and HSRUN_CORE virtual clk to make it easy to
configure the clk using imx_clk_hw_cpu API.

Since CORE and HSRUN_CORE already marked with CLK_IS_CRITICAL, no
need to set ARM as CLK_IS_CRITICAL. And when set the rate of ARM clk,
prograting it the parent with CLK_SET_RATE_PARENT will finally set
the SPLL_PFD0 clk.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Update commit log. Make this a standalone patch from V2 
V2:
 https://patchwork.kernel.org/patch/11390595/
 No change

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

