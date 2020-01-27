Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D50C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 03:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA3E214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 03:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DBGWuN0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgA0D6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 22:58:42 -0500
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:32586
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbgA0D6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 22:58:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDetR2aBvqvZotziqMPYSgd8tcm+yUFbCGiXgCz1QeX36B821E09akeL6rRIMHlgCnV4GZ+KGDdcCru3RaXK1FITTdmlqxjSyD9bGim5Ip5eLoZq12geSoxn+ylYMrmw8+XtrrFXH17YBySvRm6lw4H02byiCtF7Qtl9tD2kbMH8WtHgWpIYdSZTsIapzRhY3YjAiezxXORu4/iSN3W8e0HJ6IBb99uGgFvjdvT/kmqpDql3upqGtyyZuDT6yRYWcDAB6H1VDR52jIG9jJz3AQS5w7M5ENywjxCGEYpfIA1AHoC8DbOh3/oRNxRekDWcusF05lXqHsbVgbwDnKyCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6srGNlTOr1MGrDea/RMImTjWkNd4HAnJevtwK8GqS8=;
 b=MO9u5E0uFMVn6C8IfT/P4wABHVMhb+scKz3E+LZgliJdoEO19y3+DDwG57NcmnKi7OCDmTFyt620/T/gXtxP5kmL6zvRB1PpZgvINp1qHulzZ3A2zR9AUhlj/5+JjBmvktEC3lAsbp+z/fNRuOh+0e7YMRjEZsNxSSh35za0F6SeTKt3t4zXpDFqhn99EWExVkk2LAI74M+P7pLpBQIkiDZBhid+IzsDVfInU7EGS8stg1bjhynRklwnID+ZJithNO2brsShbLqBRzP+wWW/8pyOUK1UKAtgmA9IQ3UGubNfB/zJEWJCpt3oRTzy5tCcCembmrAuNEc3XlIdNm8geQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6srGNlTOr1MGrDea/RMImTjWkNd4HAnJevtwK8GqS8=;
 b=DBGWuN0kNZJKHbbv21p5MG3k8jbF7jN+rda/c9P4YrK4olduTG1JDMzkMh+iJFsYBHhIYPNCSPvW8cM6gH+e+ODl94HSuqKNZvUaKEs7JgEOLWA39PlvY12rMbfFirmLFs2oUsIyr4/YUi7cl4vQBiasi0Ga0L/igDFkZIooIsM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4260.eurprd04.prod.outlook.com (52.134.124.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Mon, 27 Jan 2020 03:58:37 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 03:58:37 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0401CA0009.apcprd04.prod.outlook.com (2603:1096:202:2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.20 via Frontend Transport; Mon, 27 Jan 2020 03:58:34 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] dt-bindings: soc: imx: add binding doc for aips bus
Thread-Topic: [PATCH V2] dt-bindings: soc: imx: add binding doc for aips bus
Thread-Index: AQHV1MYNqsV5ejfpvUOhCfy0vYYg4g==
Date:   Mon, 27 Jan 2020 03:58:37 +0000
Message-ID: <1580097227-4364-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40618552-b452-4767-721a-08d7a2dd3010
x-ms-traffictypediagnostic: AM0PR04MB4260:|AM0PR04MB4260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB42606D66FF2519DEBEDDCA0B880B0@AM0PR04MB4260.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(52116002)(8936002)(478600001)(36756003)(8676002)(81156014)(81166006)(4326008)(2616005)(66446008)(6486002)(5660300002)(956004)(16526019)(44832011)(26005)(186003)(66946007)(66556008)(66476007)(64756008)(71200400001)(110136005)(54906003)(6506007)(69590400006)(316002)(86362001)(6512007)(966005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4260;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6UsbYdyYUq4PIAk5i5lRPwaoqIUIk985DpeUXxSTtwKKSB8v2ubZIajtvOVoiet9iTV9neRt29xAUr335Dfr5PEXchlvGbqmZ0JEJ05pEsVOhteu12zeiKx0eapFCZR/YVcg4nEEVPiKKkGN8DZ9mcOosh2vxqd+st1xC9m8Sf7MMBjhxbxhonvMDM6a7NTYSXCwvqVBMNaUQJKe2SH+Fd6za4T38UsgtY5mw7RMbbbzaGYqjw/B0FgJkjlxh0CJBGHCjNZ585UcbQdlfaLHX405uBY3H8Ptyz4f1b4lwR5gP2QwQWkP6AGdmo8WpeGarpt8r70IZBKn95OHr1PvXh6KU/edjxFnA0vjiH6gxMrneXvjQ5n7Ukdom3Xt/eyr7mQnGfU8Pv2fTEPuYEj5a77cFiDFoq+If29MJC822emKZi3FBd1cluX55TE/CCBXCU/4+j29pgfUe8yXj8NDEvVj97UPXWN8aC54j4M6pA/aqwgFvqkM52PwioQpOi305mMy/jiIACTsjCAxtUkb4l/i+L63Pk7SmZKBl1qxx5A=
x-ms-exchange-antispam-messagedata: wvy8GiAx4iK75dMM8w83YfjDgpOdDdoOmI9FxIr5klbDQuGhfJ2BsnxHhL2zZE6vcJnHu6Tmb0MvKwR8xnsiVzxoi0bT3CS9VnYU7T7kDg3NaReuj0c7mu11u+YBsfj0cBcM0OSbYBwX2bkEFkzBJg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40618552-b452-4767-721a-08d7a2dd3010
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 03:58:37.5842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FmgMrwC24gRON7EBcZWXLhwSMOxmk/GY3z6f/SaFUaXLfgf1TahS5XXLDKc8z0LpssZsyDjcxGS3AncKggvkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add binding doc for fsl,aips-bus

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Add 'select' to pass dt_binding_check

 .../devicetree/bindings/soc/imx/fsl,aips-bus.yaml  | 47 ++++++++++++++++++=
++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.=
yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml b/=
Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml
new file mode 100644
index 000000000000..3cbf2d28a188
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,aips-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX AHB to IP Bridge
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  This particular peripheral is designed as the bridge between
+  AHB bus and peripherals with the lower bandwidth IP Slave (IPS)
+  buses.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: fsl,aips-bus
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: fsl,aips-bus
+      - const: simple-bus
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    bus@30000000 {
+      compatible =3D "fsl,aips-bus", "simple-bus";
+      reg =3D <0x30000000 0x400000>;
+      #address-cells =3D <1>;
+      #size-cells =3D <1>;
+      ranges;
+    };
+...
--=20
2.16.4

