Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F64BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25630206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="URGnyEZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGBJPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:15:39 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:14619
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbgGBJPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:15:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAFJMdCFCXnnWY9YtPX04tiq0hfJxQ2wtrnez935U5OOyXof/6FrjvcdwDkk7s3K2CrLzvDKQtjcEtLs7XR7NUnEZ/U3zdcK9AxnRY33OFQKJkFPiKuUOXjC4wEoPWxh3VFMVj1BShnzlIXOS3+xd3YwGuldQmRvcoIJ4SfvGHDviK1D3XPVE2oCSQ2aL4hpTLQJ0sX9DpazHpsoWi3SClg6YsbNND5+oC0DO9lvLOep+RwgLH/9tIlo884Dtdk94Qf3h9w9omrmKx08cX0cYRWb4rQ8E3sULf2Jk09rmnsq1f6GiGeDdAGT1bT9z08SVeTo2wgvUvTsm3g/LkRaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV89JFu9rUPiJGobhvq4B5ArQDzjFsQmakH2OqRbPxA=;
 b=hhR/kDV7Q3tkHXnxngwF9B+DyWNEp9rg+saT7mk5PJERFyWm+KNnZgSLWsE3MVHAt0BQliQeH967QCqkumgVOo5X+tFXB8vAwFckeKIHmEjCh9owQInqN8dd7VfVTnG2Koo/eX9vJfeP3FW8Yc7u+V8pi1Fnf4nGusFacNLNsc7L5qsCwuwoU2N+c876uKgvENkhYj7gVKuZa5DuZcr49C4PWBUy+oymWVcAwHVYPp0wX+u6RlojT2nagbaKM4gNMrrY4+2StOLmDsBV7gQff8HXkThg6N+5rgCkO1qUcEJUr1i2Pb7txfw6qW/voLR64D3VC3sI7dlmezS5Cuq9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV89JFu9rUPiJGobhvq4B5ArQDzjFsQmakH2OqRbPxA=;
 b=URGnyEZHFHdPfIkgr7k3Pl2uYsU2mHixDnXB9cw66AEZFZmTSHpEFQdANCuWaL4yMgxOxNgDyk0IpwHRsSTg2lMSbCOxcH1v9FA77qZseRas2Nxtz1vFkesbPWWgznbyuallcw0+utEvGlzaOgn6OVO542d2MW6T6VLlfQi7g50=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3574.namprd03.prod.outlook.com (2603:10b6:a02:aa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Thu, 2 Jul
 2020 09:15:34 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 09:15:34 +0000
Date:   Thu, 2 Jul 2020 17:13:35 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: regulator: add document bindings for
 sy8827n
Message-ID: <20200702171335.59f5e79b@xhacker.debian>
In-Reply-To: <20200702171304.68928e88@xhacker.debian>
References: <20200702171304.68928e88@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0144.apcprd02.prod.outlook.com
 (2603:1096:202:16::28) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by HK2PR02CA0144.apcprd02.prod.outlook.com (2603:1096:202:16::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 09:15:32 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 352ae42d-c7e5-4066-2cf6-08d81e6879d9
X-MS-TrafficTypeDiagnostic: BYAPR03MB3574:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3574B1164B0641852C7CF987ED6D0@BYAPR03MB3574.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFyvO+n7p3innBrHw1KfXNR++ytTtp/IzNBuxlcTqir+rUu0fgamblZWatmZZQ5pRlv3lpjmKpN4UVuWteu2xfPZFzLHKpCMLa/x2bBm2DKv19PYxG9H/ji8grzk6i7W+49GxvRs3/mWTaQ8J/66alwhLme3Ji6odhmMtxo3NKtJoi/V1BXlNi6JzCjA8U5k8asqBqUOVKHmkfQi+t3BVUSYYZuv5jTMhIsXZUalOe1b2RqdV5Tp8KzYqAJgR2t6Pp7zWQTcmxfq6NkCu52+DPchZIKHRMDBeD5Q7a4M3wkhjr5dcezYllPayYKzi3Ifr3AsjaX/JnmHiXNIXwsgXMibucwNRu8pg8SUGV3465xw13sXLMBI4xDgkuweWjPJzfUoR7G/HKmr6NB0bEMWwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(396003)(39850400004)(346002)(136003)(956004)(478600001)(2906002)(66476007)(66556008)(66946007)(8676002)(8936002)(9686003)(4326008)(55016002)(16526019)(26005)(966005)(186003)(316002)(110136005)(86362001)(7696005)(1076003)(52116002)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4QoJM+xHtgkRpW/n8wfBARu+owos3C8IkMStJkRiBFOAN7yuUreGChTbGdbbqr9idz7v1iWzZdg8psJw0z3sCJ/LSBWsYwmQbPOaJLjJADX4M/yhpkRzD64Kva9nM8ofHZozGiwRP5bMmFhk61kt/mXDe283cZ3P6/l96SC1sdxMAP2OwDdchk7aooFv+9AlfEZorvrD8mlazFs5CehntjYDe2aYnprZK3UrtCnHX8KDfEuNiw1S6hg1vEpzg99t1PfID/kox3qtZ6EcSlDx8Bq0BtssVgcM0lIkhwYZnvOoU4R9MoXN+U/WRSOOM5qYRO8IbQzAuBFlOngk5UHtfUC+s05jdvof9gmmmjmtJTtp31h1jzkZ/6xDp1p9lVmHlIGYbaK8Ftewib/86tQj+aO+2yTTLMOiedx5xNnDxUwdbjG/vPjgDM8LISMXTDQZOw26NqCHVJnuMaTRKsmQgpjlKoJoDzmJ48h1+C2Y1EYYq+cs2rFn5W2djb1xJxAD
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352ae42d-c7e5-4066-2cf6-08d81e6879d9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3573.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:15:34.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3ox3VFBkTz1mTC1LYK5z5vzAYlqPlt/wG21GSzJ6yG0wJRf74cxxYVeeDbRJ4+hy4f60mY+pQwMhSoxMdFBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for sy8827n regulator driver.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../bindings/regulator/silergy,sy8827n.yaml   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy8827n.yaml

diff --git a/Documentation/devicetree/bindings/regulator/silergy,sy8827n.yaml b/Documentation/devicetree/bindings/regulator/silergy,sy8827n.yaml
new file mode 100644
index 000000000000..15983cdc7c28
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/silergy,sy8827n.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/silergy,sy8827n.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: silergy sy8827n PMIC
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - silergy,sy8827n
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO to enable/disable the regulator.
+    maxItems: 1
+
+  silergy,vsel-state-high:
+    type: boolean
+    description:
+      Indicates if the VSEL pin is set to high.
+      If this property is missing, assume the VSEL pin is set to low.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        regulator@60 {
+          compatible = "silergy,sy8827n";
+          reg = <0x60>;
+        };
+    };
+
+...
-- 
2.27.0

