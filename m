Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EB6C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0B2206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AMUoGfEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCLJYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:24:16 -0400
Received: from mail-eopbgr130070.outbound.protection.outlook.com ([40.107.13.70]:57014
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgCLJYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:24:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeU4KfNJ/9Q53rKK2h2UtNRkaFFVXvuuk9ryQOi7SfHGlAkFtAc0uFpqNcpzyQI3RyDgUwYU1nawz/8z78DN/m+kTFPY14M6h1P40cjJ2w68wwmD/CBDrS8fq3YmzT7Mr5o9payZRotfmnvrnBUulSEPJGEcgkwG9XGZ2eePiMomtlVYCAZ+UfIV38YHooHg2lHZ0oXnMx2fm5D7Ldj8lILpeb/xBk62oxLtaC+MGiKFfUZclgEkx496Y7L0s5l9b0G915fe5iODNQxw1RnRKIRX+loCTHD2r1jjIEvkz7rvF0f05cmwHpHV+J/cFxNaB0ID/XNCf8KmnmBl+krDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSc0wLoVfGMlBt9BsItn/Q2w7BgQbkJ38ahG/ciGDs8=;
 b=Rz3cUV3879+VI8KBN7cc269bfFQVxSz1zgXZx4Wa0eEHxbvlquKXGr5yWhmDG/8Axg6PbZcNcueoJNQTcfX2XV05KNwVBu6bjWysVB3HSEJjrRp8kKtSJ4iRjFY9orzRFZIzmgf+OILx+rUF0Kr0q0yDvWNqTdkqdBf5I7LkqjUyGOpAKaPFRyNSxfhPILUj6bHTHF/uhXa0ZyKEkXxbooUzeiLEAj/TfUGgW/z3d1L7zXW2ZDjBdJFTeZGKgavpS+Wq4P2EXEt89trdCVZkrMGD5SnJbMd95rwiP5C+rd9TysJjpLswNahIFc8kkfd7zXoR/uN1Ylxfm9daFySyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSc0wLoVfGMlBt9BsItn/Q2w7BgQbkJ38ahG/ciGDs8=;
 b=AMUoGfEMKHUQl13wqHEozleRrM7JnIe7xhctEk220WuuTbJg8DoJDXVauL+InVeysnP6H1z3RI07K+qqs+eLVrEZwFTF/bCjdnU8tQ+yfQEbXp5X4d3VT+y3/xdH9muZoOXvlY2dIx+ZdX/x8ZXu2R012EmNzuOFkisxKN6XiOo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5042.eurprd04.prod.outlook.com (20.177.41.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 09:24:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:24:11 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        allison@lohutok.net, info@metux.net, Anson.Huang@nxp.com,
        leonard.crestez@nxp.com, git@andred.net, abel.vesa@nxp.com,
        ard.biesheuvel@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V1 1/4] ARM: imx: use device_initcall for imx_soc_device_init
Date:   Thu, 12 Mar 2020 17:17:22 +0800
Message-Id: <1584004645-26720-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584004645-26720-1-git-send-email-peng.fan@nxp.com>
References: <1584004645-26720-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:3:2::11) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:3:2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 09:24:07 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8bffde1-002b-493d-21ca-08d7c6671fd4
X-MS-TrafficTypeDiagnostic: AM0PR04MB5042:|AM0PR04MB5042:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5042F3F98EB2308AFB32FD1E88FD0@AM0PR04MB5042.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(316002)(52116002)(8676002)(8936002)(6506007)(36756003)(81166006)(81156014)(186003)(6666004)(9686003)(6486002)(16526019)(4326008)(66556008)(66476007)(26005)(7416002)(6512007)(956004)(5660300002)(86362001)(478600001)(2616005)(2906002)(66946007)(69590400007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5042;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0bivvowreIU5QUCIh74WbCJkk1fM3L7dde76TcRBczlzw95pien7DT3uG75bXUg3/5JFLjg2I143n3ZAZR1GmWNefUe6sFenkUT8yM5qfCWuvQ871ZbQT4HkxItL3jx3NO7iElxSyIz61Hzmo4aWBW2jBdjZr8CnGFD/nN6HS+0d+Idgp+LK1ltm0akscwl9QZ0ggIrpZ6LGJ4GPoLc8/a4+qvCVNzOyNpcy4q7QjnW8czbj/pcrg8HoJpkEfJh9cll+l1Iou1j6fZ4SVANjf7KT+wAgJPRjrojQ7IZQnqrCMDLqAyhx8jXbA/lHGsXL4lhqVFBg/JkmxxGMFpWVSQqcze9Jbnfst/7mqpAJgKPUOjCNEL/A1OQ23ADcVG2M8Of1jrfwZZsyP6OJK8ItMadpLl1Opv33R9zwmAbC20gsGzmsQ5I63fjPGE0tpu/4ObelFtNz37CmFgGb9rNOPv9oFBsIPozvTDS6cq53gjGXB1DEEwG0K5JVzQvc6dO
X-MS-Exchange-AntiSpam-MessageData: h+6Txow9OH8260OZ56d+i9yNyKdBNbm1ke1JI3Em5jMptmuiuus0XQWkeOGVBjzjPV9yoUPMMGC24Og3U+4n8JjJb7ljSCASk4FiE/8JjhIhxW9D2FqCfjXdP5qr2p3xbL527qHLkWgb7dspBMRi4w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bffde1-002b-493d-21ca-08d7c6671fd4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:24:11.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5I/6PUme3jPCU2bdxkDOjQqy1EkTolemW+J4HvIaEN8ssKmGsjCoMnUCWMQnQy7UTWj2Rcv5NqNfgvI2773SaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is preparation to move imx_soc_device_init to drivers/soc/imx/

There is no reason to must put dt devices under /sys/devices/soc0,
they could also be under /sys/devices/platform, so we could
pass NULL as parent when calling of_platform_default_populate.

Following soc-imx8.c soc-imx-scu.c using device_initcall, need
to change return type to int type for imx_soc_device_init.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/common.h       | 1 -
 arch/arm/mach-imx/cpu.c          | 9 +++++----
 arch/arm/mach-imx/mach-imx6q.c   | 8 +-------
 arch/arm/mach-imx/mach-imx6sl.c  | 8 +-------
 arch/arm/mach-imx/mach-imx6sx.c  | 8 +-------
 arch/arm/mach-imx/mach-imx6ul.c  | 8 +-------
 arch/arm/mach-imx/mach-imx7d.c   | 6 ------
 arch/arm/mach-imx/mach-imx7ulp.c | 2 +-
 8 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 5aa5796cff0e..72c3fcc32910 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -49,7 +49,6 @@ void imx_aips_allow_unprivileged_access(const char *compat);
 int mxc_device_init(void);
 void imx_set_soc_revision(unsigned int rev);
 void imx_init_revision_from_anatop(void);
-struct device *imx_soc_device_init(void);
 void imx6_enable_rbc(bool enable);
 void imx_gpc_check_dt(void);
 void imx_gpc_set_arm_power_in_lpm(bool power_off);
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 06f8d64b65af..2df649a84697 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -83,7 +83,7 @@ void __init imx_aips_allow_unprivileged_access(
 	}
 }
 
