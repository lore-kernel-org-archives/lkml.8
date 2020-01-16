Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0986C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A09F22522
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oYNbl/pJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgAPDtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:49:02 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:54051
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730397AbgAPDtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:49:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWpBpv193S2NU5pQd33UuAfFRNRk2H+vNxXZyqifErQfjGzLtL1uDe0U68/cyONs7J8aAkmNMc+3yNvagoLBAmFJAdVQnrb6SabffV16xMSELw2tUzyjrirf4IcwvqOtUNBK0nyur192/0Elax+gnlbQ8M7iXSngJhv3RNjgac0u+/XZ3T0uCFc7mOZ1qyZw7VeNhGf+ifPFuR3qC3GyJF0CzM2O500/to1JdPzsIty6SSpiHkEscI+eip7zRbP1IcjFtLOj+KJm6957bCA8pD8p3V6zFFB3Yn92YZLr5fc/WbfwEk7fGii2GqTr+I6Zl+XHSa6lKQWgdSVt0f/IPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGZY0qzSjuctB8Z4j5H+7G/QHq1ladc1W8PMWWathM0=;
 b=E5hiPGHbtxV4+20zCegPePoFP4GK6RhtXZr4okt/4jejOIgYKFdmUyQnnRRCo3SBngoD2lGQlhdE7YAYVB+jmNpeQ7nWioXZjDUgOPpSvT1xkiy/m/QHzgv2CBchAxoWFupWlofumLdGQWAAqaQE9JgMUmEx5Ma2adwVEFAmtDItvDedlpHCCp0RRqftX3JmcBa8WMtuE5x6tQdf4zAxFv+z9L+4A0K+ZugYEX1HLlOKMkqhasPS8EPjIfWnR33bxYI2XthM6OgLSfY/MPnFl0KZF6i/bmj3N35lCuSsiankpYw7qlTh1NdbXRsYOkHQ9qB4sj34PkEpElD2IS8pRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGZY0qzSjuctB8Z4j5H+7G/QHq1ladc1W8PMWWathM0=;
 b=oYNbl/pJu/FrJp7gGWp2zvoxx9zJabdzPY24VAcuhs0G2rl51ZA7pNljsK4Dd/NRyeL7o8zaOZQCQ4fF0dlaV4O+diuaJ89KchgZ0ZNzBruTXDted63KFxF1PwxBAmeDYDMTRyGkNjHcB7CpoePYOqtFD3Q43OBLg8Nv6d7ZElE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4612.eurprd04.prod.outlook.com (52.135.146.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 03:48:57 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 03:48:57 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0002.apcprd06.prod.outlook.com (2603:1096:202:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 03:48:52 +0000
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
Subject: [PATCH 0/4] soc: imx: increase build coverage for imx8 soc driver
Thread-Topic: [PATCH 0/4] soc: imx: increase build coverage for imx8 soc
 driver
Thread-Index: AQHVzB/hVXSait8oKkG3c6qn/lfwPw==
Date:   Thu, 16 Jan 2020 03:48:56 +0000
Message-ID: <1579146280-1750-1-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 92422ba1-da1f-49d9-4aef-08d79a37034c
x-ms-traffictypediagnostic: AM0PR04MB4612:|AM0PR04MB4612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB461294B6AC7A944F067F698288360@AM0PR04MB4612.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(478600001)(2616005)(66946007)(2906002)(956004)(110136005)(8676002)(81156014)(81166006)(8936002)(44832011)(4326008)(66556008)(7416002)(66446008)(64756008)(66476007)(54906003)(5660300002)(86362001)(71200400001)(69590400006)(6506007)(316002)(36756003)(26005)(186003)(16526019)(52116002)(6486002)(6512007)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4612;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5+Cn2P1jqna5u9UJUWrubediJZFjswd97PpEjS8sVFQqV0gvCVB1RKHWISRC3hIy9e1ncsa0fbg99+8+g0ndjHG8h2oHehPxCfcMsvlX2irxJp8w7Upbb6Tok8o8BeiDw1/nhQ5u0FNrXJb5KOw2NZWQBe/QAXx9+OE1L6qyYgtRKEj6tkGC4bp1O/QS1C4CYbI9yXqR3q1nKm0Y7cpDAHhsT/E9vYqaeYAboKnAmuhmOEUyQToNgT04WNjrCa0EXY+VhBQOXw0P6SLrSopxXu9PUzY4Hnx82dKOuYNHHlkNI9r7glLXsK/bsEfYb0N4UBd7E+a2eX5BHLN50b3EhkJIPTw5sJsjc8tGtXjmkAOMXYSFEA/4ihPE3LuvrGkz02YBeEmywI+jeZ1ME5Rc0Eml1HC+gBU0FljHALTcsOTvdaRt3GzkNjRPx7mCHVjpZKxvI4sz7/KaSGVM6z9OuU15lWjlXWLl6tSAxTKz2L3A8K+1N8ORE1gQSg6uHg/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92422ba1-da1f-49d9-4aef-08d79a37034c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 03:48:56.9532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpu0KSe4Sgy83ks1pGlkftg21MvFaVWaQty5Vafgks1Z2xhhoijVCTTZ85PBLmHtIaKjqsTK+qR/pBqx5anemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Rename soc-imx8.c to soc-imx8m.c which is for i.MX8M family
Add SOC_IMX8M for build gate soc-imx8m.c
Increase build coverage for i.MX SoC driver

Peng Fan (4):
  soc: imx: Kconfig: add SOC_IMX8M entry
  arm64: defconfig: Enable CONFIG_SOC_IMX8M by default
  soc: Makefile: increase build coverage for i.MX
  soc: imx: Use CONFIG_SOC_IMX8M as build gate

 arch/arm64/configs/defconfig                | 1 +
 drivers/soc/Makefile                        | 2 +-
 drivers/soc/imx/Kconfig                     | 8 ++++++++
 drivers/soc/imx/Makefile                    | 2 +-
 drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} | 0
 5 files changed, 11 insertions(+), 2 deletions(-)
 rename drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} (100%)

--=20
2.16.4

