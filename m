Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDCEC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBA222522
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LsE/+hge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgAPDtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:49:11 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:10409
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730397AbgAPDtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:49:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR3tzOdo/H7et/Dtx6A4HUYQudXOqVzx8+1MCdXP8Wa0TuygiWfbSFI72HC20kzw8Ez9rEPkpaUkAz+2oUS7bh+F1yVyBu9xt0F7v8ZKNq5BhvTOe9lQlKTtFuDAYWS8yCsCyraTHoOpuW+lAPmC+3HvIImNRgtsSa2eLQQFgT8T93cn/7YcmhUv4BC4MiDB8I9oBRSdQq5JFhUfjpHYChV3YaOJSlM6fLhVMnu11ddwS3bjihpWrPP9cokPoVJJ9CbMKfqLiMrXxx7ijrwspYhRDxnkh14fuS+sK5JwWRhQcjuhDPqKfhlRzCVTe7jOgLfHcUdIxfJ0rN9qxUQSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJs/SFlEk6+wC1rykKO6P2eIY3kjPaIaG4isboA26SQ=;
 b=nIO7R3aukbmHmPm7CPaiAhI6xIzKKNjG7hY/1Mruan/JkiDwhDlXy2+geiw6DRpmPxKORXIWEt6mWjgGX3SgYP1c480q9RK+a0zDyIGxbx8NSw3RwoGPlmGyryhZ2h88G65J8rUm94I5voAjLDMExKURBFopYhXjB2F9bNoNI1MkGkHepA3y8X5ZbDxxs7dkMRjU8mXCuLl9P0l3OqUBHaUsAiHxAV8NScdjP/mnOdlLS+HAA8cuOtBUvCw0MM/OK650nIex/Ida5N+SQUeygDY2NLFkcsk0PH+592AtaD7p0N+/897ZQYJiXFrqCPY8H5z/RM44pMK9xhNoOFgxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJs/SFlEk6+wC1rykKO6P2eIY3kjPaIaG4isboA26SQ=;
 b=LsE/+hgeasPjGURw/CkTFAIp/CvxMjs67SEuQFegsgN02eE2cItF5RtZJ4oIbHTlk+KTUscu2TOCEm8Xze4zTPC9f5Y+96NyY5NPOMLkO3RfUWbdFCKayEqopyeghlcn8jN/PDEVmgS0LTj1yOGpuxvsq3C4uqZoF+uLukc/AVA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4612.eurprd04.prod.outlook.com (52.135.146.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 03:49:06 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 03:49:06 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0002.apcprd06.prod.outlook.com (2603:1096:202:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 03:49:02 +0000
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
Subject: [PATCH 2/4] arm64: defconfig: Enable CONFIG_SOC_IMX8M by default
Thread-Topic: [PATCH 2/4] arm64: defconfig: Enable CONFIG_SOC_IMX8M by default
Thread-Index: AQHVzB/mVaFr+qyLLkmJN/EXOKD79g==
Date:   Thu, 16 Jan 2020 03:49:06 +0000
Message-ID: <1579146280-1750-3-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5dd2c160-da90-4727-2a51-08d79a370929
x-ms-traffictypediagnostic: AM0PR04MB4612:|AM0PR04MB4612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4612F3D192A773774094684088360@AM0PR04MB4612.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(478600001)(2616005)(66946007)(2906002)(956004)(110136005)(8676002)(81156014)(81166006)(8936002)(44832011)(4326008)(66556008)(7416002)(66446008)(64756008)(66476007)(54906003)(5660300002)(86362001)(71200400001)(69590400006)(6506007)(316002)(36756003)(26005)(186003)(16526019)(52116002)(6486002)(6512007)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4612;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: okAXo+qFEGjmzeit3Arv2k6tFayy/0PpoBIOE3mrfw6jzKumP73DRg+KTgWLB+QkmUwo4xNi7dXEgCvVPc6RMI6nyZX/mAXVK4AHUoCIRZ6mVoBIEsyexaJhBbXvj+E8QX0btiQi2iYG2iPXg30A+3y0CRovHyzkzcw8i4WZLz50Zzzj/OM7wK2Lnbe0flAkGl0Drpf4IUt/0+l0VPb18YcqzE51Wo7UX1YkWC7YPRXQ/jWhAPk6gro4Ijs74abBQDr0X0kI0leFbTsRd50tvZ9gjRT2dsMjwciqxTcV5CvBNFYhmvkgTBwgLL1+7JMCJ/DZxLVIlzDwsM9AL+zK2bieASY4vP01rYSeh2rOn6YvgvSO8E+HcdEQ1Chon+bdxNoaa7kn3bZ+sFihR0eBeY8vf5d6yhJ3uu4zXPLJ/djKUsh+f0gXAn6ERSCtMYKptytaLHMMSdYtL8LBkLconOVo48hOROyQoR54s6VlJhkCLecep5zpahFKiKHUwoTl
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd2c160-da90-4727-2a51-08d79a370929
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 03:49:06.8773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2i9bwUqvcvz782iYVOvmeh4dgw5D0Sa6Dt3/LF3mmRDYtD9v1EtrhtiCL4NDsyg85uyb3N+S+bUk5IkOMkafkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable CONFIG_SOC_IMX8M by default to build i.MX8M SoC drivers

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

