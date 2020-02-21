Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB2CC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F6D2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271496;
	bh=Cnisj9RKGQR/FA7XIim+1rtIYd3BMtJlvkxzs51h6yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kedcyrsE4zdFot0tgcEtl7Mlx69IzQK1mR9NEB+tJX/Pkq5XbwhjHyvTYxO23jiG4
	 NhNNeGp+Ht2ep4OYbrmegnjdC67QVQzwqNvn3o5ZKYfxf0CeUUPdawyaWENeshlsdH
	 kkTKzEVPqfQGr8WZHs55IOIxddnXGxX2ESSQgQYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgBUHvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:51:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbgBUHvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:51:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8A120801;
        Fri, 21 Feb 2020 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271491;
        bh=Cnisj9RKGQR/FA7XIim+1rtIYd3BMtJlvkxzs51h6yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTbhc/JNDPIfUf29GP/E/sm+8O9fOiVV/RngVp5FdkxuJzZoH2aKSsAMKIj+YmJSa
         avT1qY61+5mG9LRgZa4ocJdwVUJUGlVYvHwjNwhfN+XKlZRXd3RrpiucmZ5Tg3DXJn
         8SfC+JszwZoGNYifwk/uRWB8AULVAcG5KeXiTp/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 185/399] dmaengine: imx-sdma: Fix memory leak
Date:   Fri, 21 Feb 2020 08:38:30 +0100
Message-Id: <20200221072420.786249017@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit 02939cd167095f16328a1bd5cab5a90b550606df ]

The current descriptor is not on any list of the virtual DMA channel.
Once sdma_terminate_all() is called when a descriptor is currently
in flight then this one is forgotten to be freed. We have to call
vchan_terminate_vdesc() on this descriptor to re-add it to the lists.
Now that we also free the currently running descriptor we can (and
actually have to) remove the current descriptor from its list also
for the cyclic case.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Robin Gong <yibin.gong@nxp.com>
Tested-by: Robin Gong <yibin.gong@nxp.com>
Link: https://lore.kernel.org/r/20191216105328.15198-10-s.hauer@pengutronix.de
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/imx-sdma.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index c27e206a764c3..66f1b2ac5cde4 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -760,12 +760,8 @@ static void sdma_start_desc(struct sdma_channel *sdmac)
 		return;
 	}
 	sdmac->desc = desc = to_sdma_desc(&vd->tx);
-	/*
-	 * Do not delete the node in desc_issued list in cyclic mode, otherwise
-	 * the desc allocated will never be freed in vchan_dma_desc_free_list
-	 */
-	if (!(sdmac->flags & IMX_DMA_SG_LOOP))
-		list_del(&vd->node);
+
+	list_del(&vd->node);
 
 	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
 	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
@@ -1071,7 +1067,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 
 	spin_lock_irqsave(&sdmac->vc.lock, flags);
 	vchan_get_all_descriptors(&sdmac->vc, &head);
-	sdmac->desc = NULL;
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 	vchan_dma_desc_free_list(&sdmac->vc, &head);
 	sdmac->context_loaded = false;
@@ -1080,11 +1075,19 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 static int sdma_disable_channel_async(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
 
 	sdma_disable_channel(chan);
 
-	if (sdmac->desc)
+	if (sdmac->desc) {
+		vchan_terminate_vdesc(&sdmac->desc->vd);
+		sdmac->desc = NULL;
 		schedule_work(&sdmac->terminate_worker);
+	}
+
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 
 	return 0;
 }
-- 
2.20.1



