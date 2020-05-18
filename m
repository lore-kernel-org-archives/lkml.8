Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C18C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B707020671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825629;
	bh=nldiJ+MHYYN+kjgAX5mo6jUIk7pC/Xc/j4g2G7Uco6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1BYmKoks+qcWcXfJQxO3A+V3N/NwvtdO/JtpoiQCGz8B0O+l/4iDH7Ehet4JYLx2/
	 dzg4Ne+ncyXvb8GUYNin6J6irov7sn89SAXhWpbohW4ET1oVcjXQJ3cIxAMiaV/YN9
	 FO2TZaDt6y+yYSJkp2WYP4ifLhjkWK19Ib7l/iS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbgERSNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732431AbgERSBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:01:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0CEE207C4;
        Mon, 18 May 2020 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824904;
        bh=nldiJ+MHYYN+kjgAX5mo6jUIk7pC/Xc/j4g2G7Uco6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1V64h9R8tJeA+oRv4V4475RcnLMubl5Cqruxp/xKZqRfCJz/bWXSwJsE4waw7KDt0
         eoSRoMrh0cczvmBktBp3n3blwZQLq3ubF/wqRAYvrHnhgDGaM+m6EpdcAbsIbfFX9G
         4i4JOR3ElIjiW8kjRPrtCzmXZAweLOG2sqe+SYFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian von Ohr <vonohr@smaract.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 051/194] dmaengine: xilinx_dma: Add missing check for empty list
Date:   Mon, 18 May 2020 19:35:41 +0200
Message-Id: <20200518173536.041075342@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian von Ohr <vonohr@smaract.com>

[ Upstream commit b269426011bcfd97b7c3101abfe1a99147b6f40b ]

The DMA transfer might finish just after checking the state with
dma_cookie_status, but before the lock is acquired. Not checking
for an empty list in xilinx_dma_tx_status may result in reading
random data or data corruption when desc is written to. This can
be reliably triggered by using dma_sync_wait to wait for DMA
completion.

Signed-off-by: Sebastian von Ohr <vonohr@smaract.com>
Tested-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Link: https://lore.kernel.org/r/20200303130518.333-1-vonohr@smaract.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a9c5d5cc9f2bd..5d5f1d0ce16cb 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1229,16 +1229,16 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 		return ret;
 
 	spin_lock_irqsave(&chan->lock, flags);
-
-	desc = list_last_entry(&chan->active_list,
-			       struct xilinx_dma_tx_descriptor, node);
-	/*
-	 * VDMA and simple mode do not support residue reporting, so the
-	 * residue field will always be 0.
-	 */
-	if (chan->has_sg && chan->xdev->dma_config->dmatype != XDMA_TYPE_VDMA)
-		residue = xilinx_dma_get_residue(chan, desc);
-
+	if (!list_empty(&chan->active_list)) {
+		desc = list_last_entry(&chan->active_list,
+				       struct xilinx_dma_tx_descriptor, node);
+		/*
+		 * VDMA and simple mode do not support residue reporting, so the
+		 * residue field will always be 0.
+		 */
+		if (chan->has_sg && chan->xdev->dma_config->dmatype != XDMA_TYPE_VDMA)
+			residue = xilinx_dma_get_residue(chan, desc);
+	}
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	dma_set_residue(txstate, residue);
-- 
2.20.1



