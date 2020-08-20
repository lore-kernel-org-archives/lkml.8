Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09528C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C45207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ZVXy4KY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHTJRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:17:38 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:58367
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbgHTJQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:16:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMur2l4zsbE78PFb9spDhH4z0U5RPPuSOK1o/Ht+o6RBWSnu3LxX8agnis99rUR5fafuE8TYKk0DljYetU1puRswBCbgwcp5S+N2afX8viWKFQtHvTZ66W0TuWbwQJG0NEahMpeO8gFCZ7qrImqjSveDnUflrPWr/XV/L5FcIy+ojvdBk1ulIg+/MUkDhV4viAfVXnU9t60VehZSYpv6F1OfgnyHW+t9vLJo082UM9hAW+pFa0/EyNl9RCDkXRLINc+oA1y+lJrWVdGNAv1gVyht0BarZwloM0IXI4hA1EAlBWXQwHao6SVfA5hG2ke8o88RMmuWiGjdvHtgF+vEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWP85sg+5B2N7GxqB5V/tlSIKHfhx9kgFns3KJl3sJ8=;
 b=jvTnRiMRtZ0Nc4YjAmJyWwpcYDp3NZ/j/95brK1SAtYZFar6E6IZi4DCla7vJYtzKnykdR5Q90nvM9ZWJvxRFNTi72tL7caiewRGE3JkFqIeh0NZiZGxp35mwmqKzm9To+zscEZqRkUYA+YC7sx/BnSlNhTdKKV0E7oGIRRly+3Mkny3SfSMCnPDSw7SEiznXp0sdBUO565yojIM9Ue4D+MHFpEI3ZFcHTRbFjuchgOJ+yceW6JPsYKQa61GgZnLTsgyD5EUeUF21OubJg4PsT9o9VXN8E/R/lm8P6YP7NnX6c3JMFBNAHwwYOHMgJsjwNRR87cRL4j0oqZDFbr8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWP85sg+5B2N7GxqB5V/tlSIKHfhx9kgFns3KJl3sJ8=;
 b=ZVXy4KY6c3rR/+PXCAjQjKKqVH44bHrFhZRhXUGIMhh8KbTG2jHwbXmrO+OLWfxC88yykrnzR/wpeiyg/IFbcyMDlfTs+DGAhwXmaT41y6z1E3hsVasvbi+2QO5KhZrNRZKWx9c5r8ZSBRQdxhZmWtypP52XuJGLYry6OTtgHLI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN8PR03MB4738.namprd03.prod.outlook.com (2603:10b6:408:6d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 09:15:45 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 09:15:45 +0000
Date:   Thu, 20 Aug 2020 17:12:32 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 4/4] dt-bindings: regulator: Convert mp886x to
 json-schema
Message-ID: <20200820171232.1fede9bc@xhacker.debian>
In-Reply-To: <20200820171020.5df4683b@xhacker.debian>
References: <20200820171020.5df4683b@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To BN7PR03MB4547.namprd03.prod.outlook.com
 (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TYAPR03CA0015.apcprd03.prod.outlook.com (2603:1096:404:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 09:15:43 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e359bfa4-4ccd-4199-808e-08d844e99e95
X-MS-TrafficTypeDiagnostic: BN8PR03MB4738:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4738A6CE0F535F5BAE722A01ED5A0@BN8PR03MB4738.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYSLPkgKsNYDDYhvH49w8jcdZJSN5A/EuO2aSr87+DGu3l9SqdIR3Bf9+fIJAqnWWwmLzIiVFnxKwty/Qj99n4KGNDnT51ckNrFkc3K6TKeXlYqf2YKgQl2CfySu61PQ1y94fcDgFS+kOxYDMnVoBlUL8AIbuCayTxqe6MQMO9vnpqWhY8z9YVdibYuDynQH6OTuFQDeD1CD+eIP9VDE9ztyxGIHlE/LpdL0Kcnsbk1noXqVpqz0DbuID/4MovJ/vNo1lHa/8kxRkcLHiDCioexoQ+keF7HPZMIknCqDPhV5B8wfMeSdKGCGc/r9Wsbu0VO4R8gvNl/jJjc9HL+3+cKq4nQ1kefoQxcBKo7y1KtOEVxlSzEyIhT0YvOmEjmh4JWcKURB2izA0HD3hZhDslZoe32Npe6OM460ivrQgwqoITPb9EHXqjB0KcKB8fFykDMTQnO7Im/Vqype0a4iRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(316002)(2906002)(110136005)(66476007)(6486002)(66556008)(66946007)(110011004)(966005)(16576012)(4326008)(8676002)(478600001)(5660300002)(26005)(86362001)(9686003)(6666004)(52116002)(956004)(186003)(1076003)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vgzEO04YE4kGsNF1Apev1s7gMhSleIvhjepY6fRGEikvpjQVv+8Ay7Wgs+PBlsJDduRw2Gz4IcZzakA2WRBnCmDH7Fp+91V6SomHxXgiiF5j1nfOQuf8ZmR3ZufTdDJjX8tt8XoSpnsX3UAaffo63XXgjL1m4dwX5gGsJs6Ok1M4ToJariR+XLwPJfHmEpXXGKPfPppp1yvF/DWzoF5T75oG6MBQb5RgBcYV4IJz7TNv8jDgdTJFqS40+lXadpDF3wcj/lNaQyQAK1YGqT895nvB/qaKj8lODc9oarq+d9o8h6n6SZss64nUh+F8sS5FKv7tJBciYRZf6FM0/lhC5SEheIpJj/1sFGk9q0h6Nzob1xt9f3fITW38xIovUFU17r5xoQI49ym/gUhUzzTFXJ8gGgD60z6StEDMGbLBl71SqZx3ioGO//nohf11zU3yn7sw8m8g1cg6WBzmhfV6EDUED8DmgPMwNufn9odqJUhCaGbIgM1hpTKfsMX9PpAX+jPH0VdD93lIV/mrArbTige6P7ScfSTMOMZjeCwqBA+hzVdUDIkQFPEzVgxN1ekqp/RwAdvRmdCLMk7UubZgWuJDYcMNM8Kbc80FjGQ4bOP/2OaEbFSI9gckVnksWY+VglCFfnW2RxJP+OR1JqhvWQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e359bfa4-4ccd-4199-808e-08d844e99e95
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:15:45.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uguMyUL6ge4d1wq2zJbaQMXqQwZ2xKIvwQF9UDzG9GeDG4KKsUogcLTaTwZs71G4QtVtQ1sfc11GFtyi2+JALw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4738
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

