Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FA3C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DD621919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hireIQKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbgIIRGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:06:08 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:52327 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgIIPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1599666133; x=1631202133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lgjF0qlCa2/wQXads/woBQepb5ar/T8sZ1QP8YDHF0E=;
  b=hireIQKK3ZB8RrxN1lWAEoFSStbwxVv0aBT2h8/V4jnEbDwNMSzKD806
   sFpCraS1BJIpkzOYtRg4x+C9iE3osKmKxWttx5p1+qEYkBhhsXBjM8wpz
   Os6cCsi9/Xe1Nt/UjJ9buqLUNcBmVSrqYT1BcHDB+q5TlxXXzPG2Vr2st
   4EuQ33ZsyDH7HkEfbuN33FDC+epVlMjCj8hJq+nDxubBO79SLXy1iB+s5
   iqAJyxIvSJ6C35RBgekLnS2ll+jWQxsMs3brM9YkpEt8tTuX9gVD8Pn/L
   8yRM78aptxXiOuq/SuN2878+CTn/lNRpk25XjOGdiUCUTINhBb9Zp3C8P
   Q==;
IronPort-SDR: ANPmC6FDYG/kTHlVsDWN0lqWHvAqGCWqG9lwf/OkcUkyqKM6RMN9VY6JHreb91mVz/Mwm3AIxw
 WkwQk+wQRvQIdsHpX7nWukEhUodpOj+wnaZPE3ECiZftveqFWwjjIBpytDtjbfvc5BAOCRVHYo
 0fkHNPSi+n1SP8+fBvdWEtpjHLNLV6Ghrj61GcgXZan7uEUW0Knq+BPYIuPxVmZ29ifRn3Zwde
 BA2929HzE3A0CV1bS0erfF+QmwLWY7OE8chIwpZJuvIEVbIybU/leljCCUec4xpegxXHPBcIxh
 jIQ=
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="91160126"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2020 07:54:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 07:54:13 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 9 Sep 2020 07:53:37 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: sound: add DT bindings for Microchip S/PDIF TX Controller
Date:   Wed, 9 Sep 2020 17:53:47 +0300
Message-ID: <20200909145348.367033-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings for the new Microchip S/PDIF TX Controller
embedded inside sama7g5 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v4:
 - added 'Reviewed-by' tag from Rob

Changes in v3:
 - removed 'oneOf' from 'compatible' property;
 - added 'maxItems: 1' to 'dmas' property;
 - removed pinctrl related properties;

Changes in v2:
 - replaced https with http;
 - reworked example, included bindings;

 .../bindings/sound/mchp,spdiftx.yaml          | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml

diff --git a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
new file mode 100644
index 000000000000..a03b0b871fc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mchp,spdiftx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip S/PDIF Tx Controller Device Tree Bindings
+
+maintainers:
+  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+
+description:
+        The Microchip Sony/Philips Digital Interface Transmitter is a
+        serial port compliant with the IEC-60958 standard.
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    const: microchip,sama7g5-spdiftx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral Bus Clock
+      - description: Generic Clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+
+  dmas:
+    description: TX DMA Channel
+    maxItems: 1
+
+  dma-names:
+    const: tx
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spdiftx@e1618000 {
+        #sound-dai-cells = <0>;
+        compatible = "microchip,sama7g5-spdiftx";
+        reg = <0xe1618000 0x4000>;
+        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dma0 AT91_XDMAC_DT_PERID(50)>;
+        dma-names = "tx";
+        clocks = <&pmc PMC_TYPE_PERIPHERAL 85>, <&pmc PMC_TYPE_GCK 85>;
+        clock-names = "pclk", "gclk";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_spdiftx_default>;
+    };
-- 
2.25.1

