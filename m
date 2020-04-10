Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EDFC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01BE20936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586491318;
	bh=+tVkHlpjfi2FdI+R1g0HWl2/qGo+Rc7EYvcZTCZ7d7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fEWk6uMVxBthVnAarNAkAN7AkOn8pQ8bbKD9zaoQ6qKLn58IPrvxlkD0KGT0EIgF+
	 K0SDY45IHJlpAfPX84JjdG4WbIV7DhXHTs5PopGS7Tl2pvBP76MtEQpXS1QcXVu+N9
	 PjIrqJ7ijGVB+hSNjU6NeLliABm5yWL/rRd/cX2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDJDrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgDJDrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:47:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A8520BED;
        Fri, 10 Apr 2020 03:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490433;
        bh=+tVkHlpjfi2FdI+R1g0HWl2/qGo+Rc7EYvcZTCZ7d7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bg9zWVPicCxtiTN/SNm92ks+W3ZU3tyWYNd1YqTK8YYrsvsyCaUtxUJF00jgRtYcK
         QFf3r0YcXDPKIxTATbMMtlG1cj54iZGVzj/QvfqLO+nibHu2mePdSLgUPfO90VAg0B
         wUr3NkYEYaMZt3YmFJd/wpalvzBEpEM9ytlXZTTY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 31/68] spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA mode
Date:   Thu,  9 Apr 2020 23:45:56 -0400
Message-Id: <20200410034634.7731-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 3d6224e63be39ff26cf416492cb3923cd3d07dd0 ]

The driver does not create the dspi->dma structure unless operating in
DSPI_DMA_MODE, so it makes sense to check for that.

Fixes: f4b323905d8b ("spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20200318001603.9650-8-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6ec2dcb8c57a6..2ce65edf16b66 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1021,8 +1021,10 @@ static int dspi_slave_abort(struct spi_master *master)
 	 * Terminate all pending DMA transactions for the SPI working
 	 * in SLAVE mode.
 	 */
-	dmaengine_terminate_sync(dspi->dma->chan_rx);
-	dmaengine_terminate_sync(dspi->dma->chan_tx);
+	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
+		dmaengine_terminate_sync(dspi->dma->chan_rx);
+		dmaengine_terminate_sync(dspi->dma->chan_tx);
+	}
 
 	/* Clear the internal DSPI RX and TX FIFO buffers */
 	regmap_update_bits(dspi->regmap, SPI_MCR,
-- 
2.20.1

