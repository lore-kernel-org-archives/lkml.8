Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89564C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1462082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dVGjCcxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgAJHR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:17:57 -0500
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:30435
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgAJHR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:17:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh4aCcA8yowCYYzb/1uFZEIjCce2yUgmgNyLcXKNH+1UuZZ91V1ROvnYMhJSsfxDoAgNeo3fDg5v21D/PnkS3vpw1MDZ85uvefx7q8uFkFY1ZMDOoaNiHZJ+pUM/T2Tk4E3WkBFRezToBAXB5+n6JTn8os2NZL21qJLGeQ5L6jzdkMZheeirWmLWxfC/EATHmT5Y8BsYOfatcsivpixlHdyztqzjo3iAAnqC9S8nAhJp2SI5oCoR8lTMdCT6tEOClrmkopFe8mRkJ56xx6QpEOLZCnHtVUU9mox6zpqT8ZodnDRxzS91/7xbHh3xlAZwOxZYj0gS01DwjePveVCR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecmHfJVJiot1XS18SwH3PfV+9dIwuObjU5F0IFUVAKw=;
 b=YL7WJYLCTzXleaozvzHy2hNxYfRcd5aGiRRC75jELb5ytUMslSoH/wCnrzr3JqKFcD3+gSj9g7fRHPGyrWZ8ovZEnwSar5jyl90JNPu2SNjzdiWJ9RRa9m0VY9aFQwEg2We3Yo/1NZ04lws83METMGUxbMv/HDYpTDbnpCxky18c2zmCF8JuPw4J6R3vnGaziE8tfNOmvsxr1vmrjDQgnlr/zKk6GNDnqvRKOa6mSg/UhxsYEUoCpkOurT0VIC9AglY/yEMDdCZKj+aHQgbGzI+Gu3v+GdQ8rlmm5sfssMFZ1YLWDIm/8B3QgTcRWUhQCt7wyHpjEqUV7+Hk5bBldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecmHfJVJiot1XS18SwH3PfV+9dIwuObjU5F0IFUVAKw=;
 b=dVGjCcxv9OPMAJjt/zHJVDJ5ziQ6xXLwo2yUkEj1Nl2IRKJGiVWYufxc61vUXTz2/s+YP5HrL7effsqb+xehu5iB6r/kG9TwIqhRO7kvRj3NmgIIsZOTSmcYaMSOiAoS8nVf0F2NtfDQT0WfC9r6Vd5NKnZmvLGXajDU11L4XqQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7172.eurprd04.prod.outlook.com (10.186.128.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 07:17:51 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 07:17:51 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.10 via Frontend Transport; Fri, 10 Jan 2020 07:17:47 +0000
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
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V2 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_composite_core
Thread-Index: AQHVx4YROmU8DG5TrkiTcIEvRCTPVw==
Date:   Fri, 10 Jan 2020 07:17:51 +0000
Message-ID: <1578640411-16991-2-git-send-email-peng.fan@nxp.com>
References: <1578640411-16991-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1578640411-16991-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db54fddd-6379-4a4c-de84-08d7959d33f0
x-ms-traffictypediagnostic: AM0PR04MB7172:|AM0PR04MB7172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB71727D266E78E81819DCB74D88380@AM0PR04MB7172.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(2906002)(478600001)(81156014)(81166006)(69590400006)(956004)(8936002)(4326008)(2616005)(44832011)(71200400001)(8676002)(6666004)(86362001)(6512007)(5660300002)(6486002)(186003)(16526019)(66476007)(66446008)(36756003)(66556008)(64756008)(66946007)(26005)(6506007)(6636002)(54906003)(316002)(52116002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7172;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qyp1gLIOaYzwqD8ehPjyL7LWYEGGwdEfUWK4zfDZl9wjomXg7NljdbFlB+znCVFm3kNCt1eNw2p7HXmwjcJ4kL1VwPCCAA0jW0iHH7lnAANmaN+dO4UAtAo9bPtDo9oguRUNZKERfvyrw/K5llisCL7RBMVu+3QqowTF6kCX4Sj4MNgxS9eZ1JS9LhpfU2oe/vwe6KCvRA069p03Ir/pvpJ1IZg22K4D0Jd4AFELQJMAj435ZwfsxL7APZMEt6JqQHfgc/Ln6nfmnE/gwCqSb38wVCoci1xGzKUyJQkLWBXgOgn+HkMpnjTErg8u+cpUAXkxmd96RUfeEDSJGjUlvsO3w2Lwjj3VACpOuNvFU/vggKFDo3huqr6RCNr9cKeCeylgNySH9dQQvC4O3r1vk4cDwlcWPtGbw1xjKVL69w5njW40xnf6alNOJtg9MEh7221R/0Y51ub0nLZ7SDdTcZFjz+q9h8C8h+KifFLgUM89UtILMMqO3jIICl+GwyjR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db54fddd-6379-4a4c-de84-08d7959d33f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 07:17:51.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hyCUhh/+z6zlvKhNaEpGrtgOysopFjoCaSWzsad1coZonp7pLw4KwGLGMaanctBcDBGe4XsgGMhg+pJb7dzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7172
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
 drivers/clk/imx/clk.h              | 12 ++++++++++--
 2 files changed, 24 insertions(+), 6 deletions(-)

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
index 65d80c675aa9..6f0d5e8fbbac 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -474,20 +474,28 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const=
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
+			IMX_COMPOSITE_CORE, 0)
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

