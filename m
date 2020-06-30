Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0725C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45BD2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390154AbgF3RQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:16:34 -0400
Received: from out28-196.mail.aliyun.com ([115.124.28.196]:50076 "EHLO
        out28-196.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390136AbgF3RQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:16:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08608748|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0254061-0.000592515-0.974001;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.HvKRuu7_1593537376;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HvKRuu7_1593537376)
          by smtp.aliyun-inc.com(10.147.41.178);
          Wed, 01 Jul 2020 01:16:25 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v3 1/2] dt-bindings: timer: Add Ingenic X1000 OST bindings.
Date:   Wed,  1 Jul 2020 01:15:52 +0800
Message-Id: <20200630171553.70670-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200630171553.70670-1-zhouyanjie@wanyeetech.com>
References: <20200630171553.70670-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OST bindings for the X10000 SoC from Ingenic.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v1->v2:
    No change.
    
    v2->v3:
    Fix wrong parameters in "clocks".

 .../devicetree/bindings/timer/ingenic,ost.yaml     | 61 ++++++++++++++++++++++
 include/dt-bindings/clock/ingenic,ost.h            | 12 +++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,ost.yaml
 create mode 100644 include/dt-bindings/clock/ingenic,ost.h

diff --git a/Documentation/devicetree/bindings/timer/ingenic,ost.yaml b/Documentation/devicetree/bindings/timer/ingenic,ost.yaml
new file mode 100644
index 000000000000..459dd3d161c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ingenic,ost.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/ingenic,ost.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for SYSOST in Ingenic XBurst family SoCs
+
+maintainers:
+  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+
+description:
+  The SYSOST in an Ingenic SoC provides one 64bit timer for clocksource
+  and one or more than one 32bit timers for clockevent.
+
+properties:
+  compatible:
+    oneOf:
+
+      - description: SYSOST in Ingenic XBurst family SoCs
+        enum:
+          - ingenic,x1000-ost
+          - ingenic,x2000-ost
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ost
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - "#clock-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/clock/x1000-cgu.h>
+
+    ost: timer@12000000 {
+    		compatible = "ingenic,x1000-ost";
+    		reg = <0x12000000 0x3c>;
+
+    		#clock-cells = <1>;
+
+    		clocks = <&cgu X1000_CLK_OST>;
+    		clock-names = "ost";
+
+    		interrupt-parent = <&cpuintc>;
+    		interrupts = <3>;
+    	};
+...
diff --git a/include/dt-bindings/clock/ingenic,ost.h b/include/dt-bindings/clock/ingenic,ost.h
new file mode 100644
index 000000000000..9ac88e90babf
--- /dev/null
+++ b/include/dt-bindings/clock/ingenic,ost.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,tcu DT binding.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
+#define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
+
+#define OST_CLK_PERCPU_TIMER	0
+#define OST_CLK_GLOBAL_TIMER	1
+
+#endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
-- 
2.11.0

