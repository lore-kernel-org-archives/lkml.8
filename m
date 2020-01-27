Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B114CC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CCC214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RvYoNunv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgA0Jo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:44:56 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:63168
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbgA0Jo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:44:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTphzVULhX7CsWLuxRfC1sZmdxZWSrWp/BdfyRUcJpC2wVANksG6CbrU7grfcuUynEgRLIZb83ov5A2R5Sg5kEbBVfU0l7DbWeBuVxd/4za94GzMA5j7QZCkdz0BdG+RYq7ydnhBKJsyfaJJJ0k5S+XaFDp8/IMU/arILArhHg1wDhPN6E9PEYrBaKxn/qCsylNubKWGn37NfrPZXW7RFYLt8TP893l4JuZtZyO/DE59d6qugOh9g2TZBd9saou+esa/wZaUkUqJJLW987cAXbB39b/ff1Qjv2AjPBv3zp8ZznH/3aEjLeGgnjR2xmVkTamm/oUNx6xM7gjn6w+QMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGkBReNHid2tbFpJ/KMkqQsGvktMf6lNDp4/59YfdGk=;
 b=etyURQYjwFPJQ8tmWccOpO7eIsR4m9Uo/CIRaPoDJubp8iRItSwIlt6NWaLZsRdvP9cVuUj9BeMUiDQeJb9DEr9wv9Mo7Ayn5fNpUa4oGfcKFuuYV/V4Q8m8ieHBsoNxFsXLavMWoBhOKTV4xqZkp4gaJEGwJKE4CM9oQpe3L8CkguQm57Pl+MxlrxATuQ7dtVFrr6y1CfRbLNbz7YwHKKojsYl1VM2aNpDUcouvqfWt3vuPKZewHulcAo2c90+7aFzfyMyEkkiPqyBejDhD6/job1gYhBZ9Cy9tWajoT14opZQFdrJYhEu2WcFSs+9jTm3qgahnz0i5jHjzYdqXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGkBReNHid2tbFpJ/KMkqQsGvktMf6lNDp4/59YfdGk=;
 b=RvYoNunvaJxAzZUeGWO/AhIzCJ5tTrw4WPh7kDXd40t6kkr5qXAm6DChaXoe1L+SyvrJj7rd6Sqy2/yeERjE2VmsKerlrhlbDiouS5r4bfBVgdvnnka2vSt30uiwrg5epXqZ1dmf0qAs/aNR7tV+Q+Tj067Wy6nZWF6MjsZuluY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6436.eurprd04.prod.outlook.com (20.179.252.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Mon, 27 Jan 2020 09:44:52 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 09:44:52 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0401CA0005.apcprd04.prod.outlook.com (2603:1096:202:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.24 via Frontend Transport; Mon, 27 Jan 2020 09:44:48 +0000
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
Subject: [PATCH V2 3/5] arm64: defconfig: Enable CONFIG_SOC_IMX8M by default
Thread-Topic: [PATCH V2 3/5] arm64: defconfig: Enable CONFIG_SOC_IMX8M by
 default
Thread-Index: AQHV1PZsY6qPi/hgBEO4sMIC3lyBfw==
Date:   Mon, 27 Jan 2020 09:44:52 +0000
Message-ID: <1580117979-4629-4-git-send-email-peng.fan@nxp.com>
References: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: ee01c4ac-18e4-4c6b-3919-08d7a30d8ee6
x-ms-traffictypediagnostic: AM0PR04MB6436:|AM0PR04MB6436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB64366B760992DA9E9F29C6C1880B0@AM0PR04MB6436.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(81166006)(81156014)(8676002)(6666004)(71200400001)(8936002)(2906002)(6512007)(4326008)(44832011)(7416002)(69590400006)(86362001)(36756003)(110136005)(54906003)(316002)(52116002)(4744005)(66446008)(5660300002)(478600001)(6506007)(64756008)(66476007)(66946007)(6486002)(2616005)(956004)(186003)(16526019)(26005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6436;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ciehdpc1wF9bX1o5PXrD+xDV6oN8vm23pRB3NJjlLoRbn7k1S8dFW3h67SIm9gl5ibRJbwoZXnTebCwBzJmZH8vR6Md3a3CnsQz4zpe2bQDCa5sZCEgYNPnSox0dPAEo5/xR7rMMQ7GAUy1qJvO3b5W/wvspSp3Q09zFvsMs1mCCvxKvnffBWzZE94MnMIQIH7Xuvozg4eVLM12NhjN8hrfp0i+8SAL1qXf+eG8FflIvjObVv40E/fvO+RgMvuf5R6JBLhL+Eu1QHhbppKE34jj2aN4z1mLfRQ55Honb1RNrh9l6AYVz7VHfYsrrAuuiBv64C5AIFWR3stQ9gZQ5C6iVcjvgrkqM0JUm4DMrmpdnc6hhFKQgfAkbPxGrZj4XkBlpn2Ie7nwbXfEzL1EUVLdAWZNvhmh/Wn/SsUCWZKDd0+mLuFCPVfyAMDBrQu6toqkNqc8AUQ31qurHNljaG0sAOsfVxP6uMqi98JBO6lg5xaQybb53AY3JxgO6W78R
x-ms-exchange-antispam-messagedata: PHTOigGO3SW8ajy/pcqXEmw9feyfoB/dIWSEYX/E5JgmOFZmhE6+gt+12XrRZQDIEIumU0I5wuCyAgvMd4hIO8qWlCzRdpbi9kJCyabthsYSmLZZPo18Hh0fBMecOVeIg5sUIv6Y/6bgRSiVRwhiOA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee01c4ac-18e4-4c6b-3919-08d7a30d8ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 09:44:52.7487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53zjiyRco0vXBrdUroUczo2iB7CGHcUlRCnWBGoDWPp4VOQhsGlCUXGeYUa+lk+PntAG7Tahnc6JWfAAwhYycw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable CONFIG_SOC_IMX8M by default to build i.MX8M SoC drivers

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d0ea0d0d3b16..20087f1aba56 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -729,6 +729,7 @@ CONFIG_RPMSG_QCOM_GLINK_SMEM=3Dm
 CONFIG_RPMSG_QCOM_SMD=3Dy
 CONFIG_RASPBERRYPI_POWER=3Dy
 CONFIG_IMX_SCU_SOC=3Dy
+CONFIG_SOC_IMX8M=3Dy
 CONFIG_QCOM_GENI_SE=3Dy
 CONFIG_QCOM_GLINK_SSR=3Dm
 CONFIG_QCOM_RPMH=3Dy
--=20
2.16.4

