Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCBFC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8408920795
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="duGjMiYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgIDQRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgIDQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:17:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CE6C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:17:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l9so6599597wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWk3qVSr7VGifs60LnXL8P2UIqTUMmu89eotjh18HA8=;
        b=duGjMiYDurbAFlsmF2zT3FDS+RxxrgtsawWMtijuXHwZK+Fo1alN7hoZhK4btSdefi
         yvoKS6N4sdY/6xk5ExFmo0Vbijv6Mjv6LzTGDOmxl+RqLLK/A4Es/1fbDI33lDN3myG/
         wufHWYj+8Ts08o6j3WmVcYNI6t2S7MOQfE0lVISwQHlDwS04j1BDHdWu70jx6sokndeL
         1MF2uZTguxpxMy4JHYyosywABiW6fFeTbBuZPz+fJqNOwSLNdTSfrbV5OQTkwGdmPOCp
         b/jmkP5wrSkomwdY8fJcYp+bxLv9xAXj0A9GX0CeWaQI5w2ZRyvshN1qQLsknyQ4pUWg
         NX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWk3qVSr7VGifs60LnXL8P2UIqTUMmu89eotjh18HA8=;
        b=qUMjX2Lp0cw/kDs6E98yCHusm2cfkLn67ePGxRGiM6vw3iseQNvubgfPke5f1Jv7VD
         2Jn462ornegy1U0ivYQQoAnqcmzI4DNICE770mlYPrP2x92WY0q5nA5Sk2igQHjHouaL
         uHqNx+2HsKulR3HRQKPM0g4ngloMugUimZ58kl4lt11qGOnOo7u0mRoafaYrNgcIF1XV
         0YKdDYLXTATzVediwNlqEaQ+Z1zBP+jOQ9nrT5dEUDYq8+z7n0Z4nD6MQqhWdYvV6dBy
         kcrdIMt92vzhPbQrivw6y3P4F8S5Jh2MGLGUsOIidBes0pjMDoqtctardyZuwLOtKrbe
         FkAw==
X-Gm-Message-State: AOAM533K6RCqPe/lk0SJt5fGOCh0a3AJGgZZJd4lWjGGi/aTsyi8xAfk
        hjFcTBP3djM0q4LGz5+4qu1mFQ==
X-Google-Smtp-Source: ABdhPJzUqXDH+qk0EuubbmJKx2M6DzZGUVc61Fkr0PNo8RNjgbB4iQwbqWcR7WrQTW70j4gqOjXsuA==
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr8525601wmj.33.1599236219600;
        Fri, 04 Sep 2020 09:16:59 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d3sm5129543wrr.84.2020.09.04.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:16:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] dt-bindings: power: amlogic,meson-ee-pwrc: add Amlogic AXG power controller bindings
Date:   Fri,  4 Sep 2020 18:16:53 +0200
Message-Id: <20200904161654.24141-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200904161654.24141-1-narmstrong@baylibre.com>
References: <20200904161654.24141-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the bindings of the Power Controller found in the Amlogic AXG SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 23 +++++++++++++++++--
 include/dt-bindings/power/meson-axg-power.h   | 14 +++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/power/meson-axg-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index 4f524f822e84..d30f85cc395e 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -27,6 +27,7 @@ properties:
       - amlogic,meson8b-pwrc
       - amlogic,meson8m2-pwrc
       - amlogic,meson-gxbb-pwrc
+      - amlogic,meson-axg-pwrc
       - amlogic,meson-g12a-pwrc
       - amlogic,meson-sm1-pwrc
 
@@ -42,11 +43,11 @@ properties:
       - const: vapb
 
   resets:
-    minItems: 11
+    minItems: 5
     maxItems: 12
 
   reset-names:
-    minItems: 11
+    minItems: 5
     maxItems: 12
 
   "#power-domain-cells":
@@ -107,6 +108,24 @@ allOf:
         - resets
         - reset-names
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-axg-pwrc
+    then:
+      properties:
+        reset-names:
+          items:
+            - const: viu
+            - const: venc
+            - const: vcbus
+            - const: vencl
+            - const: vid_lock
+      required:
+        - resets
+        - reset-names
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/power/meson-axg-power.h b/include/dt-bindings/power/meson-axg-power.h
new file mode 100644
index 000000000000..e5243884b249
--- /dev/null
+++ b/include/dt-bindings/power/meson-axg-power.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_AXG_POWER_H
+#define _DT_BINDINGS_MESON_AXG_POWER_H
+
+#define PWRC_AXG_VPU_ID			0
+#define PWRC_AXG_ETHERNET_MEM_ID	1
+#define PWRC_AXG_AUDIO_ID		2
+
+#endif
-- 
2.22.0

