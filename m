Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0BEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9C22078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASf239Qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgHQIKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHQIKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:10:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59259C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d4so7322057pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VinDDjwHMdYpZU5SBzKCUPmBxr02wiZcQyJEfGQA3Hk=;
        b=ASf239Qutr3AaVg6ajl9M1roy35Lg2BY55LgvIRVk3stNqCZ0RNdZQ8rB1MWeQpuOr
         1CyWQGzdbE8u/vf3ZdTpaSZD6G/jfA673kVd9fXDh8+giv5yzIonNMeFqCN5yozOAC0H
         ZPlXVzvjNNZkQpTKm3hNxwpHuQ4prS8ZrVJ0u57tvoD+GLVxcGi+i6Ml4Cecqq8GxDMz
         8tGWcY2fN7lpk80ZR0F04aZjSbPkvhBbLo4rS3nAz8Xw9ISjHd937v/ZhCfJRp/DxrK2
         R3ZNI0fdrBwJ2r8DOU3feZUVevmGNB8kydY7yItKiaDLKwpbgjLgZ5aEU0btZgjhscFG
         dXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VinDDjwHMdYpZU5SBzKCUPmBxr02wiZcQyJEfGQA3Hk=;
        b=GA0UmYR/XsH8WzluinmCGFcFoKzHtuWbCen/UVhq57GNQezeRgfCm/f47XtpqruQGN
         Ys6AM13g2cw/R2bq/7CmNw4wXDCxk3lLDSkcTsWfuaaG0RXpzxTHyhCreWERE7b6tkZH
         62RTX4R4vF66yL/wypcH8xddlDEoHnpa+7fAfPijf9YqcBHBGDiXR8dl1lVHo6FIu6Zu
         ufrGA8jOY8viFUuXFA2nr6r/2jXr0YV+G99lbAWK+8Ep97DDGheaHvUncKKYkzCF+0Gj
         8RFSD9zGvGlODzwtytMqNAp1F2S5jVAXNAhEu4mdgcNtZd/KKWiCT06dUPn+tIaf/LGg
         oCug==
X-Gm-Message-State: AOAM530rG2vI2oz5Y19piba9DvXyQy84JgXzEIWiGZiRnf9vo9I930bL
        EvWog67w/kqUjyyOqPn/C7I=
X-Google-Smtp-Source: ABdhPJy4DCJivBANBKZY38wr+ek1xcFKHklAFMnVdnGJ4OZNvX15Y/fhqzzXlMNpktguFpJb4K3z5g==
X-Received: by 2002:a17:902:6ac4:: with SMTP id i4mr10549314plt.146.1597651834938;
        Mon, 17 Aug 2020 01:10:34 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:34 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, heiko@sntech.de,
        matthias.bgg@gmail.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        inux-mediatek@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 06/19] crypto: ccp: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:28 +0530
Message-Id: <20200817080941.19227-7-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817080941.19227-1-allen.lkml@gmail.com>
References: <20200817080941.19227-1-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/crypto/ccp/ccp-dev-v3.c    | 9 ++++-----
 drivers/crypto/ccp/ccp-dev-v5.c    | 9 ++++-----
 drivers/crypto/ccp/ccp-dmaengine.c | 7 +++----
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-dev-v3.c b/drivers/crypto/ccp/ccp-dev-v3.c
index 0d5576f6ad21..858566867fa3 100644
--- a/drivers/crypto/ccp/ccp-dev-v3.c
+++ b/drivers/crypto/ccp/ccp-dev-v3.c
@@ -321,9 +321,9 @@ static void ccp_enable_queue_interrupts(struct ccp_device *ccp)
 	iowrite32(ccp->qim, ccp->io_regs + IRQ_MASK_REG);
 }
 
