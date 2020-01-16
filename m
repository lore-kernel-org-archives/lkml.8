Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C03BC33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2E72075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fJVGKGya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbgAPJhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:37:08 -0500
Received: from mail-eopbgr10082.outbound.protection.outlook.com ([40.107.1.82]:11649
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731587AbgAPJhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:37:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVIWpj5JmHCPBJRA6oPoDSEK2ttRK+s1d4uulVBA4hjQld9R/81aJ2qEjS+7cxsV2vmF1Cxj6haQ/bqmb6IlR1g9njGxgIOGjxcXLArkEi9cmiF+9lmE0K0lzAX65CG6EAbf+/cW/clDKdnTAXMGJqLPwpG0zuDbifkj7DAKp87gMSCi9ab6VQYICj7a/XhONJv+9iU+Fg3+zjTy5zvKS+GUsB+vMKZu9U1OI9FQmE6Dfzh2z22hEh2P826mICKqlDj2ocbVQPIvVY7u+1Y+AdOYAI6T2AF/ZFJ8fyH7o6rynDTo6U405TaDdb7Tqieu76fQFHkx+ZSkcGYiuR8r3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI7ubkJpPBZ/+6HpkR2P1adzymlue4qOjFPzX3A6ePA=;
 b=S06GIRDtinOihftGLP9n9ulqBNp1YQ+9c2740zLKg0Qv/Qa1NqdMh74Xa59SMBNTg1nQ5ZlAaFJ6KTqkKNQ0Rv8Nuc05a4hGwyzvkDG5u+D4bvvEWLQo7m6hWjVr9WF/3A4aga2EFm2cS3mlyq2cBIQ4HpeaJyw+xoRkm1Uwikg+OQIo4DDWtMuxGx73mukB+VrNZBpWHqiWdxWZwx00zHp5K3MCBC9J+tAI9UHDhVwEaHabWVJKZfzcRqQ9wZUVd6pO5+PCJbzrthhpKBqn5vINq/3SXlAR54VzKUaDHY0ELcfgrvL1RnO3Pz8zqnhTnQhkCTiLVt5n9mn5lsx/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI7ubkJpPBZ/+6HpkR2P1adzymlue4qOjFPzX3A6ePA=;
 b=fJVGKGyamDxKm0ZNu2PSp17cJpxNDrGsiPdueSx3aytiPMTIMCZ6Psua/QFvXCBev8b2spqH5M4RWa3wF0f59s1ILQuz4GusQQ5o65r17Y7rNvrTeOSCBYZJr2KdkPaik94CqWkTvdQSrq1fNumt3i50CI3TaOR199l0mqXDXh4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4355.eurprd04.prod.outlook.com (52.134.92.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 09:37:02 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 09:37:02 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:202::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Thu, 16 Jan 2020 09:36:57 +0000
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
Subject: [RFC 4/4] soc: imx: move cpu code to drivers/soc/imx
Thread-Topic: [RFC 4/4] soc: imx: move cpu code to drivers/soc/imx
Thread-Index: AQHVzFCBOFtkNAt6cEKTo8Rz1318mw==
Date:   Thu, 16 Jan 2020 09:37:02 +0000
Message-ID: <1579167145-1480-5-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: d5a3d0e7-f9ed-4c8a-b0c5-08d79a67a3f4
x-ms-traffictypediagnostic: AM0PR04MB4355:|AM0PR04MB4355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB43559731A0516E5DB2D1BBC388360@AM0PR04MB4355.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:108;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(66446008)(64756008)(66556008)(66476007)(66946007)(26005)(16526019)(186003)(52116002)(2906002)(4326008)(478600001)(36756003)(6666004)(7416002)(8936002)(6512007)(5660300002)(44832011)(71200400001)(86362001)(6506007)(69590400006)(6486002)(956004)(316002)(81166006)(81156014)(54906003)(110136005)(8676002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4355;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3OgCaDZxsktCmvpMEM54k4v+np+H2wV4l72+G0L1Amkwfxbfl51R2AFzxrayfpX8DBzmk9zt5ULxKoNtRAB7OFovxfsKRx3x0Q4mZBJ1wAYsKXjZeKAEprz7MtLJ0cn0pELRFr8nC/MpgZooFUTG3jyKCq2ZUQhfmRb8FCpdG1IzsHj/D/9G6VanSGycfO3Cg42GAsf4NhHpmmmrbVsJrRo5V5ANhqPpowDW8J+mQefZQl1+UcSiIPburFEYWMh9nkAUmu6jsaNsl/1rSkdEIuAkNUxHUiUs4D7ZBtFR3d3X5GRu5U8uzrjpmdrPfUINw/GnJOg8Z0Ogl6TMOuqlEe696yzsx+B2Ty9iGZoXrXeucY3C3iZU57ITMhfmspYpfWTNe4EjiJah8y+EuuZnmhjm/I2vYZYloxdQV9B3ni8wYGHBNkGqFOZEeQH+zw1IlBPppJvbGt1FFxvvawhjYf4MtTo53YxiP6eft4ehIMBa3pw+dwLKjUP0lLuS2Rh
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a3d0e7-f9ed-4c8a-b0c5-08d79a67a3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 09:37:02.2703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttnybayV7MG4xS5sPGeqH8ykATJCnQJ799oVmDSkYLr5OV+yop3cJYMhc45on2BXjsUqCRPr9GmUQV7M2wgMnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4355
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Move the soc device register code to drivers/soc/imx to align with
i.MX8.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/cpu.c   | 136 ------------------------------------------
 drivers/soc/imx/Makefile  |   3 +
 drivers/soc/imx/soc-imx.c | 146 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 149 insertions(+), 136 deletions(-)
 create mode 100644 drivers/soc/imx/soc-imx.c

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 0302cb66134b..65c7224f5250 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -1,25 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/regmap.h>
-#include <linux/slab.h>
-#include <linux/sys_soc.h>
=20
 #include "hardware.h"
 #include "common.h"
=20
-#define OCOTP_UID_H	0x420
-#define OCOTP_UID_L	0x410
-
-#define OCOTP_ULP_UID_1		0x4b0
-#define OCOTP_ULP_UID_2		0x4c0
-#define OCOTP_ULP_UID_3		0x4d0
-#define OCOTP_ULP_UID_4		0x4e0
-
 unsigned int __mxc_cpu_type;
 static unsigned int imx_soc_revision;
=20
@@ -82,127 +70,3 @@ void __init imx_aips_allow_unprivileged_access(
 		imx_set_aips(aips_base_addr);
 	}
 }
-
-static int __init imx_soc_device_init(void)
-{
-	struct soc_device_attribute *soc_dev_attr;
-	const char *ocotp_compat =3D NULL;
-	struct soc_device *soc_dev;
-	struct device_node *root;
-	struct regmap *ocotp =3D NULL;
-	const char *soc_id;
-	u64 soc_uid =3D 0;
-	u32 val;
-	int ret;
-
-	soc_dev_attr =3D kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return PTR_ERR(soc_dev_attr);
-
-	soc_dev_attr->family =3D "Freescale i.MX";
-
-	root =3D of_find_node_by_path("/");
-	ret =3D of_property_read_string(root, "model", &soc_dev_attr->machine);
-	of_node_put(root);
-	if (ret)
-		goto free_soc;
-
-	switch (__mxc_cpu_type) {
-	case MXC_CPU_IMX6SL:
-		ocotp_compat =3D "fsl,imx6sl-ocotp";
-		soc_id =3D "i.MX6SL";
-		break;
-	case MXC_CPU_IMX6DL:
-		ocotp_compat =3D "fsl,imx6q-ocotp";
-		soc_id =3D "i.MX6DL";
-		break;
-	case MXC_CPU_IMX6SX:
-		ocotp_compat =3D "fsl,imx6sx-ocotp";
-		soc_id =3D "i.MX6SX";
-		break;
-	case MXC_CPU_IMX6Q:
-		ocotp_compat =3D "fsl,imx6q-ocotp";
-		soc_id =3D "i.MX6Q";
-		break;
-	case MXC_CPU_IMX6UL:
-		ocotp_compat =3D "fsl,imx6ul-ocotp";
-		soc_id =3D "i.MX6UL";
-		break;
-	case MXC_CPU_IMX6ULL:
-		ocotp_compat =3D "fsl,imx6ull-ocotp";
-		soc_id =3D "i.MX6ULL";
-		break;
-	case MXC_CPU_IMX6ULZ:
-		ocotp_compat =3D "fsl,imx6ull-ocotp";
-		soc_id =3D "i.MX6ULZ";
-		break;
-	case MXC_CPU_IMX6SLL:
-		ocotp_compat =3D "fsl,imx6sll-ocotp";
-		soc_id =3D "i.MX6SLL";
-		break;
-	case MXC_CPU_IMX7D:
-		ocotp_compat =3D "fsl,imx7d-ocotp";
-		soc_id =3D "i.MX7D";
-		break;
-	case MXC_CPU_IMX7ULP:
-		ocotp_compat =3D "fsl,imx7ulp-ocotp";
-		soc_id =3D "i.MX7ULP";
-		break;
-	default:
-		soc_id =3D "Unknown";
-	}
-	soc_dev_attr->soc_id =3D soc_id;
-
-	if (ocotp_compat) {
-		ocotp =3D syscon_regmap_lookup_by_compatible(ocotp_compat);
-		if (IS_ERR(ocotp))
-			pr_err("%s: failed to find %s regmap!\n", __func__, ocotp_compat);
-	}
-
-	if (!IS_ERR_OR_NULL(ocotp)) {
-		if (__mxc_cpu_type =3D=3D MXC_CPU_IMX7ULP) {
-			regmap_read(ocotp, OCOTP_ULP_UID_4, &val);
-			soc_uid =3D val & 0xffff;
-			regmap_read(ocotp, OCOTP_ULP_UID_3, &val);
-			soc_uid <<=3D 16;
-			soc_uid |=3D val & 0xffff;
-			regmap_read(ocotp, OCOTP_ULP_UID_2, &val);
-			soc_uid <<=3D 16;
-			soc_uid |=3D val & 0xffff;
-			regmap_read(ocotp, OCOTP_ULP_UID_1, &val);
-			soc_uid <<=3D 16;
-			soc_uid |=3D val & 0xffff;
-		} else {
-			regmap_read(ocotp, OCOTP_UID_H, &val);
-			soc_uid =3D val;
-			regmap_read(ocotp, OCOTP_UID_L, &val);
-			soc_uid <<=3D 32;
-			soc_uid |=3D val;
-		}
-	}
-
-	soc_dev_attr->revision =3D kasprintf(GFP_KERNEL, "%d.%d",
-					   (imx_soc_revision >> 4) & 0xf,
-					   imx_soc_revision & 0xf);
-	if (!soc_dev_attr->revision)
-		goto free_soc;
-
-	soc_dev_attr->serial_number =3D kasprintf(GFP_KERNEL, "%016llX", soc_uid)=
;
-	if (!soc_dev_attr->serial_number)
-		goto free_rev;
-
-	soc_dev =3D soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev))
-		goto free_serial_number;
-
-	return 0;
-
-free_serial_number:
-	kfree(soc_dev_attr->serial_number);
-free_rev:
-	kfree(soc_dev_attr->revision);
-free_soc:
-	kfree(soc_dev_attr);
-	return -ENOMEM;
-}
-device_initcall(imx_soc_device_init);
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 103e2c93c342..45dd49df3044 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
+obj-$(CONFIG_SOC_IMX6)+=3D soc-imx.o
+obj-$(CONFIG_SOC_IMX7D)+=3D soc-imx.o
+obj-$(CONFIG_SOC_IMX7ULP)+=3D soc-imx.o
 obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
 obj-$(CONFIG_IMX_SCU_SOC) +=3D soc-imx-scu.o
