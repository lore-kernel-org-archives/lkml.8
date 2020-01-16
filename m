Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F26C33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21082081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DMSsB7aV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgAPCPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:15:51 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:50850
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730202AbgAPCPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:15:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvFMkhmhQCSrJccfbxLLNCnALrGGiKM+swVWDELCvM6n8sWL7t2T76TCs26pCis/39jIpHkk/VbXPky7DaGg4ZJMHFlMn+6J+Ca+BQP3YaDa/QeOhlUoHNkXd/O5/HX5f9w3kicg0xbsIbu5DssLIjEl7vGih06j+/niADpH4IWlKeRvXgrqGwYDmGz23c58noUAs2dVPH12rT6qV3+AqL2qOWTRDhqu9CTwM9MZWj3KSxfC78CFsxGGyYKuBo47/qTKhgNUo3+RjruNeAOPtzwYwIfsoSz0LL3RKfw9norQ6YsxR+dknHnApaKoLJO2eSuNLsfMr5QMwOXYmU5W1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqfvwMOAdqydn7bTlUwdm4cDdmN76673LYMIMlgCDCQ=;
 b=Cu6J/O1mH5V7QVBveW72RUO7cP9R578cwz2itSxuPHJY07rBftIeUxVDKy/ckyRQJcJIVY/uTqFnEegloobpQLODFl1gUFHAWF3lRdd3l/1DfOIoC9NoTsf8h8YVPQn3Hq5znwJ1GPkcRm5t3nd6G11w6J7vSBBxPF6i2xSdBfczEvXd5vPesFCYo667+lbCMz4jMoDYiVteIZM9P2NtrFS7Yc6oODRSSqy7p7hgPO7mi6wbPF8/XA9hm+CQK+yng5XY8C+m+PkhcGzMRhXjNIvlY4X2ZO+i0PLZmeBfdDEIaA0FSc41D8hQhIg93vxTzwRyXco6/HjoqQL/rm/aVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqfvwMOAdqydn7bTlUwdm4cDdmN76673LYMIMlgCDCQ=;
 b=DMSsB7aVKe3Adty5yzqN6BBfZF2cVt9q16JuGctAG14UYgR1VUnRNabSx5tRYe18MMmY5eWw2Ck+s/8I5C9Ur3Pk5lJU/375S2yQq44WXPkC0SO1s20m4XdEnoIUp8K0r7JkPzFfvXqtzS3onlikcuuSRnLP80W8Vc4JtjEdH94=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6289.eurprd04.prod.outlook.com (20.179.35.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 02:15:48 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 02:15:48 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Thu, 16 Jan 2020 02:15:42 +0000
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
Subject: [PATCH V3 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V3 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_composite_core
Thread-Index: AQHVzBLdOVqCTpZiOUeYKEC0gr4JWg==
Date:   Thu, 16 Jan 2020 02:15:48 +0000
Message-ID: <1579140562-8060-2-git-send-email-peng.fan@nxp.com>
References: <1579140562-8060-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1579140562-8060-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f53ccf6a-1fd7-43e5-ca19-08d79a2a0059
x-ms-traffictypediagnostic: AM0PR04MB6289:|AM0PR04MB6289:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6289321A1AA5157D95BFBB1088360@AM0PR04MB6289.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(478600001)(4326008)(5660300002)(316002)(54906003)(110136005)(8936002)(81166006)(81156014)(8676002)(36756003)(6512007)(71200400001)(69590400006)(16526019)(6636002)(26005)(6506007)(186003)(86362001)(52116002)(64756008)(956004)(66946007)(66476007)(6486002)(66556008)(44832011)(66446008)(2616005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6289;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4KrFbx4xDVQYajooyZmYdUNehO+6wDZRGwz8b5YBSBbfnb/U27UJCpJcHR9PF9LfAS09bGWpNDHUyclNBDRTtnVKxCFm/KY8EZfyMO8cJbZGac3gE4wYq2ORjLTUYafSH+ZImHy0aiAEClvI35BnQSXoyxgeYttawGTAUbEkLJIExxbzcbGX/BvWV38Sly8JMLpMvD9RFdoYZyEmR9TLNW6v8Vo14GQMtnYrcC14SCckgKyGQrZkqxCe/w02nWhvyO/wj769y9OolSkFm1ESRIAdNw9HH+bxDqFbqYSfen80Yhh60iacbhFLpSQmmxDh9E76ii+U0W6lGdGw2fDWNO3SjwFGade8tqu68jc0dmFKuaM6uB0KgV5CcPWnc+HnIjnfSyUM2GxspQdYhHF3MXY0JpTl/bmgjkuSvxZfCPbDj3KEsg+YKOz1UAFJYQ+bhTd4EVMRFxiBSTM56nPNnM6eP4ch99hg4XtvbJDrzt6iScHkQFUJmExxMWluA1k
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53ccf6a-1fd7-43e5-ca19-08d79a2a0059
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 02:15:48.3691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3t1MkN1ZcL9JDtlf9XB2BNo/Lmi3Q8VSojnYcJi+bX52QDuWZy+2cDyTN5RRo9uZV/sc74iQ35C/9vDc/dcJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6289
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
index e0f25983e80f..4174506e8bdd 100644
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
@@ -149,8 +152,16 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char=
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
@@ -164,8 +175,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char =
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

