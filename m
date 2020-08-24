Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A0FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A0C206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="Xe9wcDVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgHXHuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:50:54 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:39553
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbgHXHut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:50:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJpntlgLfbb7iu3AyZVc/PW3uEcvy6feevGSGOzLoVJCFn8/+IWHQP9ensmiz577tNgXZXBCZoRM5kllSXhvhcMgNDw1AxLZzTO+X7jzZtWV0Wxzu/5L+sEnkpPh2KnX+EXOaQ+/gNQN8BAGfsarXQHwsulskzg/pPmdg60NM2nUqIZ0mygL9h3W8990+LW7CEFMC6Nhcwv0WTzcjToB8Ggna0opbvCc0oqrR7szMivNC0/9LILqqWPKXnGaAyS1JiLDc1OvihjRHTkG9DkexP6K+3l9bvZP6poKeDNz/GmUd5lhAuvTxm8qniw/R1lay7Q8dikajp2IwEWPKYRPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq02i526DKQwUYCvE2J6GEpfHh78zi4ZSxDWysuunGo=;
 b=coSov1Zr19tB9xtyjYPNShx74I0iRjFZL/Ok0iK2aL4ualx7z3ZEKc6MKAKEgkqGiZlvW7olWpsviz4n+W4XqELbgOcYAFw4AMch/vjlSaW/laLdNEvWfMrK/PAbkrWpE2JPuHDP6GPyw0NRgTHqc+Agtp9pLCgwOFLrkXnXtAN5Sbjt5gWQLKmgINnKDSw7r/Ela0E1f32ji6bRrruRmHgy3yUQZJmudQ8hkohShplGvIH0TUUF7OSDDM4o9krVYz/qkxqvLK/jOhxQtOqjKlvGY/D8HK6RCi+a/W3M/l2iGwbkuIaybtPZQWOn+Bk0yPA3YhzKuykl1tPejcwMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq02i526DKQwUYCvE2J6GEpfHh78zi4ZSxDWysuunGo=;
 b=Xe9wcDVfIvBFFwjJrbQ7Ls2OX2jElmC8Swt7FOa9fzsiq8xIx8FIz+XSyDdccIcuJZVAU7YU3oGyzlHWvXVhIh70/WCS8v3jSvFp0LItsYZTY01O4VMXDuO6X9O0x9K2Mmz/SM8BqTDbgCIwDc/uV7q8P76Aw+fglLOemdjTUUA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB4148.namprd13.prod.outlook.com (2603:10b6:5:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10; Mon, 24 Aug
 2020 07:50:44 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078%7]) with mapi id 15.20.3326.017; Mon, 24 Aug 2020
 07:50:44 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [PATCH 1/1] dt-bindings: riscv: sifive-l2-cache: convert bindings to json-schema
Date:   Mon, 24 Aug 2020 13:20:21 +0530
Message-Id: <1598255421-8274-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598255421-8274-1-git-send-email-sagar.kadam@sifive.com>
References: <1598255421-8274-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::28) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BMXPR01CA0018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 07:50:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af0079ab-7f71-4f1f-d614-08d848026807
X-MS-TrafficTypeDiagnostic: DM6PR13MB4148:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB41481B20362036106D4A387597560@DM6PR13MB4148.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pFWHf12fyidK2IAdKMxMrg+hR9DSq2uz1dGkA/musvZr4pOcsM4TxfvfdT0AoX+qL0opUn09PYcJKEDrLItqJ9H0+06VaIFzqQn4gkoJMlG+f7bXzNqL6d5edsXARf2xQ8zTnGuS+GOvYh8dvpzRRdmgch2odBiINFpfV3UxtIImCl8P11GhUe/fu5pwREViqrZl22m8T/xnnE8FBLiDjfqYuGhyczyuzorpsPqzTKDiobz/oi1qvIXV54HMvGzKPZaT7wRuvrCYIxQQ46Upqha+ZIB9u32QOY/kPEeYP5SJ5x8QfJ1PGz6fsAs9nDtzyYSU6ERhwlkREbp5f1SBvLRZL77CsvMbWjUAoUWxtVWtndw2hMfRvEKk8TMcOebyKRuSJIETjo6OJK5V8CGQxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(366004)(39840400004)(83170400001)(26005)(36756003)(8936002)(2616005)(16576012)(52116002)(6916009)(5660300002)(316002)(4326008)(42882007)(107886003)(83380400001)(186003)(6666004)(478600001)(6486002)(66476007)(66556008)(66946007)(8676002)(2906002)(44832011)(956004)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3cpbMCcxRRJuLhqIyZaXmOaWdxCFj8KmX3b4EVnFC+6JW33XWVQXiIVfThGYNpRJW+pzRcXi2mZtEjBfYB6URBYTQJ5DhqpGY0E3XZvi1k+TY38EJVxfxJKwBsCjN3TuISlAgmNYZVOWAFnv8OF1nZaUcJt9OYfLUX8TXp9FiGGwv/HmdEbKX0k8j6Uh92uSZN6u4Q8IRuEAJi3HEjgjNcL8Vo5ayv5gUjhRYh4+a7CrRrb/gw39wA6bsaMNupw5/x4hdc9z3wBTJmsIQ4MDoBi1dDMVqRBZss7VoG/YYy//IwJo4MG11f/JJADAgHmtEl2hSU8l8ZnZLLEZwfiC8bboPVpW1vR4UUyF2xMcQ88izVt30mxpZEGzUIdgQVDVxp4TMWL/5n3y64YOoZiJrzQJqMaadRr2y+KkiKf4fmqVy203q3ulV7HoWVUKtPdgHudXQaQaYAr8Kz7g4+lgmPKrYlJUxp+A0wUplstPtySjA9Bxe2yQzHiWg0qwsx0nqXIlqinbRIUFJ8pxZJZNvleSbLdGYVaHQSFhYpVMAm3xU7NzvBuBs3JSXU9voEhvZAKfeFCpX7iSBVHlC1hHyM2d0OO/nzu43spgo3zuOOZfJGiBWBAOev3LxILWmXex6oJNloC8dSqUVOwwf6U5Lw==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0079ab-7f71-4f1f-d614-08d848026807
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 07:50:44.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBcOVsN1VBwU6A8QIT96uZZ4s8VIKpsl3SXmHKx/NiAlHpxaQMdLazlKTvMcfWgqlNVqEtC5e3T5vJN02fzoEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2 Cache
controller to YAML format.

Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 93 ++++++++++++++++++++++
 2 files changed, 93 insertions(+), 51 deletions(-)
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
index 0000000..d2edeb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -0,0 +1,93 @@
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
+     - const: cache
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
+        compatible = "sifive,fu540-c000-ccache", "cache";
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

