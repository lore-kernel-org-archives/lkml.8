Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6320DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3632070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858807;
	bh=MBmjJhk/s+760/iUrsthu7tkS/PC5QejrvAu9pQQfZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zhEZEvt1UZnhw66Fab4DxffkkX/GZYrIGNeMtFzCjFrRArDg49RLM7PvsozIS8QKx
	 dlhfD56kth0nNjpEZ6XgawUrXJl8ZYir6wNqLLVWaDqHRkxtUXNvxBaSxkdq1afDgv
	 3I7T96WLLzY8nSXSJZ2mpbvp+6T76zLgMORbpwlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgAXJkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732126AbgAXJkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:40:04 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E0020709;
        Fri, 24 Jan 2020 09:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858803;
        bh=MBmjJhk/s+760/iUrsthu7tkS/PC5QejrvAu9pQQfZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTLf/mlQfMHmLUmpTcsxKDPJIeorfsPqg6Y/0mOZsysoaWAlBv+wRFklTcwigMPjb
         Wp/PedktULRfAb+dC/l3SxOcyJTm0AwsMtlPgI1QoqxLsw26Y2FFYNIt8/1zWFXqt2
         AemRWjsTNDKcpKhTlVBsiMgPXkV7mQRoJ8s2gvo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 060/102] net: netsec: Correct dma sync for XDP_TX frames
Date:   Fri, 24 Jan 2020 10:31:01 +0100
Message-Id: <20200124092815.386631955@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f9e6744d8fd6e..41ddd8fff2a73 100644
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



