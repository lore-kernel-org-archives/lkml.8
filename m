Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BF7C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D2420780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CdJFoo8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgDQTIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDQTIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:08:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70E5C061A0F;
        Fri, 17 Apr 2020 12:08:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so3067149wrw.7;
        Fri, 17 Apr 2020 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0n5h0em/Nkh2RKJZHyjjtZ5ecG51J1roeZUvKOcCbPU=;
        b=CdJFoo8xQOIRbA85683Lw5+DGKDpA0LVrzc8RACY32VlWa3C3srqTXMosWANNzpQQq
         gDLJcrkqKOW4zv0yf2zsVsLVXc+9/9APUcBqfHjj3Z1MDY5e+TSk++U1EF756tvmSFuZ
         BLaQpuW8x+mkCwi4vyx1l3tYz4f+uNzRijv6bVC+LRwmjVnrw3b06cpRejtnrfxeY0df
         8g4hAL57lWst3RbypPXYuscsifQUXTEDDe8m4wR+K09bsJ7dhi8p4aH9zWterHZluKDg
         ijHtatg6kPH0GXZlK80S7m1dakMzurDGgcZeogjk1FZ94VCy0PknYTWzNfUXHQsUE7QJ
         Qy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0n5h0em/Nkh2RKJZHyjjtZ5ecG51J1roeZUvKOcCbPU=;
        b=V++Co6uB8oC1Jd4UvP85AtbzsuB+1v8WP/K4eNDZ3CqON190bm5fcHiI5Buvwm6Gis
         70ySgT4+84g6nxYPYNmJpoFQzoB1hp2/8KX2Eu6c4VDA0uyHqW4XNArcuOi3kTfd05LZ
         Yxj85WXQ6ihTftRkhO99GlAq3o9uGLBpqJrEPmFZOUaD34kR750LUZywYKHebzzJcukj
         Ni9yv5NXH05lK8BCOjZC7pnf0mC7g2Jl/gbr4VTLCO3WRXhENt1B/8oKZe9vPzCi15RA
         qCIpDJHcZCyGaBNCRLtUbp1HgL/yAuE/8HyrWWUi1XJzMXCQRVBRixUhkp0yUq9C5Gyb
         RSZA==
X-Gm-Message-State: AGi0PuZRs7KfQKK8Cpb+j8BmB0syFqvQ61cMQCynLcY3YNU49dXgPlJF
        /ofGytW4Gwgr+zNWubwPZrI=
X-Google-Smtp-Source: APiQypIFsvMSQP73dHqTXb7Xph+RtyVZSYMy9XHKo8uXqdgr54fAj+ozLVMozg+o08rkh4y0ch6EZg==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr6000656wrn.56.1587150523506;
        Fri, 17 Apr 2020 12:08:43 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id q17sm8722220wmj.45.2020.04.17.12.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 12:08:43 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/4] dt-bindings: power: meson-ee-pwrc: add support for the Meson GX SoCs
Date:   Fri, 17 Apr 2020 21:08:23 +0200
Message-Id: <20200417190825.1363345-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200417190825.1363345-1-martin.blumenstingl@googlemail.com>
References: <20200417190825.1363345-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power domains on the GX SoCs are very similar to G12A. The only
known differences so far are:
- The GX SoCs do not have the HHI_VPU_MEM_PD_REG2 register (for the
  VPU power-domain)
- The GX SoCs have an additional reset line called "dvin"

Add a new compatible string and adjust the reset line expectations for
these SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 27 +++++++++++++++++++
 include/dt-bindings/power/meson-gxbb-power.h  | 13 +++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index a0e4cf143b9c..15a29ed19327 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -26,6 +26,7 @@ properties:
       - amlogic,meson8-pwrc
       - amlogic,meson8b-pwrc
       - amlogic,meson8m2-pwrc
+      - amlogic,meson-gxbb-pwrc
       - amlogic,meson-g12a-pwrc
       - amlogic,meson-sm1-pwrc
 
@@ -42,6 +43,7 @@ properties:
 
   resets:
     minItems: 11
+    maxItems: 12
 
   "#power-domain-cells":
     const: 1
@@ -77,6 +79,31 @@ allOf:
         - resets
         - reset-names
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gxbb-pwrc
+    then:
+      properties:
+        reset-names:
+          items:
+            - const: viu
+            - const: venc
+            - const: vcbus
+            - const: bt656
+            - const: dvin
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
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/power/meson-gxbb-power.h b/include/dt-bindings/power/meson-gxbb-power.h
new file mode 100644
index 000000000000..1262dac696c0
--- /dev/null
+++ b/include/dt-bindings/power/meson-gxbb-power.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_GXBB_POWER_H
+#define _DT_BINDINGS_MESON_GXBB_POWER_H
+
+#define PWRC_GXBB_VPU_ID		0
+#define PWRC_GXBB_ETHERNET_MEM_ID	1
+
+#endif
-- 
2.26.1

