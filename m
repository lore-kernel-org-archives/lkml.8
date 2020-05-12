Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E9FC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45D3206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H7zv+pIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgELN0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELN0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:26:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E98C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:26:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so9463166wru.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lm/JhSU6WIUD9liaClHiq2/rbC+K/Ls1HtNWMD1Nn2A=;
        b=H7zv+pIKMn1DFXWX7wYhzX5b9gbDPxAk9SE9ltGb5WnBojjIrTWGwZ7FVO7YXf1AoR
         COZHSxtOlkVLwcmTh97ohzAq4n9C7J6uHa4n4D27rkj+w/kfYeWrBD3lktPkCBd7OyNK
         O8P/pCK5xonSvWm29SHHyKomqkG8A+B7SHPE0Hdxxub08pQdFMBOAnAQGaUN+jnC5W1I
         DAw62gdKYZhW3y6Pzrg+noXMZ4eeW1RZlY/S2D9py4Eofn7OiX980AilKycW3g3jxVMX
         STxvCkdIKo7Txkpgq0z0bR0Ka58vlC02RDjsUwtAdg3aW0j9ktnqbckm4J6OXV57CjW8
         0RSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lm/JhSU6WIUD9liaClHiq2/rbC+K/Ls1HtNWMD1Nn2A=;
        b=gJssJBI/PwHWvM4NFaWpFknUdpb3go0ljkIpvLEuC2hGF6xokclsedVvVS9N4ZYnXk
         ntTSUBjjKykYVCE8W84/h+DMOEd03Zp8poSCVTEXTzXDOYRdw0CfEfcCQwuidxJWy1Co
         lfjIIaNxrutEaWBxNn+j7gBnyQprXNww3qRqVeu19nm2ONosgiod2tR5w6ctyuD89BXz
         uaJddZ5GN93TlWeKNHEfrXHzmBr92BEWkQf+n6/4/PXjD9TYj9KfNeMPJdSbUqkGq/uy
         emNcVg6B5AV2Yu59fD1evyD4ph4Tg8WRCjs0MMRh/6DUmr5UfCB6i8nc4imgbigD1hPo
         JHqg==
X-Gm-Message-State: AGi0PubIoPK/CneYmnxq2lzfaiU/3q1uzkFe1zRSIxQKlXWwWXPkkr1p
        LEfyIGQQfw02tNiBF0zjIZapfA==
X-Google-Smtp-Source: APiQypIMA843k3ZGcFq05wJywOzCbRuZBo362vVj3No/BJt89ev1hi92yc4IMHltKbZdcHKKO8Tw5g==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr24948754wrt.411.1589289979092;
        Tue, 12 May 2020 06:26:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id g15sm14441844wro.71.2020.05.12.06.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:26:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     lee.jones@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: mfd: add Khadas Microcontroller bindings
Date:   Tue, 12 May 2020 15:26:08 +0200
Message-Id: <20200512132613.31507-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200512132613.31507-1-narmstrong@baylibre.com>
References: <20200512132613.31507-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
boards.

It has multiple boot control features like password check, power-on
options, power-off control and system FAN control on recent boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mfd/khadas,mcu.yaml   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml

diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
new file mode 100644
index 000000000000..a3b976f101e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/khadas,mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Khadas on-board Microcontroller Device Tree Bindings
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |
+  Khadas embeds a microcontroller on their VIM and Edge boards adding some
+  system feature as PWM Fan control (for VIM2 rev14 or VIM3), User memory
+  storage, IR/Key resume control, system power LED control and more.
+
+properties:
+  compatible:
+    enum:
+      - khadas,mcu # MCU revision is discoverable
+
+  "#cooling-cells": # Only needed for boards having FAN control feature
+    const: 2
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      khadas_mcu: system-controller@18 {
+        compatible = "khadas,mcu";
+        reg = <0x18>;
+        #cooling-cells = <2>;
+      };
+    };
-- 
2.22.0

