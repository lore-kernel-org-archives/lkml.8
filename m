Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB5BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFB220767
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1glgbDoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgFPI0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:26:18 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19855 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFPI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592295978; x=1623831978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UXU8xjgeD8uULtQXTbOnbSoc5eRHvFPsywKHip7NVXs=;
  b=1glgbDoOg8L7Y295yOy9rhoTk55+pCX2+cmc4DPYKFJO/IOXA2FmwnQ7
   fGbZ9zRiId4J+OGp6jT9Bqi9HrN8dvPqYu8bN5C2W8Pha71oJd7rkNzG0
   tbNUaQYcRyqBLgig5jN7G2fmrQbIbz9xnSxRsothFTdoTiZ7auY0RH7np
   dh/iuO0TOiLeze0halKVpbTOha2MJzKiTXdAjEV1jLmpPcXtN/oG/46ng
   5CHNXrQVVchL1wnkG8EZVMP9m3PRyE+EKHu+RrOeOc1bLRZXCKO8KUgCz
   xUzTAgwzyB0+JdhVUqV1+IHCMFCBt9GcabB/BWtSMaqzE+9umIXET4zkE
   g==;
IronPort-SDR: oLPrloCPosfK2Oj+eHset1dHFSuEZWYg1KuwFZ15O+1pbC3SH5kkWl+t3yo+FzKpeLQzoMJ3ll
 ToOOZ+6KHvt3JXQrHeN8zSFIgLqS53+V/xlBWJzX+nxJgMPCOXzfeLmF5Lh0HFdDXhrSsKHw8I
 1QACVhyS/a451EcL1Is9HTea94e1WWnvo6TU+7DQcpFWQmdL1h+RiWTqM4BZwlXFe3lW5VbeZ2
 ihFnvkxKLuEjV1kBz2Q+ujPb1vvGIqzhBVdL4qN7y4tlJ1RZphSMuyiooz2zAHhKEhkQpcM3Ba
 5jQ=
X-IronPort-AV: E=Sophos;i="5.73,518,1583218800"; 
   d="scan'208";a="79621908"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2020 01:26:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 01:26:16 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 16 Jun 2020 01:26:14 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 1/3] dt-bindings: hwmon: Add Sparx5 temperature sensor
Date:   Tue, 16 Jun 2020 10:25:54 +0200
Message-ID: <20200616082556.27877-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616082556.27877-1-lars.povlsen@microchip.com>
References: <20200616082556.27877-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the DT binding specification for the Sparx5 temperature
sensor.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../bindings/hwmon/microchip,sparx5-temp.yaml | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
new file mode 100644
index 0000000000000..0df4813fd7b24
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/microchip,sparx5-temp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Sparx5 Temperature Monitor
+
+maintainers:
+  - Lars Povlsen <lars.povlsen@microchip.com>
+
+description: |
+  Microchip Sparx5 embedded temperature monitor
+
+properties:
+  compatible:
+    enum:
+      - microchip,sparx5-temp
+
+  reg:
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    tmon0: tmon@610508110 {
+        compatible = "microchip,sparx5-temp";
+        reg = <0x10508110 0xc>;
+        #thermal-sensor-cells = <0>;
+    };
+
-- 
2.27.0

