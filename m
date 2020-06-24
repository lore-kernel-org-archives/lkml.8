Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B08C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5651220CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YridMgmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403773AbgFXMdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:33:53 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:27894
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388761AbgFXMdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:33:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqRrgW0305Hj0JhNPWgNP/QOxHHlvrjmevyefCVn6T5coMYeGXCMcKwKSjikjl6nK1QvWnyYc0woZEUONNR1OqCBEg8y8QRqTNVm+fI0hPNa7SVjpUWBimg4uGaXWm6VmNgZY6T4KgYz4WhvljJayvWqZu26bst7wBdGds9WoC6RdXPo4FrhWMnCPIVmBU63PAoZvFUGj3b4lMzkwkMeiuWHFJaVesfLGJIflyOtvRRoa0Qbz82Mu4b5I/oOxadUuOw4C6kLg0DCEQTuWqt6WibSBbwPxb02gvMPNiwRMIU48ZIZVy4OeqXRXGZ0d7cg2vmJ2nLK4nE/hvENQpJ9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClO5I2bsUn+AyjxrqKfNvwQVcx9kriZ0Te1WkcvpI1I=;
 b=hbnozUIOxFfbsgNUx8f+4IChXoafrH+8fWKkdpuAvbxpF3wO87BvVjHioF9Suqlb5WfrrVG3yz6cJgYb/LC7bOHYzwrpCadVm2dLeFZLmHjU7simLSewLXrshWuDHXiLO1ZeBSNukDdLTb3WxCBmDi1n2alIJ/dMzYlRQswVcMaRslgZxjuIK600oaj7zdmNC8n3sYKp1WWg4+gD5FxrMd7w5oDeICPWBHsLr2CogH4Y5E4WyVkbg8Qoh+xUlseLxTZ0JadbyiuA2WVp+M6PGVe97LdgHD7bTl1bN9kqHXdGHrXUFJNnMLcc4jAMdOa2oWCYH8GhmY3bhu9acdmzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClO5I2bsUn+AyjxrqKfNvwQVcx9kriZ0Te1WkcvpI1I=;
 b=YridMgmkSxoCDfVPWL3L351ZpGegX2QHubGDJoAUS69SEEhKZWIL20NZES4AYfvZSyQrgID/6l+0uYTOVsDyuwg+F5RgUqQ/iZiup/dCNEbnDnktmQiGc0/pJwS4yYw7aGL+IF2voXGCHwPLE4mdw1lytLhEwwrcj5wf1quoBD0=
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB4593.eurprd04.prod.outlook.com
 (2603:10a6:208:76::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 12:33:44 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::7002:8bcf:59b6:dca]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::7002:8bcf:59b6:dca%11]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 12:33:44 +0000
From:   Franck Lenormand <franck.lenormand@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "olof@lixom.net" <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] firmware: imx: Move i.MX SCU soc driver into SCU firmware
 driver
Thread-Topic: [PATCH] firmware: imx: Move i.MX SCU soc driver into SCU
 firmware driver
