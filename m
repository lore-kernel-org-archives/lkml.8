Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061E8C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C875E2465A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="itfMACFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgAPDtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:49:15 -0500
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:6021
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730397AbgAPDtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:49:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSgmwupDvItAKaP613Dy0VJAdCtvIwRsK8R/crGYrTLyh4fjwjTTbQ+3d6nfe8XtaECS6hjU8se0gOINOrDeotD0pFM1wJBKe/nFWSO2cVlU2q65W+6wRwN90bepNDckjpkG3e4oNMqBpjDianyGcnnHn2s8Y797Uf5AvoQPRBGPNYd8c3pc/04Qjd4mf3x4H4F8EYlsICRIkQjY3gy1LQxMXhf5iZQMfSTX/xaCThjbua0hMmw22nwEcwZsBqaxHKMBuJAv+qaee0CMAUb92Ho28rj9dyMHIFwdA7WsJjcZ+frrwkpOfmGaaV7Ll76cKwxHBXNJv8xksMmjwy03aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtLxNjbNua+BrSyzWX2vn61RyddrlF0zqLeJiRxv8Pk=;
 b=SErH4WYsoUfMJIwFi4OsOVjjx55EFRyLec8Acc5eBPvWT8wDXHdwOzEahBzFSBBbE2NlOWeznbRwBHrbE4M4jv86xFzJBwzMUAdATouDo8Rvg2ChnOxgSokKqcJGYM8R3DZa3yeF2rzuVgwe7y1crpGyffwJFbZfTkW72Hby0/WsOFhMxZ2/iWX6IlFBc5mVsOe3lWSL2omMWAjStRQ/WQUHhQU4VO2YjP7hRH/JJncrvxfttlIDJXYI/BYvTm+BCBwBTHYZ2VMHpjvNMtR31Wjc73ZVa0/uNdGE7Jt0bkCFsD0BM10+yVPHHtSLCWQ5kLmeTN4fbZv5zKSyUklp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtLxNjbNua+BrSyzWX2vn61RyddrlF0zqLeJiRxv8Pk=;
 b=itfMACFeo2VnqwhDxFZy9J47uhm4Ry8rOpeqQM5LXlk+8NU6uWpl9dTkYFb9u7ARMlQ/9fyMoD4bKmx5QfyjI8nA+OWNYIQ+IgkAiF/a4+HNPzQ41K6xg21p8dS5j/i+kWkUq+Yrh5AAEg22mIoKMsWQIIg+rYWCMtZnsvoLEP4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4612.eurprd04.prod.outlook.com (52.135.146.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 03:49:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 03:49:11 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0002.apcprd06.prod.outlook.com (2603:1096:202:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 03:49:07 +0000
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
Subject: [PATCH 3/4] soc: Makefile: increase build coverage for i.MX
Thread-Topic: [PATCH 3/4] soc: Makefile: increase build coverage for i.MX
Thread-Index: AQHVzB/poPK7Lim6ckO4Mi4LQExmIw==
Date:   Thu, 16 Jan 2020 03:49:11 +0000
Message-ID: <1579146280-1750-4-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 625a6a4f-99c6-452b-da0c-08d79a370c26
x-ms-traffictypediagnostic: AM0PR04MB4612:|AM0PR04MB4612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4612F75BA2B9221762686C0888360@AM0PR04MB4612.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(478600001)(2616005)(66946007)(2906002)(956004)(110136005)(8676002)(81156014)(81166006)(8936002)(44832011)(4326008)(66556008)(7416002)(66446008)(64756008)(66476007)(54906003)(5660300002)(6666004)(86362001)(71200400001)(69590400006)(6506007)(316002)(36756003)(26005)(186003)(16526019)(52116002)(6486002)(6512007)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4612;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MIHft7g6m9XEXarQ23g0c8i4cP1AURcskBI1Lb8yl1c77pDZJYwjK0Xi4TkWrLP4dRlYVbJJwj2vdX+Hy0iF0FWlu4wp58KEmSdTyMSRgUwHObymookab3oQK+bph3+aFPpWIV6FnxMIZpQA4MDdo4y1tfdO4v/NmHrH+TwTEGMbitEyeuBnMigFC9L7It+FopdTA5pr9I+MiHbraAKJw8WkNhatQuKKu805NjKOZL4kKqrw1bFFOPW4M01LDbS+i1t1J5J/zMnbFmX0herDIk1XalOKtH7bkOC7S78Jlx9lQbhzu3QokjBi7Re0wSjqaH6xv8IkEvrWdYlUQ2UyJTINaju85cc+1G7AUX+KTEtXbIuh8kKVhOK6XhMdYifopjD7BFcggqszKssdXtRZywfnYAwI5yWzzgOxzWDhV9nbuqecTczDPb/5TbX41qti2BkFlmtlfSmA43nbYacLep8nkysipEo7mECPYFm6eWAmROtsIZC/GEADwoKYd6d/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625a6a4f-99c6-452b-da0c-08d79a370c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 03:49:11.7473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFvLZ1fwl2fjTf9ibLJRlMCUAxJRfIouKJykW8WPG1X7ZGoopBuTp3CEIs6c4TivYtaHT05jOLkuGGwT9rIpzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Increase build coverage for i.MX SoC drivers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 2ec355003524..614986cd1713 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_ARCH_DOVE)		+=3D dove/
 obj-$(CONFIG_MACH_DOVE)		+=3D dove/
 obj-y				+=3D fsl/
 obj-$(CONFIG_ARCH_GEMINI)	+=3D gemini/
-obj-$(CONFIG_ARCH_MXC)		+=3D imx/
+obj-y				+=3D imx/
 obj-$(CONFIG_ARCH_IXP4XX)	+=3D ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+=3D lantiq/
 obj-y				+=3D mediatek/
--=20
2.16.4

