Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D238DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A8F2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGJCPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:15:55 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:50862 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGJCPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:15:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 1034320160CA;
        Fri, 10 Jul 2020 10:15:53 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r28K9n0KtGAZ; Fri, 10 Jul 2020 10:15:52 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id EC14F20160B5;
        Fri, 10 Jul 2020 10:15:52 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id E909DC01FBA;
        Fri, 10 Jul 2020 10:15:52 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id E4B5E202299; Fri, 10 Jul 2020 10:15:52 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
Date:   Fri, 10 Jul 2020 10:15:35 +0800
Message-Id: <20200710021536.27544-3-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710021536.27544-1-chris.ruehl@gtsys.com.hk>
References: <20200710021536.27544-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the newly added DTS support in the shtc1 driver.
To align with the drivers logic to have high precision by default
a boolean sensirion,low_precision is used to switch to low precision.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 .../bindings/hwmon/sensirion,shtc1.yaml       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
new file mode 100644
index 000000000000..140cf3043a27
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/sensirion,shtc1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SHTC1 Humidity and Temperature Sensor IC
+
+maintainers:
+  - chris.ruehl@gtsys.com.hk
+
+description: |
+  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensor
+  designed especially for battery-driven high-volume consumer electronics
+  applications.
+  For further information refere to Documentation/hwmon/shtc1.rst
+
+  This binding document describes the binding for the hardware monitor
+  portion of the driver.
+
+properties:
+  compatible:
+    enum:
+      - sensirion,shtc1
+      - sensirion,shtw1
+      - sensirion,shtc3
+
+  reg:
+    const: 0x70
+
+  sensirion,blocking-io:
+    $ref: /schemas/types.yaml#definitions/flag
+    description:
+      If set, the driver hold the i2c bus until measurement is finished.
+
+  sensirion,low-precision:
+    $ref: /schemas/types.yaml#definitions/flag
+    description:
+      If set, the sensor aquire data with low precision (not recommended).
+      The driver aquire data with high precision by default.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c1 {
+      clock-frequency = <400000>;
+
+      shtc3@70 {
+        compatible = "sensirion,shtc3";
+        reg = <0x70>
+        sensirion,blocking-io;
+      };
+    };
+...
-- 
2.20.1

