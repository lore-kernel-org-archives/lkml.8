Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF2AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C1E22B43
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="X89LWE6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgG1IUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:20:03 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:27617
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727940AbgG1IUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:20:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG4HyMnvdV3xvmdu462KhSHATqEvDZRNChyBZsP8pxWnZ+Esx7weZMxo7fJ6ncOeSL6SHFcEpi8B+T90YQLTy1tfj/sOaHmEW9eZmCyhiSYNBBcOgo5fxisx15i1n7l8e5OnPT1bjsy9TLvXjW8yp+3L83hbD3l0bFI/bQz5y8zZEjdvinuqdvIIaS9Hv/k1cuHdxcd6cabVYmbuF74XYtKL/xbSVO7gWwlCNNVy9VmaDjDdewrL1eyzToca82kg0+snA3z9SXN3TAwu0C3wVrsJl0bgnzVLgrMpgiP5VRECL4fJ4cm3TF9tyLJK4Oqvghw8yT5o+txWRAAm5uzyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UakfVw6pCddkxw/QBPyieAVaWVxDgi8NGb45XP6g1sI=;
 b=JW78U+73rqS4qM3Bmw44u5HzKEwEKvaQdXRd02rH4j89diIhCUGStbOqoUNrzPOtOwInWDQlCmUKNx9zP269Kq6K9j8KwACJy8NWIa0QjBvM0sgVwH4XFabFZyAx6rgMf3mccv+8D6mhUdnKvG5WpmnS9qe4SCBxTdxbi9yo9WI8xSZfguVROx5RggHKwFQem3dWEzWg7UojjQ7Eo7mtaf6f2ZFs8pfayGXDIwEsVP+sPl9ht8Cw3ZAEcadZ6izHaH+pJ+LWrGyGKIotIgmagOe94qre8dySEPXLE5haeDc6lswa26ALXFkzGSFnb0zQS3/gJaG/29LtsZIg1atNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UakfVw6pCddkxw/QBPyieAVaWVxDgi8NGb45XP6g1sI=;
 b=X89LWE6BX8FWCbQ1+9rPygca4oQTECUBb8ICTUOjpRjePu0cFcvCA5jrXpmqIYOdpTBtcOACNhCukEpPHSE/GypraoZCq6kpZCvcGLGiBf6eIqLMHt8ore/aOF6Nr6KRbIqdojOBT/o8ZgcuT7EN9uNn2bGuJ8oIRZsjTXYS5xo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BY5PR03MB5143.namprd03.prod.outlook.com (2603:10b6:a03:1f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 08:19:59 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::b5cc:ca6b:3c25:a99c]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::b5cc:ca6b:3c25:a99c%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 08:19:59 +0000
