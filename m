Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2F5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D770F21741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIIGwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:52:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:27679 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgIIGwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:52:17 -0400
IronPort-SDR: yYm8Ci9PdM/3ssWd9ZrEEoVnxtF/CNdD+tgJNmVRlzm5OZnWFIE2IwWKZ36bWi+WBr6zJe0f8a
 s/4uthlLDbAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155758968"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="155758968"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 23:52:16 -0700
IronPort-SDR: xool34bVXD9qs99QBn5tuRVLU0xsmOh4JOHLtD0ngKXLs5TxWaipPoy90vtt/ktfaO84+XukNF
 h9hJyk5B5dtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="286125165"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 08 Sep 2020 23:52:13 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 1/2] Add DT bindings schema for PVT controller
Date:   Wed,  9 Sep 2020 14:52:04 +0800
Message-Id: <e0fd02f63c5b6f46376eb709ebac6da36bfe26d8.1599634208.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PVT controller (MR75203) is used to configure & control
Moortec embedded analog IP which contains temprature sensor(TS),
voltage monitor(VM) & process detector(PD) modules.

Add DT bindings schema for PVT controller.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/hwmon/moortec,mr75203.yaml | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
new file mode 100644
index 000000000000..0d5a90117522
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/moortec,mr75203.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Moortec Semiconductor MR75203 PVT Controller bindings
+
+maintainers:
+  - Rahul Tanwar <rtanwar@maxlinear.com>
+
+properties:
+  compatible:
+    const: moortec,mr75203
+
+  reg:
+    items:
+      - description: PVT common registers
+      - description: PVT temprature sensor registers
+      - description: PVT process detector registers
+      - description: PVT voltage monitor registers
+
+  reg-names:
+    items:
+      - const: common
+      - const: ts
+      - const: pd
+      - const: vm
+
+  vm-map:
+    description:
+      PVT controller has 5 VM (voltage monitor) sensors.
+      vm-map defines CPU core to VM instance mapping. A
+      value of 0xff means that VM sensor is unused.
+    maxItems: 5
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - vm-map
+  - clocks
+  - resets
+  - "#thermal-sensor-cells":
+
+additionalProperties: false
+
+examples:
+  - |
+    pvt: pvt@e0680000 {
+        compatible = "moortec,mr75203";
+        reg = <0xe0680000 0x80
+               0xe0680080 0x180
+               0xe0680200 0x200
+               0xe0680400 0xc00>;
+        reg-names = "common", "ts", "pd", "vm";
+        vm-map = [03 01 04 ff ff];
+        clocks = <&osc0>;
+        resets = <&rcu0 0x40 7>;
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.11.0

