Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AB6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650E9207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcCbx+W4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGJHmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgGJHmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:42:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BF7C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:42:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so4910347wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3mceKfuwvPXw4LfrpyxKXBpFo3LdMDItWoA8IgjhJzM=;
        b=mcCbx+W49m9LaQeY0TxVhVcgEjnTx9nW3d/ss0DtdCpyvY5Bnn3B+a48gtIEgI1DO7
         xy3lDOplcyTNmxpEJQxl43FBedxE77A0ZEdrT4ViB/RLPNL3QdcjVMUd0MvCt96UwBtu
         KyAzuiK3G9jaO+AELzbhxfAL/JutZ4D6DKSFC1m1Oq3KduZQ9eb1UWO033iu7tst9GHV
         lBaWo5FBQFw1zBtHncb3h9E9hd5OzNgtDMxrzX+751hygtFm7sxCD5LQHJwVYlrs+YlA
         XYq8K2dE3z5rQOCpLQYmYbRR1XOw7VrNqMeAaqupZefrDwAtF5NPhCHXXLFrL4dZKRxo
         bMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3mceKfuwvPXw4LfrpyxKXBpFo3LdMDItWoA8IgjhJzM=;
        b=T32lPYIXlz4Plbo4GqqN36W56xkyFcKlcenGfJdGGFj/0OW4tNeK+qZhJFjJl0XCaP
         2+zAio6Wr+oTutONKy63CcI0Q6cK/w2vP7mNP5glABnNsmsDr5qcd/7V7cBG/ECTm+PH
         HgCjKXHP4AIannc3ieYTDPMVkReRPDXVo5vFYkFEouNCI0O1pebrZGq/WcnoCJQqamXA
         PdMLrSEjWGldU6yqFrCUleitPDKJ/WXx0gO5NL0PlwPt83gxUZYuTI1OChfVkmNpAW9n
         MQtEX0ETLT2Lv3M9s4xkK7Uad+fLRUGZxyqr8GLkWo5g7Z4YQkzDla+DrZrqNSindDIT
         zUsA==
X-Gm-Message-State: AOAM530rDi8JTTn+9QkMwMIxTaIf1YfLj7kuTCWzuMd5RwzbSrngj7dP
        YaBYVqOgtd8XO9jqrILZA+likkVkBBc=
X-Google-Smtp-Source: ABdhPJyOxotx4CP1hcQHbzgM1hkwOyWlgVipkFmV8WlfQG4DDW0G9qoaG6e9fQoF2Rn2zm7qWcBvjw==
X-Received: by 2002:adf:9404:: with SMTP id 4mr64952829wrq.367.1594366930282;
        Fri, 10 Jul 2020 00:42:10 -0700 (PDT)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id p17sm7951375wma.47.2020.07.10.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 00:42:09 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/4] drm/etnaviv: add loadavg accounting
Date:   Fri, 10 Jul 2020 09:41:25 +0200
Message-Id: <20200710074143.306787-3-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710074143.306787-1-christian.gmeiner@gmail.com>
References: <20200710074143.306787-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU has an idle state register where each bit represents the idle
state of a sub-GPU component like FE or TX. Sample this register
every 10ms and calculate a simple moving average over the sub-GPU
component idle states with a total observation time frame of 1s.

This provides us with a percentage based load of each sub-GPU
component.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 14 ++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 32 +++++++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h | 29 ++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index f9afe11c50f0..b31920241c86 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -46,6 +46,19 @@ static void load_gpu(struct drm_device *dev)
 	}
 }
 
+static void unload_gpu(struct drm_device *dev)
+{
+	struct etnaviv_drm_private *priv = dev->dev_private;
+	unsigned int i;
+
+	for (i = 0; i < ETNA_MAX_PIPES; i++) {
+		struct etnaviv_gpu *g = priv->gpu[i];
+
+		if (g)
+			etnaviv_gpu_shutdown(g);
+	}
+}
+
 static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct etnaviv_drm_private *priv = dev->dev_private;
@@ -581,6 +594,7 @@ static void etnaviv_unbind(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct etnaviv_drm_private *priv = drm->dev_private;
 
+	unload_gpu(drm);
 	drm_dev_unregister(drm);
 
 	component_unbind_all(dev, drm);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index a31eeff2b297..1f0eb7e00657 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -714,6 +714,28 @@ static void etnaviv_gpu_hw_init(struct etnaviv_gpu *gpu)
 	gpu_write(gpu, VIVS_HI_INTR_ENBL, ~0U);
 }
 
