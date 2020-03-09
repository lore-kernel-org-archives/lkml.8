Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7122EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2FC24656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCITnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:43:15 -0400
Received: from v6.sk ([167.172.42.174]:34574 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgCITnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:14 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 5C6F2612FC;
        Mon,  9 Mar 2020 19:43:12 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 03/17] dt-bindings: clock: Convert marvell,mmp2-clock to json-schema
Date:   Mon,  9 Mar 2020 20:42:40 +0100
Message-Id: <20200309194254.29009-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fixed-factor-clock binding to DT schema format using
json-schema.

While at that, fix a couple of small errors: make the file base name
match the compatible string, add an example and document the reg-names
property.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v1:
- Collected Rob's Reviewed-by tag

 .../bindings/clock/marvell,mmp2-clock.yaml    | 62 +++++++++++++++++++
 .../bindings/clock/marvell,mmp2.txt           | 21 -------
 2 files changed, 62 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/marvell,mmp2.txt

diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
new file mode 100644
index 0000000000000..c5fc2ad0236dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/marvell,mmp2-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MMP2 Clock Controller
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+description: |
+  The MMP2 clock subsystem generates and supplies clock to various
+  controllers within the MMP2 SoC.
+
+  Each clock is assigned an identifier and client nodes use this identifier
+  to specify the clock which they consume.
+
+  All these identifiers could be found in <dt-bindings/clock/marvell,mmp2.h>.
+
+properties:
+  compatible:
+    const: marvell,mmp2-clock # controller compatible with MMP2 SoC
+
+  reg:
+    items:
+      - description: MPMU register region
+      - description: APMU register region
+      - description: APBC register region
+
+  reg-names:
+    items:
+      - const: mpmu
+      - const: apmu
+      - const: apbc
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@d4050000 {
+      compatible = "marvell,mmp2-clock";
+      reg = <0xd4050000 0x1000>,
+            <0xd4282800 0x400>,
+            <0xd4015000 0x1000>;
+      reg-names = "mpmu", "apmu", "apbc";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2.txt b/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
deleted file mode 100644
index 23b52dc02266a..0000000000000
--- a/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Marvell MMP2 Clock Controller
-
-The MMP2 clock subsystem generates and supplies clock to various
-controllers within the MMP2 SoC.
-
-Required Properties:
-
-- compatible: should be one of the following.
-  - "marvell,mmp2-clock" - controller compatible with MMP2 SoC.
-
-- reg: physical base address of the clock subsystem and length of memory mapped
-  region. There are 3 places in SOC has clock control logic:
-  "mpmu", "apmu", "apbc". So three reg spaces need to be defined.
-
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Each clock is assigned an identifier and client nodes use this identifier
-to specify the clock which they consume.
-
-All these identifiers could be found in <dt-bindings/clock/marvell,mmp2.h>.
-- 
2.25.1

