Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E61BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAC920656
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O+cVemWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgFROAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:00:17 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:41729 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgFROAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592488813; x=1624024813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gkdLjz1r6NMau5QrEq+reINzcOHhHZuLk5kWu8BYMO4=;
  b=O+cVemWXARpPYOFRPa64h+0DwBsE8JHNGgPOhVNVVI8fMBSiRanvXy/f
   GTyHDF2OiIyk2ZK6ve0jX0SETuTtOrVsz9h9JsAnt7OSE6CdzRRHrn0k4
   0zAZKRAGHSvP3+c6lNKrZvhtkpUONs1MLjPGZBT1v1LM+yvBoYu8Vz9qq
   YYtYzijr09pnTPtv2IHzYtdJXMZb4LO/lY0dSUA78pPJinRoqdGA3XMh0
   gHmNDBwVCr6NVPsCBm639ZjusZ6Yt4PtQLCAnwtRqeai/r/W6+TGc/0Bq
   hTSHED+00We0A5hZk+StQYqyOyI8tc1vCbOW3hhlaRx+OcjG6KytxHdZj
   w==;
IronPort-SDR: iWFye+NSDrpdrt/TXSNCG8Ww8ZuGVR8DSE8TxSiboicYkJD1qJYFVy3bcIbjzQ84gWunlp2qsz
 ffdOTTrcBziLMbIauqoSRf6TPM9/kZbNMcKK8MCE6yw/A3+etCwzZjwpa0U9ZmL4AIerWg2Gld
 vx24e8s57HmMAR6xfQOxoYxZ7Ga0O7ZnVZWulXc7FO6I92tzQh410+YGiD9qr/U21VRvJsyNj4
 T+eEbqIBoeiCwZLut6Mg1frYg+7kqxArLLm4E2tOGy4IJANQEoZ2VWdLPmAVqJarFkZ+ham6ao
 LKA=
X-IronPort-AV: E=Sophos;i="5.73,526,1583218800"; 
   d="scan'208";a="84138404"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 07:00:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 07:00:04 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Jun 2020 07:00:08 -0700
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
Subject: [PATCH v4 1/3] dt-bindings: hwmon: Add Sparx5 temperature sensor
Date:   Thu, 18 Jun 2020 15:59:49 +0200
Message-ID: <20200618135951.25441-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618135951.25441-1-lars.povlsen@microchip.com>
References: <20200618135951.25441-1-lars.povlsen@microchip.com>
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
 .../bindings/hwmon/microchip,sparx5-temp.yaml | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
new file mode 100644
index 0000000000000..76be625d56460
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
@@ -0,0 +1,44 @@
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
+  clocks:
+    items:
+      - description: AHB reference clock
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    tmon0: tmon@610508110 {
+        compatible = "microchip,sparx5-temp";
+        reg = <0x10508110 0xc>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&ahb_clk>;
+    };
--
2.27.0
