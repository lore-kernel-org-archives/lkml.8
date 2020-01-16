Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A041AC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1392073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193228;
	bh=dAs/zNG/m+VHy0DYPM6tcOxHAC0qIG1JB0YFDX/OnZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N0gaF/3eOScaENz/XhE/lPC1LYSIiM+fIkfvJWVmL0qVxHyXgGBt32Myi8aJbjX6/
	 szJkFb4eTxJqFjuGCl/He1Cg9xK97rv15suifMT8MeeLS5hZy3f4ZoNkKTatN6h1hZ
	 VTKcqz1dHDKvizTUA0LGoaFmBGN0GsQ6cmzLOTa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgAPQrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:47:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbgAPQrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:47:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7EBE207FF;
        Thu, 16 Jan 2020 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193223;
        bh=dAs/zNG/m+VHy0DYPM6tcOxHAC0qIG1JB0YFDX/OnZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLyrxKrUf6JvIKh67lmBcPTEKw/NvUZPci1U67WINGt4UbDmDTDiYPuXH/OcWIixm
         YG+9WY0Y3g2qNtAW4UNjHGe2ei1fMk0RsGQVqLSB2KjVnelOTcKzJD0WUb/pqkW+Cf
         dveCKyON+GdWJXN48yCkOjkyRatbKTVRKEhAG6TY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 049/205] net: netsec: Correct dma sync for XDP_TX frames
Date:   Thu, 16 Jan 2020 11:40:24 -0500
Message-Id: <20200116164300.6705-49-sashal@kernel.org>
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

[ Upstream commit d9496f3ecfe4823c1e12aecbcc29220147fa012c ]

bpf_xdp_adjust_head() can change the frame boundaries. Account for the
potential shift properly by calculating the new offset before
syncing the buffer to the device for XDP_TX

Fixes: ba2b232108d3 ("net: netsec: add XDP support")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/socionext/netsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index f9e6744d8fd6..41ddd8fff2a7 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -847,8 +847,8 @@ static u32 netsec_xdp_queue_one(struct netsec_priv *priv,
 		enum dma_data_direction dma_dir =
 			page_pool_get_dma_dir(rx_ring->page_pool);
 
-		dma_handle = page_pool_get_dma_addr(page) +
-			NETSEC_RXBUF_HEADROOM;
+		dma_handle = page_pool_get_dma_addr(page) + xdpf->headroom +
+			sizeof(*xdpf);
 		dma_sync_single_for_device(priv->dev, dma_handle, xdpf->len,
 					   dma_dir);
 		tx_desc.buf_type = TYPE_NETSEC_XDP_TX;
-- 
2.20.1

