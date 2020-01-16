Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A4EC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF3F20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pB6LrRy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgAPJgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:36:52 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:56800
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgAPJgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:36:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmxy7hYNeJwBuFRughBtBK0JTRSOhyp7tJrT8EfvsuqztO3yRTDrzJ3m7jZ67SnJ8KTIRNWLUdUGz7GOKwIlVvwbDDvbTkL5QNBl1/7Dc/NeZeBgMWRSnPdLoiKzVYiEkbHcjzT3r7szrHejtI5kcUjFS23XzEKbzSyvp1lrNy9YaceIEEPgBU0o9rqUTxzTwSHRHcUalVIlEiHptr9srZAYFBidUs6bqm6dpuxg5f4B6BDuimuqsxP3Vl3wvl4e/+R4NyakdXuFaBMLKBcrS3wDK4ssBDpPnHZr0ZVvtEFYDLP9Lb6qJIIskmEFKniDWj5/45cWu3uHBIG5i+XXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDBjEp4ekHynZOedeToWfedR2/wJxwlLC2SQXexxIzs=;
 b=kyApLmTPFdlafhj0JLpoymvsuQsWZsTOaSr5O/sjzu6pHx0iuTatkbUpfLr9qPKx5kTejxcvfE3qsgs4OsNDoOIjl2UEbccwy949npmdUizdxQLsG3vxRJ9+lHXugRepMmenpFToVEyEFElhuT2TDdv+3BBM+fYbnT8C+wzqn8Wg7AN9BGFs/LxPBwK7fRB3H9KpZrAgc9cth/LtSf12DBZdk+JcKBVK5+zqkrdOjcoWRotQ+yS3yNKnnFTM7DxfUPlYoAScaJZPptnTSOIlAA62ObgcpJaPnIDnvGLum1fAvhUKUtQJUZD2SL3k52wbxCIN8hzk44CvW1HuyZotfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDBjEp4ekHynZOedeToWfedR2/wJxwlLC2SQXexxIzs=;
 b=pB6LrRy203Pf/igPHp7tiBmw+JVzFLcU3CAKtxSOF3lE7CzZvrJSxt2rbnZdT6XhxPKz6DhsC6of8A/jxBfTKC2Hp3029/W8nwFgs7Q8bvz4bDPlJ376pQ5ruCYxn8yR8qjeTVJ/7Q+HWqIQ/IJDCOljK2eINwJCK+FAZoZrOJA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4337.eurprd04.prod.outlook.com (52.134.124.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 09:36:48 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 09:36:48 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:202::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Thu, 16 Jan 2020 09:36:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "info@metux.net" <info@metux.net>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "git@andred.net" <git@andred.net>, Abel Vesa <abel.vesa@nxp.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC 1/4] ARM: imx: use device_initcall for imx_soc_device_init