-static void ccp_irq_bh(unsigned long data)
+static void ccp_irq_bh(struct tasklet_struct *t)
 {
-	struct ccp_device *ccp = (struct ccp_device *)data;
+	struct ccp_device *ccp = from_tasklet(ccp, t, irq_tasklet);
 	struct ccp_cmd_queue *cmd_q;
 	u32 q_int, status;
 	unsigned int i;
@@ -361,7 +361,7 @@ static irqreturn_t ccp_irq_handler(int irq, void *data)
 	if (ccp->use_tasklet)
 		tasklet_schedule(&ccp->irq_tasklet);
 	else
-		ccp_irq_bh((unsigned long)ccp);
+		ccp_irq_bh(&ccp->irq_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -457,8 +457,7 @@ static int ccp_init(struct ccp_device *ccp)
 
 	/* Initialize the ISR tasklet? */
 	if (ccp->use_tasklet)
-		tasklet_init(&ccp->irq_tasklet, ccp_irq_bh,
-			     (unsigned long)ccp);
+		tasklet_setup(&ccp->irq_tasklet, ccp_irq_bh);
 
 	dev_dbg(dev, "Starting threads...\n");
 	/* Create a kthread for each queue */
diff --git a/drivers/crypto/ccp/ccp-dev-v5.c b/drivers/crypto/ccp/ccp-dev-v5.c
index 7838f63bab32..e68b05a3169b 100644
--- a/drivers/crypto/ccp/ccp-dev-v5.c
+++ b/drivers/crypto/ccp/ccp-dev-v5.c
@@ -733,9 +733,9 @@ static void ccp5_enable_queue_interrupts(struct ccp_device *ccp)
 		iowrite32(SUPPORTED_INTERRUPTS, ccp->cmd_q[i].reg_int_enable);
 }
 
-static void ccp5_irq_bh(unsigned long data)
+static void ccp5_irq_bh(struct tasklet_struct *t)
 {
-	struct ccp_device *ccp = (struct ccp_device *)data;
+	struct ccp_device *ccp = from_tasklet(ccp, t, irq_tasklet);
 	u32 status;
 	unsigned int i;
 
@@ -772,7 +772,7 @@ static irqreturn_t ccp5_irq_handler(int irq, void *data)
 	if (ccp->use_tasklet)
 		tasklet_schedule(&ccp->irq_tasklet);
 	else
-		ccp5_irq_bh((unsigned long)ccp);
+		ccp5_irq_bh(&ccp->irq_tasklet);
 	return IRQ_HANDLED;
 }
 
@@ -894,8 +894,7 @@ static int ccp5_init(struct ccp_device *ccp)
 	}
 	/* Initialize the ISR tasklet */
 	if (ccp->use_tasklet)
-		tasklet_init(&ccp->irq_tasklet, ccp5_irq_bh,
-			     (unsigned long)ccp);
+		tasklet_setup(&ccp->irq_tasklet, ccp5_irq_bh);
 
 	dev_dbg(dev, "Loading LSB map...\n");
 	/* Copy the private LSB mask to the public registers */
diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
index 0770a83bf1a5..a85690866b05 100644
--- a/drivers/crypto/ccp/ccp-dmaengine.c
+++ b/drivers/crypto/ccp/ccp-dmaengine.c
@@ -121,9 +121,9 @@ static void ccp_cleanup_desc_resources(struct ccp_device *ccp,
 	}
 }
 
-static void ccp_do_cleanup(unsigned long data)
+static void ccp_do_cleanup(struct tasklet_struct *t)
 {
-	struct ccp_dma_chan *chan = (struct ccp_dma_chan *)data;
+	struct ccp_dma_chan *chan = from_tasklet(chan, t, cleanup_tasklet);
 	unsigned long flags;
 
 	dev_dbg(chan->ccp->dev, "%s - chan=%s\n", __func__,
@@ -712,8 +712,7 @@ int ccp_dmaengine_register(struct ccp_device *ccp)
 		INIT_LIST_HEAD(&chan->active);
 		INIT_LIST_HEAD(&chan->complete);
 
-		tasklet_init(&chan->cleanup_tasklet, ccp_do_cleanup,
-			     (unsigned long)chan);
+		tasklet_setup(&chan->cleanup_tasklet, ccp_do_cleanup);
 
 		dma_chan->device = dma_dev;
 		dma_cookie_init(dma_chan);
-- 
2.17.1

