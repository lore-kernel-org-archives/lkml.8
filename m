Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73657206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgGHEH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:07:58 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:45412 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgGHEH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:07:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id B3B8C20001F5;
        Wed,  8 Jul 2020 12:07:54 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0TXAqsA29Xuz; Wed,  8 Jul 2020 12:07:54 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 99462200E20A;
        Wed,  8 Jul 2020 12:07:54 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 96052C01B68;
        Wed,  8 Jul 2020 12:07:54 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 91DF820031F; Wed,  8 Jul 2020 12:07:54 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
Date:   Wed,  8 Jul 2020 12:07:47 +0800
Message-Id: <20200708040748.9014-3-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708040748.9014-1-chris.ruehl@gtsys.com.hk>
References: <20200708040748.9014-1-chris.ruehl@gtsys.com.hk>
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
 .../bindings/hwmon/sensirion,shtc1.yaml       | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
new file mode 100644
index 000000000000..6725a7b646b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
@@ -0,0 +1,60 @@
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
+    maxItems: 1
+    description: I2C address 0x70
+
+  sensirion,blocking_io:
+    $ref: /schemas/types.yaml#definitions/flag
+    description:
+      If set the i2c bus hold until measure finished.
+
+  sensirion,low_precision:
+    $ref: /schemas/types.yaml#definitions/flag
+    description:
+      If set aquire data with low precision (not recommended).
+      The driver aquire data with high precision by default.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c1 {
+      status = "okay";
+      clock-frequency = <400000>;
+
+      shtc3@70 {
+        compatible = "sensirion,shtc3";
+        reg = <0x70>
+        sensirion,blocking_io;
+        status = "okay";
+      };
+    };
+...
-- 
2.20.1

