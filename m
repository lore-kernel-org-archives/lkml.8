Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97860C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6240C2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="plBHmauC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgETPBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:01:35 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56804 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589986893; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=JhyigP6vJLmsxF5F3FTyUVYAcaYZFZ9aUdyQLkCz8+Q=;
        b=plBHmauCTOLW0yzuH1qGg+mtNilkhxHpdMKm8jiCubeYq0pFXAeMAPgEzYD88T3bG7nUZr
        Xd9ft6ee/jn3c1wqmlhANAOjL/94mDmihLxGbCZFsb5BMXRyT3iPD8QABvhlenqVF1LYlb
        AJvJSqJMIH+sIv3/7egv4Ykw4doBu3k=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] usb: musb: jz4740: Prevent lockup when CONFIG_SMP is set
Date:   Wed, 20 May 2020 17:01:11 +0200
Message-Id: <20200520150111.76658-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dma_controller_irq() locks up the exact same spinlock we
locked before calling it, which obviously resulted in a deadlock when
CONFIG_SMP was enabled. This flew under the radar as none of the boards
supported by this driver needs SMP.

Fixes: 57aadb46bd63 ("usb: musb: jz4740: Add support for DMA")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/jz4740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 54e7b30acc69..42c1e8bfc4be 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -69,11 +69,11 @@ static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 	irqreturn_t	retval = IRQ_NONE, retval_dma = IRQ_NONE;
 	struct musb	*musb = __hci;
 
-	spin_lock_irqsave(&musb->lock, flags);
-
 	if (IS_ENABLED(CONFIG_USB_INVENTRA_DMA) && musb->dma_controller)
 		retval_dma = dma_controller_irq(irq, musb->dma_controller);
 
+	spin_lock_irqsave(&musb->lock, flags);
+
 	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
 	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
 	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
-- 
2.26.2