+static void etnaviv_loadavg_function(struct timer_list *t)
+{
+	struct etnaviv_gpu *gpu = from_timer(gpu, t, loadavg_timer);
+	const u32 idle = gpu_read(gpu, VIVS_HI_IDLE_STATE);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++)
+		if ((idle & etna_idle_module_names[i].bit))
+			sma_loadavg_add(&gpu->loadavg_value[i], 0);
+		else
+			sma_loadavg_add(&gpu->loadavg_value[i], 100);
+
+	spin_lock_bh(&gpu->loadavg_spinlock);
+
+	for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++)
+		gpu->loadavg_percentage[i] = sma_loadavg_read(&gpu->loadavg_value[i]);
+
+	spin_unlock_bh(&gpu->loadavg_spinlock);
+
+	mod_timer(t, jiffies + msecs_to_jiffies(10));
+}
+
 int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 {
 	struct etnaviv_drm_private *priv = gpu->drm->dev_private;
@@ -804,6 +826,10 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	for (i = 0; i < ARRAY_SIZE(gpu->event); i++)
 		complete(&gpu->event_free);
 
+	/* Setup loadavg timer */
+	timer_setup(&gpu->loadavg_timer, etnaviv_loadavg_function, 0);
+	mod_timer(&gpu->loadavg_timer, jiffies + msecs_to_jiffies(10));
+
 	/* Now program the hardware */
 	mutex_lock(&gpu->lock);
 	etnaviv_gpu_hw_init(gpu);
@@ -824,6 +850,11 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	return ret;
 }
 
+void etnaviv_gpu_shutdown(struct etnaviv_gpu *gpu)
+{
+	del_timer(&gpu->loadavg_timer);
+}
+
 #ifdef CONFIG_DEBUG_FS
 struct dma_debug {
 	u32 address[2];
@@ -1762,6 +1793,7 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	gpu->dev = &pdev->dev;
 	mutex_init(&gpu->lock);
 	mutex_init(&gpu->fence_lock);
+	spin_lock_init(&gpu->loadavg_spinlock);
 
 	/* Map registers: */
 	gpu->mmio = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 8ea48697d132..a5b9c89c6744 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -10,6 +10,8 @@
 #include "etnaviv_gem.h"
 #include "etnaviv_mmu.h"
 #include "etnaviv_drv.h"
+#include "etnaviv_sma.h"
+#include "state_hi.xml.h"
 
 struct etnaviv_gem_submit;
 struct etnaviv_vram_mapping;
@@ -91,6 +93,26 @@ struct clk;
 
 #define ETNA_NR_EVENTS 30
 
+DECLARE_SMA(loadavg, 100)
+
+static const struct {
+    const char *name;
+    u32 bit;
+} etna_idle_module_names[] = {
+    { "FE", VIVS_HI_IDLE_STATE_FE },
+    { "DE", VIVS_HI_IDLE_STATE_DE },
+    { "PE", VIVS_HI_IDLE_STATE_PE },
+    { "SH", VIVS_HI_IDLE_STATE_SH },
+    { "PA", VIVS_HI_IDLE_STATE_PA },
+    { "SE", VIVS_HI_IDLE_STATE_SE },
+    { "RA", VIVS_HI_IDLE_STATE_RA },
+    { "TX", VIVS_HI_IDLE_STATE_TX },
+    { "VG", VIVS_HI_IDLE_STATE_VG },
+    { "IM", VIVS_HI_IDLE_STATE_IM },
+    { "FP", VIVS_HI_IDLE_STATE_FP },
+    { "TS", VIVS_HI_IDLE_STATE_TS },
+};
+
 struct etnaviv_gpu {
 	struct drm_device *drm;
 	struct thermal_cooling_device *cooling;
@@ -145,6 +167,12 @@ struct etnaviv_gpu {
 	unsigned int freq_scale;
 	unsigned long base_rate_core;
 	unsigned long base_rate_shader;
+
+	/* Loadavg: */
+	struct timer_list loadavg_timer;
+	spinlock_t loadavg_spinlock;
+	struct sma_loadavg loadavg_value[ARRAY_SIZE(etna_idle_module_names)];
+	unsigned int loadavg_percentage[ARRAY_SIZE(etna_idle_module_names)];
 };
 
 static inline void gpu_write(struct etnaviv_gpu *gpu, u32 reg, u32 data)
@@ -160,6 +188,7 @@ static inline u32 gpu_read(struct etnaviv_gpu *gpu, u32 reg)
 int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value);
 
 int etnaviv_gpu_init(struct etnaviv_gpu *gpu);
+void etnaviv_gpu_shutdown(struct etnaviv_gpu *gpu);
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu);
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.26.2

