Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA24C33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698582081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lDmTDI3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgAPCPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:15:46 -0500
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:55367
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730202AbgAPCPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:15:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/j9gNwJKJ4p/xGAb/EYagmUEWJTCmNBgqXktEuySJWDwPpYIHzdZO5k9dYaOHcx9OgqdO3Zoq9WJR6olrQiRN1WF1baMpCqcLPSnB1DpEFt1fz5BjRHXrUUUn0oo4ZXhWCeg8Cdsv6IvqcY9a+boVMkjMcf2L9X3GEuCK1V2gIrl7EmgBtX3C0PEaQ613RDe199XWELdER5SLpZyHY1K3mF5kcQSHkywhPa3enBQlipGZpARbuToPgaqJuFKd+XCaDzj3g0QVr3sGNI9G51EtCDmvgK/zcSnVDlB2IpOHh8P14iRsBUGmrdNLQhQPNwRan1bdp8xTytW9uiriXikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk8wqONt0m5VutgAp1dDRQ1onFLZAHSZSFGDHYgXc1I=;
 b=NlKM+ybPZtiRltEc3orZLG5xuIkdf7Lw5dk15rL60mzhHGDEXYXliGnC2nLjgTRGUY4WlUD8kGjgW+LVBsVyQquNt7UHVmNB36DIu7oESYSRXAS+1I4wjIb3h46H8oDWbqhdi6i4KOpXv3cBOUNbR9eaTNMQFAgXp95asOmk7cB60Rhm/0IpFXnxttrXAgz0g8PYClL3r4JfKlcMkkEI6VcKVWmFtvKKijVKfwtQc5goWsaGohEa4UTs8qiMrMgb2PyOjNO6IUxI2CuNBrBnYA2uezU2s7Iaj6f6G7hrU/g4g/txvD85payEUCVicv5XLe+D8Ra4UBXMOJZD0psBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk8wqONt0m5VutgAp1dDRQ1onFLZAHSZSFGDHYgXc1I=;
 b=lDmTDI3pkRvoop9Nn1ANEmmdsqZiuAxAK6KpWdw8AFofDO9RVVFyuNkIGteDs/ScszXF1R/Ex1RpqRdj+V4jD7nhb7KOLxYMSQLrCrAD4O38LopcmweO/PNI6qmyWDPuBrpRQM1OHDQjAL8XlZ76jIZmaFRv571ncPIiTRL3SbA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6289.eurprd04.prod.outlook.com (20.179.35.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 02:15:42 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 02:15:42 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Thu, 16 Jan 2020 02:15:36 +0000
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
Subject: [PATCH V3 0/4] clk: imx: imx8m: introduce imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V3 0/4] clk: imx: imx8m: introduce
 imx8m_clk_hw_composite_core
Thread-Index: AQHVzBLaTlW3Hwqw+ku5LVRzcstOhQ==
Date:   Thu, 16 Jan 2020 02:15:42 +0000
Message-ID: <1579140562-8060-1-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 8181c590-83c3-4a5c-58ca-08d79a29fc87
x-ms-traffictypediagnostic: AM0PR04MB6289:|AM0PR04MB6289:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6289984E9B5EE15A87383EEF88360@AM0PR04MB6289.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(478600001)(4326008)(5660300002)(316002)(54906003)(110136005)(8936002)(81166006)(81156014)(8676002)(36756003)(6512007)(71200400001)(69590400006)(16526019)(6636002)(26005)(6506007)(186003)(86362001)(52116002)(64756008)(956004)(6666004)(66946007)(66476007)(6486002)(66556008)(44832011)(66446008)(2616005)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6289;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84aZxjSKhi+ihad2GpR/THb8HU+EzE/LakfJBYDnzwqXcA0WxqwakRqS+Yn0in7FFm624A53SVRrZ87ybzJ158kRQeCRz75bgoryu6hwfOAhxv+ntEs9EIZS8unb5Ce7KrdBepp68TZOp3cjXwtL6hamJQ7IEW/Czpl2LlPt17hc71OvAWhjSInBsMeniLb9Q+INVom1UoPC/N0ro0KY6MYgymcSlhurSvyQqbRaIBj+EiLsKJdPhUAQs5Qm/0RlsHr44ADRkMQL7KwKTC0H2jdfj4irTpfSRmaVmj50T/aVnJq5b5jXstiXAkAoGcz7syX2pUQmsXszB2K5xoYACp0S4uyXW0V9FimlEbw5wGgLz/IjBgWlsn1Se4VHOghYNmnPGRdLeoNdSR/oPRtZn+Tu4kOQ6Dpx5yRtuLiui+5BHPYPmJmvWv3++uL9vTMAFLv8jiUhXOmBNnUg+0JfgIJu0fovonv4snKK5h8hPMsVRmka6S0VVRg0L+e9AuTSf/UNKsjXfQXDV3Rf2r46yA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8181c590-83c3-4a5c-58ca-08d79a29fc87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 02:15:42.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ia+cxtc1zzL7zi/SnTatGMrxUx96vCXijzwI1Ob1MOXax+oxVoDPdrZfLVbazcSXCoYQ7c89YNGvoQP+pvzVkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>


Leonard,
 Please help review this V3 patchset.

V3:
 Add CLK_SET_RATE_NO_REPARENT and CLK_OPS_PARENT_ENABLE for core
 Avoid break DT for i.MX8MQ

V2:
 Rename imx8m_clk_hw_core_composite to imx8m_clk_hw_composite_core
 Add Abel's tag

To i.MX8M family, there are different types of clock slices,
bus/core/ip and etc. Currently, the imx8m_clk_hw_composite
api could only handle bus and ip clock slice, it could
not handle core slice. The difference is core slice not have
pre divider and the width of post divider is 3 bits.

To simplify code and reuse imx8m_clk_hw_composite, introduce a
flag IMX_COMPOSITE_CORE to differentiate the slices.

With this new helper, we could simplify i.MX8M SoC clk drivers.

Peng Fan (4):
  clk: imx: composite-8m: add imx8m_clk_hw_composite_core
  clk: imx: imx8mq: use imx8m_clk_hw_composite_core
  clk: imx: imx8mm: use imx8m_clk_hw_composite_core
  clk: imx: imx8mn: use imx8m_clk_hw_composite_core

 drivers/clk/imx/clk-composite-8m.c | 18 ++++++++++++++----
 drivers/clk/imx/clk-imx8mm.c       | 17 +++++------------
 drivers/clk/imx/clk-imx8mn.c       | 10 +++-------
 drivers/clk/imx/clk-imx8mq.c       | 22 ++++++++--------------
 drivers/clk/imx/clk.h              | 13 +++++++++++--
 5 files changed, 41 insertions(+), 39 deletions(-)

--=20
2.16.4

