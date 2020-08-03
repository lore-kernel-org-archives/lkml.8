Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE8CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022A620738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="WtEvkcBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgHCGpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:45:00 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:49536
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbgHCGpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5uj8ge4TrW5esK9EmMsP4Ob6u+nm7hrZjRRBEnPtRXJMKjUocpOjecGzo7q3JB1KM/Jbn65jcM7f0wK7dxtKo4vSwjx6idtgEAHOOZhcY+lRMpnd1UWh0pi1ROrEOACC6KN2G1crwnJddpmNTd2omOo0QxUuxEysL4zSE1PVEUotr3IlrAGfJStL0Dg6KdWAmWp2MgzDgdtUK3RdvTs9VRTwVu9xV/JiRE0cnKdTaW55tnSAakEDo8/mZgSnP3T8xUz+umoIXJnGrTBB7xFMHzEyElT/iMmo/l0oJZxrQxiKQw5DgHVLSp0mtdqFqVK6yM8KoWvble2AaN/B8CWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqn38w4AjSGBOcPUNyWYKKGZFOEIHQSkbK3zaA0NX+0=;
 b=e9BN4IPMu4aNfLBVRUJXFrN4ldw/KmOwXBH4YTDgxd55oF2PbFw7IS7R6uEJpzeKsbgoiN0kQljSkav6cBCgYMawR/DHzzqykMuOddeRU9You+JDNX4oN0u0fcBcn425svr8pQB6033+I6wEmYuC5vlojfChfUWPunrhEJZYyTuCuhaV3GVyogrSO4mQl0ZnT+x9su7UgGYQT4iiDoYZf5u9qoOuut4DMZKFxtZKRB01go8mEiINPA+v4Hr4kymLPkzADZxMEZEfHWtIUKqnrsazS4ZcgfhkvpVTEypRFxrL4Xd7245eh6eZ8J2YhD7w64iRuySQorfLvAa07L7m+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqn38w4AjSGBOcPUNyWYKKGZFOEIHQSkbK3zaA0NX+0=;
 b=WtEvkcBrsViDj7vEGbhN9FFwqIwOfmjBIBun+euRONXFb4P8R89b2XumI44Tr8qRWWJur1y/zah9gNUecwEAp5ImQYuh05gDwhusRnZAu4OAMfohaab0kdejNBzPKrFiTpshYnA/2kqQRwlxTPuPBilW7vbauGFxDWxzDhA4KgY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5113.namprd03.prod.outlook.com (2603:10b6:5:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Mon, 3 Aug
 2020 06:44:56 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::d9af:b798:6945:27b]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::d9af:b798:6945:27b%3]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 06:44:56 +0000
Date:   Mon, 3 Aug 2020 14:44:36 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3] dt-bindings: regulator: Convert sy8824x to json-schema
Message-ID: <20200803144436.5d2b7e54@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::26) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR0101CA0040.apcprd01.prod.exchangelabs.com (2603:1096:404:8000::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Mon, 3 Aug 2020 06:44:54 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac30496f-16b3-444a-d151-08d83778bbc0
X-MS-TrafficTypeDiagnostic: DM6PR03MB5113:
X-Microsoft-Antispam-PRVS: <DM6PR03MB51137040BB06FCECA5F89A47ED4D0@DM6PR03MB5113.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5JoDNuaFooG/6ywWXUtvPZVzP9tETrr0vI/Ftiv3uvqBCteMhcX/d3EtTyeDZyH0oo13O+pXSNDkGOHRgJo6Ov4M3+MBSdp+FF4dolpiZfgkpEYP5RKWQ5p2JW29g1CQF/PQSycaggSmP+oePI75IlFco+c96sgVXh3NkwmUjC1gbWs2uGZ10buqw/ZEPQOTMMfkuhVD3e1Qjuqo+mddOTTpiluypL8rX/SRxebhKwISUr9DzyDzVmvACfIh+79xKhCkjYZ+YUn7uUbUgdvi2y9xK2W+caF13J4d0FJKJZ4Sy8Lj3zkSZFx6lwxzCkW1qbbuNvpbmOB8hUWpdat3xwM0JA0SIYeo5A96rHtkRS1e61JtS9Tz6KJe5pnJyv0b0sd5Jolq3Khye0JuQ+zww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(8676002)(16526019)(186003)(110136005)(66556008)(8936002)(1076003)(66946007)(5660300002)(66476007)(6666004)(83380400001)(26005)(9686003)(6506007)(956004)(52116002)(7696005)(86362001)(4326008)(966005)(498600001)(55016002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zf1p6c9EuZDyoSUYHAG4fuVUDrCwBsnpMczXz5cteKzUuoAl1YhnG7JU5LISvY/NQdcjd2Or7G1BEaAkaJvDT3B3YzegKX4rqC5WCiCg18NU0dT+WY5YJu2rW9S3nGH6VglAvAvuDuD+NyugCm7mXjllkrS0kYJDFx3w3XBFgRCHRkbhlojj/yQsr/TQFpVqSx/IM2ikUXFhKBimlwCcdfI8D0YqB+A79yNXSP8sTiBlwWen5TVaImzj6/QAAP99En6RGb9fFMqMaEkx+CmFeYoE0cUul3NLQb/Pq6A5Tajr3ji4mCEODGFNAQtACrXfypG2T5SA6Gwa3dCviybi86kx1T4QPv2JKJj6dweTmE77eRbND4GvqTiOMKhE8b7wpvHC20spsQHa8GtaZ+O2hyq9YzcxO4S3BUmiLPkAMVdi9xK6Cm1qM1OZgsHMcrbF1snqUWDamSJaGOq6YkInp7AiToHH1cCUaK+5ZTjAqvhk4q6naJUGP7Uxpvsa2wgThRmRgUFP1TpcGnZK8VXeTytV3zIm88cUgVDlI18+B2ScCX1YWRTgmlMC+OtMTbBqsDYxCBd8nGPaqb+tF9PQqmZeKpzVg+EKvY8y5NWh+Dew51M96Sg4ETKwX4cc1mBM0QkkzpTwEI6FOtZHUINc7A==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac30496f-16b3-444a-d151-08d83778bbc0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 06:44:55.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrCR5Fa0/dIKaHMb+yWo7tkyNQWIBCbbiLC2nrvNl1A1icj4KWsSf86JBMU+i6ybgKgysoeLgmlLVSI8wD5rZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sy8824x binding to DT schema format using json-schema.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v2:
 - add $ref to regulator.yaml
 - add unevaluatedProperties

Since v1:
 - It seems there's something wrong with my last email, so send out a v2 with
   another email account

 .../bindings/regulator/silergy,sy8824x.yaml   | 45 +++++++++++++++++++
 .../devicetree/bindings/regulator/sy8824x.txt | 24 ----------
 2 files changed, 45 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt

diff --git a/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml b/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
new file mode 100644
index 000000000000..82af4d656177
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
@@ -0,0 +1,45 @@
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
+allOf:
+  - $ref: regulator.yaml#
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
+unevaluatedProperties: false
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
2.28.0

