Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157E8C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BDB2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bzSft2iJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgA1F2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:28:42 -0500
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:29315
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgA1F2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 00:28:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO6lY2WYULVMnmKIsW8arATFaqfPs3rI1hHgCHu3o9IICLyVQ4uHNLGfOFdQvJjP3HXfePZrkIy3c4d0YfEpg+WDwTQJZOhJrmmIi3oIHcCin+gvW5HnQ3mKC/nrkecqrgfv/uKuhIlKH0VlTq3QdUyzPkspY449wOADNBnoxGY39+MDPq9WnTOksxC5tENPKY9sl7jB2KEpr1y6/BkWEJlqIxFPUlKFX11vsZ7fm4bLSb6l588HIs4TFpKABlyb2EmHwiI/VIp+EaOd3QcOEAriB5uuFbDgHE+k3cmj/kryJWi7lWXIoHM02QIDlt6sESFPy7rakFjDh4yZtXfsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ3zTQ6kFuym5Bl6y1u2gUNP0cH+hU/PnWj9x9N0zpQ=;
 b=CaD97y98u/r79SPqn5gXyXDo4y5qn7n81Kb1WPLAJQ+BHwPo9MHUcoe4xWq1oZk/Hd4hz+tN1PV6XtFYVAfsIE2IK1VkXWdxwESW2c8P7jG0z6Bs2uEMb/XJ3qVaGQYk4+m4q8ft3ZdX+fCaIWSMcFYKpCpu6AeirbcA5klvHbyzyVy1OGVS/S/93zxOFYDNxwCWuEXkjqEtSja+u1NxcmWSqcx7jRow+KeYlBISicmlW+VUntfNXp1dpyLNZlKvUP5XQH/4oXh/bf+RWqTounrzhWmnvkYplWKU/5FJtcHgz1jUhpViOeCA/G2dQLCUAUQVhcz33v9LNYKw1Zq7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ3zTQ6kFuym5Bl6y1u2gUNP0cH+hU/PnWj9x9N0zpQ=;
 b=bzSft2iJf182/PCA8HEfPMwPWl/+BrZAa9MDNTsRQq3uhRn8VFTkSwQmqq7CD0aEGgW47bd8zvLZ7s+meay7/JqjekCQtwIcN0F3+XoarHibl2RlO5IG0Zb81nQN+mGjxX6wZ/FZG/J14DOy4uhiu2rYFoa9AbvYqawp5lr24S4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5890.eurprd04.prod.outlook.com (20.178.202.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Tue, 28 Jan 2020 05:28:37 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 05:28:37 +0000
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0113.apcprd03.prod.outlook.com (2603:1096:203:b0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.22 via Frontend Transport; Tue, 28 Jan 2020 05:28:32 +0000
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
Subject: [PATCH V4 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V4 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_composite_core
Thread-Index: AQHV1ZvKDxq3UpFxMEyFV9hEtp7TTw==
Date:   Tue, 28 Jan 2020 05:28:36 +0000
Message-ID: <1580189015-5744-2-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: c51b3319-ea4d-4768-30d1-08d7a3b2eca9
x-ms-traffictypediagnostic: AM0PR04MB5890:|AM0PR04MB5890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB58908C3B49BE1CC6419D7D78880A0@AM0PR04MB5890.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(189003)(199004)(36756003)(69590400006)(110136005)(54906003)(4326008)(71200400001)(52116002)(44832011)(66556008)(64756008)(478600001)(66476007)(66946007)(66446008)(2616005)(5660300002)(956004)(316002)(86362001)(6486002)(186003)(8676002)(16526019)(6512007)(81156014)(81166006)(6506007)(6636002)(2906002)(26005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5890;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hp9H5PyO5Nv42ftq7ZcRvqq5A74BQ4h0S+fhMwseNB+RqdH2ZUK5da8ArQ9COfHBqv/MPqrr2TpXt/FZQ6KAJKPMRJpBh1+nUp392ryEFThR7THOqaeF5kcr4/qy30ZwbvczvexEV3DhTOqb5jy9JUWt5eVfEEWXV4CU6OtvDQLO56PbguF/ofFaHpEhldgVvQspvmyfvNJAJo8EevP8HYNHtZiJSMjT+ZIm9M3ybUKDDu4ueG6LCKh8CPMFChrfOM2qDJbDb4qbvtAJoTS5XP3CstQ0oOlXsDQG/jylq/0J3fgluJNxwgZ8d4ape+GIXdm21xllyqD/kwLNhtJv/mZ+1EFhl6fPpJjFtEqV5VGR5ApNcMda6/JIzAq+JDWI79kGZY7IKdXX54MpKrNQEALnbvs3nxTJYIdIgRXn3Pf1WeVMnQw6EI+yxraP74V36vOahRrz1dJj6deVyGQ76Ou0Vb43flYHvFkk5LP+pnT2F4TFyaqBVJzvexX+7Pmv9sLhLlsEBTIRORgl0JWvOX9nkE1PDJfNiKtRms/1nYA=
x-ms-exchange-antispam-messagedata: QFeah0X2Fc6NwW0jMZlZVpxeUllN6RtuUp+w1u7Cs9fILZUAkQTHipmxWwlyyxZob1nLEvAm8L9fmnMx/sEEEj5dR3HM0jmSiiHQNT1AXQT8Lttmb8Gf4iIywErs8t7K619Rlm8W7kMbxVYQrSmNNg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51b3319-ea4d-4768-30d1-08d7a3b2eca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 05:28:36.8312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TE+6gdJb+4v8mGQcEB0XN3XYXBhe557OHGo7hDgGPPvLxfVzDyBXGVubwhWWPMZNcSCkDAlMzfCQsSBahapKRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5890
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There are several clock slices, current composite code
only support bus/ip clock slices, it could not support core
slice.

So introduce a new API imx8m_clk_hw_composite_core to support
core slice. To core slice, post divider with 3 bits width and
no pre divider. Other fields are same as bus/ip slices.

Add a flag IMX_COMPOSITE_CORE for the usecase.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 18 ++++++++++++++----
 drivers/clk/imx/clk.h              | 13 +++++++++++--
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-compo=
site-8m.c
index 20f7c91c03d2..4869c16376bf 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -15,6 +15,7 @@
 #define PCG_PREDIV_MAX		8
=20
 #define PCG_DIV_SHIFT		0
+#define PCG_CORE_DIV_WIDTH	3
 #define PCG_DIV_WIDTH		6
 #define PCG_DIV_MAX		64
=20
@@ -126,6 +127,7 @@ static const struct clk_ops imx8m_clk_composite_divider=
_ops =3D {
 struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
+					u32 composite_flags,
 					unsigned long flags)
 {
 	struct clk_hw *hw =3D ERR_PTR(-ENOMEM), *mux_hw;
@@ -133,6 +135,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char =
*name,
 	struct clk_divider *div =3D NULL;
 	struct clk_gate *gate =3D NULL;
 	struct clk_mux *mux =3D NULL;
+	const struct clk_ops *divider_ops;
=20
 	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -150,8 +153,16 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char=
 *name,
=20
 	div_hw =3D &div->hw;
 	div->reg =3D reg;
-	div->shift =3D PCG_PREDIV_SHIFT;
-	div->width =3D PCG_PREDIV_WIDTH;
+	if (composite_flags & IMX_COMPOSITE_CORE) {
+		div->shift =3D PCG_DIV_SHIFT;
+		div->width =3D PCG_CORE_DIV_WIDTH;
+		divider_ops =3D &clk_divider_ops;
+	} else {
+		div->shift =3D PCG_PREDIV_SHIFT;
+		div->width =3D PCG_PREDIV_WIDTH;
+		divider_ops =3D &imx8m_clk_composite_divider_ops;
+	}
+
 	div->lock =3D &imx_ccm_lock;
 	div->flags =3D CLK_DIVIDER_ROUND_CLOSEST;
=20
@@ -166,8 +177,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char =
*name,
=20
 	hw =3D clk_hw_register_composite(NULL, name, parent_names, num_parents,
 			mux_hw, &clk_mux_ops, div_hw,
-			&imx8m_clk_composite_divider_ops,
-			gate_hw, &clk_gate_ops, flags);
+			divider_ops, gate_hw, &clk_gate_ops, flags);
 	if (IS_ERR(hw))
 		goto fail;
=20
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index b05213b91dcf..f074dd8ec42e 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -477,20 +477,29 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const=
 char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
=20
+#define IMX_COMPOSITE_CORE	BIT(0)
+
 struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					    const char * const *parent_names,
 					    int num_parents,
 					    void __iomem *reg,
+					    u32 composite_flags,
 					    unsigned long flags);
=20
+#define imx8m_clk_hw_composite_core(name, parent_names, reg)	\
+	imx8m_clk_hw_composite_flags(name, parent_names, \
+			ARRAY_SIZE(parent_names), reg, \
+			IMX_COMPOSITE_CORE, \
+			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
 #define imx8m_clk_composite_flags(name, parent_names, num_parents, reg, \
 				  flags) \
 	to_clk(imx8m_clk_hw_composite_flags(name, parent_names, \
-				num_parents, reg, flags))
+				num_parents, reg, 0, flags))
=20
 #define __imx8m_clk_hw_composite(name, parent_names, reg, flags) \
 	imx8m_clk_hw_composite_flags(name, parent_names, \
-		ARRAY_SIZE(parent_names), reg, \
+		ARRAY_SIZE(parent_names), reg, 0, \
 		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
=20
 #define __imx8m_clk_composite(name, parent_names, reg, flags) \
--=20
2.16.4

