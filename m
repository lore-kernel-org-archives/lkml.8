Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5A5C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8EE20848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="FzmgCAu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgH1Q4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:56:38 -0400
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:3552
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbgH1Q4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:56:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqsQaaCjPEntBiinAV7DBDlZvEFBhB14dEwREuzkm2r89cAgpSY20L3TkWAkJsXBe8YLnI86Gbs3iW6RC3dI54egCxu5fSV+dnKMc7jnQvOwpVdWjm8pRLllsgt5dL9uZgjHn+9DV1OFNFwrDfMr0oVyTpxt/jeZm6Jtyr521uwW0KrNhwUdX1k75cy3AQwxjqqnhi+0TCgUGhqNvNx7Nd9DgfwyKHhkMqmcDMwzE6LdliDLZTt4zYOclCwrdQFueFwwszCjm8J4xoPvuNoTQdlrOHSI9asoDoOoFV86y8KGYWAnzmZcuqrtvXaHWFt7ihyclyzrfv6GRjDK0WgmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv9tEGcYwUq70rdwZ/BSBPEiMi4bGVqxcWtwp/rxKow=;
 b=FBm0CYfGYF/7HZNkHcrfk4oN69pH6/yog1IztQ7ksDEJNO4sl+ouSDC8XVjwq45vIPocD6PMiufdqEBBpqvqpOcBW/3JSLzOvmXPDjUweG8RcS1o9pCX2mxsU6VxTgGedTxn6dGDbW6HurJeoXF8n1lk9wiDIybQwvwVDOqsryLk36ZKLPzX3sgMUHb85UAr0lH5BhjvpnfmWSrk8YHuUOoWGxUNt2ZMs01KN0POB/pDy1d/S6I4nas7rUpKtyAbkPkZuKHFDUgQi7QV656n8K64rTtdfjPoPkJsjDeLWujCmW5fFXnm11fRiSaV0/THTjKUlvprYPpCnm16eXfKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv9tEGcYwUq70rdwZ/BSBPEiMi4bGVqxcWtwp/rxKow=;
 b=FzmgCAu8SItd7LTwjyiQdsGZHSrGjlOgnrgbpHnqxzAFmAqgSxM8MywZrhAby28eEb5Veo2p7498sLY4N2sHn2kFV2jl4379PbXyAz8i3qS5YsjFgLYP6nzEsxne/hh8SSFA7lMyxjBVPNKI4foo2KvHI8jyqyo8titAz7pY5yU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR13MB1004.namprd13.prod.outlook.com (2603:10b6:3:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5; Fri, 28 Aug
 2020 16:56:34 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078%7]) with mapi id 15.20.3326.019; Fri, 28 Aug 2020
 16:56:34 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [RESEND PATCH v2 1/1] dt-bindings: riscv: sifive-l2-cache: convert bindings to json-schema