Thread-Topic: [RFC 1/4] ARM: imx: use device_initcall for imx_soc_device_init
Thread-Index: AQHVzFB5yGe49vkt3U6MybEMHs/GuA==
Date:   Thu, 16 Jan 2020 09:36:48 +0000
Message-ID: <1579167145-1480-2-git-send-email-peng.fan@nxp.com>
References: <1579167145-1480-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1579167145-1480-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61d910c8-ccbe-4489-dc4f-08d79a679b79
x-ms-traffictypediagnostic: AM0PR04MB4337:|AM0PR04MB4337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB433700B7BCDAF4CA6AAE132588360@AM0PR04MB4337.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(8936002)(86362001)(69590400006)(71200400001)(6512007)(186003)(16526019)(52116002)(956004)(44832011)(2616005)(6486002)(26005)(6506007)(478600001)(4326008)(7416002)(2906002)(81166006)(66556008)(81156014)(66476007)(66446008)(8676002)(110136005)(316002)(54906003)(5660300002)(36756003)(66946007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4337;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fwPvO3Fq8djF21uqcEi+nmDfUXt6dIP1x1oGNXK3RcqEZF+48qzAgwRGZ7YTIwQjpeA9Lvx03BqRDCgvwyC/qZKMCf3CcNR/YYETkpQDaSm+MXArBjphz7s3X0j5FEh1npzzJpTG8BCOph2z/5SrUUmj2gyDLkmtSO7eKxgayYT7RXzrhQ0XpuAuGwQB7zdd2/8OjIGkOHLzYY43ROOKSGN0eTP/e5TolzMcF0m/v6bXR2MMTDVytrN4+H0qdqiBHsrvWUQ4CGn276GFENxaRZU/tvxuBcqjW7OmKN2RVEEvwEh96ImVKKQzB+tHaKsxkFJOMob9D/Bit3X3w6LCenPH+UlDjnf9h1tNJNT3orLCA+piCSQv1FwOh2vC715DGDa9CjKS09tj6+p01cMHsDHWyhKf6a58OLWVBytZ/bpAMwXlzNO1nqHaOdxfmX6Usj3/kPhcO0h6ljJu1M47KUyU0uKH8XE+hptESk9MT42BCO/OZOH/KzlazhZoBkf
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d910c8-ccbe-4489-dc4f-08d79a679b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 09:36:48.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exzDltkTiyf2S5S9HKpxHbG5J1GwM9rh2FATlXw1OFRGNcCfnnBLp7d3848X4DWC6okw83wAozjNpBa6teTodg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4337
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
index 912aeceb4ff8..09e89aa7be50 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -49,7 +49,6 @@ void imx_aips_allow_unprivileged_access(const char *compa=
t);
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
=20
-struct device * __init imx_soc_device_init(void)
+static int __init imx_soc_device_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	const char *ocotp_compat =3D NULL;
@@ -97,7 +97,7 @@ struct device * __init imx_soc_device_init(void)
=20
 	soc_dev_attr =3D kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
-		return NULL;
+		return PTR_ERR(soc_dev_attr);
=20
 	soc_dev_attr->family =3D "Freescale i.MX";
=20
@@ -219,7 +219,7 @@ struct device * __init imx_soc_device_init(void)
 	if (IS_ERR(soc_dev))
 		goto free_serial_number;
=20
-	return soc_device_to_device(soc_dev);
+	return 0;
=20
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
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.=
c
index edd26e0ffeec..735da3311320 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -258,21 +258,15 @@ static void __init imx6q_axi_init(void)
=20
 static void __init imx6q_init_machine(void)
 {
-	struct device *parent;
-
 	if (cpu_is_imx6q() && imx_get_soc_revision() =3D=3D IMX_CHIP_REVISION_2_0=
)
 		imx_print_silicon_rev("i.MX6QP", IMX_CHIP_REVISION_1_0);
 	else
 		imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
 				imx_get_soc_revision());
=20
-	parent =3D imx_soc_device_init();
-	if (parent =3D=3D NULL)
-		pr_warn("failed to initialize soc device\n");
-
 	imx6q_enet_phy_init();
=20
-	of_platform_default_populate(NULL, NULL, parent);
+	of_platform_default_populate(NULL, NULL, NULL);
=20
 	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6s=
l.c
index e00818abe54d..0f046a37dc73 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -46,13 +46,7 @@ static void __init imx6sl_init_late(void)
=20
 static void __init imx6sl_init_machine(void)
 {
-	struct device *parent;
-
-	parent =3D imx_soc_device_init();
-	if (parent =3D=3D NULL)
-		pr_warn("failed to initialize soc device\n");
-
-	of_platform_default_populate(NULL, NULL, parent);
+	of_platform_default_populate(NULL, NULL, NULL);
=20
 	if (cpu_is_imx6sl())
 		imx6sl_fec_init();
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6s=
x.c
index d5310bf307ff..781e2a94fdd7 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -63,13 +63,7 @@ static inline void imx6sx_enet_init(void)
=20
 static void __init imx6sx_init_machine(void)
 {
-	struct device *parent;
-
-	parent =3D imx_soc_device_init();
-	if (parent =3D=3D NULL)
-		pr_warn("failed to initialize soc device\n");
-
-	of_platform_default_populate(NULL, NULL, parent);
+	of_platform_default_populate(NULL, NULL, NULL);
=20
 	imx6sx_enet_init();
 	imx_anatop_init();
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6u=
l.c
index 311f5e4ff723..9db8e567c6b5 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -56,13 +56,7 @@ static inline void imx6ul_enet_init(void)
=20
 static void __init imx6ul_init_machine(void)
 {
-	struct device *parent;
-
-	parent =3D imx_soc_device_init();
-	if (parent =3D=3D NULL)
-		pr_warn("failed to initialize soc device\n");
-
-	of_platform_default_populate(NULL, NULL, parent);
+	of_platform_default_populate(NULL, NULL, NULL);
 	imx6ul_enet_init();
 	imx_anatop_init();
 	imx6ul_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.=
c
index ebb27592a9f7..879c35929a13 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -78,12 +78,6 @@ static inline void imx7d_enet_init(void)
=20
 static void __init imx7d_init_machine(void)
 {
-	struct device *parent;
-
-	parent =3D imx_soc_device_init();
-	if (parent =3D=3D NULL)
-		pr_warn("failed to initialize soc device\n");
-
 	imx_anatop_init();
 	imx7d_enet_init();
 }
diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7=
ulp.c
index 11ac71aaf965..128cf4c92aab 100644
--- a/arch/arm/mach-imx/mach-imx7ulp.c
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -57,7 +57,7 @@ static void __init imx7ulp_init_machine(void)
=20
 	mxc_set_cpu_type(MXC_CPU_IMX7ULP);
 	imx7ulp_set_revision();
-	of_platform_default_populate(NULL, NULL, imx_soc_device_init());
+	of_platform_default_populate(NULL, NULL, NULL);
 }
=20
 static const char *const imx7ulp_dt_compat[] __initconst =3D {
--=20
2.16.4

