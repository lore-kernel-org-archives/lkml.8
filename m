Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79447C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D0B20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ptX7rsY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgE0QRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgE0QRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:17:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD6BC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:17:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t18so10540672wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSgUFPU/lmBJj5c376kcW/aHDA5eHqQfL3OqaeYjnYo=;
        b=ptX7rsY0ZtKBP9iNOKmKbnieslpshoIG/AuK/vjmExfbtz91dlVxapurUhIt8TSL2m
         HToH7PGQncAnPCXVB22Wt5lTZpNNph3feLKP7ck5Hlsc3UkBkIjPa9ik8UcCQqzUbJ+/
         9rLZ+0kpIxzsVKEkFdZGSFY8PWDa0fEm5/nUjbSrO9CCHUYyzjBzFpPrYv4Fedkfg9sf
         p55JFi3GQ9zxbfrNcP0trL1zs+e7Fk5JpTrCGS3yt/tc4gONsA1umQxkFTirQM9YNDg2
         dmgNSyiytQQCRM4GcZhEM+6u74vyWbyZ0VnrSZ8+iN6AJ33YV/9sD8BiZecdK1u1ceNy
         OOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSgUFPU/lmBJj5c376kcW/aHDA5eHqQfL3OqaeYjnYo=;
        b=GN6RYmWCB2HFNU/uTKlljUeCt4wI2VGmPHhLUufzU+ydKy8no96jN8bKGRWXhluinA
         83+V8hjXy2tHFdbs3xbvFzS07d6XGLYxLO0WzVk0S3amLolPVisFlh0qiSkMBTwM09mD
         D692rOq/tbvaKYRBrIsQM4gmBkiFGlH/l+HhIIpmR+kOTA0FWn82Sd8+flBls1aJsu5R
         e04OsshTCd/37zq3dIF68iT9N3XKoUgB7J+rFbE7+E4EW7wvirFHn2NwH7XM2vkBX+Bc
         VMpM40AEa/SQq0rCqZGmfn0Tz+KjB2AYpaXZ+hzIbO3k9BpzGlilKMbQUMqwFifNa0HA
         Wb6g==
X-Gm-Message-State: AOAM531yMceLrOffvy8s6nX/BP1Tuuai/aX8+Af81JXUupXI6rs+guL3
        O6qrYe0VvoSJMqb1R2rDYJK6yw==
X-Google-Smtp-Source: ABdhPJwkfI8vfcy2wHmTP3rC760TSjRdMUEuJibRF0yfB2ObnbADS8LUP77SQMPqRpunP/H6g3ssJg==
X-Received: by 2002:adf:e751:: with SMTP id c17mr10340714wrn.134.1590596271251;
        Wed, 27 May 2020 09:17:51 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id w12sm3364038wmk.12.2020.05.27.09.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:17:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] irqchip/irq-mtk-sysirq: drop unnecessary spinlock
Date:   Wed, 27 May 2020 18:17:43 +0200
Message-Id: <20200527161743.15972-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver takes a regular spinlock when a raw spinlock is already
taken which results in the following lockdep splat:

=============================
[ BUG: Invalid wait context ]
5.7.0-rc6-02446-gb9827c0a9fe7-dirty #1 Not tainted
-----------------------------
swapper/0/0 is trying to lock:
ffffff800303b798 (&chip_data->lock){....}-{3:3}, at: mtk_sysirq_set_type+0x48/0xc0
other info that might help us debug this:
context-{5:5}
2 locks held by swapper/0/0:
 #0: ffffff800302ee68 (&desc->request_mutex){....}-{4:4}, at: __setup_irq+0xc4/0x8a0
 #1: ffffff800302ecf0 (&irq_desc_lock_class){....}-{2:2}, at: __setup_irq+0xe4/0x8a0
stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc6-02446-gb9827c0a9fe7-dirty #1
Hardware name: Pumpkin MT8516 (DT)
Call trace:
 dump_backtrace+0x0/0x180
 show_stack+0x14/0x20
 dump_stack+0xd0/0x118
 __lock_acquire+0x8c8/0x2270
 lock_acquire+0xf8/0x470
 _raw_spin_lock_irqsave+0x50/0x78
 mtk_sysirq_set_type+0x48/0xc0
 __irq_set_trigger+0x58/0x170
 __setup_irq+0x420/0x8a0
 request_threaded_irq+0xd8/0x190
 timer_of_init+0x1e8/0x2c4
 mtk_gpt_init+0x5c/0x1dc
 timer_probe+0x74/0xf4
 time_init+0x14/0x44
 start_kernel+0x394/0x4f0

We don't need the spinlock here - the irq_set_type() callback is always
called with the irq_desc->lock taken. This removes the spinlock entirely.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/irqchip/irq-mtk-sysirq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 73eae5966a40..da2fc4809222 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -12,10 +12,8 @@
 #include <linux/of_address.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 
 struct mtk_sysirq_chip_data {
-	spinlock_t lock;
 	u32 nr_intpol_bases;
 	void __iomem **intpol_bases;
 	u32 *intpol_words;
@@ -30,14 +28,12 @@ static int mtk_sysirq_set_type(struct irq_data *data, unsigned int type)
 	u8 intpol_idx = chip_data->intpol_idx[hwirq];
 	void __iomem *base;
 	u32 offset, reg_index, value;
-	unsigned long flags;
 	int ret;
 
 	base = chip_data->intpol_bases[intpol_idx];
 	reg_index = chip_data->which_word[hwirq];
 	offset = hwirq & 0x1f;
 
-	spin_lock_irqsave(&chip_data->lock, flags);
 	value = readl_relaxed(base + reg_index * 4);
 	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_EDGE_FALLING) {
 		if (type == IRQ_TYPE_LEVEL_LOW)
@@ -53,7 +49,6 @@ static int mtk_sysirq_set_type(struct irq_data *data, unsigned int type)
 
 	data = data->parent_data;
 	ret = data->chip->irq_set_type(data, type);
-	spin_unlock_irqrestore(&chip_data->lock, flags);
 	return ret;
 }
 
@@ -212,7 +207,6 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 		ret = -ENOMEM;
 		goto out_free_which_word;
 	}
-	spin_lock_init(&chip_data->lock);
 
 	return 0;
 
-- 
2.25.0