Date:   Fri, 28 Aug 2020 22:25:43 +0530
Message-Id: <1598633743-1023-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598633743-1023-1-git-send-email-sagar.kadam@sifive.com>
References: <1598633743-1023-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SG2PR02CA0032.apcprd02.prod.outlook.com (2603:1096:3:18::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:56:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6ad8684-b5de-43f9-54f3-08d84b7351f3
X-MS-TrafficTypeDiagnostic: DM5PR13MB1004:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR13MB1004A81E00F20F76431CD24F97520@DM5PR13MB1004.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JV5vbdT3N9EhbNoBZWzjUvP3FcuCMFGP1LJsD7NvOjierKC3v0JeI7Qu3xUD3SDVMapoRp20GhaE3rRmjHRnznaalmdJueFN6xgDwQCb4ZixoAcBUtZbmywGh7ravZ4cBi+YVePsJ14/XYUKgnVwRk1t2UMGrc8uIliyU3mGGWdg2gGt9NMUqYPu5DInUzj415FWJsnZgVpGo85b/TC6lUO8ugFZeu1ckkL7vnFJsdgjz0Pi95kYTrvE9h/1FgwKF6YpnT2Dcl8HOP+BSx5ppdiMtDfck1bf2192uOzDiuuY4+XYZRtAYAkCFIH1ZqZbhOvxJDzCc2TCGx0sTCtCiqEpQIw5iIOUtaUdYWmuVETjDQbhK2BUFOVA43bCEfRaveqIfaQsX3APn1DSKSFODQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39850400004)(346002)(366004)(376002)(4326008)(66946007)(2906002)(316002)(478600001)(6666004)(52116002)(66476007)(8676002)(107886003)(66556008)(8936002)(16576012)(83380400001)(6486002)(2616005)(5660300002)(956004)(83170400001)(26005)(186003)(6916009)(42882007)(966005)(36756003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3sSAYDggMCQ1MpcEytVdO48laEVwtyFkeJvDUMIyDEoUCrt9NGw97XVdojtcLx9Bcig4bn+7VGaXeENAP3WVCiVpW5lqGLA8ByinYyP+NPft69O0KilAFksWHJAVUTHiNXUa1MbyyECXRiAqWRO3lyMvZYgbtm2VmPNUWjfcNqhXqv747qyHQAMuh3L6fmalAPjTwdRkrzLnRsZ9J6q4XzBCSCfI1WZDIBGPbv9oQ3Gg50DAlbe3QL5Ti+xSZdxqo7rpCpT87mvlqmyr44hI5o7H8Kkdra/YU4jfFbxl1vH8WBNMbQv77ArbVCI6kdINLZNDdLkk0zlMbY9PifmcPJg7/qG5EPcUem2QnZrwy2WZekqqJ4kO6jcxDmSCDnCPNAwYt3+UJ3DMDYMSWgvtfPXRmASea6I0rOanJhzw+zPkvyFvUeNuWt3bgl5zvtepgum5aNjj5jekeHQT5JUjyeYuq7cvk9MZlbnaWNr2oJyaR/UO9IBC05w5wyosbD7FMF11AybkV9RmdaDG0TjiQKLBap+R0zN5GDSEgtKneQWB4B0t+JTyL12xGg0fQ2B3iBWO4bLv9D1AwDxZq2mu3Kh22/bR2kXW5PF9fSIHET6iSa0f3hC8YbbGWWjTzT0H9qHadnD8rTMZNNunG9VR4w==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ad8684-b5de-43f9-54f3-08d84b7351f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:56:34.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMxxJ8dnyVJ0T8kqy3kC4zEaUj/HqFarwK85cPdlnmXo5L1R3V1kcjKNWRAslHokyEFTxqwZqTwvHNjQ2sOBVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2 Cache
controller to YAML format.

Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 92 ++++++++++++++++++++++
 2 files changed, 92 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
deleted file mode 100644
index 73d8f19..0000000
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-SiFive L2 Cache Controller
---------------------------
-The SiFive Level 2 Cache Controller is used to provide access to fast copies
-of memory for masters in a Core Complex. The Level 2 Cache Controller also
-acts as directory-based coherency manager.
-All the properties in ePAPR/DeviceTree specification applies for this platform
-
-Required Properties:
---------------------
-- compatible: Should be "sifive,fu540-c000-ccache" and "cache"
-
-- cache-block-size: Specifies the block size in bytes of the cache.
-  Should be 64
-
-- cache-level: Should be set to 2 for a level 2 cache
-
-- cache-sets: Specifies the number of associativity sets of the cache.
-  Should be 1024
-
-- cache-size: Specifies the size in bytes of the cache. Should be 2097152
-
-- cache-unified: Specifies the cache is a unified cache
-
-- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
-
-- reg: Physical base address and size of L2 cache controller registers map
-
-Optional Properties:
---------------------
-- next-level-cache: phandle to the next level cache if present.
-
-- memory-region: reference to the reserved-memory for the L2 Loosely Integrated
-  Memory region. The reserved memory node should be defined as per the bindings
-  in reserved-memory.txt
-
-
-Example:
-
-	cache-controller@2010000 {
-		compatible = "sifive,fu540-c000-ccache", "cache";
-		cache-block-size = <64>;
-		cache-level = <2>;
-		cache-sets = <1024>;
-		cache-size = <2097152>;
-		cache-unified;
-		interrupt-parent = <&plic0>;
-		interrupts = <1 2 3>;
-		reg = <0x0 0x2010000 0x0 0x1000>;
-		next-level-cache = <&L25 &L40 &L36>;
-		memory-region = <&l2_lim>;
-	};
diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
new file mode 100644
index 0000000..e14c8c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2020 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sifive-l2-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive L2 Cache Controller
+
+maintainers:
+  - Sagar Kadam <sagar.kadam@sifive.com>
+  - Yash Shah <yash.shah@sifive.com>
+  - Paul Walmsley  <paul.walmsley@sifive.com>
+
+description:
+  The SiFive Level 2 Cache Controller is used to provide access to fast copies
+  of memory for masters in a Core Complex. The Level 2 Cache Controller also
+  acts as directory-based coherency manager.
+  All the properties in ePAPR/DeviceTree specification applies for this platform.
+
+allOf:
+  - $ref: /schemas/cache-controller.yaml#
+
+properties:
+  compatible:
+    items:
+     - enum:
+        - sifive,fu540-c000-ccache
+    description: |
+      Should have "sifive,<soc>-cache" and "cache".
+
+  cache-block-size:
+    const: 64
+
+  cache-level:
+    const: 2
+
+  cache-sets:
+    const: 1024
+
+  cache-size:
+    const: 2097152
+
+  cache-unified: true
+
+  interrupts:
+    description: |
+      Must contain entries for DirError, DataError and DataFail signals.
+    minItems: 1
+    maxItems: 3
+
+  reg:
+    maxItems: 1
+    description: address of cache controller's registers.
+
+
+  next-level-cache:
+    description: |
+      Phandle to the next level cache if present.
+
+  memory-region:
+    description: |
+      The reference to the reserved-memory for the L2 Loosely Integrated memory region.
+      The reserved memory node should be defined as per the bindings in reserved-memory.txt.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - cache-block-size
+  - cache-level
+  - cache-sets
+  - cache-size
+  - cache-unified
+  - interrupts
+  - reg
+
+examples:
+  - |
+    cache-controller@2010000 {
+        compatible = "sifive,fu540-c000-ccache";
+        cache-block-size = <64>;
+        cache-level = <2>;
+        cache-sets = <1024>;
+        cache-size = <2097152>;
+        cache-unified;
+        reg = <0x2010000 0x1000>;
+        interrupt-parent = <&plic0>;
+        interrupts = <1 2 3>;
+        next-level-cache = <&L25>;
+        memory-region = <&l2_lim>;
+    };
-- 
2.7.4

