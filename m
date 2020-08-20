Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9153BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8CF208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922829;
	bh=9iDkBjyNg4vVbg1GlSkhhNS5EoBVzfow7YBSe+QL4us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kOeo7k90wmXkW4HdiKBGrLgDn/DfUz8GnG9Q1/Egb8pK6omeEmNuEJVNh8PNIa/lo
	 U2GtSDE8YNbvObJZpcBWI9ZkN+vmD6oz6XNqfvQjib3kHKqIY6eQGQt6SZKzvRmIit
	 BFGyF1tB8SHZhq7KyeVCWTeNukhZCt4uykuY6HzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgHTL1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbgHTKGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:06:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18FFF20855;
        Thu, 20 Aug 2020 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917969;
        bh=9iDkBjyNg4vVbg1GlSkhhNS5EoBVzfow7YBSe+QL4us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdH2F5Tvh2EJxFYRaoJ7GLXBvlFKzrvbblrvv/hF1rzraWfz7cYKgNUPXt5bHzRqm
         zdg0MQdXmA+QGpwAsnLhnx0eQOi71e2N61zKaYgr8EBr5QGEN3JgM3kLaWMtb6o3tH
         lRGczfRGxd1nW8f5h0tDIB8wYxRyKX2G3L6MwHBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 196/212] gpu: ipu-v3: image-convert: Combine rotate/no-rotate irq handlers
Date:   Thu, 20 Aug 2020 11:22:49 +0200
Message-Id: <20200820091612.258939813@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Longerbeam <slongerbeam@gmail.com>

[ Upstream commit 0f6245f42ce9b7e4d20f2cda8d5f12b55a44d7d1 ]

Combine the rotate_irq() and norotate_irq() handlers into a single
eof_irq() handler.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 58 +++++++++-----------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index 50b73f3876fb7..098b86eb26d74 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -987,9 +987,10 @@ static irqreturn_t do_irq(struct ipu_image_convert_run *run)
 	return IRQ_WAKE_THREAD;
 }
 
-static irqreturn_t norotate_irq(int irq, void *data)
+static irqreturn_t eof_irq(int irq, void *data)
 {
 	struct ipu_image_convert_chan *chan = data;
+	struct ipu_image_convert_priv *priv = chan->priv;
 	struct ipu_image_convert_ctx *ctx;
 	struct ipu_image_convert_run *run;
 	unsigned long flags;
@@ -1006,45 +1007,26 @@ static irqreturn_t norotate_irq(int irq, void *data)
 
 	ctx = run->ctx;
 
-	if (ipu_rot_mode_is_irt(ctx->rot_mode)) {
-		/* this is a rotation operation, just ignore */
-		spin_unlock_irqrestore(&chan->irqlock, flags);
-		return IRQ_HANDLED;
-	}
-
-	ret = do_irq(run);
-out:
-	spin_unlock_irqrestore(&chan->irqlock, flags);
-	return ret;
-}
-
-static irqreturn_t rotate_irq(int irq, void *data)
-{
-	struct ipu_image_convert_chan *chan = data;
-	struct ipu_image_convert_priv *priv = chan->priv;
-	struct ipu_image_convert_ctx *ctx;
-	struct ipu_image_convert_run *run;
-	unsigned long flags;
-	irqreturn_t ret;
-
-	spin_lock_irqsave(&chan->irqlock, flags);
-
-	/* get current run and its context */
-	run = chan->current_run;
-	if (!run) {
+	if (irq == chan->out_eof_irq) {
+		if (ipu_rot_mode_is_irt(ctx->rot_mode)) {
+			/* this is a rotation op, just ignore */
+			ret = IRQ_HANDLED;
+			goto out;
+		}
+	} else if (irq == chan->rot_out_eof_irq) {
+		if (!ipu_rot_mode_is_irt(ctx->rot_mode)) {
+			/* this was NOT a rotation op, shouldn't happen */
+			dev_err(priv->ipu->dev,
+				"Unexpected rotation interrupt\n");
+			ret = IRQ_HANDLED;
+			goto out;
+		}
+	} else {
+		dev_err(priv->ipu->dev, "Received unknown irq %d\n", irq);
 		ret = IRQ_NONE;
 		goto out;
 	}
 
-	ctx = run->ctx;
-
-	if (!ipu_rot_mode_is_irt(ctx->rot_mode)) {
-		/* this was NOT a rotation operation, shouldn't happen */
-		dev_err(priv->ipu->dev, "Unexpected rotation interrupt\n");
-		spin_unlock_irqrestore(&chan->irqlock, flags);
-		return IRQ_HANDLED;
-	}
-
 	ret = do_irq(run);
 out:
 	spin_unlock_irqrestore(&chan->irqlock, flags);
@@ -1137,7 +1119,7 @@ static int get_ipu_resources(struct ipu_image_convert_chan *chan)
 						  chan->out_chan,
 						  IPU_IRQ_EOF);
 
-	ret = request_threaded_irq(chan->out_eof_irq, norotate_irq, do_bh,
+	ret = request_threaded_irq(chan->out_eof_irq, eof_irq, do_bh,
 				   0, "ipu-ic", chan);
 	if (ret < 0) {
 		dev_err(priv->ipu->dev, "could not acquire irq %d\n",
@@ -1150,7 +1132,7 @@ static int get_ipu_resources(struct ipu_image_convert_chan *chan)
 						     chan->rotation_out_chan,
 						     IPU_IRQ_EOF);
 
-	ret = request_threaded_irq(chan->rot_out_eof_irq, rotate_irq, do_bh,
+	ret = request_threaded_irq(chan->rot_out_eof_irq, eof_irq, do_bh,
 				   0, "ipu-ic", chan);
 	if (ret < 0) {
 		dev_err(priv->ipu->dev, "could not acquire irq %d\n",
-- 
2.25.1



