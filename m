Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD78C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9753D20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="gSJtPsuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgH0HH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:07:28 -0400
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com ([40.107.94.64]:53216
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726123AbgH0HH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPwJqkBDDPm2VvyUOrvjODJangcocOc1bVAfM5q7u4lMdsiId+DUKyqr3+iBPIcbFzlORKAOmrJLi1fWUDR2Gi+YqucjVWlQvtd9mjKRtS5xOpjYv7gFXuG+FxZwSaTEUvBKxA14JNE/yAp1i9nISNNzPFvJpijy/yL8PVvVc2MlkcD71Wm0ok8J7tnFMMG/oSRwJ2Vb7fTOUUYrIfOpXqFRUiyoytmF2DLDl6fRDsHTqnBX7niod6UH093Sex9OIm3n+8tdI4MeBI3cWa6cQhodxOJQy97/OsP4THjRquBT/UWGVpm2ifH9VM8OHi0lBaaDaqsZnAYuHf/AkUc4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWP85sg+5B2N7GxqB5V/tlSIKHfhx9kgFns3KJl3sJ8=;
 b=Wt4uJRIT39lyJW2ulO6Iqf5j/9TYGlXOes2PHapeaT+If+597b0n4PkU9ozT0IkXQh8xgiKcg4qUb6M7xHlODRFQjXGJZ1xaz5zM5gE+tPAqfcyQeR2rnqRe1kHPvO1loTLQU9gq3AJY3nz2Fzr6eHXUi0qsP59Aq/RIKk5E+yK1Xo4cA6OfIgG/KX0Z6S4P69hZ/rnsf7FbOY7VuH+Wfm6zg/RbBgJaEoImLK517ururlsNtMNg56in7u3qi34ebcWYr3oaTAAuo09K2edHMvSa9K7rEf/10bbnLx761Y92kUzGptZUc2ENksK6IE45EHx4oPnJy4j3J3Pilt5GuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWP85sg+5B2N7GxqB5V/tlSIKHfhx9kgFns3KJl3sJ8=;
 b=gSJtPsuFCzG5uMZjQDQc9cvkW+bssYo+r9CEBKG8yMTbavTVbZRSTJudO4Vkr1nTmM4qrW1AUWR4jcfB4Qon5V1pzZffC58NkmbbOMW/imTbBirtJTooeWjQs+/xijhPS999cAEVAiFljwkYAnJgUwvWCKufwKEy2WJk6Jjs0XU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DS7PR03MB5543.namprd03.prod.outlook.com (2603:10b6:5:2cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 27 Aug
 2020 07:07:24 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 07:07:24 +0000
Date:   Thu, 27 Aug 2020 15:06:40 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: regulator: Convert mp886x to json-schema
Message-ID: <20200827150640.267f6edc@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYBP286CA0047.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::35) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TYBP286CA0047.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:10a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 07:07:22 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b662f9-f66c-4db2-6496-08d84a57d956
X-MS-TrafficTypeDiagnostic: DS7PR03MB5543:
X-Microsoft-Antispam-PRVS: <DS7PR03MB5543FE5536F46A8A216FEF45ED550@DS7PR03MB5543.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HwQBouK217366edF+pIrAnbhDFHsaqBJ1rMFJDnnWOIt7nA+6GAG2l/Ti7Gug/0erjofcY1mm9n/WPXS4XYserSOeI99s5+DC/bZ69l9P7K+Kq4QWKAl965SEgpBYvGomN0pEf9x0JmCzDRKsxXHle1w/QKC2Wh7QMwOHLiRGZevuXeiZACI6UHPSJ6j8mNUp2OyURdc9XxIfXqIPJsAGf9KsaGwG4CuOVJ6IBx/x9+N/7ap+IbIE6XjXvh/GqTpFx4h8g+0F6K1btSoZGgSLj+2HAGu7IxJuWQyBZz59AjWxZOoqwEZ9t1PM77TMicYSgibwL6GhqQSn8kjlfgD3r1OzBWPT/50nFC+QLwndtSwJF4+rbv0VNdxDcbOPzKLxGufgqoklSV78pVpM14uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(346002)(376002)(6486002)(6666004)(16576012)(316002)(2906002)(66476007)(478600001)(66556008)(966005)(5660300002)(66946007)(83380400001)(1076003)(8936002)(110136005)(9686003)(26005)(186003)(956004)(8676002)(86362001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rultQWKETAJh/rR1+CCgw1w/n1rGGJSroJmb3eNZC7JW+ub6SYudxuI4Eqwf9q8F4QIbfkMgF03S5w6MEV8EJKA0mIqSyYENh6stKj16CHCqm/HTnwNN6GIkNQ/UNasGBTtwGJFxp1MV2taLDHov1JFiSxWo4vAmyOBeJHMtXSN/t7l1yL7TTyqwOay3Lz/yi6z1WhczHqap+DrCApGhmxVETeymcwcpN5X8Wi/8bM3HfZ0shz/NTO5RnB59VcGt3g8UjpBJpioj+DSYJMvChLd+1ml8TSvX61RnW3rxEfWP/IiuNjdbexacWSQIqUTRrSExXmeNMg7nXuODivzwaJNRP+ZwA1RnMab4m4kRoB8ntYWYqHYOCjR1wNYKX1KL56hpyeIU8Jk7CyqX9o4DXfO8F9cQHIm+YdTCmCaCMDCVPSDPlbpvQ3wqiRNGJF+2gIJbbUOCGqdcbqEtePqAzkRFOQI4i+8YxMEv7gQ5Z+5VcazC2tZ6pbWEjG2GHBdw01CyI7i4Uy5LGvuOLlJiI6LpF+MEuGWj8YIdH0MiB1mseXBGWPPgJ4kLZmsV7ZgFLw4TzOVu3DoKHNFiJxnofPgGiQH+WWJ8OXZbQWWoDvzTj/GlmDmbDxNf8Nk6F2wdlJU2XxaRwP26Y3+JmIwF+Q==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b662f9-f66c-4db2-6496-08d84a57d956
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 07:07:24.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOdANX4vSZbSSrnetQ5rW+bgjj9hLa7ckzKvDpRaaYnp6iMfsbLuAY9mCxA2CajG+Yv93oD4yxTXrR2I1xCxmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mp886x binding to DT schema format using json-schema.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../devicetree/bindings/regulator/mp886x.txt  | 31 ----------
 .../bindings/regulator/mps,mp886x.yaml        | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/mp886x.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp886x.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mp886x.txt b/Documentation/devicetree/bindings/regulator/mp886x.txt
deleted file mode 100644
index b05307bbb0d9..000000000000
--- a/Documentation/devicetree/bindings/regulator/mp886x.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Monolithic Power Systems MP8867/MP8869 voltage regulator
-
-Required properties:
-- compatible: Must be one of the following.
-	"mps,mp8867"
-	"mps,mp8869"
-- reg: I2C slave address.
-- enable-gpios: enable gpios.
-- mps,fb-voltage-divider: An array of two integers containing the resistor
-  values R1 and R2 of the feedback voltage divider in kilo ohms.
-
-Optional properties:
-- mps,switch-frequency-hz: The valid switch frequency in Hertz. Available values
-  are: 500000, 750000, 1000000, 1250000, 1500000
-
-Any property defined as part of the core regulator binding, defined in
-./regulator.txt, can also be used.
-
-Example:
-
-	vcpu: regulator@62 {
-		compatible = "mps,mp8869";
-		regulator-name = "vcpu";
-		regulator-min-microvolt = <700000>;
-		regulator-max-microvolt = <850000>;
-		regulator-always-on;
-		regulator-boot-on;
-		enable-gpios = <&porta 1 GPIO_ACTIVE_LOW>;
-		mps,fb-voltage-divider = <80 240>;
-		reg = <0x62>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml b/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
new file mode 100644
index 000000000000..ba175b30f468
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mps,mp886x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power Systems MP8867/MP8869 voltage regulator
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mps,mp8867
+      - mps,mp8869
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO to enable/disable the regulator.
+    maxItems: 1
+
+  mps,fb-voltage-divider:
+    description: An array of two integers containing the resistor
+      values R1 and R2 of the feedback voltage divider in kilo ohms.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    maxItems: 2
+
+  mps,switch-frequency-hz:
+    description: The valid switch frequency in Hertz.
+    enum: [500000, 750000, 1000000, 1250000, 1500000]
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - mps,fb-voltage-divider
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        regulator@62 {
+          compatible = "mps,mp8869";
+          regulator-name = "vcpu";
+          regulator-min-microvolt = <800000>;
+          regulator-max-microvolt = <1150000>;
+          enable-gpios = <&porta 1 GPIO_ACTIVE_LOW>;
+          mps,fb-voltage-divider = <80 240>;
+          reg = <0x62>;
+        };
+    };
+
+...
-- 
2.28.0

