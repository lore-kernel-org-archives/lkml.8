Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF161C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF562082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586491150;
	bh=Dxv9GWgwYfpM4ZleMavZeL7T7rb9/AIQg6B8qLU2Pao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oR4CFnPkfshmzeeJlTc90Z5frR9J3dn4jsUD9E9XyYy4JngacuB1t/70zw2Y7O/Jp
	 eYDnOsW8yModlvHcwj4JUJzuNCeMxBPHIQu1z5pM1zmluVzQ++4yMfuj0aD37fCQi3
	 MFxRwYbZp95MVH5Em/SWBxLvMgUFsacathvwynjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgDJDsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgDJDs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:48:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BFF216FD;
        Fri, 10 Apr 2020 03:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490507;
        bh=Dxv9GWgwYfpM4ZleMavZeL7T7rb9/AIQg6B8qLU2Pao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hCL4ydLva/QusgsHkh+HenAXvD1Dwz2m9KvkRFsfcie9FEQGBRfMWg8sGZur+fX2Q
         PDapxpTxGNFtgbIyHvHHSkJB6QJnUZefPAOEiXu4Fb0BLDrhhoH4D28rUk9SUfuglg
         TfxIZol22gdmV+HFHj7u2/V0HKXI4y8WnMLIC02Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 22/56] spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA mode
Date:   Thu,  9 Apr 2020 23:47:26 -0400
Message-Id: <20200410034800.8381-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034800.8381-1-sashal@kernel.org>
References: <20200410034800.8381-1-sashal@kernel.org>
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
index 8428b69c858bc..a534b8af27b8d 100644
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

