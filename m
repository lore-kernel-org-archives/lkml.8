Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DCEC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508592176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="juKtJk7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBSIGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:06:41 -0500
Received: from mail-vi1eur05on2056.outbound.protection.outlook.com ([40.107.21.56]:8129
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbgBSIGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpdQTn5JTkOTAzs14ZkvUv15PY/2+9LWdUI9ppINHXimKAY58MCuU6wsFQBCDzmeXoMvb6QYseYyXYk4Bo5Q7uWHWIFfV911MgwjyEzRiD52x5wmq3k6klCtoWrwQ4B3xZ/3tFMB3E92z/mjImyFcMrORVSVNFqptzxZWHq8UbRNa7kahGD/cIfTM+HVy3dwMjJJec61qpXZj+SJaz+xkldjC7jiPu2pZJjo3rYgp+AxL6vhy2nERxjTBJ6bBnj17yA/IIDFDa31LVeofPiO3s5jh+gqvkgaqtQzrNr4cuBV3I6Pd1VTIgaJrH0lI/CPeSG320nWBCkQcFh9lJoqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay+9PXBCAMyE3JNz/XEu4o0HEVcPTs3bbzwdLXVpVwI=;
 b=WpkMJT8ANXQMVFi22ngGCDbbnqRNuLtainPcKJaIqKTPHXxBAKqePJggWB9kQv1gWoIygX3JVDNDZp1DUmTJ91RP+RRflogUOm+i5B15f5zsPFXp6cNh0194O9tFJAlc+Ttw4V09ZrkbJ0YCbosQx7Kj71htAIoXncjYYeasekqerBQ3f6uZoMnXnK8orSZ/G9bbdvONvJ7UrkATkATYT5kVYoZOZUb7vhCyY417Xf6X8CQuOIhjXSVq0jxitRP/DaX11sz7nhGo5HIBfUr+QiksHGXjpSic1BhPY1R/5iwdtgpeiBon067r0Pb9ILBcklfR9V+ple3N5Thc+/8mFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay+9PXBCAMyE3JNz/XEu4o0HEVcPTs3bbzwdLXVpVwI=;
 b=juKtJk7N/QeCdoiogvES+C2vC2BoyJwAyldkijAVS/xe+NfF7g23CiojhPbk0qxD6by57HhtvSSKVbFoonyCNrBDfUV9ts62+K1raIdgrGv0fF7ylgu1OyB+arM7ygMuzSfcnWE3jlfShg8rmwj8KUPRwgtLIhgDtolR6Fsx6B8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:06:36 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:36 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 08/14] ARM: imx: imx7ulp: support HSRUN mode
Date:   Wed, 19 Feb 2020 15:59:51 +0800
Message-Id: <1582099197-20327-9-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:32 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d47c9d1-6c35-47bd-2f5f-08d7b512a449
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:|AM0PR04MB6401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6401520E2FDA6F16D46AF86388100@AM0PR04MB6401.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(2616005)(81166006)(8676002)(9686003)(4326008)(66476007)(8936002)(478600001)(52116002)(6512007)(6506007)(66556008)(69590400006)(81156014)(316002)(86362001)(66946007)(956004)(6666004)(186003)(5660300002)(26005)(6486002)(36756003)(16526019)(2906002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSHLKoJYyOBEeclnW1EyaeSIGvEsUEJCqhhknP+h6XIPD9Wa5NdDjI++bnDT9H0HxnwCjO86Iw1KX1Uapq8OQbrbhuJxz4GVI/r/F8rhwUoNAfSdqzapxRh03c79VewLFrhcoNTdWkSYk3qKwPgo4ZWwpOr8bUtHxG9YbtRmX80M29DvJ7xvdO/83ZyNzU0G6XKzRpIR1B/mNEJ3yjqwEBjWCBfwVMXYcLlB/XhHFdpY7V/x9IgqPmKCyDwjOBHlNNJ9znq6ngLQCPI+pMi/uoMEQR97RwGzxxyEAvF2g0LnNjsUAKpnpgrb81c9yiGCwd0x4hBE3FESHQM/nuifmtI1tmgSwLKGPzZ6cId2ZU5YrzrXiZsXB/3MjAyaLn4xbxUPLgYQkC3jBUb4u0VCLvmFAUhrrH896t1P+cHihYo/DjY1TpPx1WEHgo5N0igdGrd9HgfqGjORRySZJWzWvAipf/t8aVVMkSn1Y1Uf5SGyoB/4/mTw0If/1uOHUOWZXchAajOj6LNHetW/7QXssqP0ZlR46fc3Yd6LoPrQdKc=
X-MS-Exchange-AntiSpam-MessageData: yOhJml+cVZoZr6nSdROFHQzXFD5RvKeDSUUbrI4W3y8jPTNhxuZeHprMaSoWFhwNc/lz9U6ier3699MiO3uYaeFk0N583iYIno8UV9GD7BwKSR5QVrdT/3KS7KkQFJ1zpYiW1YtMaTi9eA/DahciiQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d47c9d1-6c35-47bd-2f5f-08d7b512a449
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:06:36.8411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNUA19Oy5/34kS1KYaTk1eH6WpytqJdSA6/QuMogXiK9Hwhqy65luXTRhREMSApgcWOor6T0rrxj4NrFuVpueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Configure PMPROT to let ARM core could run into HSRUN mode.
In LDO-enabled mode, HSRUN mode is not allowed, so add a check before
configure PMPROT.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/pm-imx7ulp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 2e756d8191fa..393faf1e8382 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -11,6 +11,10 @@
 
 #include "common.h"
 
+#define PMC0_CTRL		0x28
+#define BM_CTRL_LDOEN		BIT(31)
+
+#define SMC_PMPROT		0x8
 #define SMC_PMCTRL		0x10
 #define BP_PMCTRL_PSTOPO        16
 #define PSTOPO_PSTOP3		0x3
@@ -25,7 +29,10 @@
 #define BM_PMCTRL_RUNM		(3 << BP_PMCTRL_RUNM)
 #define BM_PMCTRL_STOPM		(7 << BP_PMCTRL_STOPM)
 
+#define BM_PMPROT_AHSRUN	BIT(7)
+
 static void __iomem *smc1_base;
+static void __iomem *pmc0_base;
 
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
 {
@@ -65,5 +72,13 @@ void __init imx7ulp_pm_init(void)
 	of_node_put(np);
 	WARN_ON(!smc1_base);
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-pmc0");
+	pmc0_base = of_iomap(np, 0);
+	WARN_ON(!pmc0_base);
+	of_node_put(np);
+
+	if (!(readl_relaxed(pmc0_base + PMC0_CTRL) & BM_CTRL_LDOEN))
+		writel_relaxed(BM_PMPROT_AHSRUN, smc1_base + SMC_PMPROT);
+
 	imx7ulp_set_lpm(ULP_PM_RUN);
 }
-- 
2.16.4

