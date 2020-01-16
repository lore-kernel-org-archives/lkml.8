Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33122C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED67F2467A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ChLLMiBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgAPDtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:49:21 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:25097
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730397AbgAPDtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:49:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs4XFACGmuac/8HTHFXhHrgUyw8pEofxhmN77ihjhKESpZ4iz32srDKADGcxlkUYGAYhplccj1fm3J8olHrpHssB6gj5cVS9genzVwhk9kgwDLphyR0MOb26dAOiT0Iva/l84EwmYE/qpvp9jKPqhhg73yhoVnB++oggE9DlwVyXInjUAVy5uUAbwvLfO70nuFe82BaxjGx8rXxBzIs4j/iUMke2UW/bAKX2yaXzI3m37UmzjVK+OAEndQpkcVkAR7s5amH5Z3ynV27JOxbsMDhonseL9sKA+3Gd6wk5fQOVOasmG9d5pAHhZan5Zx6WUEANk7CoR2PkChwW0ftg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWdrEgsGxBUhEeIl1TveLZnox0xgq3TjOubjUxjvwTM=;
 b=C4wcsnq3fA4MQcD+1T2oo4e9snkeDjNTz8Ff0ispemMJIck3KZWS4Sf8Gb/s1H2U1i476nE9j80lKzcXUdsb8qd56aDqvenbw1J0y+bZSu/XJqw96bcTdvTGfFaydHHJMDhfhkoRmj7EU87yw02R6ZyPOjJlKxsetzxXgLU2o99XybOONO+ZYTc0RAbm7m+80UEIjBOdqbEjmHKtfImBwyoUyNyiRRZj1B7vqPIQpnmJKLZUHpA302lKOriTw2TCpAlM9HBpezCkZhZ+RyuTM0Qkx44nfT4qBGezR1XYrzRx08GGdfKovHPDnmIDYqYby9zos1/+Re1V3lrLRJbfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWdrEgsGxBUhEeIl1TveLZnox0xgq3TjOubjUxjvwTM=;
 b=ChLLMiBUjM88eN5J/vnxOOaeUcip4jVn+m1QGu37cXOOJcy3wSDD79ESHDebLXcMMa2isnHPzYKfdYAiBy52ymc8ypiV5Wbz0qHECdDJv37tJFHoETJr87eYHI1uHuepTNF1lBVkz1zU8uQ+SSVg5FWr61UGjaL9fEqMrhLeLtY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4612.eurprd04.prod.outlook.com (52.135.146.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 03:49:17 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 03:49:16 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0002.apcprd06.prod.outlook.com (2603:1096:202:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 03:49:12 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Subject: [PATCH 4/4] soc: imx: Use CONFIG_SOC_IMX8M as build gate
Thread-Topic: [PATCH 4/4] soc: imx: Use CONFIG_SOC_IMX8M as build gate
Thread-Index: AQHVzB/s+hHkepQnjku3J7ycSA+g0w==
Date:   Thu, 16 Jan 2020 03:49:16 +0000
Message-ID: <1579146280-1750-5-git-send-email-peng.fan@nxp.com>
References: <1579146280-1750-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1579146280-1750-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd1e982c-b780-4275-cc83-08d79a370f0f
x-ms-traffictypediagnostic: AM0PR04MB4612:|AM0PR04MB4612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4612D1868298F9AF5F7F6EA188360@AM0PR04MB4612.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(478600001)(2616005)(66946007)(2906002)(956004)(110136005)(8676002)(81156014)(81166006)(8936002)(44832011)(4326008)(66556008)(7416002)(66446008)(64756008)(66476007)(54906003)(5660300002)(86362001)(71200400001)(69590400006)(6506007)(316002)(36756003)(26005)(186003)(16526019)(52116002)(6486002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4612;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yrbWfduEyrEW+5JTTzP172ID6kip/4qYyGkc+IienQWRrwYLqWIL7oHLu7vkF58/r6uB/tkkWra7uNj/cBCA/D2BWGIuMxN8c+y12ELrSas0+DiIKrN3zmZPfVR09dGiuXpHyceST/HBkZxxUhCla22i+KQmFycNmtWhHsma2zoHmp3RAvart6+LL05tE7+JtMDmzjWLgM0QkU8wqIm4JFr2qNYAQO7Czio2eaRVVF5eYZ5PfG0HgHiRjwhaYAYPlAyrV79KFgr+I87JW1cWg2eE2vKVEfk9/c2thvk7d31cZZh8W7VEEuC+jYu8VEjBWo432ksv2873/oiFg48g8jK0lS2KhlGTnxLYG+o/bbQiihPLTD3DZvwpwyx+MlM0UAkeb0ZJFHcRlzXwS4p31KoqpkOs1GntGut2cIEIQi9zE28KLxnKgzzSHDadREYC7VK+a6quBFNJlyJ/G4KdDbNLkacPzEROeUVnCTwFk7Pp5j6niumAHcmLTqJbyHpP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1e982c-b780-4275-cc83-08d79a370f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 03:49:16.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chO3To2d3Puh+dwEr+gdg6qnt1Wj8KHLXLldamd5k7Izn29eCMYwp5rW7nhftl9Wy/nvIacTYueUSedG9sl17g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The soc-imx8.c driver is actually for i.MX8M family, so rename it
to soc-imx8m.c.
Use CONFIG_SOC_IMX8M as build gate, not CONFIG_ARCH_MXC, to control
whether build this driver, also make it possible for compile test.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Makefile                    | 2 +-
 drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} (100%)

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index cf9ca42ff739..103e2c93c342 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
-obj-$(CONFIG_ARCH_MXC) +=3D soc-imx8.o
+obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
 obj-$(CONFIG_IMX_SCU_SOC) +=3D soc-imx-scu.o
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8m.c
similarity index 100%
rename from drivers/soc/imx/soc-imx8.c
rename to drivers/soc/imx/soc-imx8m.c
--=20
2.16.4

