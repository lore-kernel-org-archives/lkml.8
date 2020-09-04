Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C25C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541FF2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BXn6l57w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgIDQFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0714EC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:05:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so7302436wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWk3qVSr7VGifs60LnXL8P2UIqTUMmu89eotjh18HA8=;
        b=BXn6l57w9qyXVibrJ5jp9i/JzzB7TN9JxbjHYo/O+r526kqzhSOyXk9qmnsnZ5VwMe
         LsRiQI0Y0VNBSFNJWrkazfgBZcWbmixUz/l51Lt2E3jJCypNX2eSBd5+sWTBmj5B9zJ/
         qRkyP0l0ly2ICs/EEymKRhkXWq5mjReaPjxsUdOxPXqmpVT0mPwOSe6EyfXqpcxkNg7r
         WjbTgIXvH07ChtQ5xN43TGsCbvTyXHFsvA8Ubi9hg37LLvvyqnYuj+UvCera7/36RjSc
         ezJ5p7OMWU2lsn3z2IjUn4jp5b0Z8UPgrJUXXH0WY6iY4bYczZjsMZjjXc/Y3uSISCM8
         6mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWk3qVSr7VGifs60LnXL8P2UIqTUMmu89eotjh18HA8=;
        b=sLrooM/1QTIb+xWVU0ZVfx3+2ujx33IgvnMs2PBifKRG/uuj7i2wo6Jm28XBcU8Wl/
         lu8OtosXEMqPUDTD7OAJsDWHQVbNKLADJCSLItNnFlrlccBPIzfPixYI+6j8IuSyn4kP
         jIyso7ZnENxCeaEwnWRqStF6C43GrNGKOuwyx0lYzdOG8OYMTxEUaXfQj9vq5Moz9zfs
         jSjK9k5zJ/NWMxB5Zj2yeD53lE3ZaqS2ECGTy+T/AeD5VSoWftCq6w+PqWKWiDcScflX
         jPo1lydev72omygtskOCDvjGDNHU/3SwMH2JzCgseN4bbLRfqfPeOgyaG01abJdnybKB
         ngFA==
X-Gm-Message-State: AOAM532wzqpsTyeUnfuZii1P8FM/83Itb8srKzDnuKnUZB8fJV2hZOhW
        +Pu18m9NKkqevR2P+hgwHLWU7A==
X-Google-Smtp-Source: ABdhPJyCOtL0gp+SuW6a5ho/NkzYsNKxyg3bl+zCQz5P7ZG/gjzESGsHaNHpYzmDjWXhoLt4yfDN3w==
X-Received: by 2002:adf:eb86:: with SMTP id t6mr1931676wrn.411.1599235503477;
        Fri, 04 Sep 2020 09:05:03 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id o9sm12038486wrw.58.2020.09.04.09.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:05:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: power: amlogic,meson-ee-pwrc: add Amlogic AXG power controller bindings
Date:   Fri,  4 Sep 2020 18:04:59 +0200
Message-Id: <20200904160500.22924-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200904160206.22570-1-narmstrong@baylibre.com>
References: <20200904160206.22570-1-narmstrong@baylibre.com>
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