Thread-Index: AQHWSiI9sFJUktKfZ0ueTRO9gk8o56jnsbFA
Date:   Wed, 24 Jun 2020 12:33:44 +0000
Message-ID: <AM4PR0401MB24016D7F1E97F70AEC23BEB392950@AM4PR0401MB2401.eurprd04.prod.outlook.com>
References: <1593000687-12213-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593000687-12213-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [82.242.109.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6786d14d-e8ee-4f3a-db40-08d8183ad5e2
x-ms-traffictypediagnostic: AM0PR04MB4593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4593C94A17F254D8AEE3BA6092950@AM0PR04MB4593.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NxvWE6qR+me6AbUb3oqnrw+vxO9SNo7+niehLv+3DA8JCs2IW0UdKkeAdje1oPg5spSMJ0tgCQCSwiAyeoYgfNiCNdVJ61aPkUoZkU9fGvlqcas5iM1Ffwu6onRUIM4eHt/fMGJCNi0F1XEhDEfMQcG0Dl/kFwd2zpYY7I6pbHPpkwfzg1uYXguhaQbvieNQNo3F6jT80QhpkM/y4HwgJyp27R06uVCxxxFy5VyqtAq+cVD66RirJXj9VdLzEbb5pRftiGbOwA8ENx79sUgNhJ/yCmh/RrvNz7ts5zbAY/ecRhiIfFBttuepL3jPjk1HnCK8KIOAavGQ1UkTqCpMt6m/E8UCy3Qdad63hb3+SbgRuFTsk7wCbfQ6/Wgn23kF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(53546011)(7696005)(83380400001)(44832011)(33656002)(26005)(86362001)(66556008)(66446008)(2906002)(64756008)(66476007)(71200400001)(52536014)(8936002)(8676002)(6506007)(9686003)(478600001)(5660300002)(110136005)(186003)(55016002)(76116006)(30864003)(316002)(4326008)(66946007)(7416002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: q8idKxQrUIOlRsJy+uOfLRuW8ZtSXHelE+oQl9lQoUfpMcknsA6fGXr0rSABEHI4Jc5n1YPWTwTH3Io1D2mL/oGaI1veR8B7AlWPLBaouNd5qCGctfbDxOgPktIxhUB7k7bs59YwyCyG4/Lx3TgVgUi6dcP4H67vdLduw/HWBUKakfDQCrg6TI+e0S2/Yh+1kBW5Qdwg7iovsWUMA+pzlPx334RUIy918wTNyHHWFMBLnEzaIC7YYXfU8FX/m4mCgPSiXxXXY3UgrVo4o0+a2oRW7szFBA0My3YP8Vz6/8jSVc1naTLKH+E1V9rLwegP+potIGV6lVv5TV9Zo9n3hjRjkYaF4aiwR0ANmAcd97jw8CPgNi0vjILGMWP1eNXjUzlI4h1apxns/gkBies1TsJviTTnnA1aeOyZYIKO9OydVfhVhPGnaK8llenhyCiDYurQ1g73aD47G/3JuK3czogNTHkEziSiLuB2vKPMKkk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6786d14d-e8ee-4f3a-db40-08d8183ad5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 12:33:44.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anNtTJdjF6mpvU2ai0xPxSY09xihRC5BvYkNgwlLKE58BgC8nuxtJVG1koVMyanZiX5lMQJj4gItQbuKnWVk8koD7amc4tmYRhAbTSnG1JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The move of folder is a good idea however I do not feel adding the code of =
soc-imx-scu.c  to imx-scu.c is the best.
Until now imx-scu.c was focused on exchanging the RPC and init the IRQ.
Why not have soc-imx-scu.c  copied to imx-scu-soc.c (change filename) to ha=
ve a pattern similar to imx-scu-irq? And keep the  imx_scu_soc_init into im=
x-scu.c.

Regards,

Franck LENORMAND, STEC Engineer

-----Original Message-----
From: Anson Huang <Anson.Huang@nxp.com>=20
Sent: Wednesday, June 24, 2020 2:11 PM
To: catalin.marinas@arm.com; will@kernel.org; shawnguo@kernel.org; s.hauer@=
pengutronix.de; kernel@pengutronix.de; festevam@gmail.com; bjorn.andersson@=
linaro.org; Leo Li <leoyang.li@nxp.com>; vkoul@kernel.org; geert+renesas@gl=
ider.be; olof@lixom.net; Leonard Crestez <leonard.crestez@nxp.com>; Aisheng=
 Dong <aisheng.dong@nxp.com>; Peng Fan <peng.fan@nxp.com>; Franck Lenormand=
 <franck.lenormand@nxp.com>; arnd@arndb.de; krzk@kernel.org; Daniel Baluta =
<daniel.baluta@nxp.com>; linux-arm-kernel@lists.infradead.org; linux-kernel=
@vger.kernel.org
Cc: dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] firmware: imx: Move i.MX SCU soc driver into SCU firmware =
driver

The i.MX SCU soc driver depends on SCU firmware driver, so it has to use pl=
atform driver model for proper defer probe operation, since it has no devic=
e binding in DT file, a simple platform device is created together inside t=
he platform driver. To make it more clean, we can just move the entire SCU =
soc driver into SCU firmware driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig   |   1 -
 drivers/firmware/imx/imx-scu.c | 127 ++++++++++++++++++++++++++++++
 drivers/soc/imx/Kconfig        |   9 ---
 drivers/soc/imx/Makefile       |   1 -
 drivers/soc/imx/soc-imx-scu.c  | 172 -------------------------------------=
----
 5 files changed, 127 insertions(+), 183 deletions(-)  delete mode 100644 d=
rivers/soc/imx/soc-imx-scu.c

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig in=
dex ae76fae..35f037f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -854,7 +854,6 @@ CONFIG_OWL_PM_DOMAINS=3Dy  CONFIG_RASPBERRYPI_POWER=3Dy=
  CONFIG_FSL_DPAA=3Dy  CONFIG_FSL_MC_DPIO=3Dy -CONFIG_IMX_SCU_SOC=3Dy  CONF=
IG_QCOM_AOSS_QMP=3Dy  CONFIG_QCOM_GENI_SE=3Dy  CONFIG_QCOM_RMTFS_MEM=3Dm di=
ff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c =
index 2ab0482..2719487 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -7,6 +7,7 @@
  *
  */
=20
+#include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/err.h>
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/sci.h>
@@ -18,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/sys_soc.h>
=20
 #define SCU_MU_CHAN_NUM		8
 #define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
@@ -45,6 +47,25 @@ struct imx_sc_ipc {
 	u8 count;
 };
=20
+struct imx_sc_msg_misc_get_soc_id {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct {
+			u32 control;
+			u16 resource;
+		} __packed req;
+		struct {
+			u32 id;
+		} resp;
+	} data;
+} __packed __aligned(4);
+
+struct imx_sc_msg_misc_get_soc_uid {
+	struct imx_sc_rpc_msg hdr;
+	u32 uid_low;
+	u32 uid_high;
+} __packed;
+
 /*
  * This type is used to indicate error response for most functions.
  */
