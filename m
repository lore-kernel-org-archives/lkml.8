Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9969BC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5AE24682
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="HRMOGWg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBFPYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:24:38 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:15398
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727789AbgBFPYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hah9DnP8RjwkVkSEoptK7nomknl+4ojinj1uLq6LSBTz8w81XFFp408zbHPOTfQOC3RCCNiia25Q9x7gSHPWqJoeHvaKn5Q1xoXH4A/BtSNJ6101rrb2NMwQcO+lT1TNP7ME2ugqidVYN3DmueOsNwH5vg+sWwGQkayGCkiOKTUdO220P+EXc8vS5pQPANMLWxBI7fIzHdF7eZ2KoVN/uhJuPbtitHqKrfww6PO1wl+AemMVgG2MtGnF2RXy2pM0g4OOrD2rEcRinMW35dm/nrQvh866hFU98uA6DUe/iwBfKokBmS0GU5qekdW6g6to3fYhpWYP20jCnoJivEpT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxacbAxE9SCR9kD2aT4z0F5/qBgG16/j/quan9SZXec=;
 b=YNpYq8+zNlylLKnLS6ljQPx1ZBOcz3ig2byTXNpLsjMiE6jLRrmaTh1RRZ3lAcLcZAiXfGe2b67zpQEizjb5f6PB130ot7nGRlswKJhuFTP2Z4fQhdLbjoqLw97rq6xprSD/bDwlY1s8smDgT0r6qUQNGnGIunU3gEvKpWLvRCPraH1cB+F0YRD4GKWedvCSw20gg/83qaVLgUQ3NKashODO/dVzg/LHWYTlyW5OuosaE1i6mBiq/ttXNAz+R0VTnhXZP3UlFqI+niqekKXs9j9tYDAtX4GDtOHSRFSq52+odF3vH9JtN9vp5i/eq9O0StVd1DG2YqPAuAPNno6Eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxacbAxE9SCR9kD2aT4z0F5/qBgG16/j/quan9SZXec=;
 b=HRMOGWg3fgNZFe+JRay4RDVIocd8apTobLplDMYb/AZPibZKAeP4I218EhLEMs6cmzcz3fsDYTCIwjnn4Ymw56GjycuYfxqMIsOPoOz7peWHup0E/IIzB+zN3Vfgp4W3r0sVX2D+iEK7AOzD+pxRvJ26B3FwC25TUZu+A9ZyNkI=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB1847.eurprd09.prod.outlook.com (10.171.76.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 15:24:12 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7%7]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 15:24:12 +0000
Received: from localhost (193.47.161.132) by GV0P278CA0019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 15:24:12 +0000
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
Subject: [PATCH 5/5] arm64: dts: imx8qm-rom7720: added sata node
Thread-Topic: [PATCH 5/5] arm64: dts: imx8qm-rom7720: added sata node
Thread-Index: AQHV3QF86XfMAKsLvk6dsr17oKebTA==
Date:   Thu, 6 Feb 2020 15:24:12 +0000
Message-ID: <20200206152222.31095-6-oliver.graute@kococonnector.com>
References: <20200206152222.31095-1-oliver.graute@kococonnector.com>
In-Reply-To: <20200206152222.31095-1-oliver.graute@kococonnector.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: GV0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::6) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b38e2ad5-46ea-46c1-4716-08d7ab189eac
x-ms-traffictypediagnostic: DB6PR0902MB1847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0902MB18476329D4520A69F0DC8EC9EB1D0@DB6PR0902MB1847.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(346002)(376002)(136003)(366004)(199004)(189003)(508600001)(4326008)(64756008)(186003)(5660300002)(2906002)(6486002)(66446008)(6916009)(81166006)(81156014)(44832011)(16526019)(956004)(2616005)(26005)(66556008)(4744005)(66946007)(66476007)(54906003)(7416002)(6496006)(8676002)(52116002)(86362001)(36756003)(8936002)(71200400001)(1076003)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB1847;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3nu3eNTwz9peRC0dyfH7rgbU3SgxEMIGtYmTJ8YXPnohVNmMJi5wEoKQ79m1dEB3yCUk8TCUiNZK3feWbGgHIsJz8ebPIIFTREHvvc9mQK96PJ4pI2yzpcFscmAi/biRrwIBjMzACv4MR9X4ok0meTg74GeVm202iw9T95pYYuQThq2bH/xDdcqpUdQ5UX1GqVoDcCosn5O+P7ab/6dnWNN/02MuZ7lktl2eH1EBn17633VDTXdjm7gGWBHAmT88mel2S84863oBpTq6CRRR1CD8XOv0rzgYF151ZVA2PjeURg4HJn3lFHlGxhDo/NXZr/LHZ8cWNWGj7faPkL9u/OQQuqnhYFAU/yAkR/77LXe0KsA0KhI/YMUiC0/j5Z6Cqnrs5HXJLdRlUEGr4SLWRCW+7ZsiU/k9lqBU2PWKbSSA68wm0eVaCwTokMB7Y+Y6NolIVuB8XvFRTEBP0hBo7ybB89ayDdlg0WpCsnWqfaX6+mzwdM3r3VVs0Tez1gM
x-ms-exchange-antispam-messagedata: lt8W/VObuAOAxnM9csWNQu8N8Ua0/Ao5h04Xxr75QAuhKSOP6OE0o5BOy4g6o+ggY5MZBY3dFETeYDRyeygk+bmDyd7jvxs4n/SjxCOy/i2UggP/sGiW5AlA06TEmOrxIisRXoIBBcE9oRc7k3V/ag==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38e2ad5-46ea-46c1-4716-08d7ab189eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:24:12.7259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggkWW8OWt1n9xsKxTFQfHJ5f+2kl6mgay+pg6YUorGyRECwMoqRILUarLzbIjXTs4wNyFnU4R3g0qvLrkuroxkiUEnpD5qKvGjLreO9Kc8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB1847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts b/arch/arm=
64/boot/dts/freescale/imx8qm-rom7720-a1.dts
index 466f8c5c3705..8edfc8302357 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts
@@ -106,6 +106,12 @@
 	};
 };
=20
+&sata {
+	pinctrl-0 =3D <&pinctrl_pciea>;
+	clkreq-gpio =3D <&lsio_gpio4 27 GPIO_ACTIVE_LOW>;
+	status =3D "okay";
+};
+
 &usdhc1 {
 	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 =3D <&pinctrl_usdhc1>;
--=20
2.17.1

