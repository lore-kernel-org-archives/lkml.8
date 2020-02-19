Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2406C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A191D24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="JksPxXvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBSNBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:01:01 -0500
Received: from mail-vi1eur05on2134.outbound.protection.outlook.com ([40.107.21.134]:38304
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbgBSNBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:01:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZCReinrj0F2OgtvZQbSuu7dT3slY9vIIGIjCHfyU//gxAaw/jsb8ti28PZGE56rf1UK88zCwB0WuX28ru2ArW3E10zRQakFeyJjcY+CFBV7slB0b9qRy/3KwwWrVp8zJ7fMbYgCrQlgWdSFNYXvKDtGIPybDCyiJnosnkgrz3LQklqUcyq3DuKrUO5ObKR0IpDsMxWDAtqFBFJF0bg6C65arH2nofigdEnZJBEDanyF+CexTdXj81tD4+LQine7IC+CI5hnP1xToWY3kMCToCZhxORKx2dB7BGZkVzkITy1HlfSfpvIBhi8UJVCyxweunTgFYV/a/RyTIvr+l94fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKYAJvxICZw5zHPktbvolEqhcRwoPwEIlStoWNgggP4=;
 b=fsb+SZP6VBMwllF/dwqZKqnoEjifLJmCN9L0cuH9pJR0KekdBEu0oCwRykdwI/zohC1d7uc38+bW2L+BNzqAEeWi70zna3cglGcKFemoPE1YtW4GgASwN+kasYhHiF2ee3OMYi174QJMaYvwYzVl/h3ceKZdw/4ESrs7oDUX5Do8zNsPRqh/PE2HbEUG+K/f1K5B1IWceGmaGLf9AS+JX06knxiluYpHcHVNz9xkOt/FOwSAibDCJlgggNDqpcnub2Y4hBBvsGH4TF7ARZkp3i9aXIVvgG48DKIBixNLRbbNSCUS9ohsGFR5OFCmRX1u9ZDfFwXAw7NdqN66aNEIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKYAJvxICZw5zHPktbvolEqhcRwoPwEIlStoWNgggP4=;
 b=JksPxXvLDWfHY43PH7Poc0fpOTdlLCEaS896Dtx9LTkwS2vqsGXKRRifM1wC2gYSUyPV52v//0Cbs79DnZl3m74hiqCuECjIwwSGzkbIPFTP2HBJiX9RGMMRNLlG8+Xr7SnbiqpogzGo5aYN3I0wQchqzRSiPwVFzOEscSbOdJ0=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB6495.eurprd05.prod.outlook.com (20.179.24.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 19 Feb 2020 13:00:53 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 13:00:53 +0000
Received: from localhost (194.105.145.90) by PR3P192CA0039.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:57::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Wed, 19 Feb 2020 13:00:52 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        =?iso-8859-1?Q?S=E9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: arm: fsl: add nxp based toradex
 colibri-imx7 bindings
Thread-Topic: [PATCH v2 2/3] dt-bindings: arm: fsl: add nxp based toradex
 colibri-imx7 bindings
Thread-Index: AQHV5ySdHzbR11NHgEey3HjegCAEBA==
Date:   Wed, 19 Feb 2020 13:00:52 +0000
Message-ID: <20200219130043.3563238-3-oleksandr.suvorov@toradex.com>
References: <20200219130043.3563238-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20200219130043.3563238-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR3P192CA0039.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:57::14) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83f43a9e-9962-4853-1820-08d7b53bc02b
x-ms-traffictypediagnostic: VI1PR05MB6495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6495038E6D302F21BB4482D8F9100@VI1PR05MB6495.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(16526019)(52116002)(26005)(71200400001)(8936002)(186003)(8676002)(81166006)(6496006)(81156014)(7416002)(44832011)(6916009)(6486002)(1076003)(4326008)(86362001)(956004)(5660300002)(64756008)(66446008)(66556008)(2906002)(478600001)(2616005)(316002)(66476007)(36756003)(66946007)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6495;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uE6/Rqil6PSYMdVRb2Q7wDcXFiaVMWNDLgOK4fdOjNVi8y3IRakb1mWqg5KR4FF3/RfGnQ9ZssU8b/W8vPI2WAJt+1Z4mV6jwr23qUcGBHhn3xtQww6CbQ+FIwBvrsG86s7qPuba9/0XG2WZ7taulknc5SXERtYd6xYcAfaML1IdVTdF+I7rOaN7/kmwcuSpfj0iCgbFhPKSHX+0zikfuz+qw5z1IRtv3lDcpmeqqd/7WK8JHJJ/Bc3/BFvR5gbpFoHmJU2fJethoqCXFlXUi6Qaw9ohr4/xmox5lLYg/yBkVAdgZmEJnR0w7t4UpKjuu7x+Yunl4lXcj0PLlfIJARgVP9AHdY4nGXRMVkzFnXunJ18oqKx2nhcHM0Fnaz9eyEV1xIlRSQ/vLxkv2iX4Rn44DuOlKiNghIJUGsW4gc9QmTl1T1+SGYMJyABfu9j2
x-ms-exchange-antispam-messagedata: Abxio4uPsieu83503GFa88KzYrDOnzE92c0BaZHiUIjXUsZFQAkphJ4obhigo/l2HWIAgxeP4PYGkR2w9//F7r3r+pHZjS/pfbu6DrqsmpSbE5LScv8req8rvC9TGrEfHqO1NqNMWEuZgUowwEOOJQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f43a9e-9962-4853-1820-08d7b53bc02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 13:00:52.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErQdQSbLE30ZebVqEFcGrxmFf6uCrtYcUKA8bXGdHxjQL/B2p1fmtBzYbDdtM9oECtOIuKVQMjHVEFnerYDCdl20FA2ZnuMk9jHO1suLc7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the NXP SoC based Toradex Colibri iMX7S/D module
and the Aster carrier board devicetree bindings.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation=
/devicetree/bindings/arm/fsl.yaml
index e654a6376bc4..239ac2c31f49 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -274,6 +274,7 @@ properties:
         items:
           - enum:
               - toradex,colibri-imx7s           # Colibri iMX7 Solo Module
+              - toradex,colibri-imx7s-aster     # Colibri iMX7 Solo Module=
 on Aster Carrier Board
               - toradex,colibri-imx7s-eval-v3   # Colibri iMX7 Solo Module=
 on Colibri Evaluation Board V3
               - tq,imx7s-mba7             # i.MX7S TQ MBa7 with TQMa7S SoM
           - const: fsl,imx7s
@@ -285,7 +286,9 @@ properties:
               - fsl,imx7d-sdb-reva        # i.MX7 SabreSD Rev-A Board
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
               - toradex,colibri-imx7d                   # Colibri iMX7 Dua=
l Module
+              - toradex,colibri-imx7d-aster             # Colibri iMX7 Dua=
l Module on Aster Carrier Board
               - toradex,colibri-imx7d-emmc              # Colibri iMX7 Dua=
l 1GB (eMMC) Module
+              - toradex,colibri-imx7d-emmc-aster        # Colibri iMX7 Dua=
l 1GB (eMMC) Module on Aster Carrier Board
               - toradex,colibri-imx7d-emmc-eval-v3      # Colibri iMX7 Dua=
l 1GB (eMMC) Module on Colibri Evaluation Board V3
               - toradex,colibri-imx7d-eval-v3           # Colibri iMX7 Dua=
l Module on Colibri Evaluation Board V3
               - tq,imx7d-mba7             # i.MX7D TQ MBa7 with TQMa7D SoM
--=20
2.24.1

