Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E48EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A6A222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="li+XwGsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgBFPY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:24:26 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:15398
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727557AbgBFPYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ19ejM3rnfnUUIqYueTb1GNXEgvTlUK5YGGZ28apWZW4zwMvWj5mQYap/y4ID4xWBvuXfrRw4NsVx3py2g7Slt4IbpcdGnfKIer8tBQZS3VQTmGqqRjCXNA4nPDmPyWVBm/IAf2EOfXZrydRa8UbEyMyRIFMZwGp8RDcJBKxD+6ekAn5Uz8LxB8xeOlsu8LJDg5jrThlFafw0wQTa078qVJjo7Alo04OJU/k3ytkWn+yxk9AZVUzpzY7xJ8+Doh4DhmQYD5YM7Pdgo7XrDsm3yl5Qhnl3gqVN2eMLLH7ZPgmn3LJvE7moCxRSxrXbKGF4oJjjDxETlQF79Ho/2AbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIMFvvMFtYO6T0EUoaJ/htAD7+yP4O1vKO4FAMiYnC4=;
 b=bybJJVaKZ5qQJ1yrjuLXrOyV8iPn9zXRlYxKagWnRw89FBEldoWJ0PPPtEstBlJpnOlYkO7lqx11EjcXU3mZABxsEGHO4uvvbC7wYu08L5REWpdPtTINDtFwWEH5XgaEcpptqVjRCq9S5d/HjfhqmOBBwgh4V7Azcuj0yAigRp3d/Y/lbCabQORbRQ6HCvusY1I9yiKdTC6EjxUaw3LduQH9hWTx0lR9FX2QJdCm8aUSLhOMX8/rtb/F0HrEEhcIXeZB29jE297fPK+fd3bY7tWEgx58Lu9z3Fx46Bw6qq5prHdbY/ScbEV3emqqQfbFynUVftVc5i6rsYUgB534JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIMFvvMFtYO6T0EUoaJ/htAD7+yP4O1vKO4FAMiYnC4=;
 b=li+XwGsrWtmyvKKHuSDPGpHYOzAyxQ9e3AitrGSAytlCQF1nvOX5XK+eaIf0A8M6mRSBFRv+DTA85qhB9z1rdmEG4TmcCwnJYvYByDhV9NZlvdxFIqm8A/oPAN8ypTNXV0GtdpTUufU8hg2KigOSfujJ6sPCcLPRf3b7m/5hBuM=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB1847.eurprd09.prod.outlook.com (10.171.76.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 15:24:08 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7%7]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 15:24:08 +0000
Received: from localhost (193.47.161.132) by GV0P278CA0035.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 15:24:07 +0000
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
Subject: [PATCH 2/5] arm64: dts: imx8qm: added System MMU
Thread-Topic: [PATCH 2/5] arm64: dts: imx8qm: added System MMU
Thread-Index: AQHV3QF5hUkxAjhWT0Goj1otwWD+bQ==
Date:   Thu, 6 Feb 2020 15:24:08 +0000
Message-ID: <20200206152222.31095-3-oliver.graute@kococonnector.com>
References: <20200206152222.31095-1-oliver.graute@kococonnector.com>
In-Reply-To: <20200206152222.31095-1-oliver.graute@kococonnector.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: GV0P278CA0035.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::22) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df47cfef-fcfa-4f06-23d3-08d7ab189be0
x-ms-traffictypediagnostic: DB6PR0902MB1847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0902MB1847888746D6002D25C3E972EB1D0@DB6PR0902MB1847.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(346002)(376002)(136003)(366004)(199004)(189003)(508600001)(4326008)(64756008)(186003)(5660300002)(2906002)(6486002)(66446008)(6916009)(81166006)(81156014)(44832011)(16526019)(956004)(2616005)(26005)(66556008)(4744005)(66946007)(66476007)(54906003)(7416002)(6496006)(8676002)(52116002)(86362001)(36756003)(8936002)(71200400001)(1076003)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB1847;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PFNbnYwEWy1pXLBjRgM+V+/91voQR1nQeE7Q+buZFe0UeQSZhLtcmuBUncf3ZdkyuTi/6DWdlLmZaE6FluXcWlL5tRuZxm44LeiLVtuonrTCKNwFgSy1Mjj7VgDPYV+ZEyE+ZZW2sUPRwBSSDZSngI7ewMUTXZHjgR+DsQq/JrxFyY3bT72eQuiZavDuyUGzgVGWebkC6SIcnV0GFLIhH1TgUY1B2s5TJdOgP4y3+rhspTj/s9TN0rGSIMab0/98XgorXPajdxyUHLhTPYnlqIi9c7AXx9vL6mcXh2szmEvhGAwQisXVwG+WaxffrYyKY6AE9JcszaFCJ/7ZaPbOKWP3VOjIlairn2EuEzZcx29kDLptrYVfzX1I8tEIrp+/HZmT3IH6twQmbxTo0JyL41BVdHmLFwyHnbFtpcpLgfV888KELrBbVAxmuMoOzTvCaweieSht0Q0pNbvTN3v7yeiKcFbm9LooZqrKgcYdVf/2jIw/YmTFf7K+x/ycUXXb
x-ms-exchange-antispam-messagedata: Uxg+SI59ZyXk9G3hCfYkZwcQ+Jyev8//ZJOXSZdi3zdWW+3C3Bbz1ZLAHc3Cv+tuIUQP7wOA6LTcsMJekxbl914rDjlnMeAjYe9fOIsyxb28ZkadeOdj1qLPSXaKmUFumK840dEF4weVpGJkxOuLKA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df47cfef-fcfa-4f06-23d3-08d7ab189be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:24:08.0436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDFc6sdLoHImwUVJ80yV3QfFzFwaD32Vlb2xvw6/83ct5jcMfE5sW8c1WPs0Nednb1WDXKYAK3wvRUYE41yKSZW2gGJYPtZJ7GgZ1TXjFBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB1847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8qm.dtsi
index 7efc0add74ea..fa827ed04e09 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -140,6 +140,23 @@
 		method =3D "smc";
 	};
=20
+	smmu: iommu@51400000 {
+		compatible =3D "arm,mmu-500";
+		interrupt-parent =3D <&gic>;
+		reg =3D <0 0x51400000 0 0x40000>;
+		#global-interrupts =3D <1>;
+		#iommu-cells =3D <2>;
+		interrupts =3D <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
+			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>;
+	};
+
 	timer {
 		compatible =3D "arm,armv8-timer";
 		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
--=20
2.17.1

