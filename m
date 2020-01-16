Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CC4C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B092073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202540;
	bh=v75bXRMSKTL3NICTqvXximu6+JREaJsiI69ut9tXW18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NywHG2oQFC/+mTbnRwtylCeYc9zaznPFf0wAn+tTzeayzrH8wlXs5PsfptOZDV7sv
	 g7eYbjA6DGFaizxzRcYL8gE/sNmCsl1Jp0zLb/Edqs3AYIcBMkNgkzyiYiYW+JHpEu
	 yp74RVQ/JrZtONSriEmZ0MpN7yt75lKrP4bSreQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgAPQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730774AbgAPQxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:53:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094392176D;
        Thu, 16 Jan 2020 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193600;
        bh=v75bXRMSKTL3NICTqvXximu6+JREaJsiI69ut9tXW18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smcTOp4RAgHBixHFooBJP8ZFA7l8DzLzcr3eW5wUWWcjweUiqmqB22zQDMpHjebTu
         SE4qzyB9MVMxqjYI1Ax7sjBfOk76DK06AqIRWNKX8BcLdS7rzad+wn8Qx0srVw+4Vq
         hXzZsf+GQISr9hEuZfd3RT+usmHGWLSLr8UwZF+0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 139/205] tty: serial: pch_uart: correct usage of dma_unmap_sg
Date:   Thu, 16 Jan 2020 11:41:54 -0500
Message-Id: <20200116164300.6705-139-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 74887542fdcc92ad06a48c0cca17cdf09fc8aa00 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/pch_uart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6157213a8359..c16234bca78f 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -233,6 +233,7 @@ struct eg20t_port {
 	struct dma_chan			*chan_rx;
 	struct scatterlist		*sg_tx_p;
 	int				nent;
+	int				orig_nent;
 	struct scatterlist		sg_rx;
 	int				tx_dma_use;
 	void				*rx_buf_virt;
@@ -787,9 +788,10 @@ static void pch_dma_tx_complete(void *arg)
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
@@ -1010,6 +1012,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 		dev_err(priv->port.dev, "%s:dma_map_sg Failed\n", __func__);
 		return 0;
 	}
+	priv->orig_nent = num;
 	priv->nent = nent;
 
 	for (i = 0; i < nent; i++, sg++) {
-- 
2.20.1

