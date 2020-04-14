Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E927C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5CC2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Gfgg12dE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632898AbgDNUPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2632823AbgDNUPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:15:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9028C061A41;
        Tue, 14 Apr 2020 13:15:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x18so11755975wrq.2;
        Tue, 14 Apr 2020 13:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWakixpL4b6GKDOYVEkla9E7WK5+obuCNXmlgeBSkZw=;
        b=Gfgg12dESrr5raPF106kCihFug8RkS02LF3WFC8y8yUyub5qNgsy8jhBRFB8yGJUwq
         H6JnGAEZiP1FWARU8Yf2MIW1aD+/CyaT9asq7lCkIUTVvRKiR/FRta07Lq509tqOBJ2V
         kuxg+1+fAdkOzISdJpR7QCQMSUm380rpVTD5PY6wOMrHvbtL5Za/WThOxvK2BFqI8kYJ
         9W4FkKygQ5JNZpSKv/2/TswOwuD4ZFj+ZHjTZhRe0oSo4/n107ticI1KQxcHT1zQtLPW
         I8NG/25tYn9NFno9Jc1dx7XSmLXNFimJTuWSnucyvK8QvoqB262tk5110TQvzx0BuiBN
         wIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWakixpL4b6GKDOYVEkla9E7WK5+obuCNXmlgeBSkZw=;
        b=Hq702qqiHMphFiW/TQuOF7IH3LEx/I7FNvycAfXYREdYU8EZEzVhEEBmvig/tNLVuf
         y+an/O+Gs+LIp86kHdj7YnEUlPlvJ3A04RH4ts0pjBY4RpgonKr1JAjRJKu1Wr6rdwkE
         tjChrOviNO6b/it95L3vv2viARa3pNT7O64iq9CFd2UshjX/7qyonYFUBDjJOvK5M6Iw
         GPxdwIIFABBmo1PhrKYDllYG5xDsgm58LZxHtLf+OJsHn6oLYcUB2gfrS8Pw5fm6BxHE
         O8dzylYdlJT6GfvrmhQld+lOl7zySFo97EH2Mg9nhX48oiz9aeJQeGG44blqKVu3ULxq
         +vfg==
X-Gm-Message-State: AGi0PuabWzB0GX3ACkeUEnYVhC3/MZcxmCKAWs0K8eESIfpG0mIAjRpP
        jKXJeJiBaIPfK6SxObZi0g4=
X-Google-Smtp-Source: APiQypKSNPmVFZhEc+zOeADaCFUJ2x4K2vogb8D2QNrNe5wZlqzEYa0jFI6Ht1vr/SkxxxIP2qteow==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr18972068wrr.192.1586895328436;
        Tue, 14 Apr 2020 13:15:28 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id u17sm22537467wra.63.2020.04.14.13.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:15:27 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 1/4] dt-bindings: power: meson-ee-pwrc: add support for Meson8/8b/8m2
Date:   Tue, 14 Apr 2020 22:14:54 +0200
Message-Id: <20200414201457.229131-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414201457.229131-1-martin.blumenstingl@googlemail.com>
References: <20200414201457.229131-1-martin.blumenstingl@googlemail.com>
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
2.26.0

