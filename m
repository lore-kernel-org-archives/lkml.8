Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911B3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551A2207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bO0fI40o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgA1Orp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:47:45 -0500
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:59015
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbgA1Orf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:47:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXYDHwFVTzrHTN9F7MBtR9wV2A0MwNcqubbqM38GkPx/rWx3vhlNmoQ9efAiOBFW5ojfyqDMOQmLuJU34KzpMMepmF1zq3LiVCWQ2Dyq+NyNy7aA0ScDUvIBcBf99/Uq8SkUBVJCTw7wP9SiMM8fR6iK1ZqyKqgSIGbpyhrT3PycVUNgcboydpbeSLyAwUFli/ZwOe/Jlgk2zdpjHZc5/JpcXBXTVBxM/KnwY0KNaP/GbdjMyTfNE/w7AdJnB6HdJISfosJh15Zcpmh1jplGTZKbWnS3veRoMCNcUKllmIj881VOVaWzaKwtmxoIK4h3dZdGS7SO38qwQy2w7m4egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tlwq5K4/chX7Z6HS9u+EsJBHmeleJCJJnM8FeDatjV8=;
 b=SR4AXdpQUxgYO7xkyDjlc8A46BGoc4w7ybXfbaITTbcKP+3DdvoB+JAuRV6JfMFT+k53DComeAYo4LVGMhDj7PQ0qHDhgsbZp3UpzBysw5WLsww5b0KFRVSWPIroV4GN0o8mSgV09sZL52WeRR75WGPqdyRKPvEg5FaAdF7iWLI0EdRLWAKhdS71ITxMAJQSS5o3wgO1kGz9OcHDyNvJtg7fY2QXqGf6UONT5ShNh38Uo/a/k8Zmkh+Mn985M3sf3ZU95b69oZo6sDnCCUcqzoiZBP87Vjpc8TPrD7125PJoP/wHQ3CXvyFz5dCx396ZzM4CgG3/8G6Qmw+PnjJDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tlwq5K4/chX7Z6HS9u+EsJBHmeleJCJJnM8FeDatjV8=;
 b=bO0fI40oMsm1OiQLfhEsQ/Y6uNrTsxNEjEbKeMRaLsSIsNZCxhkQcwea6vKiXJmMZau+SIEOcVeeA3IcjRc63MFhg3/VZv9Od4wQnKdxD9LZ2sM4jRWGwlLVEX9FluN5oytk+meKB8Q4IhmVy2AmPFFm304fASrXssXAbsMEG98=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3456.eurprd04.prod.outlook.com (52.134.3.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 14:47:30 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 14:47:30 +0000
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM4PR05CA0030.eurprd05.prod.outlook.com (2603:10a6:205::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Tue, 28 Jan 2020 14:47:29 +0000
From:   "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: fsl: Add generic CPU DAI driver
Thread-Topic: [PATCH] ASoC: fsl: Add generic CPU DAI driver
Thread-Index: AQHV1endWlacWLF960CV3VuNFcs0Vg==
Date:   Tue, 28 Jan 2020 14:47:30 +0000
Message-ID: <20200128144707.21833-1-daniel.baluta@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR05CA0030.eurprd05.prod.outlook.com (2603:10a6:205::43)
 To VI1PR0402MB3839.eurprd04.prod.outlook.com (2603:10a6:803:21::19)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b83ff956-32bd-4c92-a9ae-08d7a401002b
x-ms-traffictypediagnostic: VI1PR0402MB3456:|VI1PR0402MB3456:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB34565BFD45440BF4569166DCB80A0@VI1PR0402MB3456.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(6506007)(1076003)(6666004)(54906003)(86362001)(66446008)(956004)(66476007)(66556008)(8936002)(64756008)(66946007)(4326008)(2616005)(71200400001)(186003)(26005)(52116002)(16526019)(6916009)(6512007)(478600001)(81166006)(6486002)(2906002)(8676002)(5660300002)(316002)(81156014)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3456;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOITcrIcj/JRTNo9v7E3xasgRqm7JxoNtKa7b4HWrcZVZ3KyjUC7CdfL6JglqFY9DzGVf6ferx1UvGQloUhUeupNIqqmiVXLahyZZL5yXAippeDWOUJM3Sa5OX4NGXQm5qYPfwe42IPHm29f5BKWexq/5FEU5g5p7+qQjTRLtPXC2x2wg8XDgP/ppd1w1XEe7NDQpxCs+kQtQfO/qoiKrXhXfrmZKOegdEW5nIgZIuJikudFk2PJ6VxPzThtmGVa7wodqQflUZZpPbx/soyk0k3ovwMWwTdvDnWa+enbzTTwLh4Q+Y2E2XZw87uXN2vDp/+MJJpcgyYPQoHPKEoXW2DlhjCMAlPJDBE/9+JLuVUjA8AHpCz5trrUm2pWqiAc2aHDnPHxc9awET53RWooLdD0ckKP65PMIQ1zECI2ZE6ENRxSeFnCWCOwzZLgSBGbRtBaQXri/h8WsVinu7ml89Zz94QOVESsxeOG4z3rEkRgXQWo2cAKzkhBpIjgh95V
x-ms-exchange-antispam-messagedata: 4t+o7MwiSUe563FBM2cSQ2p1hiM4Kqdx85lDTjaIKstm5mLffpOaZEQv6JNd8qXmBbvy7eHRprGEJg1LEfX6xC4QVXHjltxBw4U8UawdGYi0woXr494BTYDb/y6O+vl3TsafL/f559aKQFr+mDs0dA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83ff956-32bd-4c92-a9ae-08d7a401002b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 14:47:30.3976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrRXrlFouCSnb5JvJJ+0sLJxhOsIJ/tTcwMyMPxPnTvefUcTg20lPBqO4iXNTKq4ft5YayIf9WtotzOtUz+CfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

On i.MX8 platforms that have a DSP the DAI handling is taken care
of by two entities:
	* Application Processor (AP), which runs Linux
	* DSP, which runs a firmware (typically Sound Open Firmware)

The DSP has access to DAI IP registers, but it cannot easily handle
resources like:
	* clocks
	* power domain management
	* pinctrl

For this reason we introduce a generic FSL DAI driver which will take
care of the resources above.
---
 sound/soc/fsl/Kconfig   |   8 ++
 sound/soc/fsl/Makefile  |   2 +
 sound/soc/fsl/fsl_dai.c | 276 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)
 create mode 100644 sound/soc/fsl/fsl_dai.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 65e8cd4be930..bea8ab2c24f9 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -75,6 +75,14 @@ config SND_SOC_FSL_ESAI
 	  This option is only useful for out-of-tree drivers since
 	  in-tree drivers select it automatically.
=20
+config SND_SOC_FSL_DAI
+	tristate "Generic FSL DAI support for Sound Open Firmware"
+	help
+	  Say Y if you want to enable generic FSL DAI support to be used
+	  with Sound Open Firmware. This module takes care of enabling
+	  clocks, power domain, pinctrl for FSL DAIs. The rest of DAI
+	  control is taken care of by SOF firmware.
+
 config SND_SOC_FSL_MICFIL
 	tristate "Pulse Density Modulation Microphone Interface (MICFIL) module s=
upport"
 	select REGMAP_MMIO
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 8cde88c72d93..e4ed253b6657 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -20,6 +20,7 @@ snd-soc-fsl-ssi-y :=3D fsl_ssi.o
 snd-soc-fsl-ssi-$(CONFIG_DEBUG_FS) +=3D fsl_ssi_dbg.o
 snd-soc-fsl-spdif-objs :=3D fsl_spdif.o
 snd-soc-fsl-esai-objs :=3D fsl_esai.o
+snd-soc-fsl-dai-objs :=3D fsl_dai.o
 snd-soc-fsl-micfil-objs :=3D fsl_micfil.o
 snd-soc-fsl-utils-objs :=3D fsl_utils.o
 snd-soc-fsl-dma-objs :=3D fsl_dma.o
@@ -32,6 +33,7 @@ obj-$(CONFIG_SND_SOC_FSL_SAI) +=3D snd-soc-fsl-sai.o
 obj-$(CONFIG_SND_SOC_FSL_SSI) +=3D snd-soc-fsl-ssi.o
 obj-$(CONFIG_SND_SOC_FSL_SPDIF) +=3D snd-soc-fsl-spdif.o
 obj-$(CONFIG_SND_SOC_FSL_ESAI) +=3D snd-soc-fsl-esai.o
+obj-$(CONFIG_SND_SOC_FSL_DAI) +=3D snd-soc-fsl-dai.o
 obj-$(CONFIG_SND_SOC_FSL_MICFIL) +=3D snd-soc-fsl-micfil.o
 obj-$(CONFIG_SND_SOC_FSL_UTILS) +=3D snd-soc-fsl-utils.o
 obj-$(CONFIG_SND_SOC_FSL_MQS) +=3D snd-soc-fsl-mqs.o
diff --git a/sound/soc/fsl/fsl_dai.c b/sound/soc/fsl/fsl_dai.c
new file mode 100644
index 000000000000..f70889939801
--- /dev/null
+++ b/sound/soc/fsl/fsl_dai.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale Generic DAI driver for DSP
+//
+// Copyright 2019 NXP
+// Author: Daniel Baluta <daniel.baluta@nxp.com>
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+enum fsl_dai_type {
+	FSL_DAI_TYPE_NONE,
+	FSL_DAI_TYPE_SAI,
+	FSL_DAI_TYPE_ESAI,
+};
+
+#define FSL_DAI_ESAI_CLK_NUM	4
+static const char *esai_clks[FSL_DAI_ESAI_CLK_NUM] =3D {
+	"core",
+	"extal",
+	"fsys",
+	"spba",
+};
+
+#define FSL_DAI_SAI_CLK_NUM	5
+static const char *sai_clks[FSL_DAI_SAI_CLK_NUM] =3D {
+	"bus",
+	"mclk0",
+	"mclk1",
+	"mclk2",
+	"mclk3",
+};
+
+struct fsl_dai {
+	struct platform_device *pdev;
+
+	/* DAI clocks */
+	struct clk **clks;
+	const char **clk_names;
+	int num_clks;
+
+	/* Power Domain handling */
+	int num_domains;
+	struct device **pd_dev;
+	struct device_link **link;
+
+	/* DAIS */
+	struct snd_soc_dai_driver *dai_drv;
+	int num_drv;
+};
+
+static struct snd_soc_dai_driver fsl_esai_dai =3D {
+	.name =3D "esai0",
+};
+
+static struct snd_soc_dai_driver fsl_sai_dai =3D {
+	.name =3D "sai1",
+};
+
+static const struct snd_soc_component_driver fsl_dai_component =3D {
+	.name =3D "fsl-dai",
+};
+
+static int fsl_dai_init_clocks(struct fsl_dai *dai_priv)
+{
+	struct device *dev =3D &dai_priv->pdev->dev;
+	int i;
+
+	dai_priv->clks =3D devm_kcalloc(dev, dai_priv->num_clks,
+				      sizeof(*dai_priv->clks), GFP_KERNEL);
+	if (!dai_priv->clks)
+		return -ENOMEM;
+
+	for (i =3D 0; i < dai_priv->num_clks; i++) {
+		dai_priv->clks[i] =3D devm_clk_get(dev, dai_priv->clk_names[i]);
+		if (IS_ERR(dai_priv->clks[i])) {
+			dev_dbg(dev, "Failed to get clk %s\n",
+				dai_priv->clk_names[i]);
+			dai_priv->clks[i] =3D NULL;
+		}
+	}
+
+	return 0;
+}
+
+int fsl_get_dai_type(struct fsl_dai *dai_priv)
+{
+	struct device_node *np =3D dai_priv->pdev->dev.of_node;
+
+	if (of_device_is_compatible(np, "fsl,esai-dai"))
+		return FSL_DAI_TYPE_ESAI;
+
+	if (of_device_is_compatible(np, "fsl,sai-dai"))
+		return FSL_DAI_TYPE_SAI;
+
+	return FSL_DAI_TYPE_NONE;
+}
+
+static int fsl_dai_probe(struct platform_device *pdev)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	struct fsl_dai *priv;
+	int dai_type;
+	int ret;
+	int i;
+
+	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev =3D pdev;
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	dai_type =3D fsl_get_dai_type(priv);
+	switch (dai_type) {
+	case FSL_DAI_TYPE_ESAI:
+		priv->clk_names =3D esai_clks;
+		priv->num_clks =3D FSL_DAI_ESAI_CLK_NUM;
+		priv->dai_drv =3D &fsl_esai_dai;
+		priv->num_drv =3D 1;
+		break;
+	case FSL_DAI_TYPE_SAI:
+		priv->clk_names =3D sai_clks;
+		priv->num_clks =3D FSL_DAI_SAI_CLK_NUM;
+		priv->dai_drv =3D &fsl_sai_dai;
+		priv->num_drv =3D 1;
+		break;
+	default:
+		dev_err(&pdev->dev, "Invalid DAI type %d\n", dai_type);
+		return -EINVAL;
+	}
+
+	ret =3D fsl_dai_init_clocks(priv);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Error at init clocks\n");
+		return ret;
+	}
+
+	priv->num_domains =3D of_count_phandle_with_args(np, "power-domains",
+						       "#power-domain-cells");
+	if (priv->num_domains < 0) {
+		dev_err(&pdev->dev, "no power-domains property in %pOF\n", np);
+		return priv->num_domains;
+	}
+
+	priv->pd_dev =3D devm_kmalloc_array(&pdev->dev, priv->num_domains,
+					  sizeof(*priv->pd_dev), GFP_KERNEL);
+	if (!priv->pd_dev)
+		return -ENOMEM;
+
+	priv->link =3D devm_kmalloc_array(&pdev->dev, priv->num_domains,
+					sizeof(*priv->link), GFP_KERNEL);
+	if (!priv->link)
+		return -ENOMEM;
+
+	for (i =3D 0; i < priv->num_domains; i++) {
+		priv->pd_dev[i] =3D dev_pm_domain_attach_by_id(&pdev->dev, i);
+		if (IS_ERR(priv->pd_dev[i])) {
+			ret =3D PTR_ERR(priv->pd_dev[i]);
+			goto unroll_pm;
+		}
+
+		priv->link[i] =3D device_link_add(&pdev->dev, priv->pd_dev[i],
+						DL_FLAG_STATELESS |
+						DL_FLAG_PM_RUNTIME |
+						DL_FLAG_RPM_ACTIVE);
+		if (!priv->link[i]) {
+			ret =3D -EINVAL;
+			dev_pm_domain_detach(priv->pd_dev[i], false);
+			goto unroll_pm;
+		}
+	}
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret =3D devm_snd_soc_register_component(&pdev->dev, &fsl_dai_component,
+					      priv->dai_drv, priv->num_drv);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register DAI ret =3D %d\n", ret);
+		return ret;
+	}
+	return 0;
+
+unroll_pm:
+	while (--i >=3D 0) {
+		device_link_del(priv->link[i]);
+		dev_pm_domain_detach(priv->pd_dev[i], false);
+	}
+	return ret;
+}
+
+static int fsl_dai_remove(struct platform_device *pdev)
+{
+	struct fsl_dai *priv =3D platform_get_drvdata(pdev);
+	int i;
+
+	pm_runtime_disable(&priv->pdev->dev);
+
+	for (i =3D 0; i < priv->num_domains; i++) {
+		device_link_del(priv->link[i]);
+		dev_pm_domain_detach(priv->pd_dev[i], false);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id fsl_dai_dt_ids[] =3D {
+	{ .compatible =3D "fsl,esai-dai", },
+	{ .compatible =3D "fsl,sai-dai", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_dai_dt_ids);
+
+#ifdef CONFIG_PM
+static int fsl_dai_runtime_resume(struct device *dev)
+{
+	struct fsl_dai *priv =3D dev_get_drvdata(dev);
+	int i, ret;
+
+	for (i =3D 0; i < priv->num_clks; i++) {
+		ret =3D clk_prepare_enable(priv->clks[i]);
+		if (ret < 0) {
+			dev_err(dev, "Failed to enable clk %s\n",
+				priv->clk_names[i]);
+			goto out;
+		}
+	}
+	return 0;
+out:
+	while (--i >=3D 0)
+		clk_disable_unprepare(priv->clks[i]);
+
+	return ret;
+}
+
+static int fsl_dai_runtime_suspend(struct device *dev)
+{
+	struct fsl_dai *priv =3D dev_get_drvdata(dev);
+	int i;
+
+	for (i =3D 0; i < priv->num_clks; i++)
+		clk_disable_unprepare(priv->clks[i]);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops fsl_dai_pm_ops =3D {
+	SET_RUNTIME_PM_OPS(fsl_dai_runtime_suspend,
+			   fsl_dai_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static struct platform_driver fsl_dai_driver =3D {
+	.probe =3D fsl_dai_probe,
+	.remove =3D fsl_dai_remove,
+	.driver =3D {
+		.name =3D "fsl-dai",
+		.pm =3D &fsl_dai_pm_ops,
+		.of_match_table =3D fsl_dai_dt_ids,
+	},
+};
+
+module_platform_driver(fsl_dai_driver);
+
+MODULE_ALIAS("platform:fsl-dai");
+
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@nxp.com>");
+MODULE_DESCRIPTION("FSL Generic DAI driver for DSP");
+MODULE_LICENSE("GPL v2");
--=20
2.17.1

