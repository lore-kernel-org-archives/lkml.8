Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1250C5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E732465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBSV4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:56:43 -0500
Received: from mxout2.idt.com ([157.165.5.26]:50676 "EHLO mxout2.idt.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbgBSV4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:56:43 -0500
Received: from mail6.idt.com (localhost [127.0.0.1])
        by mxout2.idt.com (8.14.4/8.14.4) with ESMTP id 01JLuYLD030681;
        Wed, 19 Feb 2020 13:56:34 -0800
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail6.idt.com (8.14.4/8.14.4) with ESMTP id 01JLuYA4018416;
        Wed, 19 Feb 2020 13:56:34 -0800
Received: from minli-office.na.ads.idt.com (corpimss.corp.idt.com [157.165.140.30])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id 01JLuXW10601;
        Wed, 19 Feb 2020 13:56:33 -0800 (PST)
From:   min.li.xe@renesas.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, netdev@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH v3 1/2] dt-bindings: ptp: Add device tree binding for IDT 82P33 based PTP clock
Date:   Wed, 19 Feb 2020 16:56:15 -0500
Message-Id: <1582149375-25168-1-git-send-email-min.li.xe@renesas.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <min.li.xe@renesas.com>

Add device tree binding doc for the PTP clock based on IDT 82P33
Synchronization Management Unit (SMU).

Changes since v1:
 - As suggested by Rob Herring:
   1. Drop reg description for i2c
   2. Replace i2c@1 with i2c
   3. Add addtionalProperties: false

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 .../devicetree/bindings/ptp/ptp-idt82p33.yaml      | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/ptp-idt82p33.yaml

diff --git a/Documentation/devicetree/bindings/ptp/ptp-idt82p33.yaml b/Documentation/devicetree/bindings/ptp/ptp-idt82p33.yaml
new file mode 100644
index 0000000..25806de
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/ptp-idt82p33.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/ptp-idt82p33.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IDT 82P33 PTP Clock Device Tree Bindings
+
+description: |
+  IDT 82P33XXX Synchronization Management Unit (SMU) based PTP clock
+
+maintainers:
+  - Min Li <min.li.xe@renesas.com>
+
+properties:
+  compatible:
+    enum:
+      - idt,82p33810
+      - idt,82p33813
+      - idt,82p33814
+      - idt,82p33831
+      - idt,82p33910
+      - idt,82p33913
+      - idt,82p33914
+      - idt,82p33931
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+addtionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        phc@51 {
+            compatible = "idt,82p33810";
+            reg = <0x51>;
+        };
+    };
-- 
2.7.4