Date:   Tue, 28 Jul 2020 16:19:42 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: regulator: Convert sy8824x to json-schema
Message-ID: <20200728161942.3e18e5bd@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:404:28::17) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0029.jpnprd01.prod.outlook.com (2603:1096:404:28::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24 via Frontend Transport; Tue, 28 Jul 2020 08:19:57 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d108cf26-a298-479c-8624-08d832cf04d0
X-MS-TrafficTypeDiagnostic: BY5PR03MB5143:
X-Microsoft-Antispam-PRVS: <BY5PR03MB51438D2CD1E5BBF2E4B973F3ED730@BY5PR03MB5143.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHrKSOP16vsfpQ56gWlPjIz9LOl4mWhuTwA9OTtbdQPQcNN6w2xBLbz4CjKpVVF2U2pkrtp5Yyjlc1w/aX9pbliuf2QkescRDzF6CERisRBP/LLac/F/X08EVUZxlvMmmxlL+7jj5YtTM4kIcff6ivPnTs7WeuKCDC92vRlY3Y5Zv8SoVMEep2IW35qdd+Pn9Y6mUlfqIt87vJZBcFEukK54kvk1GFGXSwJW9Z7IZQPnoJPO2vNJlKnFrrtpiC232GJZm1din+plQJ/YABn/9AQru3pBDbIaP8e2mMvC55yfmBr4xc8DW+xKaQx8n+zJ5xYzYBfVeKq6tgTgtMVJNen8iRhcQAN9eYXtcYLy8ef8/dlne7Ew3ktLbSXgOgGFd9UK+RUafOnMgbh/YMUlsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(366004)(376002)(39860400002)(136003)(4326008)(8676002)(26005)(83380400001)(186003)(66476007)(316002)(66946007)(66556008)(55016002)(478600001)(9686003)(1076003)(8936002)(6666004)(16526019)(110136005)(956004)(86362001)(966005)(52116002)(2906002)(6506007)(5660300002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aIm+bWsXpG4BjXQsyfdWRPwpz2/UmpgpV/x4WBPsTj9BdHfJ2/x+neRp/AkdzThcx5WD/FhSrDMzQsG53ErGYC0bxNdRU4e1DJ4hBy0xp1gG+mx0184BU03hs7E4kpSYAFToRmGH/kxlF7jC+P4NWy1QSIYN/GWsfqAdwrcfWxX2giuRzBs3czCSjzLICT+58zkI3cfwZXz2ZzZkYF8pAzSZjuztPkOOK2eQ0N0JgvD5b1DdYWc74ZHHWnMF2tWhVOypqeiLu+M4UztkIQETI0sbv3qwzJPDfCqf3l8yPJ31h1OgaEoUDRmH5u8uIV0K4QSoxaJ2WChZIjIasQw1VZQVDlH6bWbzTqMOPyFrO1mqtIVxt+u3/cTTMjTh8W43D1WbfsBnYscel87QlzENO+rzvV4gLTQ1ZJeB7DPDtT/4qg+vGEdVygxTMvJIKx7hzSxB8WKZ4LImy25oz3ADsfmykKNSiDESds/0Vn0rcUNe6JRkiwPXjkoARoK1Cshl
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d108cf26-a298-479c-8624-08d832cf04d0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3573.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 08:19:59.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc7cD8TK2P1z6281uOFTSHw6iwTI51i6FP24UKScoM+fgrDRNXwMtJ+BH3NRKSD8XANjrqGXWNcWWF+RPUR69A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sy8824x binding to DT schema format using json-schema.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../bindings/regulator/silergy,sy8824x.yaml   | 40 +++++++++++++++++++
 .../devicetree/bindings/regulator/sy8824x.txt | 24 -----------
 2 files changed, 40 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt

diff --git a/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml b/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
new file mode 100644
index 000000000000..62a476c94111
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/silergy,sy8824x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: silergy sy8824c,sy8824e,sy20276 and sy20278 PMIC
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - silergy,sy8824c
+      - silergy,sy8824e
+      - silergy,sy20276
+      - silergy,sy20278
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        regulator@60 {
+          compatible = "silergy,sy8824c";
+          regulator-min-microvolt = <800000>;
+          regulator-max-microvolt = <1150000>;
+          reg = <0x60>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/regulator/sy8824x.txt b/Documentation/devicetree/bindings/regulator/sy8824x.txt
deleted file mode 100644
index c5e95850c427..000000000000
--- a/Documentation/devicetree/bindings/regulator/sy8824x.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-SY8824C/SY8824E/SY20276 Voltage regulator
-
-Required properties:
-- compatible: Must be one of the following.
-	"silergy,sy8824c"
-	"silergy,sy8824e"
-	"silergy,sy20276"
-	"silergy,sy20278"
-- reg: I2C slave address
-
-Any property defined as part of the core regulator binding, defined in
-./regulator.txt, can also be used.
-
-Example:
-
-	vcore: regulator@00 {
-		compatible = "silergy,sy8824c";
-		reg = <0x66>;
-		regulator-name = "vcore";
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1150000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-- 
2.28.0.rc0

