Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671DC33CB6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F39920730
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vou3mHCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgASKMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 05:12:50 -0500
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:41601
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbgASKMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 05:12:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTCcj32Wwq0uKN8EUjlG8PDneNDrRBJkcqvGSBrMAy0cYL4yz3O/lbBRFYb8nSDpxhzh1gw1TQEmAsV/HUrZi4TKfMMz/QKngIYM/izQDNyWfOX3t+0FNmRwQJ17dMvhprn4W7SAajXUD0iXGa4Teq4b6UbYjiNnYfoLrglugoOrptvBw7KZMdNLG6qX1e16pR2FJ+WJBMDhespWLFKIh7dX5Iw+cKKEgYrYNpzbIpqoFHBXfpEIXRU0n0+50Z/1g0F2aMCFquTZUzxgsVQENdBGTqC44Q9vUkRdXb2d6U3es8emet8qsJ9uQzB4Q41fxJyEKCtA0BxbzfmkfF5taQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW4wqVvrv4KE+Tk5Jysq0WdyDmZh/sj/OhSriDtJQLw=;
 b=SFQJxehZ7qGp6ZpfwImOshHu4y6wy33R2DsySP6q4vJBaaMYxC+iyh8wZUl6LTC32I3F1NKn6kKDXPtrEqyrYlW/UKgm9I+W78l7gYC8S75yt3x32OC1zivZwiJs3IoMfkgEOzx7xlel8Y/V56yB/c2k0oH5kk9jZtX8jaE0DOvqCZIk9oPv0CQdse+jSSLzndTcw8aZeZ7ytxlk1Aap6SF+zKkOBCeDmQ9S7XfAbvg8eXHzrnE+V56qgseUThK9bZJ7/1Oyr4aKej6/zMMzS3ozz77sAh/YVHs235yujq4ndTl1R+Yz0R9ngzYuUW9bpNjLRveK9l2hmSURVUQ5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW4wqVvrv4KE+Tk5Jysq0WdyDmZh/sj/OhSriDtJQLw=;
 b=Vou3mHCa/skQ5X1jPgDyQvrbCIyNbTv2WuAz1eHPEE3IiWc0NVJ46Ev62lW7VaxAXAwgDD5e3Uq4DsjrRf+5aoh87MTM9TKkmpsjw9V67HT1TYLSBiVZvfagqV8SgfbXlsPdVvy/gqp/BL6T1AfEROQrdT4/AeenV9d7UkWoXxI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0SPR01MB0058.eurprd04.prod.outlook.com (20.179.37.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Sun, 19 Jan 2020 10:12:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2644.024; Sun, 19 Jan 2020
 10:12:46 +0000
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0104.apcprd03.prod.outlook.com (2603:1096:203:b0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.20 via Frontend Transport; Sun, 19 Jan 2020 10:12:41 +0000
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
Subject: [PATCH] clk: imx: imx8mp: add ocotp root clk
Thread-Topic: [PATCH] clk: imx: imx8mp: add ocotp root clk
Thread-Index: AQHVzrD+KCxt16k/UUaPoEt5ULSIVQ==
Date:   Sun, 19 Jan 2020 10:12:46 +0000
Message-ID: <1579428498-10068-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cdaf15f2-6689-402c-0dd7-08d79cc8212f
x-ms-traffictypediagnostic: AM0SPR01MB0058:|AM0SPR01MB0058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0SPR01MB0058475C3FFD38E11A1E754988330@AM0SPR01MB0058.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(66556008)(66476007)(66446008)(64756008)(2906002)(16526019)(186003)(6512007)(36756003)(478600001)(44832011)(26005)(66946007)(6486002)(4326008)(956004)(2616005)(8936002)(6636002)(81166006)(81156014)(6506007)(52116002)(86362001)(5660300002)(316002)(8676002)(110136005)(54906003)(71200400001)(69590400006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0058;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dOJ7reTn/7x5QHW5gqu6jc71Gpgb24s8wMQyEGtMLSpob1tHtymzD9UVQstSvdINsfeGVc/z5eAJNQC88Z/qMJWkWRgqb/a/PwSVmMCv/T/5Sdxanhje3TfdxhAsMvOmsXtYZk6BRsn5o5aQh2XpnDY8N5AHRPPKT6DkCyEtI7q90nioGZfmAn1H/IPM2OPhDSk1linXky8UVb08xyhWvvW3xjUD4zRcwEJZ8tCyKbBtE6IFmsXMeUmR6f+sf4SiD+Q1pqgMt5YYAsLLhDi27z298pWRDlj4xnCrZLHX+/7tChM8KsiYILg+fCAOBGAr96+fqxmM5XVhozqjEc84BnMOQMJqy05PP4+VtsRGHeG3S7W9icsyRbCfPG1kI4lJnjPtSK6KNKSEatBH4TX8JrHROf4A/TFL5biMvBT/6qvw1sky7iE8Mja2DSDT5AGZkiqMW44NE9uVtirEkomMdFZWW4j99OJGRljlWQQT5KsGXsC4eVeBqLNJ+i+ENNF/m7JrlYuosKBmprDNtoBk/g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaf15f2-6689-402c-0dd7-08d79cc8212f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 10:12:46.4476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwfEUGR6/VpzQaxAUA1gZSRz7kx9sCRUANh35HUgMwQr3GebJ8OXwMcwWj1MnXGnlOu7LBHQ6vxbCbZqcMi25Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add ocotp root clk, then when using nvmem to read fuse, clk
could be managed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index f6c120cca0d4..ee83aa2162d9 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -671,6 +671,7 @@ static int imx8mp_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MP_CLK_I2C2_ROOT] =3D imx_clk_hw_gate4("i2c2_root_clk", "i2c2", c=
cm_base + 0x4180, 0);
 	hws[IMX8MP_CLK_I2C3_ROOT] =3D imx_clk_hw_gate4("i2c3_root_clk", "i2c3", c=
cm_base + 0x4190, 0);
 	hws[IMX8MP_CLK_I2C4_ROOT] =3D imx_clk_hw_gate4("i2c4_root_clk", "i2c4", c=
cm_base + 0x41a0, 0);
+	hws[IMX8MP_CLK_OCOTP_ROOT] =3D imx_clk_hw_gate4("ocotp_root_clk", "ipg_ro=
ot", ccm_base + 0x4220, 0);
 	hws[IMX8MP_CLK_PCIE_ROOT] =3D imx_clk_hw_gate4("pcie_root_clk", "pcie_aux=
", ccm_base + 0x4250, 0);
 	hws[IMX8MP_CLK_PWM1_ROOT] =3D imx_clk_hw_gate4("pwm1_root_clk", "pwm1", c=
cm_base + 0x4280, 0);
 	hws[IMX8MP_CLK_PWM2_ROOT] =3D imx_clk_hw_gate4("pwm2_root_clk", "pwm2", c=
cm_base + 0x4290, 0);
--=20
2.16.4

