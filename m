Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B85C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F1A222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="kwHFPJh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgBFPYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:24:34 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:15398
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727505AbgBFPYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5li6/WwksEhWpqWuRoavSTtFhiK8LR1iGLCfbcE7WlMaTwvIC9O52UOqBfsiGXm7abtfTZld7UmqeHmkuK/I57UmL21Mie2s7iQZk+QZlmvdBndbxGaR5ZLrlNf7MPcAF9aOLE+izOR7KRX/TIN4Jp1Zvj50t9SE6gOQW22P7+b0MCAmWSUDGjVLAZDZEEr6Qrh8gKZYSP/L2XGAiMbCPdDd7vKjYhzzA3lvdk43/tuR2jro9DA+4F3WdYLlpZU73a+yx81O9HkyHkHE9eWUS1H1/XiN6pTKKeZ4TT0ZlINDyDhOMv7Pu7CKFlnIYM3bZqD37kNSvrnklGQDxiDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toZDouw/ofV3eZGQ1rB/FHy1riorfgb0UqXJmUf6LhA=;
 b=TJ1NjjaR2odUb8bPSxf6dyvIpBTKpCVmxJtJWNuZ9JGbrcUFbJbNiHtx/7FyAxrw0OJqKFzF2Nxo4VTDzfmk514cZgtiovivj7I9mLixKHiVSjcjNOKDUcHjZJ+Hm2iEnypLze3sR7ibc9iCxLBOz6gjPpnQiME+gUvGYrW6QugQmcPSkplHzuCJSIYB8Uu0e5vrYvejtKPBSrYoAcvG0kHccwvck9FvqEWN87Ih/pyrvfKDq2Z2cvmHNznFl4M2zH+We5NF8rUr6jfRoIU49x6osC5jmHfH3XkBxg1OCia/AZk9RKBUsLKYcMPuLUIQZt8GIDXwRx5a3FyAlBp/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toZDouw/ofV3eZGQ1rB/FHy1riorfgb0UqXJmUf6LhA=;
 b=kwHFPJh9cpcXN/tj6GqkA4fYohrFt0c70y5mzkmilVxHk296YQqbGiEhqq2BJJrYmpJP21peF53cxvwE8ZSebzoORtDNNdIOP6ZBCzCaQcEIfPb2WaIrRqhYKJqas01k6Em8+jGuGipJvw/lK5LERJr3ypm69JrO6EQHdpbH8QM=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB1847.eurprd09.prod.outlook.com (10.171.76.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 15:24:09 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7%7]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 15:24:09 +0000
Received: from localhost (193.47.161.132) by GV0P278CA0034.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 15:24:09 +0000
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
Subject: [PATCH 3/5] arm64: dts: imx8qm: added sata node
Thread-Topic: [PATCH 3/5] arm64: dts: imx8qm: added sata node
Thread-Index: AQHV3QF6DWUgMDjwi0S3VULcsUehEQ==
Date:   Thu, 6 Feb 2020 15:24:09 +0000
Message-ID: <20200206152222.31095-4-oliver.graute@kococonnector.com>
References: <20200206152222.31095-1-oliver.graute@kococonnector.com>
In-Reply-To: <20200206152222.31095-1-oliver.graute@kococonnector.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: GV0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::21) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e77b47a4-5b1e-4cdf-2d42-08d7ab189cc7
x-ms-traffictypediagnostic: DB6PR0902MB1847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0902MB1847D31AAC7E1977ABE743F1EB1D0@DB6PR0902MB1847.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(346002)(376002)(136003)(366004)(199004)(189003)(508600001)(4326008)(64756008)(186003)(5660300002)(2906002)(6486002)(66446008)(6916009)(81166006)(81156014)(44832011)(16526019)(956004)(2616005)(26005)(66556008)(66946007)(66476007)(54906003)(7416002)(6496006)(8676002)(52116002)(86362001)(36756003)(8936002)(71200400001)(1076003)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB1847;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Np/PsX60n0JhU895OcLcw52xUUYSVtZ17/NUTyRM5MQuxJ2gKgRVZP43fbMNxIJJ/3kSmMpHzm0qPkrqEQ1D81LkTiB6PCbvyJ3HcF+1DSiDuNo7SbBrrYHlajdoNu8gKoKNlqCNr5Mfk/jXNpMyT9JGzKJ7kGQKvUX0qiIYVGL+rn7o0mr5Hg0bai8IRiDAR3ryslDVFK4Prk2JXPqI2TfWb1O2XvlKLmIq/pahTfODluo4W/CehYjsMCSyptH4oCKsD/1LiyCNIcR7NFeGuLt9ZR8MA4QCdV5GWX+zt71UPykiHgS9/xaW5Aiy0yEfxrU8g8hDjz36NYXWEVFGlCoQRTMTSfztWUlT2sUvc+PKoNkMHT8Kg6YL7ZeEx+teuSqx7URF9j217VoPIsE2HfwRD4Yp8wzF2XtPP0IetaFV63wBd7MbYnQqCcJ+2m8X5lB8FOD1HNl4dIyUrsZZyZVrlh/s8PEuO0PXvc+LEB8=
x-ms-exchange-antispam-messagedata: 7eq2JA12m677xrIHsdXpytwSZtDeUIvgtIeA7FKlVxd6JG14RE82WZdIzQ2IcDLWYDmRkJgnUiHQon93d8tOacxie8E3CtPy79uiNz0/aa7EDX2N329QMqTWmy4h6EnE8TUKVsZuGzzzBxyM2aJhuA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77b47a4-5b1e-4cdf-2d42-08d7ab189cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:24:09.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2od5b4DMLr0ssHOK2tqNSQOH7bA/bNTEvE3YH0YSPsX06Qs/e6wqOXIqvssDzzeRoqcC7jnN3bqVj4jlCNMaS7xStcIbpWS7iypN595iLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB1847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8qm.dtsi
index fa827ed04e09..5d96be5fec1b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -140,6 +140,29 @@
 		method =3D "smc";
 	};
=20
+	sata: sata@5f020000 {
+		compatible =3D "fsl,imx8qm-ahci";
+		reg =3D <0x0 0x5f020000 0x0 0x10000>, /* Controller reg */
+			<0x0 0x5f1a0000 0x0 0x10000>; /* PHY reg */
+		reg-names =3D "ctl", "phy";
+		interrupts =3D <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+/*
+		clocks =3D <&clk IMX8QM_HSIO_SATA_CLK>,
+			 <&clk IMX8QM_HSIO_PHY_X1_PCLK>,
+			 <&clk IMX8QM_HSIO_SATA_EPCS_TX_CLK>,
+			 <&clk IMX8QM_HSIO_SATA_EPCS_RX_CLK>,
+			 <&clk IMX8QM_HSIO_PHY_X2_PCLK_0>,
+			 <&clk IMX8QM_HSIO_PHY_X2_PCLK_1>,
+			 <&clk IMX8QM_HSIO_PHY_X1_APB_CLK>;
+		clock-names =3D "sata", "sata_ref", "epcs_tx", "epcs_rx",
+				"phy_pclk0", "phy_pclk1", "phy_apbclk";
+*/
+		hsio =3D <&hsio>;
+		//power-domains =3D <&pd_sata0>;
+		iommus =3D <&smmu 0x13 0x7f80>;
+		status =3D "disabled";
+	};
+
 	smmu: iommu@51400000 {
 		compatible =3D "arm,mmu-500";
 		interrupt-parent =3D <&gic>;
--=20
2.17.1