diff --git a/drivers/soc/imx/soc-imx.c b/drivers/soc/imx/soc-imx.c
new file mode 100644
index 000000000000..e01c7ccf1f4b
--- /dev/null
+++ b/drivers/soc/imx/soc-imx.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 NXP.
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#include <soc/imx/cpu.h>
+#include <soc/imx/revision.h>
+
+#define OCOTP_UID_H	0x420
+#define OCOTP_UID_L	0x410
+
+#define OCOTP_ULP_UID_1		0x4b0
+#define OCOTP_ULP_UID_2		0x4c0
+#define OCOTP_ULP_UID_3		0x4d0
+#define OCOTP_ULP_UID_4		0x4e0
+
+static int __init imx_soc_device_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	const char *ocotp_compat =3D NULL;
+	struct soc_device *soc_dev;
+	struct device_node *root;
+	struct regmap *ocotp =3D NULL;
+	const char *soc_id;
+	u64 soc_uid =3D 0;
+	u32 val;
+	int ret;
+
+	soc_dev_attr =3D kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return PTR_ERR(soc_dev_attr);
+
+	soc_dev_attr->family =3D "Freescale i.MX";
+
+	root =3D of_find_node_by_path("/");
+	ret =3D of_property_read_string(root, "model", &soc_dev_attr->machine);
+	of_node_put(root);
+	if (ret)
+		goto free_soc;
+
+	switch (__mxc_cpu_type) {
+	case MXC_CPU_IMX6SL:
+		ocotp_compat =3D "fsl,imx6sl-ocotp";
+		soc_id =3D "i.MX6SL";
+		break;
+	case MXC_CPU_IMX6DL:
+		ocotp_compat =3D "fsl,imx6q-ocotp";
+		soc_id =3D "i.MX6DL";
+		break;
+	case MXC_CPU_IMX6SX:
+		ocotp_compat =3D "fsl,imx6sx-ocotp";
+		soc_id =3D "i.MX6SX";
+		break;
+	case MXC_CPU_IMX6Q:
+		ocotp_compat =3D "fsl,imx6q-ocotp";
+		soc_id =3D "i.MX6Q";
+		break;
+	case MXC_CPU_IMX6UL:
+		ocotp_compat =3D "fsl,imx6ul-ocotp";
+		soc_id =3D "i.MX6UL";
+		break;
+	case MXC_CPU_IMX6ULL:
+		ocotp_compat =3D "fsl,imx6ull-ocotp";
+		soc_id =3D "i.MX6ULL";
+		break;
+	case MXC_CPU_IMX6ULZ:
+		ocotp_compat =3D "fsl,imx6ull-ocotp";
+		soc_id =3D "i.MX6ULZ";
+		break;
+	case MXC_CPU_IMX6SLL:
+		ocotp_compat =3D "fsl,imx6sll-ocotp";
+		soc_id =3D "i.MX6SLL";
+		break;
+	case MXC_CPU_IMX7D:
+		ocotp_compat =3D "fsl,imx7d-ocotp";
+		soc_id =3D "i.MX7D";
+		break;
+	case MXC_CPU_IMX7ULP:
+		ocotp_compat =3D "fsl,imx7ulp-ocotp";
+		soc_id =3D "i.MX7ULP";
+		break;
+	default:
+		soc_id =3D "Unknown";
+	}
+	soc_dev_attr->soc_id =3D soc_id;
+
+	if (ocotp_compat) {
+		ocotp =3D syscon_regmap_lookup_by_compatible(ocotp_compat);
+		if (IS_ERR(ocotp))
+			pr_err("%s: failed to find %s regmap!\n", __func__, ocotp_compat);
+	}
+
+	if (!IS_ERR_OR_NULL(ocotp)) {
+		if (__mxc_cpu_type =3D=3D MXC_CPU_IMX7ULP) {
+			regmap_read(ocotp, OCOTP_ULP_UID_4, &val);
+			soc_uid =3D val & 0xffff;
+			regmap_read(ocotp, OCOTP_ULP_UID_3, &val);
+			soc_uid <<=3D 16;
+			soc_uid |=3D val & 0xffff;
+			regmap_read(ocotp, OCOTP_ULP_UID_2, &val);
+			soc_uid <<=3D 16;
+			soc_uid |=3D val & 0xffff;
+			regmap_read(ocotp, OCOTP_ULP_UID_1, &val);
+			soc_uid <<=3D 16;
+			soc_uid |=3D val & 0xffff;
+		} else {
+			regmap_read(ocotp, OCOTP_UID_H, &val);
+			soc_uid =3D val;
+			regmap_read(ocotp, OCOTP_UID_L, &val);
+			soc_uid <<=3D 32;
+			soc_uid |=3D val;
+		}
+	}
+
+	soc_dev_attr->revision =3D kasprintf(GFP_KERNEL, "%d.%d",
+					   (imx_get_soc_revision() >> 4) & 0xf,
+					   imx_get_soc_revision() & 0xf);
+	if (!soc_dev_attr->revision)
+		goto free_soc;
+
+	soc_dev_attr->serial_number =3D kasprintf(GFP_KERNEL, "%016llX", soc_uid)=
;
+	if (!soc_dev_attr->serial_number)
+		goto free_rev;
+
+	soc_dev =3D soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		goto free_serial_number;
+
+	return 0;
+
+free_serial_number:
+	kfree(soc_dev_attr->serial_number);
+free_rev:
+	kfree(soc_dev_attr->revision);
+free_soc:
+	kfree(soc_dev_attr);
+	return -ENOMEM;
+}
+device_initcall(imx_soc_device_init);
--=20
2.16.4

