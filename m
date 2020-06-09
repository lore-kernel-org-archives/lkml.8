Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5248C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768C8206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725460;
	bh=ux20pKgxkePOnk5ddRAUhX2YFDl59tK1nunAVPgzEVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nZlLTtyX07RgxolKo6+plKMvi/axBN1OHu7pZV3gjCXX7JKiVAC9d89xNbl3oRvjG
	 bDCsTHHNxTV4WtlsfckeGb8PGgOV9P30y0Ryw/AF0QF4NdZHwil5lfZJ9pqU7lMQqt
	 MgPZxxsqhZhd1dsbdyEB1ag7DVVhSXhRpKbDnYYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbgFIR5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733304AbgFIRzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:55:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7822207ED;
        Tue,  9 Jun 2020 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725350;
        bh=ux20pKgxkePOnk5ddRAUhX2YFDl59tK1nunAVPgzEVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erFtERDNP5tGGIoBpQTUfPEs7p6wkvGBBQLK5N2tbZYPMWr8rPxt08G9Dj/CPtrUe
         qhpoGwvJaIPUkE0TiZfyFsrKksRdOCnk+PesAIQEzkK0aZkqS+3NkQ6oVDPW8iLxqD
         pYafa0N8+m4wxmzfBZzAh5kSjAiNcmHE1LJl3C8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 5.7 12/24] usb: musb: jz4740: Prevent lockup when CONFIG_SMP is set
Date:   Tue,  9 Jun 2020 19:45:43 +0200
Message-Id: <20200609174150.337439033@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174149.255223112@linuxfoundation.org>
References: <20200609174149.255223112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit 685f5f24108a5f3481da70ee75a1b18b9de34257 upstream.

The function dma_controller_irq() locks up the exact same spinlock we
locked before calling it, which obviously resulted in a deadlock when
CONFIG_SMP was enabled. This flew under the radar as none of the boards
supported by this driver needs SMP.

Fixes: 57aadb46bd63 ("usb: musb: jz4740: Add support for DMA")

Cc: stable@vger.kernel.org
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Bin Liu <b-liu@ti.com>
Link: https://lore.kernel.org/r/20200525025049.3400-6-b-liu@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/jz4740.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -30,11 +30,11 @@ static irqreturn_t jz4740_musb_interrupt
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


