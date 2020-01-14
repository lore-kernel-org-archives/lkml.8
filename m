Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FBFC33CAD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A392187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ifgo6CAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgANH1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:27:21 -0500
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:28590
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728877AbgANH1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:27:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoYvyVcYglt3u3wiDZ99xqayudNInRyTGNrlunih+3fN06SWpViXkytXN7SwnzxR6JsSMhjYZzviuNGQ/33FBDdIVHRoQLZXR4yhTbe+NMrXLKaRnziwD94y1oKaewsDQk+ME0bSbHVgdtCvlWffIRw3IHvej+bzp2BBZI4jlQ/8+KiEqBb6gk6GcWeFFOl2WqNomjZisCOCypFsqRZ5jNelNl8qfWrBIjTHSy6fbIs/oZdMsRyAoubafPcGGupelLp5keXJ3YP+O7YC9q9xDa9LYiXabj8W4OsuR85go5B+3Y46SsZoOiyJ59ClT09MKWlFVNEwizivVjgqrrKYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVBsOrrIJtM8aBTF6ArFlPCxdqS2xZkxNEwG4+vr0xE=;
 b=Ii9L6jKL27tNLkp2IWnuWHXG1xVTKFGn0hcwNxl748G3VvWkXjaV9P7W4CwlwrVXwfH0d+6ks6eDEbSGFdiB+RpV3QeR3WsD7BgmZ8kkE6ydI5HJJt86b8Mp0Ytfk/w/SijgyeGQ9l1/MnEsi0fuxLYcjwVuWlFMzdEqwJtZppOrRTILJXE8e+X6thQh9tAlEAtDpgItO4stl0W2WAjxiL0tAhKFjAzWIliBTEPR5hGG6LSZz2GW4K78jOWn988ydnO78zDrKI0jw+l1ShuzCclX3/ASyyia7I10foVq76+iO8YSDBKM8DOcqugxoUa0LknUB3DZSe5/ZQXWXxdcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVBsOrrIJtM8aBTF6ArFlPCxdqS2xZkxNEwG4+vr0xE=;
 b=ifgo6CAs2muuOKV/HadNbJxD5VNZZgPe6zxWVvnE9sNEvJzUg8GmXiA7xum5LKYS9VAEefVok2tUyU5+D5GD+1iEANCA9l+BJMINRj982FJh9/CCJ+aZul+qefFf49fc+/tIm8t4miHy2dV+u5wT91P3DQTCVFZd+BKHYdi1SIU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5490.eurprd04.prod.outlook.com (20.178.115.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 07:27:16 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 07:27:16 +0000
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 07:27:11 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/4] clk: imx: imx8mq: fix a53 cpu clock
Thread-Topic: [PATCH V2 1/4] clk: imx: imx8mq: fix a53 cpu clock
Thread-Index: AQHVyqwL+gJCbLkXRk231KEqZiOAVg==
Date:   Tue, 14 Jan 2020 07:27:15 +0000
Message-ID: <1578986576-6168-2-git-send-email-peng.fan@nxp.com>
References: <1578986576-6168-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1578986576-6168-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bca1712f-342a-436e-07c0-08d798c32e11
x-ms-traffictypediagnostic: AM0PR04MB5490:|AM0PR04MB5490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5490A2B5E7ABD9606D2ED14188340@AM0PR04MB5490.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(66476007)(478600001)(66946007)(2906002)(66446008)(66556008)(6506007)(64756008)(52116002)(186003)(2616005)(26005)(44832011)(16526019)(8936002)(71200400001)(69590400006)(956004)(81166006)(8676002)(36756003)(81156014)(86362001)(5660300002)(4326008)(6486002)(6636002)(110136005)(6512007)(316002)(54906003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5490;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bf6MGMW76oDH69aRPnhzy9NoX3AvrdvP4U69aKP1AUu4iRMR6VIApSzI/VRbBLHeP2w/2cYTW/xxYNmJcECcS/vk83Y58QI3YiV2KlEGGhsn7KsyGGCvww9bN7fcJt0OmculQ6BVag10zdtvvCBdmVC4Oty+jHXpbeCfp7YvCSjnj++nPmg8ZJObgELqHOGV3IzArvqsQZvAdQJkgmc6swKXVRKRXllPukaGNGRy+Ob1SL58sFgAoNavRi3a/l03zTk2DKDAP/OfHkchYrH8txlHBcdAuZz+hhL7OtRiKRmXOvUHMvSCsIpSAVN25t9FSSYyQV2TjZffWIGbyVIVESs90pyx3GbJ+XppvbJtuMmVeXgmkUp77S7wR2XemDqCANRRPG9wCCJ7CQyxPybmPTc/s1/qB/bUVRG98mHz9WmnGCjFoKTnUc7xL2m2IMG+jITvRKq8DdI0YgC+W4WmEnig7SLTJqxddZ6in+LVG0J/YPA/t8Ydj7eUxpY5FkDk2nu4UVbUdVeL/ApgDInM4g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca1712f-342a-436e-07c0-08d798c32e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 07:27:15.7455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SlF7qNrSdtGeJL+YR0KYLPE40ROGXtUUGeP/SQVhPfxxo3fOqyViK84ktSPh56CebtaMGwjO91VGeArP37INwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root
signoff timing is 1Ghz, however the A53 core which sources from CCM
root could run above 1GHz which voilates the CCM.

There is a CORE_SEL slice before A53 core, we need configure the
CORE_SEL slice source from ARM PLL, not A53 CCM clk root.

The A53 CCM clk root should only be used when need to change ARM PLL
frequency.

Add arm_a53_core clk that could source from arm_a53_div and arm_pll_out.
Configure a53 ccm root sources from 800MHz sys pll
Configure a53 core sources from arm_pll_out
Mark arm_a53_core as critical clock

Fixes: db27e40b27f1 ("clk: imx8mq: Add the missing ARM clock")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/clk/imx/clk-imx8mq.c             | 16 ++++++++++++----
 include/dt-bindings/clock/imx8mq-clock.h |  4 +++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index b031183ff427..82a16b8e98a9 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -41,6 +41,8 @@ static const char * const video2_pll_out_sels[] =3D {"vid=
eo2_pll1_ref_sel", };
 static const char * const imx8mq_a53_sels[] =3D {"osc_25m", "arm_pll_out",=
 "sys2_pll_500m", "sys2_pll_1000m",
 					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "sys3_pll_out", }=
;
=20
+static const char * const imx8mq_a53_core_sels[] =3D {"arm_a53_div", "arm_=
pll_out", };
+
 static const char * const imx8mq_arm_m4_sels[] =3D {"osc_25m", "sys2_pll_2=
00m", "sys2_pll_250m", "sys1_pll_266m",
 					"sys1_pll_800m", "audio_pll1_out", "video_pll1_out", "sys3_pll_out", =
};
=20
@@ -411,6 +413,9 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D imx8m_clk_hw_composite_core("gpu_core_di=
v", imx8mq_gpu_core_sels, base + 0x8180);
 	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D imx8m_clk_hw_composite("gpu_shader_div=
", imx8mq_gpu_shader_sels, base + 0x8200);
=20
+	/* CORE SEL */
+	hws[IMX8MQ_CLK_A53_CORE] =3D imx_clk_hw_mux2_flags("arm_a53_core", base +=
 0x9880, 24, 1, imx8mq_a53_core_sels, ARRAY_SIZE(imx8mq_a53_core_sels), CLK=
_IS_CRITICAL);
+
 	/* BUS */
 	hws[IMX8MQ_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
imx8mq_main_axi_sels, base + 0x8800);
 	hws[IMX8MQ_CLK_ENET_AXI] =3D imx8m_clk_hw_composite("enet_axi", imx8mq_en=
et_axi_sels, base + 0x8880);
@@ -574,11 +579,14 @@ static int imx8mq_clocks_probe(struct platform_device=
 *pdev)
 	hws[IMX8MQ_GPT_3M_CLK] =3D imx_clk_hw_fixed_factor("gpt_3m", "osc_25m", 1=
, 8);
 	hws[IMX8MQ_CLK_DRAM_ALT_ROOT] =3D imx_clk_hw_fixed_factor("dram_alt_root"=
, "dram_alt", 1, 4);
=20
-	hws[IMX8MQ_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_div",
-					   hws[IMX8MQ_CLK_A53_DIV]->clk,
-					   hws[IMX8MQ_CLK_A53_SRC]->clk,
+	clk_hw_set_parent(hws[IMX8MQ_CLK_A53_SRC], hws[IMX8MQ_SYS1_PLL_800M]);
+	clk_hw_set_parent(hws[IMX8MQ_CLK_A53_CORE], hws[IMX8MQ_ARM_PLL_OUT]);
+
+	hws[IMX8MQ_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_core",
+					   hws[IMX8MQ_CLK_A53_CORE]->clk,
+					   hws[IMX8MQ_CLK_A53_CORE]->clk,
 					   hws[IMX8MQ_ARM_PLL_OUT]->clk,
-					   hws[IMX8MQ_SYS1_PLL_800M]->clk);
+					   hws[IMX8MQ_CLK_A53_DIV]->clk);
=20
 	imx_check_clk_hws(hws, IMX8MQ_CLK_END);
=20
diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings=
/clock/imx8mq-clock.h
index 3bab9b21c8d7..ac71e9e502b8 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -424,6 +424,8 @@
 #define IMX8MQ_SYS2_PLL_500M_CG			283
 #define IMX8MQ_SYS2_PLL_1000M_CG		284
=20
-#define IMX8MQ_CLK_END				285
+#define IMX8MQ_CLK_A53_CORE			285
+
+#define IMX8MQ_CLK_END				286
=20
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
--=20
2.16.4

