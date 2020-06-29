Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46442C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CD920672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgIP8sWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbgF2TjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387439AbgF2Thn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489BFC0307B3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:58:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so18623184ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zMZEixiFTF5mevY+VAYJknP06+KYN1owPnfYBfA5mxY=;
        b=fgIP8sWCkgrxJ+mLPRUsnOUtmnT8rWOcMr5mr81MZdDyY8rho2NuX5xFE2H3wesszQ
         mcd1dx0F7G+izOpy6l1Q/1cxspZ9URShXtjWxPEXMgQNHqHh2baD4Zc8YGtdXnmJoGTl
         e0AhQuG8+eQlDwRxuPr/F7eDzV6euJu6nu1qMPZmhw1eGLMdGLg1ivo6v1RuuieZ0k9t
         jo/5HyLQ5hbOEViAErngn2fWTJ/buTp2J3IVsw7h9BqdCYXQfWPBQJbqc+Y4hayqRv8q
         FXjEYb18omFR0bm9d9fNMziFFh/tFowXdaPBVYNfNKDkPgX35VjGEcu/2ojH+eVtcP5J
         5MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zMZEixiFTF5mevY+VAYJknP06+KYN1owPnfYBfA5mxY=;
        b=WyZFZxuH6EJgWHcwNq5eK2dNLwnnkguWBHGwaQDTFwMGGnAQc7qGPi3lkXolxbB1sM
         n2gH1M2rAQ7036Op/SDEFzNKI0apbaoBqeoiEZqAzQzvhhVAruUU46pIv+D06OXeeThN
         63+VXGYkjM0v+2eJJ4Yci1KPpzTHqzJqEL+vHmIp4DfcXUqQPuMoMDgJrFHMB0djUy2d
         MgP2y/SN6OZVUBW4CG7eAYPQJVLXSmIWZB1Ejs4XHTlSTeENnpLUnmBfp4kdUNnfhIDR
         1E0oV+P5LZKHC2v6E37N44rQexPILLkNXssaPkd24LFIqkJ4Zt4eWR1iG+S6YTfx3nIi
         QHkw==
X-Gm-Message-State: AOAM5323ujswx8Cdol2wdXqxNH1NhKxUYxk2gZnFsM/R5LukZ34zWF99
        y4bZGdQgbAjULvw9XE84kjFM7uxjI7Bv6Gulv+/BhUgj3Kw=
X-Google-Smtp-Source: ABdhPJyJa1uJ8nWPgBY1njmJFVf8+PrABb1P8QVxFmDEpUU06Og534cpetWQyyaLbYaEtBrKco73a0FNHHfFhqvuMS8=
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr2178955ljc.141.1593446279815;
 Mon, 29 Jun 2020 08:57:59 -0700 (PDT)
MIME-Version: 1.0
From:   microcai <microcaicai@gmail.com>
Date:   Mon, 29 Jun 2020 23:57:48 +0800
Message-ID: <CAMgqO2y9MYDj6antOaWLBRKU8vGEwqCB-Y1TkXTSWsmsed+W6A@mail.gmail.com>
Subject: [PATCH] spi-nor: Add support for xt25f32b/xt25f128b
To:     tudor.ambarus@microchip.com
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 5e308ec7332d01e84a3a5233f4cb8bd5a00026cf Mon Sep 17 00:00:00 2001
From: microcai <microcaicai@gmail.com>
Date: Mon, 29 Jun 2020 23:36:40 +0800
Subject: [PATCH] spi-nor: Add support for xt25f32b/xt25f128b

The RockPi4b dev board ship with xt25f32b solded. add these ids so the
board's spi flash can be accessed within linux.

Signed-off-by: microcai <microcaicai@gmail.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/xtx.c    | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/xtx.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 653923896205..3f7a52d7fa0b 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -17,6 +17,7 @@ spi-nor-objs += sst.o
 spi-nor-objs += winbond.o
 spi-nor-objs += xilinx.o
 spi-nor-objs += xmc.o
+spi-nor-objs += xtx.o
 obj-$(CONFIG_MTD_SPI_NOR) += spi-nor.o

 obj-$(CONFIG_MTD_SPI_NOR) += controllers/
diff --git a/drivers/mtd/spi-nor/xtx.c b/drivers/mtd/spi-nor/xtx.c
new file mode 100644
index 000000000000..05f2d69401b2
--- /dev/null
+++ b/drivers/mtd/spi-nor/xtx.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005, Intec Automation Inc.
+ * Copyright (C) 2014, Freescale Semiconductor, Inc.
+ */
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static const struct flash_info xtx_parts[] = {
+ /* XTX (Shenzhen Xin Tian Xia Tech) */
+ { "xt25f32b", INFO(0x0b4016, 0, 64 * 1024, 64, SECT_4K) },
+ { "xt25f128b", INFO(0x0b4018, 0, 64 * 1024, 256, SECT_4K) },
+};
+
+const struct spi_nor_manufacturer spi_nor_xtx = {
+ .name = "xtx",
+ .parts = xtx_parts,
+ .nparts = ARRAY_SIZE(xtx_parts),
+};
-- 
2.26.2
