Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D351C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF3120738
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oA245YJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgIHP6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730936AbgIHPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:54:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B8AC061234
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:28:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so732233wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cu6qtzuHSpIxrLwUNTOO8k3jBCZ/URxPEoM+zt5iIyQ=;
        b=oA245YJNIl81sFsge5Skr5CcilojbDrjtgLLDyV/vbCChg+D3qltoBRTQgdfxw5T1N
         tgU+RYRvKRrJAMHe/JizkKIZq/1tBT53uhWEXJxpJEYdxoY2X0Oni6mveRV1YdA7bITT
         IVU8zUdXtv1VHFgQKxB2Im3gseDNqZZLGgymHareitk2LFV9U1xNk7TJi/jj261QZED+
         EHGt+/hqzA6/GL+rZxYatMu9LU+RWXjBIKQubbrFGSinF4SKS2L2Harc9yrkLVm2ITKy
         np/OHFxYVuv+1kmYJCpcLiqhjCfGhESTQXVmJ6gQ4MmpFj+jO6hIgVF/5DMKgw7/Tl6Y
         78Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cu6qtzuHSpIxrLwUNTOO8k3jBCZ/URxPEoM+zt5iIyQ=;
        b=augbbMUKFpC0R2UjYclMXAsUXUsShNC8kryZIk34RykF7etI0WoUIYe92czp5f5jkc
         0m1tHLHYWk1MLjeEuvfS0+1NgQQaSNFgsFqRSTZRBUlz+5KJa5dElTGNmNStQqiSkyfO
         +W6XjyKKOe05ZmHske5GmOdV8V1vSqDPTV++wF0xqei58xbI9yRvwVbJKe+LL8ZLmebc
         lq2namjdRD0GObNxTYOP14GWuXLNke+iQt+FcMOa7UMXE/RvBnofd+lf1soilIku/3O3
         CdeIvHzmR0e/udjhighl6UhNJBjBKgFmR1g1+wDHcWtKEl+MX8N94G7nMoXuWsNwQJLf
         CwdA==
X-Gm-Message-State: AOAM5330SE1Mmpk7IWL3YZH5AqrZdQIHCIvGm+JKiuiL4kJJ6W2EoNTC
        c+2epimPlHcKn2P1XfxwM6ZbvGpLSym5fg==
X-Google-Smtp-Source: ABdhPJxYCfLbCqSpwLjMwHYAhoT2kee8zWH+Wn3HQDgrBioo4CJzH5Ig5tVEm0cDPisJIqvnZRONXQ==
X-Received: by 2002:adf:db43:: with SMTP id f3mr29009759wrj.219.1599571679421;
        Tue, 08 Sep 2020 06:27:59 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y1sm34225387wru.87.2020.09.08.06.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:27:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] nvmem: switch to simpler IDA interface
Date:   Tue,  8 Sep 2020 15:27:55 +0200
Message-Id: <20200908132755.11944-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't need to specify any ranges when allocating IDs so we can switch
to ida_alloc() and ida_free() instead of the ida_simple_ counterparts.

ida_simple_get(ida, 0, 0, gfp) is equivalent to
ida_alloc_range(ida, 0, UINT_MAX, gfp) which is equivalent to
ida_alloc(ida, gfp). Note: IDR will never actually allocate an ID
larger than INT_MAX.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb2eaf6..cd332d711dd1 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -321,7 +321,7 @@ static void nvmem_release(struct device *dev)
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
-	ida_simple_remove(&nvmem_ida, nvmem->id);
+	ida_free(&nvmem_ida, nvmem->id);
 	gpiod_put(nvmem->wp_gpio);
 	kfree(nvmem);
 }
@@ -596,7 +596,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!nvmem)
 		return ERR_PTR(-ENOMEM);
 
-	rval  = ida_simple_get(&nvmem_ida, 0, 0, GFP_KERNEL);
+	rval  = ida_alloc(&nvmem_ida, GFP_KERNEL);
 	if (rval < 0) {
 		kfree(nvmem);
 		return ERR_PTR(rval);
@@ -608,7 +608,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(nvmem->wp_gpio)) {
-		ida_simple_remove(&nvmem_ida, nvmem->id);
+		ida_free(&nvmem_ida, nvmem->id);
 		rval = PTR_ERR(nvmem->wp_gpio);
 		kfree(nvmem);
 		return ERR_PTR(rval);
-- 
2.17.1

