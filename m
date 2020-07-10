Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36193C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6A82078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZvMaIi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgGJHm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgGJHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:42:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AF3C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:42:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so4796347wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+AOncTOyKiyuTn+z9vgFWVxiOOP/Vbkgsqc1OQWgTo=;
        b=DZvMaIi/1zqx4BTT1p4cA36/s8skYa2Q1fA9hpzlupCetFiGTB94N05SaGHW33NXv2
         EnthAbu/pUrvTxNuomR4EOezB60PjEHIY0bznzG6uddmDmobUVAW4IP4sF9YGNezQ3m/
         VkIuVF6yQb33usZ9WCz+rNZiSta9K5MBr69Awsi3AOSo4wTXhSiwx3v1ZakZ09px8hLC
         axqVR8dlEzSaz5KAqswUZesWNTujgN7PErjjeyqmP4Oy3XYCQpK4ikp2LdR6b9RY8DPQ
         JYIo/WWRUGlZzdafTpu+26JKDU4TrVc1Fh9niUzUqpEXU4u700TTwysRtwGWW9NZ8TCc
         xcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+AOncTOyKiyuTn+z9vgFWVxiOOP/Vbkgsqc1OQWgTo=;
        b=ob8+CFS84XdPoiV0K3DQeSHxBH2As6DLdH4294tjame+FOpyyK+dLCbepNmdpvBVgn
         QbHVxJ5rJSHFsM5V//IgoAhk0kg7ZO1MqgnDMQTbLF481iQjd6+ZxJiA2aT5tm8TDCoe
         ifoB9OUSu8mG8J5mjI1z+hqDwIuvImptdsgI+R8H2hZWoDdyYoT62KO++7cuQI5/TnzO
         rMZwQRZ4jF+sq1uOatNBN6wbst8YhoqSIounrCAGFsl0XBfGzTQpyH9756xkWWFl+k0b
         NB9SLP26emq2KKU0M9/dgd89zoe2VPQB26PYuIu48spv70OFAo6q+0eQ9hUggddBU7zc
         Pb4Q==
X-Gm-Message-State: AOAM532A/Imuw3Gst7ofgr2YiEz+bKN5VZiD0V+6SmUppOY0AInO3c5L
        s3lNyDu97YpEVCOwUPWPCuRAvO7OpK4=
X-Google-Smtp-Source: ABdhPJzges5pbexyT7tU6s1WoJWZQszHJ53HKcnVVAWTRDzbSkuC0R6MlLDQP9pBymxFWVhqYXuMaQ==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr3800834wmh.130.1594366925820;
        Fri, 10 Jul 2020 00:42:05 -0700 (PDT)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id p17sm7951375wma.47.2020.07.10.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 00:42:05 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/4] drm/etnaviv: add simple moving average (SMA)
Date:   Fri, 10 Jul 2020 09:41:24 +0200
Message-Id: <20200710074143.306787-2-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710074143.306787-1-christian.gmeiner@gmail.com>
References: <20200710074143.306787-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a SMA algorithm inspired by Exponentially weighted moving
average (EWMA) algorithm found in the kernel.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_sma.h | 53 +++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_sma.h

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sma.h b/drivers/gpu/drm/etnaviv/etnaviv_sma.h
new file mode 100644
index 000000000000..81564d5cbdc3
--- /dev/null
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sma.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Etnaviv Project
+ */
+
+#ifndef __ETNAVIV_SMA_H__
+#define __ETNAVIV_SMA_H__
+
+#include <linux/bug.h>
+#include <linux/compiler.h>
+
+/*
+ * Simple moving average (SMA)
+ *
+ * This implements a fixed-size SMA algorithm.
+ *
+ * The first argument to the macro is the name that will be used
+ * for the struct and helper functions.
+ *
+ * The second argument, the samples, expresses how many samples are
+ * used for the SMA algorithm.
+ */
+
+#define DECLARE_SMA(name, _samples) \
+    struct sma_##name { \
+        unsigned long pos; \
+        unsigned long sum; \
+        unsigned long samples[_samples]; \
+    }; \
+    static inline void sma_##name##_init(struct sma_##name *s) \
+    { \
+        BUILD_BUG_ON(!__builtin_constant_p(_samples));	\
+        memset(s, 0, sizeof(struct sma_##name)); \
+    } \
+    static inline unsigned long sma_##name##_read(struct sma_##name *s) \
+    { \
+        BUILD_BUG_ON(!__builtin_constant_p(_samples));	\
+        return s->sum / _samples; \
+    } \
+    static inline void sma_##name##_add(struct sma_##name *s, unsigned long val) \
+    { \
+        unsigned long pos = READ_ONCE(s->pos); \
+        unsigned long sum = READ_ONCE(s->sum); \
+        unsigned long sample = READ_ONCE(s->samples[pos]); \
+      \
+        BUILD_BUG_ON(!__builtin_constant_p(_samples));	\
+      \
+       WRITE_ONCE(s->sum, sum - sample + val); \
+       WRITE_ONCE(s->samples[pos], val); \
+       WRITE_ONCE(s->pos, pos + 1 == _samples ? 0 : pos + 1); \
+    }
+
+#endif /* __ETNAVIV_SMA_H__ */
-- 
2.26.2

