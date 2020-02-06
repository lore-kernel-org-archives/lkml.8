Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3BEC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3312622314
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="V5+NcWDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBFPYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:24:23 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:15398
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727505AbgBFPYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g373pJHc8GpAB0iecqf4mnsYS9q7ntaUiQsz1Th3tLE9mTOJj2B8UQqsLxWZYw+STgq0vaVraDhA4hBLTA+bIL58CZT6Ts3Zf661rXi5ZMlERBKJe3jiPxzH7fWFGLCChh9BCO/9qDnbQnIrQ83FNHA1Xv0zFsWIYvee4WH1Vbs/JWXkG61inZJx1g0xF5aPdGAcf1XRM6et2AZfkqIEBTALDCIPSelcNc0SFiRQ0f+IW3zCDKC3U2trlVa1TNu6hWt0101c/TO/kBGLXipDSs7e4N/TOnMNdvTfJTFL1k7TE/GUXLCc2h77zW/XswYxSyGsrcaYvzJVrDoo0gPeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHbTS/Cj5dXSnqAU1g1UiSK63sJIv+b7AgFYor3Dnxw=;
 b=g2z7r/4uXgRc6kDSo0AToiqO5xodzMCoH81MkjPlhgT8QceXtXai/Ep0KwzkpffK2d41XIDrkY+fHwd4LoyyXGz9hKtjFf09YeDy0a8pOIwEWmGLsBoF7b7sF7gP0e2nBgzYK8rb7x+jwI7LQGCyfplFpnZL//WBMqH4SN8Zwb8Z5VjHOOwRZYxyAIqito2pvj9cSDjS+OtC+cDvtbOhTaJv88DZ9c5FRsZgHjdklirKtxq+2EaH/UJlFs5XKwSN0D0CR6GCKhGirvdHcbpQyhwYMPoXTETL9BmWgCIzaph4uDXD5dpsRKmnQm6ObbaeA7vgdTPLpSozwtdlgyi3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHbTS/Cj5dXSnqAU1g1UiSK63sJIv+b7AgFYor3Dnxw=;
 b=V5+NcWDLjlibv4GAYFbhXlYAoS7AtBOnApSLTQH8PwuOjWQ2mbDGzQXOVS+UFhkF/STKjKc1KEfgy/nnSZgdRc8Ka+O+JNsJ2ttIWPU7F40UTSoMPK1esFaJqNXPNhyWo7lbT1SSHgxMwjplpdZA24N+AqyVc/8X1QJxWytktGk=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB1847.eurprd09.prod.outlook.com (10.171.76.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 15:24:05 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7%7]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 15:24:05 +0000
Received: from localhost (193.47.161.132) by GV0P278CA0030.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 15:24:05 +0000
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
Subject: [PATCH 1/5] arm64: dts: imx8qm: Add HSIO Subsystem node
Thread-Topic: [PATCH 1/5] arm64: dts: imx8qm: Add HSIO Subsystem node
Thread-Index: AQHV3QF42MnWrrcWVUadUtYBmD3lxQ==
Date:   Thu, 6 Feb 2020 15:24:05 +0000
Message-ID: <20200206152222.31095-2-oliver.graute@kococonnector.com>
References: <20200206152222.31095-1-oliver.graute@kococonnector.com>
In-Reply-To: <20200206152222.31095-1-oliver.graute@kococonnector.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: GV0P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::17) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8a7d717-9f79-422d-4a86-08d7ab189a7b
x-ms-traffictypediagnostic: DB6PR0902MB1847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0902MB1847959BA1EB316538BE0134EB1D0@DB6PR0902MB1847.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(346002)(376002)(136003)(366004)(199004)(189003)(508600001)(4326008)(64756008)(186003)(5660300002)(2906002)(6486002)(66446008)(6916009)(81166006)(81156014)(44832011)(16526019)(956004)(2616005)(26005)(66556008)(4744005)(66946007)(66476007)(54906003)(7416002)(6496006)(8676002)(52116002)(86362001)(36756003)(8936002)(71200400001)(1076003)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB1847;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJr3Wxs9ylCzWO6CQZu73YQ8Z41VEs1hOdm56Qqb68kLeF6gdgmy2bRF2XrCX/KAzi9tZIEqdIVnFJje0D/siRVW2N/+WAKShhDSGZmEJKLizOAJ22KjtSkUTOGBf5WWboUHOsc7rkvQ7j937ltcRwmyLh8r9Z4T/pFtjzb2WvevcJazLmtOcJmlf6XkMvuNszG6AWrCMuxf9A4FhMBcPdYqp7gnubso4ys8fLThTYVXdC3umZDK1dieQK1/CJ5VcGF7Hpiwvb0KLA+1R3jXVip6b9xlaeNFHkD9Ngq+hPcGHLA6g2VV/GVDj44xTrkPmHtpqECabwuBDdm/UYRcntM4sbMXZmXHx2paY3Xax8I+QSqZcoajucqKtktqNebdfaTQSfu3EpUSuqbPizHAir6xRTILLMz2MHzcikHdCITHrzfyah1b/+K5sNDSGRKrSh8kZDthH889KvnUQBC0whSz1CZoAk4V6Uz9Fl/u5sQSibkNI6BIRd/pJWwExXu0
x-ms-exchange-antispam-messagedata: dN0gDG+W4UP15wX7lAHJWa5YtE4F5OqKZPpwClJlGspFErzFxY+NOojctbHFMLTbiyeHMYZe3GDbu6iF8FqPmCnB3Qhb50F7E390aHibfK79sWLMxi4OqKjS97dhViJzCba70UA9YYvQXUEdT+098Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a7d717-9f79-422d-4a86-08d7ab189a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:24:05.6859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vfMJX+jSV5DDTPrZ6xJTysMSPtc1K6sAZSkM0WjqZW96L+EVMisIkSj2s4q7OOQgisMhSTpeHOn6xtSS23iwjaEAEJulPFqTX05r8FiauU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB1847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8qm.dtsi
index 097eca99c6ff..7efc0add74ea 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -125,6 +125,11 @@
 		interrupt-parent =3D <&gic>;
 	};
=20
+	hsio: hsio@5f080000 {
+		compatible =3D "fsl,imx8qm-hsio", "syscon";
+		reg =3D <0x0 0x5f080000 0x0 0xF0000>; /* lpcg, csr, msic, gpio */
+	};
+
 	pmu {
 		compatible =3D "arm,armv8-pmuv3";
 		interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
--=20
2.17.1

