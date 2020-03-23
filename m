Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2473AC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFF420769
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgCWJz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:55:57 -0400
Received: from jax4mhob20.registeredsite.com ([64.69.218.108]:48594 "EHLO
        jax4mhob20.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727737AbgCWJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:55:57 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.205])
        by jax4mhob20.registeredsite.com (8.14.4/8.14.4) with ESMTP id 02N9tt2x122335
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:55:55 -0400
Received: (qmail 5728 invoked by uid 0); 23 Mar 2020 09:55:55 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 23 Mar 2020 09:55:55 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2] dt-bindings: iio: accel: Add bmi088 accelerometer bindings
Date:   Mon, 23 Mar 2020 10:55:51 +0100
Message-Id: <20200323095551.23500-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
the accelerometer part.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: convert to yaml format

 .../bindings/iio/accel/bosch,bmi088.yaml      | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
new file mode 100644
index 000000000000..715f79c3b2a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/bosch,bma400.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMI088 IMU accelerometer part
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: |
+  Acceleration part of the IMU sensor with an SPI interface
+
+  Specifications about the sensor can be found at:
+    https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
+
+properties:
+  compatible:
+    enum:
+      - bosch,bmi088_accel
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+  spi {
+    bmi088_accel@1 {
+      compatible = "bosch,bmi088_accel";
+      reg = <1>;
+      spi-max-frequency = <10000000>;
+    };
+  };
-- 
2.17.1

