Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66DDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8397C2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ngWpM4Vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgFOHoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:44:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE00AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:44:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p5so15958320wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLML/7CffDFBhoqwyzC9IFFqzUtN0PnXKPbU0+WecW8=;
        b=ngWpM4Vd5ByUkX1bUWebKGgG0vYWezYAT7vWvhgdaTo8IBZujJgVraWXo6Ox6Yb/+9
         cR5YyPmPnGK45v6sM/dK+T+hW3FTrjwS10sazaftNflzQNQFOABhYSmVSimImmg7Euyf
         NWVYY4ypkR2JseWN9ChtJP2Zy7FLfsT19Qf0ZhjPbmHYo5yH0kRts0nNcfii4NqLMQfR
         V0ShmXbG7Hr4Fn6EETdOiX0bcZ9x7AHb8xGgXyVHxF7rsg+vYDrbgjynUJQAntcaQYal
         CY/a/rom9ousRJ9Z25dSmcaGbQViMd2DjSbRFsfm6lLnvb+dsVxLdfbwJedlIfVqAzC/
         sDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLML/7CffDFBhoqwyzC9IFFqzUtN0PnXKPbU0+WecW8=;
        b=jU055WTpF5yUdsLOX0CUp9q6lLnXEW+nH58c9S4u5gmxmo1AJQ4wFVuD67be6ISsOs
         OPPVE8VygQEQCB1A7CCre/ayfK3wo0ixTPP9hXiH4QXR2WHs755zdH2FQDdasln+28An
         W2Lva9IXx86Jrge7T8UlddXhkgKxtmAQicPLBcZKztwW6UyFtPsY8648bZBzw/iFzLBE
         AYQkpaBUQF+Q0O4s5VpMsHhwcwr6w8L2j+IsPqWY34SwVgkPR1tjnerMb0shRwo21FWM
         UvCVmrRtNAiDyx+4xnX9/HvCm3wHOhxSi8QDpGIDx/r9XeBerx8DhX+eWkKjBpUn5VHp
         g2eQ==
X-Gm-Message-State: AOAM531+uxvLvOeteYjffcZsv0cnvvI7t1V8RckcgKak/nLNqbp/7Rlc
        hbc4emzvX8nBjSbfHLhGwcxRIQ==
X-Google-Smtp-Source: ABdhPJw4+6gHE62n11a4DToU9lNCniCgkvi+x33BOd94wC0+HgPDvk1KRFmpSkPOQNQpytwNGESEAg==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr29528478wrt.219.1592207089789;
        Mon, 15 Jun 2020 00:44:49 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id z16sm23227610wrm.70.2020.06.15.00.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 00:44:49 -0700 (PDT)
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
Subject: [RESEND PATCH] irqchip/irq-mtk-sysirq: replace spinlock with raw_spinlock
Date:   Mon, 15 Jun 2020 09:44:45 +0200
Message-Id: <20200615074445.3579-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver may take a regular spinlock when a raw spinlock
(irq_desc->lock) is already taken which results in the following
lockdep splat:

=============================
[ BUG: Invalid wait context ]
5.7.0-rc7 #1 Not tainted
-----------------------------
swapper/0/0 is trying to lock:
ffffff800303b798 (&chip_data->lock){....}-{3:3}, at: mtk_sysirq_set_type+0x48/0xc0
other info that might help us debug this:
context-{5:5}
2 locks held by swapper/0/0:
 #0: ffffff800302ee68 (&desc->request_mutex){....}-{4:4}, at: __setup_irq+0xc4/0x8a0
 #1: ffffff800302ecf0 (&irq_desc_lock_class){....}-{2:2}, at: __setup_irq+0xe4/0x8a0
stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc7 #1
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

Replace the spinlock_t with raw_spinlock_t to avoid this warning.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
Rebased on top of v5.8-rc1.

 drivers/irqchip/irq-mtk-sysirq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 73eae5966a40..6ff98b87e5c0 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -15,7 +15,7 @@
 #include <linux/spinlock.h>
 
 struct mtk_sysirq_chip_data {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	u32 nr_intpol_bases;
 	void __iomem **intpol_bases;
 	u32 *intpol_words;
@@ -37,7 +37,7 @@ static int mtk_sysirq_set_type(struct irq_data *data, unsigned int type)
 	reg_index = chip_data->which_word[hwirq];
 	offset = hwirq & 0x1f;
 
-	spin_lock_irqsave(&chip_data->lock, flags);
+	raw_spin_lock_irqsave(&chip_data->lock, flags);
 	value = readl_relaxed(base + reg_index * 4);
 	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_EDGE_FALLING) {
 		if (type == IRQ_TYPE_LEVEL_LOW)
@@ -53,7 +53,7 @@ static int mtk_sysirq_set_type(struct irq_data *data, unsigned int type)
 
 	data = data->parent_data;
 	ret = data->chip->irq_set_type(data, type);
-	spin_unlock_irqrestore(&chip_data->lock, flags);
+	raw_spin_unlock_irqrestore(&chip_data->lock, flags);
 	return ret;
 }
 
@@ -212,7 +212,7 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 		ret = -ENOMEM;
 		goto out_free_which_word;
 	}
-	spin_lock_init(&chip_data->lock);
+	raw_spin_lock_init(&chip_data->lock);
 
 	return 0;
 
-- 
2.26.1

