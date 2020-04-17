Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAEDC38A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4194F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X/vV81ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgDQTIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729241AbgDQTIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:08:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF219C061A0C;
        Fri, 17 Apr 2020 12:08:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t14so4234730wrw.12;
        Fri, 17 Apr 2020 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7toYxcHEl8iaWER3ZlC9JRifsVMdDzRalye45CJVzA=;
        b=X/vV81ld6aX8iOfd6EBTWFdYDsUkRAv5VbWiyJLuN2n6qvsyvf+siW7gcPKuFYUZjV
         dINlrbrxg3TldmDOV+osKfVUv4y/jiqMX3o+CVsPft30H3clB+VVpxDmIjbD5RpPoEQq
         vEpLEiVqnmAaSIDcdjM5wMHVNpymJYJW7qpx9RDbY2t8ZUlLM//JDNZ9UaXnRBFafceI
         a9AANq6ofLYjY0CCFNl5Yy18yur4Um7FmgGjIB6/U7thSkDjPMEchUbap8+u9K0f9+8j
         HU1cIBm/dRplGGP2p514mZci0z/naifFDJmTHJVGn9vSKoMA2FuSEWGmLey1QmfWBD84
         xpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7toYxcHEl8iaWER3ZlC9JRifsVMdDzRalye45CJVzA=;
        b=XYG/auamWjIhRUcuFuzDZerihDztzyhl8u4mW54jzNhKYsUWEuh8inCDnY8l3QRbUH
         Ul3OpvduC8Zb8aGC/Iy5oN0zw1lF/B0k/hwILEaQqpbEDhO9D7O53qaYrozYYHGZwRHy
         OcjgziQmEEM5qOU5BClR8SaeCa/ELOaBDAxDmn/IWORzCru8CrnqLH2ulX1THONQPlpK
         F+i7XDgsgkYtJwR/e85oZIb50VUMZ+jZFqZ0dUH6S4NUywKDjePCjY055R4gD2DQf8JS
         6TZJAsQdVhsg8DwcW2S88pxLkZF04a6xXGyoiWIODuzpTtpMAcsBGsAAbH3TbCvMPNHc
         HOFA==
X-Gm-Message-State: AGi0PuY3Yth7qUoo+SHM8EwR/tOL8iaIIjoJR4e4nydrT7z65wjgHiD9
        U4swJ3yThKvusm48KhrcdKs=
X-Google-Smtp-Source: APiQypLiWbVAQam5qXO040+ZMNoB7DJ7i6qLa2IMuFLeKPMH2DWEfFa6GMS2cppkLOnQjdi14lMr4g==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr5267702wrs.32.1587150522537;
        Fri, 17 Apr 2020 12:08:42 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id q17sm8722220wmj.45.2020.04.17.12.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 12:08:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/4] dt-bindings: power: meson-ee-pwrc: add support for Meson8/8b/8m2
Date:   Fri, 17 Apr 2020 21:08:22 +0200
Message-Id: <20200417190825.1363345-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200417190825.1363345-1-martin.blumenstingl@googlemail.com>
References: <20200417190825.1363345-1-martin.blumenstingl@googlemail.com>
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

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 75 ++++++++++++++-----
 include/dt-bindings/power/meson8-power.h      | 13 ++++
 2 files changed, 71 insertions(+), 17 deletions(-)
 create mode 100644 include/dt-bindings/power/meson8-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index 6c6079fe1351..a0e4cf143b9c 100644
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
@@ -37,20 +43,6 @@ properties:
   resets:
     minItems: 11
 
-  reset-names:
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
-
   "#power-domain-cells":
     const: 1
 
@@ -59,12 +51,61 @@ properties:
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
2.26.1

