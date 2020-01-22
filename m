Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21411C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AAE2467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685687;
	bh=OYHLdzTv6DuN+cQWgdk2ujfLcH7pBy3HLUC/selvCJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XRk5gJwtUnZulCgDQOCUZ16loiVytxTQ5Xhy26IdH5YS3y9TmgKApX/jH05Fxqxqm
	 DxfmQzu79MUgfz3Z+7cZFJ9Qjcr82ppXsF7+ljoPeyQ+lFOYoBlcwT39MO6E3aOYZp
	 7OnsdlS2Va7wV8ArXra/ITKJgF2s0thnUS5ZMVQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgAVJeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730959AbgAVJen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:34:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAE82467B;
        Wed, 22 Jan 2020 09:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685682;
        bh=OYHLdzTv6DuN+cQWgdk2ujfLcH7pBy3HLUC/selvCJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZ4oC94EP+Bpu8nfhLtADzqRZ8+GH92ICpLol4EKI7d0vzJH7gEJxuRL+2G21meh8
         kNfyBsuNhPHT3TMCtLgRBZftf2dk7LTWPbnu1jgVgHEIHZqsrKh2tcEjIYqjVlN17T
         VwO6/+9exfFcX8Fmyn8Ip45QrT0yyi/c37NJuK3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4.9 36/97] tty: serial: pch_uart: correct usage of dma_unmap_sg
Date:   Wed, 22 Jan 2020 10:28:40 +0100
Message-Id: <20200122092802.330819958@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 74887542fdcc92ad06a48c0cca17cdf09fc8aa00 upstream.

Per Documentation/DMA-API-HOWTO.txt,
To unmap a scatterlist, just call:
	dma_unmap_sg(dev, sglist, nents, direction);

.. note::

	The 'nents' argument to the dma_unmap_sg call must be
	the _same_ one you passed into the dma_map_sg call,
	it should _NOT_ be the 'count' value _returned_ from the
	dma_map_sg call.

However in the driver, priv->nent is directly assigned with value
returned from dma_map_sg, and dma_unmap_sg use priv->nent for unmap,
this breaks the API usage.

So introduce a new entry orig_nent to remember 'nents'.

Fixes: da3564ee027e ("pch_uart: add multi-scatter processing")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/1573623259-6339-1-git-send-email-peng.fan@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/pch_uart.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -252,6 +252,7 @@ struct eg20t_port {
 	struct dma_chan			*chan_rx;
 	struct scatterlist		*sg_tx_p;
 	int				nent;
+	int				orig_nent;
 	struct scatterlist		sg_rx;
 	int				tx_dma_use;
 	void				*rx_buf_virt;
@@ -806,9 +807,10 @@ static void pch_dma_tx_complete(void *ar
 	}
 	xmit->tail &= UART_XMIT_SIZE - 1;
 	async_tx_ack(priv->desc_tx);
-	dma_unmap_sg(port->dev, sg, priv->nent, DMA_TO_DEVICE);
+	dma_unmap_sg(port->dev, sg, priv->orig_nent, DMA_TO_DEVICE);
 	priv->tx_dma_use = 0;
 	priv->nent = 0;
+	priv->orig_nent = 0;
 	kfree(priv->sg_tx_p);
 	pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_TX_INT);
 }
@@ -1033,6 +1035,7 @@ static unsigned int dma_handle_tx(struct
 		dev_err(priv->port.dev, "%s:dma_map_sg Failed\n", __func__);
 		return 0;
 	}
+	priv->orig_nent = num;
 	priv->nent = nent;
 
 	for (i = 0; i < nent; i++, sg++) {


