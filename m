Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D320EC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BC02078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="o/PiQFqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgDTU1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgDTU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:26:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2615C061A0C;
        Mon, 20 Apr 2020 13:26:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h2so1013048wmb.4;
        Mon, 20 Apr 2020 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnh+McsJx0RoUC/D7GUKGKHfeXKqPCTz0PtdlxFfOB4=;
        b=o/PiQFqksFUYRPMkKFrQgndQGSJI9ciJA357NNeXzTWM8lsoquahb/EEL97Vh+UH2x
         5cTlZIirnZjKLz3ekAkfMfpXBcSccl4hMZbGcyuOlRAkl7ol9DzoVh9o9xxZJH31dxLo
         va3bSTHUakRiApC/nkd6pEKKDqyMyuiXzWxa8p3d2X0YnUcqDzMktzcQGKC7KwSCqtPm
         YhoqjUVq5fCPIIi91mYg72KS5bO407J8/xuqaZ95at7DXw1AEKvioh1gAc4PDviiA64y
         yoqWw+IzQTJFdGQZDMwwYxxYMt21LsfhG+MXDpqeZySPu6Na75Frr7gR/8bRx5gVwYFd
         vmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnh+McsJx0RoUC/D7GUKGKHfeXKqPCTz0PtdlxFfOB4=;
        b=jjB1jfQTPdlTY89p1RL4B9UTiBzHl2KbsFLBZThEqCalbjYGW0P3aNxJtrqE+8uWtX
         loy4nkJNnfx4/A2TIezmBxXs3RDAC6YS3kHXx/aseezg9u/qC6yfbushabkjHp+yFvKj
         dM5x+yr7tqEVbQek/74tocUGkGPtlaYmWni8JfN+Z9KhchJlLONyQH/QfADAveI4ag7+
         HJ5g4GuO3jtN7ZMr6BSZ+FQPjMslryT1FbWJGzCLL5FSTkBwcbwEsZpbBc51lEFWyRc3
         CkctFUZ6Mwy6cFNcsFxqDrLKXTGM2GN/KzLgl9LB1JCLQ1eVdRYeYHlVOTz/HdSuXJ5U
         w3/Q==
X-Gm-Message-State: AGi0PuamwRZd3xkjkjp+SFPPpQIK8Xs2QEPvsAoWr5jLaJUDORGgQAGS
        /StobkOTbnDO6c6pZf2iN4hE50ESrC0=
X-Google-Smtp-Source: APiQypKZQvp7B+IRpQsVNj52BY2L/RrQ0bY8cTNf87BOA6UpV1lzLCYZmUrbDf4YEkV5+FW5fNomog==
X-Received: by 2002:a05:600c:2316:: with SMTP id 22mr1141143wmo.164.1587414384242;
        Mon, 20 Apr 2020 13:26:24 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id l19sm657846wmj.14.2020.04.20.13.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:26:23 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/4] dt-bindings: power: meson-ee-pwrc: add support for Meson8/8b/8m2
Date:   Mon, 20 Apr 2020 22:26:09 +0200
Message-Id: <20200420202612.369370-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420202612.369370-1-martin.blumenstingl@googlemail.com>
References: <20200420202612.369370-1-martin.blumenstingl@googlemail.com>
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
2.26.1

