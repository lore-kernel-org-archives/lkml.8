Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E34FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3C222314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgATMdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:33:47 -0500
Received: from olimex.com ([184.105.72.32]:45159 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgATMdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:33:46 -0500
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 04:33:42 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list),
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v2 1/2] dmaengine: sun4i: Add support for cyclic requests with dedicated DMA
Date:   Mon, 20 Jan 2020 14:33:25 +0200
Message-Id: <20200120123326.30743-2-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120123326.30743-1-stefan@olimex.com>
References: <20200120123326.30743-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the cyclic transfers can be used only with normal DMAs. They
can be used by pcm_dmaengine module, which is required for implementing
sound with sun4i-hdmi encoder. This is so because the controller can
accept audio only from a dedicated DMA.

This patch enables them, following the existing style for the
scatter/gather type transfers.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
Changes for v2:
 - None

 drivers/dma/sun4i-dma.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index e397a50058c8..7b41815d86fb 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -669,43 +669,41 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 	dma_addr_t src, dest;
 	u32 endpoints;
 	int nr_periods, offset, plength, i;
+	u8 ram_type, io_mode, linear_mode;
 
 	if (!is_slave_direction(dir)) {
 		dev_err(chan2dev(chan), "Invalid DMA direction\n");
 		return NULL;
 	}
 
-	if (vchan->is_dedicated) {
-		/*
-		 * As we are using this just for audio data, we need to use
-		 * normal DMA. There is nothing stopping us from supporting
-		 * dedicated DMA here as well, so if a client comes up and
-		 * requires it, it will be simple to implement it.
-		 */
-		dev_err(chan2dev(chan),
-			"Cyclic transfers are only supported on Normal DMA\n");
-		return NULL;
-	}
-
 	contract = generate_dma_contract();
 	if (!contract)
 		return NULL;
 
 	contract->is_cyclic = 1;
 
-	/* Figure out the endpoints and the address we need */
+	if (vchan->is_dedicated) {
+		io_mode = SUN4I_DDMA_ADDR_MODE_IO;
+		linear_mode = SUN4I_DDMA_ADDR_MODE_LINEAR;
+		ram_type = SUN4I_DDMA_DRQ_TYPE_SDRAM;
+	} else {
+		io_mode = SUN4I_NDMA_ADDR_MODE_IO;
+		linear_mode = SUN4I_NDMA_ADDR_MODE_LINEAR;
+		ram_type = SUN4I_NDMA_DRQ_TYPE_SDRAM;
+	}
+
 	if (dir == DMA_MEM_TO_DEV) {
 		src = buf;
 		dest = sconfig->dst_addr;
-		endpoints = SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM) |
-			    SUN4I_DMA_CFG_DST_DRQ_TYPE(vchan->endpoint) |
-			    SUN4I_DMA_CFG_DST_ADDR_MODE(SUN4I_NDMA_ADDR_MODE_IO);
+		endpoints = SUN4I_DMA_CFG_DST_DRQ_TYPE(vchan->endpoint) |
+			    SUN4I_DMA_CFG_DST_ADDR_MODE(io_mode) |
+			    SUN4I_DMA_CFG_SRC_DRQ_TYPE(ram_type);
 	} else {
 		src = sconfig->src_addr;
 		dest = buf;
-		endpoints = SUN4I_DMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
-			    SUN4I_DMA_CFG_SRC_ADDR_MODE(SUN4I_NDMA_ADDR_MODE_IO) |
-			    SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM);
+		endpoints = SUN4I_DMA_CFG_DST_DRQ_TYPE(ram_type) |
+			    SUN4I_DMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
+			    SUN4I_DMA_CFG_SRC_ADDR_MODE(io_mode);
 	}
 
 	/*
@@ -747,8 +745,13 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 			dest = buf + offset;
 
 		/* Make the promise */
-		promise = generate_ndma_promise(chan, src, dest,
-						plength, sconfig, dir);
+		if (vchan->is_dedicated)
+			promise = generate_ddma_promise(chan, src, dest,
+							plength, sconfig);
+		else
+			promise = generate_ndma_promise(chan, src, dest,
+							plength, sconfig, dir);
+
 		if (!promise) {
 			/* TODO: should we free everything? */
 			return NULL;
-- 
2.17.1
