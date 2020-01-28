Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A5CC35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFC724681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DDaD5e3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgA1GDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:03:13 -0500
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:40943
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgA1GDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:03:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Baj5kaWn5zXKoS9MUQTeFryUI4+6iYfUL0F+fHFjC8ur66Fl0rrcVijW8WpWzjkdmoS6oMKpNOhytfnL7wiHx4KG0u/F/pTe51BmltUPnYpj/u6Oiil655dEnfLPz9x4/ctMFS2ZjuPeV63m73bDX/kxQYhkUv7fLuihFumoTuNDCOXcvzNjpwGYD0XK1TamTjdnaxUWQkoD8CR9n6Q6sdhGrjI3FpXZm740vukGlVE0iVlriNI6QAihvCf8Sojq0Ig81JkzZ/duxZ0jud1UF37qS/zeNuym4K7PCubeM/4H8g9V+/op5FIoTFAGhwzPAGzK/NvGBgONo0stk9isIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tETQvbBRX8v/xgVNT/oVUXPAuZoKQ+siTYO6sFH9zds=;
 b=G2joecOdlnhsDmdnlItj7EVCf92oIHLhY7Y4jbh+hz6oIx4vBOdFCHFqcamLqn09ZKCaykpDyE4WGaZmp/frlKTrL4kqA7Um2fMvLruO+hf1W5HYvkWE3yrNmra+fKiIjJrqBnuPBb1dJMOlvj9I6vVVDQMnb71YDgB47CTtjwjxgRFW1gKU6qmxhlaKJPMpaqzZr92vecyU/QzykOzpYLgSWsNQN0kIANWhqfmjjXKB45QHWHuH5YWcV1YrQRRLMg4nMib7HT4H7l2uFcorqfKu/yf8pcJOpSktk41vg8Sif/qddwHKHBg35RbZBLoB4kA9yovL2FAl5FTLdfkMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tETQvbBRX8v/xgVNT/oVUXPAuZoKQ+siTYO6sFH9zds=;
 b=DDaD5e3qu2Bql7y4usn4/Sds46s+loieP1Gb43E+Ah0xeSPyzZi38PvI4E5/LBGe+8L1qMSVMnI4lQXMYY2oCvTKlCUeUrYdCIHFyF9yTSd9IyNMozl8ICpSqojF8sNcya5qgdkjp6AQTVPUvAWDI2Tzw4FOWKN6yfhkSVcIxKY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5377.eurprd04.prod.outlook.com (20.178.113.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 06:03:09 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 06:03:09 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0087.apcprd04.prod.outlook.com (2603:1096:202:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.20 via Frontend Transport; Tue, 28 Jan 2020 06:03:05 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/2] soc: imx: increase build coverage for imx8 soc driver
Thread-Topic: [PATCH V3 0/2] soc: imx: increase build coverage for imx8 soc
 driver
Thread-Index: AQHV1aCdMkWgGrHEXE+1Qb5+U0XS6g==
Date:   Tue, 28 Jan 2020 06:03:09 +0000
Message-ID: <1580191098-5886-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 411ad249-2749-41ff-20a3-08d7a3b7bff0
x-ms-traffictypediagnostic: AM0PR04MB5377:|AM0PR04MB5377:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5377AA02E141423604ED5080880A0@AM0PR04MB5377.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2616005)(956004)(52116002)(86362001)(8936002)(8676002)(81156014)(81166006)(36756003)(64756008)(66446008)(66556008)(66476007)(44832011)(2906002)(16526019)(5660300002)(66946007)(478600001)(4744005)(6486002)(110136005)(54906003)(26005)(316002)(71200400001)(6512007)(6506007)(69590400006)(186003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5377;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VS3qdGvzNS5TLaT3wi0ptfQ92htU0iDmUHLUMlAEF/lR0lXgAEoBvFqUJYmhMXkHmvGByjwYScnPKpFHWQjVjBDPdQGLmh2DCBrTPlme0+ZwFXlQgFWW+TGW+z4mIW8F3i6khV7T7Itp92BjsFw0fZVJ/K6n3hU5shkQYwSbk9s655kSR+7XhqfTZcXiOLqVooR2Ds5UBb7ACyopDa0zQ+SWsfZfIgoJCdKhK1xh2xgbYRdUOu7ibMurXgImBL+YCW7erZ7/j7/7r2+caxQ/BsVBDQLNr3ncG6A0HLWm1RHD067NE/72XvtenAxFfeTYBRtWAuxieE1ASKeGImmqHOJ+sZ15yw23iYuP2R0R6xcJY/NevbUO0uNWBPdBpq2U2XvGKLE4wey/xqpkLxZgOVy+CU6dl5Bmeq9Y9sdheG1loQMq7gW0lo3u5BVxibr/4fVwR+ODBZTEdGZ9k7zRgTJfBGngqAEWwfePoAF42kSuqZIm20tKh0XojXAhrvWzzCWqDw+erptpod0Te+U00J2UqonLCX66X57xzxHxnnw=
x-ms-exchange-antispam-messagedata: 0M5hLP6NFnEooB0fAhC9vrlOlbkzQLTlaY0CTQlaaS/94GSvD/a8nOwbkcEibprM7bKajanYN/IuVyLzGJa4I7TiBlOjArogD3RShUn12SDqYiIBz3kG88jpSgPXpv+55l0uVEBZ1zy3T7BL5vPhWg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411ad249-2749-41ff-20a3-08d7a3b7bff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 06:03:09.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkKg65OVCUr3UvgAAF0TYmk90+89DAJi4GInkypp4xQYstJekFKBEjfdLOTICcDVDVBvmE9h8+C7jpZVGNQDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>


V3:
 Per Arnd's suggestions, merged Patch 2/3/4/5 into one patch
 Dropped the defconfig change with a default Kconfig

 Leonard, I dropped you R-b in V3 since the change.

V2:
 Include Leonard's patch to fix build break after enable compile test
 Add Leonard's R-b tag

Rename soc-imx8.c to soc-imx8m.c which is for i.MX8M family
Add SOC_IMX8M for build gate soc-imx8m.c
Increase build coverage for i.MX SoC driver

Leonard Crestez (1):
  soc: imx: gpcv2: include linux/sizes.h

Peng Fan (1):
  soc: imx: increase build coverage for imx8m soc driver

 drivers/soc/Makefile                        | 2 +-
 drivers/soc/imx/Kconfig                     | 9 +++++++++
 drivers/soc/imx/Makefile                    | 2 +-
 drivers/soc/imx/gpcv2.c                     | 1 +
 drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} | 0
 5 files changed, 12 insertions(+), 2 deletions(-)
 rename drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} (100%)

--=20
2.16.4

