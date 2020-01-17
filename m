Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C488C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DEE2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iK/BYypu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgAQGKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 01:10:10 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:13453
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbgAQGKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 01:10:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9YZ7SeaL4IxwnHjXnBo8bomj/DR8BdPrNf25e97mGkfBeFwSDlflCHChjMjdmfjR+bW48Db8DazU49HX1Py9ywhAfpXAzwfVpcyJvrMvXB+Dnc6pVDKCLH3KFYgizxBub27gCUEj9V6P3+myiDoVCqquqDWX0eF9Sb+ls7MIjnasBtITAESJwzKb/bGmHkxnD7XRAAb5faxWUJXprZ1Gk0WaXe0IQnuHdav89RuJ3eZG6p4I2sipT8MN0wrFYXz8KgT6Tuhh4JDL2PSAsv3nH8+47HLCGTkOsIdm/LArAuuKB9zCcp5SmbMd1m42eE82W8AZh+LjA/Jp4bI6tYNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLRB06ggZXV3N0THnwaLutwxurMVJ4C9ZnZsx13BUJg=;
 b=j5tPiy8nlqVFCVVxuo8tUAnygw5PSmAHnvzSUzVpSm4F8MkY/mInW4450RI//O/LdaP4wOsqzBRPr2RW6y1ldT3ioiSA/8PD0uUGwSYQ+OpqP6BmDKpPmgW1B8h3wzs4oHXnSgZfTy2/T4fvf+5dU3e8MMbmMiA03x8lUpkn6Lus5qTTHepNS8FHHDLr2UFoDmduG4fI/j6kPL6d3FQD1ZJ7gDboL4tIFob5Pch/BocHt1VO5zngAjUk9ep0xP9eO31UOODj+jJKDTdmiKoEZDp4/Vy8UIzOrkBFTJIe8sn8+jaYU3FTtk93Vtsm1OjJR6R/Y1eSE6/Lt4qHQfhlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLRB06ggZXV3N0THnwaLutwxurMVJ4C9ZnZsx13BUJg=;
 b=iK/BYypu3qe6RXpwYDUfVVRcbMlbBpGSb/U3I+wbroRCtyk4P3fps+Xapaj84Xov5mIj2ZzoPcjVOGaW3xiLtFw4hy0t9nYcJaKcTrm+GybBbAUq13/s0+D/X8k8Na4D2xqqtjzvsnusfPiVwF8jXIKBDJcfg+1YPjcOxRReGlA=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4841.eurprd04.prod.outlook.com (20.176.232.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 06:10:05 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 06:10:05 +0000
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0102.apcprd01.prod.exchangelabs.com (2603:1096:3:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 06:10:01 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: [PATCH V6 1/2] dt-bindings/irq: add binding for NXP INTMUX interrupt
 multiplexer
Thread-Topic: [PATCH V6 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
Thread-Index: AQHVzPzD99CH/S91r02y83rc7QJYcQ==
Date:   Fri, 17 Jan 2020 06:10:05 +0000
Message-ID: <20200117060653.27485-2-qiangqing.zhang@nxp.com>
References: <20200117060653.27485-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20200117060653.27485-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR01CA0102.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::28) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:38::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5158b9fa-c515-4f2b-5bff-08d79b13e561
x-ms-traffictypediagnostic: DB7PR04MB4841:|DB7PR04MB4841:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB48418F949A6B900C80A61CF5E6310@DB7PR04MB4841.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(199004)(189003)(1076003)(5660300002)(66446008)(6506007)(8676002)(478600001)(81156014)(81166006)(6512007)(966005)(16526019)(186003)(2906002)(36756003)(86362001)(26005)(316002)(110136005)(54906003)(8936002)(6486002)(66946007)(71200400001)(64756008)(4326008)(7416002)(66556008)(66476007)(69590400006)(2616005)(956004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4841;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MQr5bEwFkc4B7Jjzy8ZfJukHnNfAXjrVwn045KGphG5/THkJG+ietC/RPL5JT2sjzWtbqCJcfsZGoXeDhVE5hbjBmSvEckt/m5p+TqooFk8rIV6qEDTsRfVcqNoJxpQhUScEBqCgPeTI6QFlorzhPsAPfP505OBl91I6Q10AtMx/ZNT/GtyymuKWF4nac7Q3X85x4AtKK9xYMlLmzxi2x6ylwQj5DTmpJZpLdFiRJpQLn58CewhtB/r7GskyYZgRE5DLP8EhQ6v+RXZa3iPnMizp7O6bhN5fFEdGZ3YSkKmnTPCaVvk8t4Qo1yTL4wfTz42d5N5SsERHTSgSki2IZ9N0XeTHCWlkQtt+cH0u5SXF6gmGr83ZxzhzsBk8EK1l5BuD+a49dQwjSav70c8YbOc0vAgS2ziwkzjsaucAdPYt7n5+nZM7k4DWLlGaV9caz5Z0rvjc3Dmj4eSlcXUsCbpxvdSccJjHfakfnOgWZWX1DEoVMacLy+IH1KJAaq/MqRUbpa4Nx07ofORQ3mKmhFFpPm5pYXeoefJBAeIyXFA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5158b9fa-c515-4f2b-5bff-08d79b13e561
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 06:10:05.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XijxD+fG8PinChnXsRuaFdWCQEphYiaPvPzIgAQXBBLFb6khj++zP21BwGB0+uH+wNw1F2X2GrB5isWAAu8eDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4841
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
for i.MX8 family SoCs.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../interrupt-controller/fsl,intmux.yaml      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
fsl,intmux.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,int=
mux.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmu=
x.yaml
new file mode 100644
index 000000000000..43c6effbb5bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yam=
l
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,intmux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale INTMUX interrupt multiplexer
+
+maintainers:
+  - Joakim Zhang <qiangqing.zhang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx-intmux
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+    description: |
+      Should contain the parent interrupt lines (up to 8) used to multiple=
x
+      the input interrupts.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description: |
+      The 1st cell is hw interrupt number, the 2nd cell is channel index.
+
+  clocks:
+    description: ipg clock.
+
+  clock-names:
+    const: ipg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@37400000 {
+        compatible =3D "fsl,imx-intmux";
+        reg =3D <0x37400000 0x1000>;
+        interrupts =3D <0 16 4>,
+                     <0 17 4>,
+                     <0 18 4>,
+                     <0 19 4>,
+                     <0 20 4>,
+                     <0 21 4>,
+                     <0 22 4>,
+                     <0 23 4>;
+        interrupt-controller;
+        interrupt-parent =3D <&gic>;
+        #interrupt-cells =3D <2>;
+        clocks =3D <&clk>;
+        clock-names =3D "ipg";
+    };
--=20
2.17.1

