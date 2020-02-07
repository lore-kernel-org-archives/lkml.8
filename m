Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DE2C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33E920838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kyovkwhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBGUjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:39:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35721 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBGUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:39:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so384546pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/3HQWF35ivl3fkO172M9O1viQmjTTJED1CtfoRt15k=;
        b=kyovkwhUgtT8TT1uUvaC6AuyI4FyJwhKnP2lWDRHoS0VSvI15vlplW1mblQYhsbbrs
         tQHoBxPZ57xwafBkBirfvb049NzgtoHnbdZ8Ut+hRDCnttl58lPSi9KyN/ekvVKNLVsY
         IIkQR4r2wZQ9ILD71ApdxVFwEh5YGL7kgWv+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/3HQWF35ivl3fkO172M9O1viQmjTTJED1CtfoRt15k=;
        b=LL37AcVTrP5ZKEFm86qjfypb6Qha+EOmYIfHlnW2ahYBZpqqB2LprxTyXokWb8hDZo
         3cimorDmraI5NRzNyFyklyTPl7dCvK/JTFhIDB8oLKxxYWHPQbseB/an7HI9/wztNc6e
         C3DB2CDoxWIauN2zFrJqV/3tHMvNniSHaNmtGIDSLW09XfkWpYyzDHnIkYSbofBu52a7
         hOAvgtbF68+buRXXM6VkZPumC9wMAL6cftFNAuOelDx/3Opa9Ud4LyZ8QV2ZPaaw9dB3
         yurdy+VPR9JfRBXOHrR4xTVI/UOl+5IMYfKUOTKxEr9lQAgHj8ndnoOihzIiZE+tPI8v
         CLAA==
X-Gm-Message-State: APjAAAXuLixEmMxXOyX0vIIIA41XkdSdXnFM0D3q+9KcxG9++R02flO0
        MOqlLYcIgq6qBQvstGAmryqKB98UtWY=
X-Google-Smtp-Source: APXvYqy9YVlC5Lo5de3O6H+Tzla/M3k33LZB+4zXlSllG7vpr8NBR9lXsDjqxybmpzmvkf3nETwnOw==
X-Received: by 2002:a62:1a97:: with SMTP id a145mr713986pfa.244.1581107973858;
        Fri, 07 Feb 2020 12:39:33 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id 4sm4051001pfn.90.2020.02.07.12.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:39:33 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: Add cros-ec Type C port driver
Date:   Fri,  7 Feb 2020 12:37:44 -0800
Message-Id: <20200207203752.209296-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207203752.209296-1-pmalani@chromium.org>
References: <20200207203752.209296-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Chrome OS devices with Embedded Controllers (EC) can read and
modify Type C port state.

Add an entry in the DT Bindings documentation that lists out the logical
device and describes the relevant port information, to be used by the
corresponding driver.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- No changes. Patch first introduced in v2 of series.

 .../bindings/chrome/google,cros-ec-typec.yaml | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
new file mode 100644
index 00000000000000..46ebcbe76db3c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Chrome OS EC(Embedded Controller) Type C port driver.
+
+maintainers:
+  - Benson Leung <bleung@chromium.org>
+  - Prashant Malani <pmalani@chromium.org>
+
+description:
+  Chrome OS devices have an Embedded Controller(EC) which has access to
+  Type C port state. This node is intended to allow the host to read and
+  control the Type C ports. The node for this device should be under a
+  cros-ec node like google,cros-ec-spi.
+
+properties:
+  compatible:
+    const: google,cros-ec-typec
+
+  port:
+    description: A node that represents a physical Type C port on the
+      device.
+    type: object
+    properties:
+      port-number:
+        description: The number used by the Chrome OS EC to identify
+          this type C port.
+        $ref: /schemas/types.yaml#/definitions/uint32
+      power-role:
+        description: Determines the power role that the Type C port will
+          adopt.
+        oneOf:
+          - items:
+            - const: sink
+            - const: source
+            - const: dual
+      data-role:
+        description: Determines the data role that the Type C port will
+          adopt.
+        oneOf:
+          - items:
+            - const: host
+            - const: device
+            - const: dual
+      try-power-role:
+        description: Determines the preferred power role of the Type C port.
+        oneOf:
+          - items:
+            - const: sink
+            - const: source
+            - const: dual
+
+    required:
+      - port-number
+      - power-role
+      - data-role
+      - try-power-role
+
+required:
+  - compatible
+  - port
+
+examples:
+  - |+
+    typec {
+      compatible = "google,cros-ec-typec";
+
+      port@0 {
+        port-number = <0>;
+        power-role = "dual";
+        data-role = "dual";
+        try-power-role = "source";
+      };
+    };
-- 
2.25.0.341.g760bfbb309-goog

