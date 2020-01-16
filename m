Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A34C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C2C2081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VBfaiAUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgAPGMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:12:17 -0500
Received: from mail-vi1eur05on2049.outbound.protection.outlook.com ([40.107.21.49]:9056
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728899AbgAPGMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:12:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcxusYsRAN1PDo/+TuoOXFueOLDQW7jmnC787cramEudJ2qt3HhOdD01eDPorKIudWZYCMXkBMCq2ArAdAiLwyXUkjposdJJ7IACU2cSCWvOQa/FqXWwESrS1MPt9ZtXU9WhtiYSlkHwkz4W159GG4KjDjyTIb2wBk/AH4/9FvesyYppvKVVi4VKcXD0C2kQl/Zr5YRL3hjDTgVO4XMovzVyqfFZfY3yulpTupnJCG3j9FGdYTNJ718rwFlCD/dMwAwAYF64VuCGvygSJn5WCC+RgoOwsRY0hba5QJ/G5V1wIrZ3vTlJoiyowqJ7ha6Yp2tzREr7giRU1WPjHB0c7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZlp0hn5anwYHIFLGRSoB3cLtm5DuSiKODBoQcHQi3k=;
 b=LC7IrrEBNhO2UgUGsH23+o6wheKflkgrWHfNOwqRsosvYeKB+8jUvQDqQFNM+gXW43Xj4Zcuq5B3kjGnZyXdbOAmS22coT8pTA9Skbgyik17hbveBV/3XIxGoM9yf5roQiSxr7On1CpsGW2+RH8Ual6pzbEm8ez1Nu1gexg5LfvHSfZjzpWZ/El9CO1hbimhB2nuK2vap5ClJDe39ZygQcBcMvSe2KYaZWEsN/DUPSK91Nep/pYy0m6IESJYbSfQHz74JzTSlouSo5k/Nwdu3luulp0fHjSoHkhzc/vlVSr9cwaiRbdp1WoH1oDmLVTqaFp4AJi1uC7TbE6kRFyEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZlp0hn5anwYHIFLGRSoB3cLtm5DuSiKODBoQcHQi3k=;
 b=VBfaiAUgH9czQ7LI+8ZLfdvIguHNTz9h2XD3wsTtePtoV6LB4svO52DDDU3vzeYTuCuD+QzuU0PGdNezzvLK/OuZtNjqKlERQyvZzz/RqTlWjNSfLgoi7Gh7FCXZiQXv7DoYbGR6hafrgNIBGX1DZJJBR8kaaQml1VVdR13CQcU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5108.eurprd04.prod.outlook.com (20.176.214.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 06:12:13 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 06:12:13 +0000
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0117.apcprd03.prod.outlook.com (2603:1096:203:b0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 06:12:08 +0000
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
Subject: [PATCH] dt-bindings: soc: imx: add binding doc for aips bus
Thread-Topic: [PATCH] dt-bindings: soc: imx: add binding doc for aips bus
Thread-Index: AQHVzDPkXhRChugwfUOXOWtxuk1SeA==
Date:   Thu, 16 Jan 2020 06:12:12 +0000
Message-ID: <1579154877-13210-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:203:b0::33) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b13c75f0-d8fc-4049-72a9-08d79a4b0702
x-ms-traffictypediagnostic: AM0PR04MB5108:|AM0PR04MB5108:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB51085722F26664CFB4C9BDEA88360@AM0PR04MB5108.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(66556008)(8936002)(71200400001)(86362001)(81166006)(2906002)(81156014)(8676002)(36756003)(44832011)(5660300002)(66476007)(186003)(26005)(66946007)(66446008)(478600001)(64756008)(16526019)(69590400006)(316002)(54906003)(6506007)(6486002)(6512007)(2616005)(6666004)(966005)(956004)(110136005)(4326008)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5108;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhZIswzk02VpnWTg7hvuDaE6xUGNl6wTJAwdM3hntt+pKy43TgKEaUnI/Io4DxZ2q8p2HxSB8V36LEIk0uOS4EUKVmNfakwMVRq3/5y/tNv3/mTI/ZEbg8+2ZlRjHFfk+878asTkIC+RZNHrpgj1Sq7DuGjsEQTszDawfZpyiXNuxvLfVVSD9TvroCbF323tGFv46JxviKFxbFFMTNLOpeH29Qui2EyVE424NL7zQ1gJlJSc1JrkugFSSfk1EC1E2x2SoDvtTjRgf4DPqaGMKOYoPBXkklXsg/+2+Xz7fcfRE7m5aD1PeSZozUnyworx930/jL+ftH9S6PeIoaOWpoXVO3jhU7HV6QcV5kRC8DetlYK8nGZSK8islS+i4NPETRDrMS37JXkYk1qKp6uWROEMEPpovngL/7e0KbRQJNk7M3+Nez0Ms9JPkijdE5+qjZrP2CgJqLbTVSPzGbRMe+pG9mSYaTAF/jyL/K/GDjS1H+DUdpgzqeSsQCKsAkk29XPobyeHthnN2N3zRkoHW45VQTT2CP+QmtaI4VlYSdc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13c75f0-d8fc-4049-72a9-08d79a4b0702
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 06:12:13.0038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4kTMtZ0p4IKcpsgXWJyntYdMeU3tkCO1COaollfvejAQuJe2h1qKZwtg+UUp/mIzFWYML4PKhCU4VitsC04cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add binding doc for fsl,aips-bus

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/soc/imx/fsl,aips-bus.yaml  | 38 ++++++++++++++++++=
++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.=
yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml b/=
Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml
new file mode 100644
index 000000000000..73ce1b7fc306
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml
@@ -0,0 +1,38 @@
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
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,aips-bus
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

