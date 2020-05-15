Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3858C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C52B2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lobsCH0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgEOUrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgEOUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:47:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412EC061A0C;
        Fri, 15 May 2020 13:47:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so5035400wrt.1;
        Fri, 15 May 2020 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aa13zQ7giAP62TWcUaUMtr6UzYCBsQUKHFJYOsGW7SY=;
        b=lobsCH0EYpvxTKHOpF1dKlAqEXOCKQMqI+ptQNtpsMvwS+4O71tcnncrEmcSqLVDIF
         U5iViPOUcAW9Zb9A5rQWzXKe+dhjwkakV90AhK0MTcdunVyA8eCR35+X77yKt8KmshEl
         NI0GQlKPnTvwiycEts0A+pQZzM2jImnws+c467BQID11h2xo35EGEggD6RllSBRNBSsN
         nSu096LX+Kd9K8LGUkWGEe1jldGJZpc/tFAGUjIrmOORB/js20Dn9Qg+f0NuNFipWvAt
         UjLBswsFylNtFPGblQuo3DaFjdPBNh+LFeGUFs5NKv1uuXxE+vzdWMYpdRcaXdTH8qpt
         MIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aa13zQ7giAP62TWcUaUMtr6UzYCBsQUKHFJYOsGW7SY=;
        b=UGsOCGDO5/vJSxd1qG7emt9RCOW/a98cbu5Qpvz1wVz2pQp+xZyqIJeasFmOT4ArQQ
         VeILxvhdEXkzpE2ftZsLvdfOlnEbTA7OQjis6jQZPUfzohp1bVLFkWZC0jWBLJo/TCtg
         aZ2pFO07boh9adOoF7pi/tMZ1c/9OTJgPWmZBPT6FLE5u5GWO/9r7vI96YL9/3g3AOL+
         a46HPsUjTM2WjqB78hqHzI9+9j9vamS9mcdWxqONXcfBbgITmQPcged3Nt5J9YUNn62x
         AZWl/f8bfs7Y6gkpIH4x7jEXnk2C6QHhkV4bcqMm4oQj2FgYjDDB9vinvDMNhOhBixDm
         QiMg==
X-Gm-Message-State: AOAM533Q8IUYBw+VsvbdXQOUn8JoyISKINktxGmoJNFAlJUs73jnu8YA
        LO0Jhqyxjl/s0iZaWLvrNd8=
X-Google-Smtp-Source: ABdhPJzSYZVwL0MvX4mnQ019vfEPaARvRU1Y//ent/z/wxWPckJyH5OsTY4DN0SVxaqWOrDeEqcLxw==
X-Received: by 2002:a5d:4747:: with SMTP id o7mr6036241wrs.11.1589575664068;
        Fri, 15 May 2020 13:47:44 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r11sm5296211wma.35.2020.05.15.13.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:47:43 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, narmstrong@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: power: meson-ee-pwrc: add support for Meson8/8b/8m2
Date:   Fri, 15 May 2020 22:47:06 +0200
Message-Id: <20200515204709.1505498-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515204709.1505498-1-martin.blumenstingl@googlemail.com>
References: <20200515204709.1505498-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power domains on the 32-bit Meson8/Meson8b/Meson8m2 SoCs are very
similar to what G12A still uses. The (known) differences are:
- Meson8 doesn't use any reset lines at all
- Meson8b and Meson8m2 use the same reset lines, which are different
  from what the 64-bit SoCs use
- there is no "vapb" clock on the older SoCs
- amlogic,ao-sysctrl cannot point to the whole AO sysctrl region but
  only the power management related registers

Add a new compatible string and adjust clock and reset line expectations
for each SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 74 +++++++++++++++----
 include/dt-bindings/power/meson8-power.h      | 13 ++++
 2 files changed, 72 insertions(+), 15 deletions(-)
 create mode 100644 include/dt-bindings/power/meson8-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index 6c6079fe1351..2a1c933ae434 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -23,13 +23,19 @@ description: |+
 properties:
   compatible:
     enum:
+      - amlogic,meson8-pwrc
+      - amlogic,meson8b-pwrc
+      - amlogic,meson8m2-pwrc
       - amlogic,meson-g12a-pwrc
       - amlogic,meson-sm1-pwrc
 
   clocks:
-    minItems: 2
+    minItems: 1
+    maxItems: 2
 
   clock-names:
+    minItems: 1
+    maxItems: 2
     items:
       - const: vpu
       - const: vapb
@@ -38,18 +44,7 @@ properties:
     minItems: 11
 
   reset-names:
-    items:
-      - const: viu
-      - const: venc
-      - const: vcbus
-      - const: bt656
-      - const: rdma
-      - const: venci
-      - const: vencp
-      - const: vdac
-      - const: vdi6
-      - const: vencl
-      - const: vid_lock
+    minItems: 11
 
   "#power-domain-cells":
     const: 1
@@ -59,12 +54,61 @@ properties:
     allOf:
       - $ref: /schemas/types.yaml#/definitions/phandle
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson8b-pwrc
+            - amlogic,meson8m2-pwrc
+    then:
+      properties:
+        reset-names:
+          items:
+            - const: dblk
+            - const: pic_dc
+            - const: hdmi_apb
+            - const: hdmi_system
+            - const: venci
+            - const: vencp
+            - const: vdac
+            - const: vencl
+            - const: viu
+            - const: venc
+            - const: rdma
+      required:
+        - resets
+        - reset-names
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-g12a-pwrc
+            - amlogic,meson-sm1-pwrc
+    then:
+      properties:
+        reset-names:
+          items:
+            - const: viu
+            - const: venc
+            - const: vcbus
+            - const: bt656
+            - const: rdma
+            - const: venci
+            - const: vencp
+            - const: vdac
+            - const: vdi6
+            - const: vencl
+            - const: vid_lock
+      required:
+        - resets
+        - reset-names
+
 required:
   - compatible
   - clocks
   - clock-names
-  - resets
-  - reset-names
   - "#power-domain-cells"
   - amlogic,ao-sysctrl
 
diff --git a/include/dt-bindings/power/meson8-power.h b/include/dt-bindings/power/meson8-power.h
new file mode 100644
index 000000000000..dd8b2ddb82a7
--- /dev/null
+++ b/include/dt-bindings/power/meson8-power.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2019 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON8_POWER_H
+#define _DT_BINDINGS_MESON8_POWER_H
+
+#define PWRC_MESON8_VPU_ID			0
+#define PWRC_MESON8_ETHERNET_MEM_ID		1
+#define PWRC_MESON8_AUDIO_DSP_MEM_ID		2
+
+#endif /* _DT_BINDINGS_MESON8_POWER_H */
-- 
2.26.2

