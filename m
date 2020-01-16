Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB4C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814D42470B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196367;
	bh=206sE0FgN/guZTm+kxehiEoGAU09Y0UfRM/qPQMxmPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K51B/90RSFxchwsIumMmWCPIttFUuKFDdZvESzSnZYi02UIAr6TwiMYGYEOKVpqdc
	 pyvgiPBL+CuOGVT1EveOLoDkuwhhZpdJioWuehxhrQ/QZTc7XMYuhrrauqIilayAMe
	 +ULwL4NshOKyu3cTllbpJiJIYirAkCJY2vsiATMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393473AbgAPRj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405058AbgAPRig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:38:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98BDF24700;
        Thu, 16 Jan 2020 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196315;
        bh=206sE0FgN/guZTm+kxehiEoGAU09Y0UfRM/qPQMxmPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+EfXb8j03j9bO5AhfTzwohUiVkUmb2lQ85aVLkbBp2lZkl7fO+oLxFxV4m74bZvN
         gvfDYGj6kGM+My9zemR0qRBIu6MVn9yDSetsor4/SCxWJodX3Uw6hSZBdH7kbleVwL
         KivVUnDQeUp2fwS6HNH5LSbUarTl/J8rTCCrC2JA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 121/251] dmaengine: axi-dmac: Don't check the number of frames for alignment
Date:   Thu, 16 Jan 2020 12:34:30 -0500
Message-Id: <20200116173641.22137-81-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit 648865a79d8ee3d1aa64aab5eb2a9d12eeed14f9 ]

In 2D transfers (for the AXI DMAC), the number of frames (numf) represents
Y_LENGTH, and the length of a frame is X_LENGTH. 2D transfers are useful
for video transfers where screen resolutions ( X * Y ) are typically
aligned for X, but not for Y.

There is no requirement for Y_LENGTH to be aligned to the bus-width (or
anything), and this is also true for AXI DMAC.

Checking the Y_LENGTH for alignment causes false errors when initiating DMA
transfers. This change fixes this by checking only that the Y_LENGTH is
non-zero.

Fixes: 0e3b67b348b8 ("dmaengine: Add support for the Analog Devices AXI-DMAC DMA controller")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dma-axi-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 7f0b9aa15867..9887f2a14aa9 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -451,7 +451,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_interleaved(
 
 	if (chan->hw_2d) {
 		if (!axi_dmac_check_len(chan, xt->sgl[0].size) ||
-		    !axi_dmac_check_len(chan, xt->numf))
+		    xt->numf == 0)
 			return NULL;
 		if (xt->sgl[0].size + dst_icg > chan->max_length ||
 		    xt->sgl[0].size + src_icg > chan->max_length)
-- 
2.20.1