-struct device * __init imx_soc_device_init(void)
+static int __init imx_soc_device_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	const char *ocotp_compat = NULL;
@@ -97,7 +97,7 @@ struct device * __init imx_soc_device_init(void)
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
-		return NULL;
+		return PTR_ERR(soc_dev_attr);
 
 	soc_dev_attr->family = "Freescale i.MX";
 
@@ -219,7 +219,7 @@ struct device * __init imx_soc_device_init(void)
 	if (IS_ERR(soc_dev))
 		goto free_serial_number;
 
-	return soc_device_to_device(soc_dev);
+	return 0;
 
 free_serial_number:
 	kfree(soc_dev_attr->serial_number);
@@ -227,5 +227,6 @@ struct device * __init imx_soc_device_init(void)
 	kfree(soc_dev_attr->revision);
 free_soc:
 	kfree(soc_dev_attr);
-	return NULL;
+	return -ENOMEM;
 }
+device_initcall(imx_soc_device_init);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 284bce1112d2..85c084a716ab 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -245,21 +245,15 @@ static void __init imx6q_axi_init(void)
 
 static void __init imx6q_init_machine(void)
 {
-	struct device *parent;
-
 	if (cpu_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_2_0)
 		imx_print_silicon_rev("i.MX6QP", IMX_CHIP_REVISION_1_0);
 	else
 		imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
 				imx_get_soc_revision());
 
-	parent = imx_soc_device_init();
-	if (parent == NULL)
-		pr_warn("failed to initialize soc device\n");
-
 	imx6q_enet_phy_init();
 
-	of_platform_default_populate(NULL, NULL, parent);
+	of_platform_default_populate(NULL, NULL, NULL);
 
 	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index e27a6889cc56..f6e87363d605 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -45,13 +45,7 @@ static void __init imx6sl_init_late(void)
 
 static void __init imx6sl_init_machine(void)
 {
-	struct device *parent;
-
-	parent = imx_soc_device_init();
-	if (parent == NULL)
-		pr_warn("failed to initialize soc device\n");
-
-	of_platform_default_populate(NULL, NULL, parent);
+	of_platform_default_populate(NULL, NULL, NULL);
 
 	if (cpu_is_imx6sl())
 		imx6sl_fec_init();
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index d5310bf307ff..781e2a94fdd7 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -63,13 +63,7 @@ static inline void imx6sx_enet_init(void)
 
 static void __init imx6sx_init_machine(void)
 {
-	struct device *parent;
-
-	parent = imx_soc_device_init();
-	if (parent == NULL)
-		pr_warn("failed to initialize soc device\n");
-
-	of_platform_default_populate(NULL, NULL, parent);
+	of_platform_default_populate(NULL, NULL, NULL);
 
 	imx6sx_enet_init();
 	imx_anatop_init();
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 3b0e16ccd59d..e018e716735f 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -55,13 +55,7 @@ static inline void imx6ul_enet_init(void)
 
 static void __init imx6ul_init_machine(void)
 {
-	struct device *parent;
-
-	parent = imx_soc_device_init();
-	if (parent == NULL)
-		pr_warn("failed to initialize soc device\n");
-
-	of_platform_default_populate(NULL, NULL, parent);
+	of_platform_default_populate(NULL, NULL, NULL);
 	imx6ul_enet_init();
 	imx_anatop_init();
 	imx6ul_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index ebb27592a9f7..879c35929a13 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -78,12 +78,6 @@ static inline void imx7d_enet_init(void)
 
 static void __init imx7d_init_machine(void)
 {
-	struct device *parent;
-
-	parent = imx_soc_device_init();
-	if (parent == NULL)
-		pr_warn("failed to initialize soc device\n");
-
 	imx_anatop_init();
 	imx7d_enet_init();
 }
diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7ulp.c
index 11ac71aaf965..128cf4c92aab 100644
--- a/arch/arm/mach-imx/mach-imx7ulp.c
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -57,7 +57,7 @@ static void __init imx7ulp_init_machine(void)
 
 	mxc_set_cpu_type(MXC_CPU_IMX7ULP);
 	imx7ulp_set_revision();
-	of_platform_default_populate(NULL, NULL, imx_soc_device_init());
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static const char *const imx7ulp_dt_compat[] __initconst = {
-- 
2.16.4

