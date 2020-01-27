Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3BAC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348D72168B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qsrEJZA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgA0Jom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:44:42 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:48565
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbgA0Jol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:44:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HII1iHSAsgp8QZBHeUugRkwBR1UEbF9nvXqKj0flxgXF+Q3TDgVfNSH0UvMtgjh5Eb1JxiX60VhEeZZVq0fbi2As9NzuLpj++XqoavYiW3W2rVam0E8Xd78YRwLAEFILB+Xz4Nlv7bDNx2k2m3RYAITrlYfnlPgen0ppm4E7pj33kUXr3hbH9QJFlrj0Bc8t3kBf9WHh6/gQGz1NCem1izpvlFpZxCUFR90WGr10FpcXMqJr68ccUi4hn3xqxmnFpe+kf6BhKbX90z2sSk5Td6CqWfvp6UASixnonWel+jdpGT12pteb0b0NqQ5wWTWKOuM4uaGg8eWX+h4O6K3uCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmyDQ1wFPTZDH0I3nXO14rYvD1nbvrWvujHq77+hdLI=;
 b=RUK1L7ZsRRt3e/51ADBsGhB98e61mAA1qr+HFsoRk7/8Y+mtxL1h8mmxzHhpbmeuF/Bzyd5OeoyNH+NHFs8m0RlIb2TMhrDi3YWpwX7toZQS+38Pl1zQlocCJGc+OGxluD0W/+pNKdaqZW7MElMSjW+N/AkwF0de0RjAGenmE1WrnlFxiY2K49r5Uh4/E9v+9H5NG/3HmXYNyvjRdVir1qyKXT218E/FwJ368yj6YFaUnbcFixMo2H305yxghuGoWWN9h6fNOvk4rAzcPAOAGDQR2UVIU8Du3+0W4kNn0C8rIhdqXJePYdehnIkPG4V3RDiI8QXUhY9yafmvzlCq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmyDQ1wFPTZDH0I3nXO14rYvD1nbvrWvujHq77+hdLI=;
 b=qsrEJZA6W9uv/xqzKCbndo7G+V7nBjmjArsKgIoSihYZsvr+LQhMQZD6wBKYbXGjRjJ32H9e2+HM5gOvKQiARjw532fzxXkJa72DoR8l6szeZSz5+zkj0vWGJ42ezswHEPc0ENDtU2MID8OFuWCtxZwVSNYoGRB+rHK7ngDwQn4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7108.eurprd04.prod.outlook.com (10.186.131.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Mon, 27 Jan 2020 09:44:38 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 09:44:38 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0401CA0005.apcprd04.prod.outlook.com (2603:1096:202:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.24 via Frontend Transport; Mon, 27 Jan 2020 09:44:33 +0000
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
Subject: [PATCH V2 0/5] soc: imx: increase build coverage for imx8 soc driver
Thread-Topic: [PATCH V2 0/5] soc: imx: increase build coverage for imx8 soc
 driver
Thread-Index: AQHV1PZk+mGdzzCjckexq+nG+OcySg==
Date:   Mon, 27 Jan 2020 09:44:38 +0000
Message-ID: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:202:2::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a46ed305-41a8-43c6-edfc-08d7a30d864a
x-ms-traffictypediagnostic: AM0PR04MB7108:|AM0PR04MB7108:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7108D8F9A91B2DA5CAD23F48880B0@AM0PR04MB7108.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(4744005)(69590400006)(4326008)(36756003)(6512007)(16526019)(26005)(186003)(6506007)(8676002)(81156014)(52116002)(54906003)(5660300002)(6486002)(81166006)(71200400001)(8936002)(110136005)(316002)(86362001)(7416002)(66446008)(64756008)(44832011)(66476007)(66556008)(66946007)(2906002)(956004)(2616005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7108;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OiBMllz2ahsOWPBrrjCxktaVG0FItfHCFR6OEvpKw/MfRcq+yGL/qDc6pR3xKO+RyEZ+BcOlP72TAqX2HxRpNQeTNbiaTJ5UV+CQ4m7wtpb0+Sf7X62a1vdp81qEEBZiWsB5mgu3jo4OjdQldc8XQtnfRZk9Ri3trzBdfCPLJg1XHMahfTzV2jZV2vkeegEjBtWn0XyPr3dquBsPhwR+RGYUZ4w7sfWNPa1K0TTVNE5vdsOaeYuIeAotz066WmjLEl3rDI7mapFldida40tgd+4pzOgTULtd0KuMzRfCGePU29zpS08ByZxbg+qj6Rj/goGhh0bLv3DoMUrpuuKyfyZ59QDVW9t4WbDP/eBH4Fz9Ghwm5w0uVDtCKxbdSxLPATzW3AXnhO3sxvVLNoDLj7JzLW4oqGiXiSG1IafW8ww7wklX4qad6XlzwJzsoB8O1A4eSXZ1PS4g4ZQfiHan5RbUfq+B06qjwpMpQBFEfPXJcTgJWUACMyn+n6+8sLbG
x-ms-exchange-antispam-messagedata: y8/BoRCKZbtrFq4eGiZqGsbIjRdkG/b7IDh1dyz5/eOgBv+iW9+Tor6ygOmtlECcacKx6M3xhqJYlteVlqtAytaL4E1rCOfJ4tovl1ZidXd8d0y5B+tvulvmBJ76RPZSe+xODT8gU4FyZHgI8XBw4Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46ed305-41a8-43c6-edfc-08d7a30d864a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 09:44:38.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jo82YoizbKADP+NUIlTA1ogarq6NcQ+5e3uUWDxdqhGfUQGx4uZDHr3x4KnqXzKTqB67t+QpIQPTlaqMuR/+cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>


V2:
 Include Leonard's patch to fix build break after enable compile test
 Add Leonard's R-b tag

Rename soc-imx8.c to soc-imx8m.c which is for i.MX8M family
Add SOC_IMX8M for build gate soc-imx8m.c
Increase build coverage for i.MX SoC driver

Leonard Crestez (1):
  soc: imx: gpcv2: include linux/sizes.h

Peng Fan (4):
  soc: imx: Kconfig: add SOC_IMX8M entry
  arm64: defconfig: Enable CONFIG_SOC_IMX8M by default
  soc: Makefile: increase build coverage for i.MX
  soc: imx: Use CONFIG_SOC_IMX8M as build gate

 arch/arm64/configs/defconfig                | 1 +
 drivers/soc/Makefile                        | 2 +-
 drivers/soc/imx/Kconfig                     | 8 ++++++++
 drivers/soc/imx/Makefile                    | 2 +-
 drivers/soc/imx/gpcv2.c                     | 1 +
 drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} | 0
 6 files changed, 12 insertions(+), 2 deletions(-)
 rename drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} (100%)

--=20
2.16.4

