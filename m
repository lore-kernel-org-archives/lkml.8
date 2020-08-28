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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32E3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B86208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="ruuaKcGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgH1QBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:01:43 -0400
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:47040
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728471AbgH1QBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blC5QhpL5+J1OhMIn50kOAPsu9HqdgxhSp1NLmQPCs7H+P6eJwr6nnGBHSFzXji3L2cELomZ6rY1K9W7uBTCDWxmhlGWN2vHUqqT/biQj4I4AxNBNLEB7dqXU0M/AFFeDUKSOo9Mc3uIr9h4VbQbVDeJUwy15NFj6BPkNU0mZeaagW4OiBQcS0xgHWJDtR51Pq0bCQ5weYbXpPOJewpRdbYiJONgR0LvA7m5Zgp/h2o9i+AqqkmAOEHnpy1dZd5ipS1RnVqKpXBCsIm/mchgcKhtyzFj0D8uOB1BTR1TV0wX59HIA9GOPp8akl6K8dYzfIoeMEZ2+igHdH3lTLQXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv9tEGcYwUq70rdwZ/BSBPEiMi4bGVqxcWtwp/rxKow=;
 b=BKbIFQ9E1ByZZfSQi/Iy8HgDndh9OC3WJz8IJE2McKbYTF+Dx5bBYWN98m4LQNmJ8U6FUrkQGCEV7lXgNEsom9GrweGv6qLwbboQc5fRVRMoEzkv7misWXmv1u+WRwVU/iAKKjrD/88Zyf9i5aOT12zZ8c/PNJXHdo6akfOUMdDUSH/R0fHWltX1x1lMFQ8ncA3WhngX9CNP1v7DIsOjY6Zw5HJI9BApki/uWDZBCrZrI3ayw92e6m2LV9t+Sl4kWuwtgU+CczhPC/G2WDHb1SbJ84IBnCV0fscJR5Bdw87sGa3Q4lRaomfUQ4zXvGgUuzfos1BZOYG4uy0etDMk4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv9tEGcYwUq70rdwZ/BSBPEiMi4bGVqxcWtwp/rxKow=;
 b=ruuaKcGxyAcattwVoeoMFVfrdb0j1/ln70/ZEMvWLv/W8NavMfHm2ZEIXgFggFuCjmCMznkgyVmOeLq2AAJhO586BK/n1hSx+Xg+HeKQiHl0tMOR5rEMKW7tJph6haJQYsOqINILf2/ItZtuEahFycJEmmMv0W5uKjGD7bNZdd8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR13MB1210.namprd13.prod.outlook.com (2603:10b6:3:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10; Fri, 28 Aug
 2020 16:01:20 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078%7]) with mapi id 15.20.3326.019; Fri, 28 Aug 2020
 16:01:20 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2] dt-bindings: riscv: sifive-l2-cache: convert bindings to json-schema
Date:   Fri, 28 Aug 2020 21:30:53 +0530
Message-Id: <1598630453-31125-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598630453-31125-1-git-send-email-sagar.kadam@sifive.com>
References: <1598630453-31125-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:01:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d8b5a42-17c8-45e5-51cb-08d84b6b9aa9
X-MS-TrafficTypeDiagnostic: DM5PR13MB1210:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR13MB1210EC4D03D78F447CEA711C97520@DM5PR13MB1210.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzDLhK4fNSXx6DOmozSscdUylYX2URcD+n98ffz6g/SD59014pA9XweOjtU7qEMGtqbRci57hp0OlkderENiHzm4xn5CC6aUECDgh8PpYZmvQx995coItkF+f+9jcBuvQ/7oA4DPG1kAVu5YUyPoLdpehn+sQyDTO3K+/0Fol5p8JmqE7D8il3tSZjPcBEqvii4X4XE6e3+sty8MdGQP+8Kuy6PnsncM0RyzcZgmuQGZ404hGRESoiwzVdAexuepZa3LEJNv9ux+yoFpuXi/O2bhnbTbtpsT+8IqcbrDWDywUXDUkLyRrAqJeKj/GNuj+NnGpuenTfONKjXOAhjLy1at+1wjIWD4xL2+YsdgopJibvgdvofLMHZuEvlOs4u54yL5Or1KNZmqdyGBBAZcQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39850400004)(346002)(396003)(136003)(956004)(478600001)(52116002)(42882007)(2616005)(6666004)(44832011)(186003)(66556008)(66476007)(36756003)(2906002)(966005)(66946007)(83380400001)(83170400001)(16576012)(26005)(316002)(107886003)(4326008)(6486002)(6916009)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RcHepO71r7CohR0d0EYsprpXC6kB+SqDsuVRQ0BKu9B3+c48Ao4fCIB0+ATgege3QURaWMT6Upy7GjfV0csQGBrhWQ7n4kx4Yc3bZUJIfHCh2qcfqZdeIE/eO4EuWwEuLqvL4c/8kXCYRJP8lZSS+foHlXspdruKgL5n2CqnP8NODb7bOaQlvXFZ57Mr8EDw8czEWeBRv2V86LV5cdXjteefV7U4G72c0o0tvDks37Pn7AjPfM+1780ezEghOozsp/WAaORsC5geJF3LTETR3zn9PPvz7oi/FTE3lmFmYc0f1JT6FuoMqSpec0sQYoc46+pdY9Oq8JKSQa27FluUyTe9fVoEq3LMBnhTnV6c/1sXqp/TSCY/3RJigapIZdVArlF5sTAltuoTFSB0blH9Vwh/OL5L44FEppjtu3yockjqUFdMG1ytbRQjuMwfAS93o6/PgX4Jz1vihCtKzJQbjSdx6yNjq0kuNtCctVCJdw41qMBnPpSLrc/0Hbaid/FQnLJL3TK49Ot386AknPcwmMx2r8MeRoWxgjXYBz8LeSwbaX7e/ouIDVDDP5vPq/ikDl82suhvyr3Hy7oWeMCySAcfNhssO9negKvGEseeIHxfzQh35/N+gkk7evPkww1h8uyoXxLB47v5DjLZQiU+Pw==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8b5a42-17c8-45e5-51cb-08d84b6b9aa9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:01:20.3965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARyyPhna1CD2f9xIrzz6vITeuxfq1NaJrIpR89w7UQjkJMSf1gQBlffTgIJKX8Neb8wQIsQpZ9kNhlJxicCOaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1210
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

