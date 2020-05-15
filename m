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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3275AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028B72070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fBIES9PT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgEOUru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgEOUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:47:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41EAC05BD09;
        Fri, 15 May 2020 13:47:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h17so4976604wrc.8;
        Fri, 15 May 2020 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=io9HbGLfwqw/JzcwD/85WE8s/tU0qrBss8rIvaIKOpk=;
        b=fBIES9PTnZMx1z/RxzfSuNWwOpXwZTYRBdHsnOnp6Dzk9FUD1GsinGLEDgoKJD4Rqm
         QvoMoIa0AtFNiGcQkeQehsC3NgaYv1+fsmcTWxtTF9yrpurAh/ikD3ETeFrTy6moiSSk
         wArDgdue61bERQ7g+xh1HGcnzjy32f6RxRG/929/2lyOCh4vYP1tdX1MbG9oOm6j4Umh
         yHldAT/sPFJWTFVI3IE3q5RQuoXm6dU4QE4kFe5kPkQBeGU9Zs68ojoGChZJwzPi0OeM
         bWvyfc8o51ep+vLxZByXLUBfJdKf0fUS8228Wpmzve4E8w3SvWEAIiRMZfLcwqqcwRRc
         wXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=io9HbGLfwqw/JzcwD/85WE8s/tU0qrBss8rIvaIKOpk=;
        b=mmfzgwl83A3RiTUMn2IoUYj3o01SKSiEGh7R2BS+3d60I/Pa7AKxDuo1PPN4403SIY
         l/P9EAiesyAb6k0GOyV7EjffigkCZeVpex+bc3N+BqzgvsbdqQhfYM9nhyrIrkhbvS3k
         IDvJSaN3Te4Xak320hjZF4btYR+21mSiIKMqHcUt3HQ1kd9cKLH/PMwphWn2S8i3j7v0
         U4dtvCx1j49QjFy5jJvm28hdMWO80cbDkTOC1Ry7gHeXMbKbW995J7PWME6Ko/rp1wjq
         spVax3AwabZIuSdrqnZZ0CmxgkcvWrUevmHjq0cdRyeIo36qjLr7np7UFQtq8JIeqSdH
         hLtQ==
X-Gm-Message-State: AOAM531f4mh/kW9Du5ksjZjLqVy7aberPUu+9TRegfWveqz7QpQPutkH
        fkluXoSDoaPfRDQsoFiD5PY=
X-Google-Smtp-Source: ABdhPJyk88sXvPkIvscfLdPhA3JY+CRiqrjJzM9Orh7xQHTAJbQ/kklPlLugGY4Y9sG/HJ+RwYCsHQ==
X-Received: by 2002:a05:6000:1104:: with SMTP id z4mr6609176wrw.57.1589575665430;
        Fri, 15 May 2020 13:47:45 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r11sm5296211wma.35.2020.05.15.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:47:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, narmstrong@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/4] dt-bindings: power: meson-ee-pwrc: add support for the Meson GX SoCs
Date:   Fri, 15 May 2020 22:47:07 +0200
Message-Id: <20200515204709.1505498-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515204709.1505498-1-martin.blumenstingl@googlemail.com>
References: <20200515204709.1505498-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 28 +++++++++++++++++++
 include/dt-bindings/power/meson-gxbb-power.h  | 13 +++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index 2a1c933ae434..51a6fac892e3 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -26,6 +26,7 @@ properties:
       - amlogic,meson8-pwrc
       - amlogic,meson8b-pwrc
       - amlogic,meson8m2-pwrc
+      - amlogic,meson-gxbb-pwrc
       - amlogic,meson-g12a-pwrc
       - amlogic,meson-sm1-pwrc
 
@@ -42,9 +43,11 @@ properties:
 
   resets:
     minItems: 11
+    maxItems: 12
 
   reset-names:
     minItems: 11
+    maxItems: 12
 
   "#power-domain-cells":
     const: 1
@@ -80,6 +83,31 @@ allOf:
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
2.26.2

