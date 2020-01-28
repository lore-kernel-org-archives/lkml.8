Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D42AC35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A8A2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VtCd2wMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgA1Fa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:30:28 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:46149
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgA1Fa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 00:30:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjK12UOq3qwvCpDSwcgnWEeHjV0o759YfgnB1Qv2HrxHsjCfM0b7f0Yf2Cp3FFiq2P1as2h21laUmWiANRSlhB9Ccn4Gli88QzSqkw4/fBYoKGZdYAK7bPppo+9fAU1f56sMJSW2VW4Kmhc644ptB4B4AwenA1+mUr+CW9X3RzsHX1qQbJAtwbS10mAUCShDC2no/i+OhSvwtIz1EExwd3oCHIMUTvbKI3e4ctMMuM+E0u24YqbnPhi8FDUAj0BP0pcCUbcvqze4nvebsA29kd1tvXEz2WK3SLuKD0yFn4lx2e0p1r7tm+JhMqeO86tBMdbuJQPolzBxL/4TnADEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QomV2iyuDdDfBBb+S8qw0VS/XK5vknZpvEXh1RbFdk=;
 b=kr5YneypvK0RuJh4zdYgBOa6nY09bbsPqI1/3fS/XvkhgFpvNtMKpNcnAnQtKslYtH7YhFe5JIxd1cm2YMpXW3q+dP1NMAEnuF/KYok+mn8c9Ad58vML7UrZi39p1Svshk1jSxUEayaibEAlaKJ1HVvcubZf6Y/lfZGuiSv2aw7GIyfuImwYejUDjED++oXjoqUaZ2pmiwQYIrDGp/vzmWlHJkFnhlfiOy2Y4/6GuIuEuxeu9dJq73alW62unOw/oC8Il8+aCrb5Ji8fFSkFhANGb4YxhjYD3lbNuwMRSyrrtfkLJfSYYA6HQqP4mgj+wOaJqf3bp9NChPTDDaUarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QomV2iyuDdDfBBb+S8qw0VS/XK5vknZpvEXh1RbFdk=;
 b=VtCd2wMemMAJjCon/SF8+8veWgiqq8XVC3wOp96mOepRcUsBkJX/IKS4zepHl5M4IkO9y3i+4ctdHbZF3yZg86asE2TfgQcccVOAHbAwLrb0bg21X4L46DWP09Gl0v8izCdeLiX08Dypaw9nfAVZIjk9EZTnYgCSK3TkYoBilqc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5890.eurprd04.prod.outlook.com (20.178.202.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Tue, 28 Jan 2020 05:28:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 05:28:41 +0000
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0113.apcprd03.prod.outlook.com (2603:1096:203:b0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.22 via Frontend Transport; Tue, 28 Jan 2020 05:28:37 +0000
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
Subject: [PATCH V4 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V4 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Index: AQHV1ZvNSuPHrnVkw0ajxH2uX1Z86Q==
Date:   Tue, 28 Jan 2020 05:28:41 +0000
Message-ID: <1580189015-5744-3-git-send-email-peng.fan@nxp.com>
References: <1580189015-5744-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1580189015-5744-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:203:b0::29) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2dbaf1f0-d39f-4b0d-c087-08d7a3b2ef78
x-ms-traffictypediagnostic: AM0PR04MB5890:|AM0PR04MB5890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5890046B19CA96EAB2FD36AF880A0@AM0PR04MB5890.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(189003)(199004)(36756003)(69590400006)(110136005)(54906003)(4326008)(71200400001)(52116002)(44832011)(66556008)(64756008)(478600001)(66476007)(66946007)(66446008)(2616005)(5660300002)(956004)(316002)(86362001)(6486002)(186003)(8676002)(16526019)(6512007)(81156014)(81166006)(6506007)(6636002)(2906002)(26005)(8936002)(6666004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5890;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iqPfC4ptr+voFBIKtlbehC19mm6orQ9n7P0jqI+lDcGeUAZPRWbV8pirUeD4fpr9FdP78x73NAYl5feigbS+Qx5YrJH8oVEmEtSN2z7H3NhLfLiKVqPWsa79aM7sixEo2LIRPkIIkiobXb6oNmThpUcIeFYUAdUYSjQFuIyLO8jN0DHaqvdvWIq9NoJCel1a2leL3rhth08FUGcUIq/uNG2jFM76vK5aJC5VPnJoO5EQt5Bf6Y5L458agWzDqRO6AMZ6h/abJ9mxpdMfgi1352OKKeCr39XQ7hztPql3rQBHv0nnoqAHXlAYphBeM4pn8++YI0yGNDIlH3iAXDXbjjkabaxaMzMXD6rLafM2mxnHRAQU1ujIKjQ77CssVavVFXrU8IkX0Qj05D298bnXp5wtUF1FQkfJuYdydYVQAImQRJdJQ3PBXH5Vw+bUufkGA791OO09o2OVPwxLugcm9LYu35pW/Wgj3V+QJywJrbyl1QxGHfm/87gDdV3wkDJ/BpcbFQlEJBzUL1oydsANyNEufZMQYU0VhIk5HtvWyyHdiKnWk34mJVjmSC+hMMzX
x-ms-exchange-antispam-messagedata: bBNq8eCF0XuJBRlYfHlM66Ubi3Sh/gGhLHY0DIq84awREVnq/6tBMbj28SZwNi2VZ7IPoWloZUK1+GlPcvRTwMnrkANf9qwoYGW86NX786fKKDQ3VPJrzDWCL5NHLqVY6CNlO0PtiXNTQD4aXt5Qtw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbaf1f0-d39f-4b0d-c087-08d7a3b2ef78
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 05:28:41.4961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oz20OC00wc1tNQySHbAA7x4ma60SPzVqPOmnEtCoQYY0ShFLXlxnJrLpdB9YsHlLghVOWYz/BTvowog3rJ+7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5890
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use imx8m_clk_hw_composite_core to simplify code.

Add new definitions, and X_SRC/CG/DIV will be alias to the new
definitions for backwards compatibility

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c             | 34 ++++++++++++++++++----------=
----
 include/dt-bindings/clock/imx8mq-clock.h |  7 ++++++-
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 4c0edca1a6d0..ac9452cd9a82 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -403,22 +403,26 @@ static int imx8mq_clocks_probe(struct platform_device=
 *pdev)
=20
 	/* CORE */
 	hws[IMX8MQ_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src", base + 0x8000,=
 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));
-	hws[IMX8MQ_CLK_M4_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base + 0x8080, 2=
4, 3, imx8mq_arm_m4_sels, ARRAY_SIZE(imx8mq_arm_m4_sels));
-	hws[IMX8MQ_CLK_VPU_SRC] =3D imx_clk_hw_mux2("vpu_src", base + 0x8100, 24,=
 3, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));
-	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D imx_clk_hw_mux2("gpu_core_src", base + 0=
x8180, 24, 3,  imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels));
-	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D imx_clk_hw_mux2("gpu_shader_src", base=
 + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sel=
s));
-
 	hws[IMX8MQ_CLK_A53_CG] =3D imx_clk_hw_gate3_flags("arm_a53_cg", "arm_a53_=
src", base + 0x8000, 28, CLK_IS_CRITICAL);
-	hws[IMX8MQ_CLK_M4_CG] =3D imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src", bas=
e + 0x8080, 28);
-	hws[IMX8MQ_CLK_VPU_CG] =3D imx_clk_hw_gate3("vpu_cg", "vpu_src", base + 0=
x8100, 28);
-	hws[IMX8MQ_CLK_GPU_CORE_CG] =3D imx_clk_hw_gate3("gpu_core_cg", "gpu_core=
_src", base + 0x8180, 28);
-	hws[IMX8MQ_CLK_GPU_SHADER_CG] =3D imx_clk_hw_gate3("gpu_shader_cg", "gpu_=
shader_src", base + 0x8200, 28);
-
 	hws[IMX8MQ_CLK_A53_DIV] =3D imx_clk_hw_divider2("arm_a53_div", "arm_a53_c=
g", base + 0x8000, 0, 3);
-	hws[IMX8MQ_CLK_M4_DIV] =3D imx_clk_hw_divider2("arm_m4_div", "arm_m4_cg",=
 base + 0x8080, 0, 3);
-	hws[IMX8MQ_CLK_VPU_DIV] =3D imx_clk_hw_divider2("vpu_div", "vpu_cg", base=
 + 0x8100, 0, 3);
-	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D imx_clk_hw_divider2("gpu_core_div", "gpu=
_core_cg", base + 0x8180, 0, 3);
-	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D imx_clk_hw_divider2("gpu_shader_div", =
"gpu_shader_cg", base + 0x8200, 0, 3);
+
+	hws[IMX8MQ_CLK_M4_CORE] =3D imx8m_clk_hw_composite_core("arm_m4_core", im=
x8mq_arm_m4_sels, base + 0x8080);
+	hws[IMX8MQ_CLK_VPU_CORE] =3D imx8m_clk_hw_composite_core("vpu_core", imx8=
mq_vpu_sels, base + 0x8100);
+	hws[IMX8MQ_CLK_GPU_CORE] =3D imx8m_clk_hw_composite_core("gpu_core", imx8=
mq_gpu_core_sels, base + 0x8180);
+	hws[IMX8MQ_CLK_GPU_SHADER] =3D imx8m_clk_hw_composite("gpu_shader", imx8m=
q_gpu_shader_sels, base + 0x8200);
+	/* For backwards compatibility */
+	hws[IMX8MQ_CLK_M4_SRC] =3D hws[IMX8MQ_CLK_M4_CORE];
+	hws[IMX8MQ_CLK_M4_CG] =3D hws[IMX8MQ_CLK_M4_CORE];
+	hws[IMX8MQ_CLK_M4_DIV] =3D hws[IMX8MQ_CLK_M4_CORE];
+	hws[IMX8MQ_CLK_VPU_SRC] =3D hws[IMX8MQ_CLK_VPU_CORE];
+	hws[IMX8MQ_CLK_VPU_CG] =3D hws[IMX8MQ_CLK_VPU_CORE];
+	hws[IMX8MQ_CLK_VPU_DIV] =3D hws[IMX8MQ_CLK_VPU_CORE];
+	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D hws[IMX8MQ_CLK_GPU_CORE];
+	hws[IMX8MQ_CLK_GPU_CORE_CG] =3D hws[IMX8MQ_CLK_GPU_CORE];
+	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D hws[IMX8MQ_CLK_GPU_CORE];
+	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D hws[IMX8MQ_CLK_GPU_SHADER];
+	hws[IMX8MQ_CLK_GPU_SHADER_CG] =3D hws[IMX8MQ_CLK_GPU_SHADER];
+	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D hws[IMX8MQ_CLK_GPU_SHADER];
=20
 	/* BUS */
 	hws[IMX8MQ_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
imx8mq_main_axi_sels, base + 0x8800);
@@ -567,7 +571,7 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MQ_CLK_WDOG2_ROOT] =3D imx_clk_hw_gate4("wdog2_root_clk", "wdog",=
 base + 0x4540, 0);
 	hws[IMX8MQ_CLK_WDOG3_ROOT] =3D imx_clk_hw_gate4("wdog3_root_clk", "wdog",=
 base + 0x4550, 0);
 	hws[IMX8MQ_CLK_VPU_G1_ROOT] =3D imx_clk_hw_gate2_flags("vpu_g1_root_clk",=
 "vpu_g1", base + 0x4560, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
-	hws[IMX8MQ_CLK_GPU_ROOT] =3D imx_clk_hw_gate4("gpu_root_clk", "gpu_core_d=
iv", base + 0x4570, 0);
+	hws[IMX8MQ_CLK_GPU_ROOT] =3D imx_clk_hw_gate4("gpu_root_clk", "gpu_core",=
 base + 0x4570, 0);
 	hws[IMX8MQ_CLK_VPU_G2_ROOT] =3D imx_clk_hw_gate2_flags("vpu_g2_root_clk",=
 "vpu_g2", base + 0x45a0, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
 	hws[IMX8MQ_CLK_DISP_ROOT] =3D imx_clk_hw_gate2_shared2("disp_root_clk", "=
disp_dc8000", base + 0x45d0, 0, &share_count_dcss);
 	hws[IMX8MQ_CLK_DISP_AXI_ROOT]  =3D imx_clk_hw_gate2_shared2("disp_axi_roo=
t_clk", "disp_axi", base + 0x45d0, 0, &share_count_dcss);
diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings=
/clock/imx8mq-clock.h
index 3bab9b21c8d7..2b88723310bd 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -424,6 +424,11 @@
 #define IMX8MQ_SYS2_PLL_500M_CG			283
 #define IMX8MQ_SYS2_PLL_1000M_CG		284
=20
-#define IMX8MQ_CLK_END				285
+#define IMX8MQ_CLK_GPU_CORE			285
+#define IMX8MQ_CLK_GPU_SHADER			286
+#define IMX8MQ_CLK_M4_CORE			287
+#define IMX8MQ_CLK_VPU_CORE			288
+
+#define IMX8MQ_CLK_END				289
=20
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
--=20
2.16.4

