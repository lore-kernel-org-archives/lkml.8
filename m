Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85834C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62689206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597920632;
	bh=w+0SdTVoLMPTYRA6OvzQc4jKtLLTB9UMSwWPyv85Eoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BurGC6ojdUBYeYt8qwOTi5wU4aTu4duwIjAnOJPITTRhqMxPie/lsdffIxefb5/Tp
	 j4qT6legJH5UC4oYht6e9bWmtF7HrNpVBYylWZ+3URKL0PxIl0H1jUPX34oDuxwrCv
	 Ey3Ux2nkmmJ+r7ib6H+1Dl3/7i60S9rbzKj1rNzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbgHTKu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731242AbgHTKPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:15:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C7A2067C;
        Thu, 20 Aug 2020 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918518;
        bh=w+0SdTVoLMPTYRA6OvzQc4jKtLLTB9UMSwWPyv85Eoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whUv46Z/sQTUVW1OTBmhjrEkVStXgKjSkWQwo0IOqzaBhrc6+UuYf+G3554hUQVd7
         3LeiBeSqQ2SaZCbYAqObjPxs4Cd42unQfs5wIVjjunHoPMUWM8fyvkflddDxqNUlXH
         Q0GYDeOz+f2hTq2HnlKXWGlcRz314bM7d09h45iQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 200/228] gpu: ipu-v3: image-convert: Combine rotate/no-rotate irq handlers
Date:   Thu, 20 Aug 2020 11:22:55 +0200
Message-Id: <20200820091617.546331045@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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
index a5e33d58e02f7..d2f9e65522676 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -992,9 +992,10 @@ static irqreturn_t do_irq(struct ipu_image_convert_run *run)
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
@@ -1011,45 +1012,26 @@ static irqreturn_t norotate_irq(int irq, void *data)
 
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
@@ -1142,7 +1124,7 @@ static int get_ipu_resources(struct ipu_image_convert_chan *chan)
 						  chan->out_chan,
 						  IPU_IRQ_EOF);
 
-	ret = request_threaded_irq(chan->out_eof_irq, norotate_irq, do_bh,
+	ret = request_threaded_irq(chan->out_eof_irq, eof_irq, do_bh,
 				   0, "ipu-ic", chan);
 	if (ret < 0) {
 		dev_err(priv->ipu->dev, "could not acquire irq %d\n",
@@ -1155,7 +1137,7 @@ static int get_ipu_resources(struct ipu_image_convert_chan *chan)
 						     chan->rotation_out_chan,
 						     IPU_IRQ_EOF);
 
-	ret = request_threaded_irq(chan->rot_out_eof_irq, rotate_irq, do_bh,
+	ret = request_threaded_irq(chan->rot_out_eof_irq, eof_irq, do_bh,
 				   0, "ipu-ic", chan);
 	if (ret < 0) {
 		dev_err(priv->ipu->dev, "could not acquire irq %d\n",
-- 
2.25.1



