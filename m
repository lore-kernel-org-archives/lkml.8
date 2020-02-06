Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5DEC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54112465D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="KFowUmOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgBFPYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:24:51 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:15398
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727742AbgBFPYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N62Z4B/X04Kne4ksxkeY0ib6j6gEQFrqQgGUJ0kOD3Gz7cjOu4gW7teka6hf3q6yqbtag7c0mlg5rD5DmwTTLhA5b5ejGDbxezOZUwSIWoiK/5NbH44HbVlTpAo7Ms/xMH/ijG1IqXkO7R+M9LYbd+w7WQcCfjE3OI/SZJoq55inHFbr93gwM1Fa7fC6b5CYzi+6B6MvwSN/+QfQViltXEg9iJ1zXqlOgePuy+XHZalNySjmAmrJda9bWj9ZBiHEFgC6+T6Dm7LP4jWx5Y5ALJLgFgvg3ZGN++T6Zb+W7mYHhIzM22Kb/PTEsz7KNSjKeWR39+qi7/Z3+v5HLT1+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CfIDiG3f2lVvkBVgFK8fZrQMXDhES4e9XzYn8SJWfE=;
 b=chzj/eTH0qwH7l/m0OUD+LQiFeuPxzZw0bH5V0ZBHUaCxceKxd+llsYtPqMG91kpoKjwGCLZ/zJCItBNCBTOcaf+wmKi518WhkReBj7aSv7Tt40SY77U6rgSTvu48c7WiaznwpNq15DCC838FJywLvlbCBDY5PueTMdsPbUS24kGmRx9CW/Eur5SVT+G3AkFeTFrCUAGgCXa7oNkqTUEgXLSYWH+pdVSdx1MIGCOjbOVSLESswlHJSWTjXlLZuXkk2LeCyjlVSKyKhgmBf3G88608ef3O+5c4ptu3IKc+J2UltFVaEWpWXkZBtZmUklRadchfh432tyz+EIl0+E/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CfIDiG3f2lVvkBVgFK8fZrQMXDhES4e9XzYn8SJWfE=;
 b=KFowUmOP2UILuTiCA/ZzeQ4rGo16+P6J8vFzrpRuWSu3kr0qvp0tu6yo7CCIT1VRi2uW1uO4xnop7Yk4RGGlZ+7ri6E7pBsiJ5k2RY/aWN099+GhvlJTA0fq6BISf8s04F+5YJbcfJrU1rXPRv27ay2YEaWdRmRs/CHdIiiY4zY=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB1847.eurprd09.prod.outlook.com (10.171.76.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 15:24:11 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7%7]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 15:24:11 +0000
Received: from localhost (193.47.161.132) by GV0P278CA0033.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 15:24:10 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>
CC:     "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] arm64: dts: imx8qm: added pinctrl for pciea
Thread-Topic: [PATCH 4/5] arm64: dts: imx8qm: added pinctrl for pciea
Thread-Index: AQHV3QF7o6P+rjW/+0adfVkW6hcFWw==
Date:   Thu, 6 Feb 2020 15:24:11 +0000
Message-ID: <20200206152222.31095-5-oliver.graute@kococonnector.com>
References: <20200206152222.31095-1-oliver.graute@kococonnector.com>
In-Reply-To: <20200206152222.31095-1-oliver.graute@kococonnector.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: GV0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::20) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6769e0c8-fff8-4aac-1416-08d7ab189dac
x-ms-traffictypediagnostic: DB6PR0902MB1847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0902MB1847D678C139893EE5DE86F9EB1D0@DB6PR0902MB1847.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(346002)(376002)(136003)(366004)(199004)(189003)(508600001)(4326008)(64756008)(186003)(5660300002)(2906002)(6486002)(66446008)(6916009)(81166006)(81156014)(44832011)(16526019)(956004)(2616005)(26005)(66556008)(4744005)(66946007)(66476007)(54906003)(7416002)(6496006)(8676002)(52116002)(86362001)(36756003)(8936002)(71200400001)(1076003)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB1847;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: keXvlmhOvPYxwID81i8++8LcJkTtb2c+TFv/PJ23meg4lBPrKsFdcw5LPr42nEB+4tVTA/2I6b44L5uFStQB+Oq1xnk7eZEP34b1ebiDhIF/wWLsJ4mmV+qfmxFAQN6+JKSE2Vh1jGdJ4jsborwE9FlHHH/Qq+ZtK4niVPNiw8I54kAm+xLnKtW+HDLNl2vyJjOLdzdMdx/1M9Bs5PZ5yE+AShnim7aneWcdFj3SOJ6lyykkX71jYfxIc6wznPoEDEeP9Y+BDkFDGHhd7nMyyf2MDGSCIvgiq2aEF2ArHVlg4JKgtuPgYTBDe2TFq+dojBK0WYyNMvozA/1zwDKFeeYOvZQX/5k5CnWV+t/oJgp00lSr8s0grWq0XjyQ7yJMPL2mRkbrxD5jxJgFlHyTnAOx/qVeMeVn9zu1VQjqImPcdB5RSPRdlerCg/PzA9i9w95Og7/VjkfrZi6pjtCztTtGyHx9exQCrGogQJcl5KsX5WnCzxkCN2k55ErPDPlf
x-ms-exchange-antispam-messagedata: F+9qr+rhNflahVW4scQVkIlauYIx9b4VRlaDjgiH0M6Yw46LdHTahQunTR8E5YiIBe1JE07nyoVFG1t+tNFDD1D3lfKlDVRoqpbn2o+1vHpz5sEmG5X0IJ+WA7DPjruLbspaFcxf5EuerYc77YBuEg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6769e0c8-fff8-4aac-1416-08d7ab189dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:24:11.0428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mb2m5L85cQRWxwsPpk0ESqmClHFs6PHSEMLNRQeEY/3Ubg+0voHk4noZju5HKCfm9OtuQs/4E8m+iihULHa3jF49j9vTKZgRACDbZsVhQ70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB1847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts b/arch/arm=
64/boot/dts/freescale/imx8qm-rom7720-a1.dts
index 331eec2dff01..466f8c5c3705 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts
@@ -174,6 +174,14 @@
 		>;
 	};
=20
+	pinctrl_pciea: pcieagrp{
+		fsl,pins =3D <
+			IMX8QM_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO27	0x06000021
+			IMX8QM_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO28	0x04000021
+			IMX8QM_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO29	0x06000021
+		>;
+	};
+
 	pinctrl_rtc_epson_rx8900: rtc_epson_rx8900_grp {
 		fsl,pins =3D <
 			IMX8QM_SIM0_POWER_EN_DMA_I2C3_SDA	0xc600004c
--=20
2.17.1

