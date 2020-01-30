Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DA7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69082206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTBz3D2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgA3TKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:10:55 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:54892 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3TKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:10:55 -0500
Received: by mail-pg1-f202.google.com with SMTP id i21so2408755pgm.21
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 11:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8yPZBT02dhU6sVfnDKBlA+jOWpq/2cl2umK0tzNJVBE=;
        b=TTBz3D2SGElhO3Fat076p/PKpoM+esnw2RoZZW7IqnERaNC+LsOCoxl31VSMOECq/7
         NUO5iU/QQFsDkrtOpYjFklMq84NOoKkZwkX53/sV00n9evs5wUOQTCulXCSDe5d0eGRT
         OUIhteEFVGvAUjQlQ6EtFR9LXbt11CV99hkGAufgoUB2OGl2dIU+B6D+p5UNqbdbNqEY
         6bhDCbQd9D/408RXf1hYN2xzKvx0RIkSSW85qYG3SQmN7NwhQZDkRTFQU24NQTjCXIl4
         igUwW6YLZ2zUdfPTDK/uLP4U5aUWukO83hKoGZECLTeMk6pDzuM6h5F2xwv9CumTO/Xf
         Lj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8yPZBT02dhU6sVfnDKBlA+jOWpq/2cl2umK0tzNJVBE=;
        b=COXbZl/8USz55IMy0K4rz+YLpciKkIJI9DRUTOy2Ibt50KVPm7GBN2onrqwxEuWc1A
         BVvBfFPnwcf9OWlq3zxlJx6dkyu/r4UYk4jywmePveu8i9TmgbRDijyIimi1w+jo2uCM
         6vvKzfa19/b5vVX4ioQLPfUTYV95jvBXV1C7RHM3XuR2j6do1YOsGuXTPDXqSX8lsywu
         C3bPPq3szk9xJWg/iSI9Y2CBmxqJI/TscND8Lxm5PWGnLdhOFJvEcpu3FjTQQGhPl80Y
         E5agn0YeKTUUive3qHFUr8FiLKvbFCVUDqC9bCn+enidfzVhkLZL53vMu1T1CzEUnf7K
         ih+w==
X-Gm-Message-State: APjAAAUjMOUqiHO4BDRKK60hXTrE2H9ki964/GX3HjR17990vfVg+iDQ
        J9L/wBHmcJ0ar1Mm3oG8UZkz9pBXKNL1Og==
X-Google-Smtp-Source: APXvYqwShCG6mlMAlaWy7deIQZEwnVXA0kx4PMo46X5AynA4dIPnFzFn6FXwUhqm5k8wHgwEal0unptfi6FFow==
X-Received: by 2002:a63:f5c:: with SMTP id 28mr6397451pgp.348.1580411453063;
 Thu, 30 Jan 2020 11:10:53 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:10:49 -0800
Message-Id: <20200130191049.190569-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] dma-debug: dynamic allocation of hash table
From:   Eric Dumazet <edumazet@google.com>
To:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increasing the size of dma_entry_hash size by 327680 bytes
has reached some bootloaders limitations.

Simply use dynamic allocations instead, and take
this opportunity to increase the hash table to 65536
buckets. Finally my 40Gbit mlx4 NIC can sustain
line rate with CONFIG_DMA_API_DEBUG=y.

Fixes: 5e76f564572b ("dma-debug: increase HASH_SIZE")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/debug.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 2031ed1ad7fa109bb8a8c290bbbc5f825362baba..a310dbb1515e92c081f8f3f9a7290dd5e53fc889 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -27,7 +27,7 @@
 
 #include <asm/sections.h>
 
-#define HASH_SIZE       16384ULL
+#define HASH_SIZE       65536ULL
 #define HASH_FN_SHIFT   13
 #define HASH_FN_MASK    (HASH_SIZE - 1)
 
@@ -90,7 +90,8 @@ struct hash_bucket {
 };
 
 /* Hash list to save the allocated dma addresses */
-static struct hash_bucket dma_entry_hash[HASH_SIZE];
+static struct hash_bucket *dma_entry_hash __read_mostly;
+
 /* List of pre-allocated dma_debug_entry's */
 static LIST_HEAD(free_entries);
 /* Lock for the list above */
@@ -934,6 +935,10 @@ static int dma_debug_init(void)
 	if (global_disable)
 		return 0;
 
+	dma_entry_hash = vmalloc(HASH_SIZE * sizeof(*dma_entry_hash));
+	if (!dma_entry_hash)
+		goto err;
+
 	for (i = 0; i < HASH_SIZE; ++i) {
 		INIT_LIST_HEAD(&dma_entry_hash[i].list);
 		spin_lock_init(&dma_entry_hash[i].lock);
@@ -950,6 +955,7 @@ static int dma_debug_init(void)
 		pr_warn("%d debug entries requested but only %d allocated\n",
 			nr_prealloc_entries, nr_total_entries);
 	} else {
+err:
 		pr_err("debugging out of memory error - disabled\n");
 		global_disable = true;
 
-- 
2.25.0.341.g760bfbb309-goog