@@ -257,6 +278,108 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void =
*msg, bool have_resp)  }  EXPORT_SYMBOL(imx_scu_call_rpc);
=20
+static int imx_scu_soc_uid(u64 *soc_uid) {
+	struct imx_sc_msg_misc_get_soc_uid msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_MISC;
+	hdr->func =3D IMX_SC_MISC_FUNC_UNIQUE_ID;
+	hdr->size =3D 1;
+
+	ret =3D imx_scu_call_rpc(imx_sc_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	*soc_uid =3D msg.uid_high;
+	*soc_uid <<=3D 32;
+	*soc_uid |=3D msg.uid_low;
+
+	return 0;
+}
+
+static int imx_scu_soc_id(void)
+{
+	struct imx_sc_msg_misc_get_soc_id msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_MISC;
+	hdr->func =3D IMX_SC_MISC_FUNC_GET_CONTROL;
+	hdr->size =3D 3;
+
+	msg.data.req.control =3D IMX_SC_C_ID;
+	msg.data.req.resource =3D IMX_SC_R_SYSTEM;
+
+	ret =3D imx_scu_call_rpc(imx_sc_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("%s: get soc info failed, ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	return msg.data.resp.id;
+}
+
+static int imx_scu_soc_init(struct device *dev) {
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	int id, ret;
+	u64 uid =3D 0;
+	u32 val;
+
+	soc_dev_attr =3D devm_kzalloc(dev, sizeof(*soc_dev_attr),
+				    GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family =3D "Freescale i.MX";
+
+	ret =3D of_property_read_string(of_root,
+				      "model",
+				      &soc_dev_attr->machine);
+	if (ret)
+		return ret;
+
+	id =3D imx_scu_soc_id();
+	if (id < 0)
+		return -EINVAL;
+
+	ret =3D imx_scu_soc_uid(&uid);
+	if (ret < 0)
+		return -EINVAL;
+
+	/* format soc_id value passed from SCU firmware */
+	val =3D id & 0x1f;
+	soc_dev_attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL, "0x%x", val);
+	if (!soc_dev_attr->soc_id)
+		return -ENOMEM;
+
+	/* format revision value passed from SCU firmware */
+	val =3D (id >> 5) & 0xf;
+	val =3D (((val >> 2) + 1) << 4) | (val & 0x3);
+	soc_dev_attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
+						(val >> 4) & 0xf, val & 0xf);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
+
+	soc_dev_attr->serial_number =3D devm_kasprintf(dev, GFP_KERNEL,
+						     "%016llX", uid);
+	if (!soc_dev_attr->serial_number)
+		return -ENOMEM;
+
+	soc_dev =3D soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	return 0;
+}
+
 static int imx_scu_probe(struct platform_device *pdev)  {
 	struct device *dev =3D &pdev->dev;
@@ -328,6 +451,10 @@ static int imx_scu_probe(struct platform_device *pdev)
=20
 	imx_sc_ipc_handle =3D sc_ipc;
=20
+	ret =3D imx_scu_soc_init(dev);
+	if (ret)
+		dev_warn(dev, "failed to initialize SoC info: %d\n", ret);
+
 	ret =3D imx_scu_enable_general_irq_channel(dev);
 	if (ret)
 		dev_warn(dev,
diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index d515d2=
c..d49fa63 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -8,15 +8,6 @@ config IMX_GPCV2_PM_DOMAINS
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
=20
-config IMX_SCU_SOC
-	bool "i.MX System Controller Unit SoC info support"
-	depends on IMX_SCU
-	select SOC_BUS
-	help
-	  If you say yes here you get support for the NXP i.MX System
-	  Controller Unit SoC info module, it will provide the SoC info
-	  like SoC family, ID and revision etc.
-
 config SOC_IMX8M
 	bool "i.MX8M SoC family support"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile index 4461=
432..078dc91 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -5,4 +5,3 @@ endif
 obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
-obj-$(CONFIG_IMX_SCU_SOC) +=3D soc-imx-scu.o diff --git a/drivers/soc/imx/=
soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c deleted file mode 100644 inde=
x 92448ca..0000000
--- a/drivers/soc/imx/soc-imx-scu.c
+++ /dev/null
@@ -1,172 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2019 NXP.
- */
-
-#include <dt-bindings/firmware/imx/rsrc.h> -#include <linux/firmware/imx/s=
ci.h> -#include <linux/slab.h> -#include <linux/sys_soc.h> -#include <linux=
/platform_device.h> -#include <linux/of.h>
-
-#define IMX_SCU_SOC_DRIVER_NAME		"imx-scu-soc"
-
-static struct imx_sc_ipc *soc_ipc_handle;
-
-struct imx_sc_msg_misc_get_soc_id {
-	struct imx_sc_rpc_msg hdr;
-	union {
-		struct {
-			u32 control;
-			u16 resource;
-		} __packed req;
-		struct {
-			u32 id;
-		} resp;
-	} data;
-} __packed __aligned(4);
-
-struct imx_sc_msg_misc_get_soc_uid {
-	struct imx_sc_rpc_msg hdr;
-	u32 uid_low;
-	u32 uid_high;
-} __packed;
-
-static int imx_scu_soc_uid(u64 *soc_uid) -{
-	struct imx_sc_msg_misc_get_soc_uid msg;
-	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
-	int ret;
-
-	hdr->ver =3D IMX_SC_RPC_VERSION;
-	hdr->svc =3D IMX_SC_RPC_SVC_MISC;
-	hdr->func =3D IMX_SC_MISC_FUNC_UNIQUE_ID;
-	hdr->size =3D 1;
-
-	ret =3D imx_scu_call_rpc(soc_ipc_handle, &msg, true);
-	if (ret) {
-		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
-		return ret;
-	}
-
-	*soc_uid =3D msg.uid_high;
-	*soc_uid <<=3D 32;
-	*soc_uid |=3D msg.uid_low;
-
-	return 0;
-}
-
-static int imx_scu_soc_id(void)
-{
-	struct imx_sc_msg_misc_get_soc_id msg;
-	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
-	int ret;
-
-	hdr->ver =3D IMX_SC_RPC_VERSION;
-	hdr->svc =3D IMX_SC_RPC_SVC_MISC;
-	hdr->func =3D IMX_SC_MISC_FUNC_GET_CONTROL;
-	hdr->size =3D 3;
-
-	msg.data.req.control =3D IMX_SC_C_ID;
-	msg.data.req.resource =3D IMX_SC_R_SYSTEM;
-
-	ret =3D imx_scu_call_rpc(soc_ipc_handle, &msg, true);
-	if (ret) {
-		pr_err("%s: get soc info failed, ret %d\n", __func__, ret);
-		return ret;
-	}
-
-	return msg.data.resp.id;
-}
-
-static int imx_scu_soc_probe(struct platform_device *pdev) -{
-	struct soc_device_attribute *soc_dev_attr;
-	struct soc_device *soc_dev;
-	int id, ret;
-	u64 uid =3D 0;
-	u32 val;
-
-	ret =3D imx_scu_get_handle(&soc_ipc_handle);
-	if (ret)
-		return ret;
-
-	soc_dev_attr =3D devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
-				    GFP_KERNEL);
-	if (!soc_dev_attr)
-		return -ENOMEM;
-
-	soc_dev_attr->family =3D "Freescale i.MX";
-
-	ret =3D of_property_read_string(of_root,
-				      "model",
-				      &soc_dev_attr->machine);
-	if (ret)
-		return ret;
-
-	id =3D imx_scu_soc_id();
-	if (id < 0)
-		return -EINVAL;
-
-	ret =3D imx_scu_soc_uid(&uid);
-	if (ret < 0)
-		return -EINVAL;
-
-	/* format soc_id value passed from SCU firmware */
-	val =3D id & 0x1f;
-	soc_dev_attr->soc_id =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "0x%x", v=
al);
-	if (!soc_dev_attr->soc_id)
-		return -ENOMEM;
-
-	/* format revision value passed from SCU firmware */
-	val =3D (id >> 5) & 0xf;
-	val =3D (((val >> 2) + 1) << 4) | (val & 0x3);
-	soc_dev_attr->revision =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%d.%d"=
,
-						(val >> 4) & 0xf, val & 0xf);
-	if (!soc_dev_attr->revision)
-		return -ENOMEM;
-
-	soc_dev_attr->serial_number =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						     "%016llX", uid);
-	if (!soc_dev_attr->serial_number)
-		return -ENOMEM;
-
-	soc_dev =3D soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev))
-		return PTR_ERR(soc_dev);
-
-	return 0;
-}
-
-static struct platform_driver imx_scu_soc_driver =3D {
-	.driver =3D {
-		.name =3D IMX_SCU_SOC_DRIVER_NAME,
-	},
-	.probe =3D imx_scu_soc_probe,
-};
-
-static int __init imx_scu_soc_init(void) -{
-	struct platform_device *pdev;
-	struct device_node *np;
-	int ret;
-
-	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx-scu");
-	if (!np)
-		return -ENODEV;
-
-	of_node_put(np);
-
-	ret =3D platform_driver_register(&imx_scu_soc_driver);
-	if (ret)
-		return ret;
-
-	pdev =3D platform_device_register_simple(IMX_SCU_SOC_DRIVER_NAME,
-					       -1, NULL, 0);
-	if (IS_ERR(pdev))
-		platform_driver_unregister(&imx_scu_soc_driver);
-
-	return PTR_ERR_OR_ZERO(pdev);
-}
-device_initcall(imx_scu_soc_init);
--
2.7.4

