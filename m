Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C6AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A68B2158C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034907;
	bh=tftKU4F3tosnPC/SGYFbVSw+AXCzOi+KqBNrkdOQgyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U0oYKHT8ce1KP8Xkfd7tQqqcmULodi1oaQzjM8mpr0gFkOoRcK1e8j/HZ3GlDe4FW
	 zRXwkGBN26cnIagJdVM4F6yoCiM1X3UGJhdBv4LXnML7H8tT303fuHG51fLGHByCpK
	 RNF+FwxC5Xo9q3Sw6IIWJf6vQ0+sEbZX93/tBMKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgFASI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbgFASIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:08:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260DB20872;
        Mon,  1 Jun 2020 18:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034903;
        bh=tftKU4F3tosnPC/SGYFbVSw+AXCzOi+KqBNrkdOQgyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQPKy1erLqsp0Ck6Faa9JgoDvCi6nwxSoD5n1XZnU51KYXTeLZf3RnZFlAY711dlV
         +w37CPUllFD8kJxUyTVu+5BBVGBYBn1vh7CFli4l8hP4ybghFdnSaDg+LCGA02sW7t
         JKFYilLU2uNlcPtWaiiG6RNsZxu0WBnlvBXXJbiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 024/142] net/mlx5e: Update netdev txq on completions during closure
Date:   Mon,  1 Jun 2020 19:53:02 +0200
Message-Id: <20200601174040.326271561@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit 5e911e2c06bd8c17df29147a5e2d4b17fafda024 ]

On sq closure when we free its descriptors, we should also update netdev
txq on completions which would not arrive. Otherwise if we reopen sqs
and attach them back, for example on fw fatal recovery flow, we may get
tx timeout.

Fixes: 29429f3300a3 ("net/mlx5e: Timeout if SQ doesn't flush during close")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -537,10 +537,9 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *c
 void mlx5e_free_txqsq_descs(struct mlx5e_txqsq *sq)
 {
 	struct mlx5e_tx_wqe_info *wi;
+	u32 dma_fifo_cc, nbytes = 0;
+	u16 ci, sqcc, npkts = 0;
 	struct sk_buff *skb;
-	u32 dma_fifo_cc;
-	u16 sqcc;
-	u16 ci;
 	int i;
 
 	sqcc = sq->cc;
@@ -565,11 +564,15 @@ void mlx5e_free_txqsq_descs(struct mlx5e
 		}
 
 		dev_kfree_skb_any(skb);
+		npkts++;
+		nbytes += wi->num_bytes;
 		sqcc += wi->num_wqebbs;
 	}
 
 	sq->dma_fifo_cc = dma_fifo_cc;
 	sq->cc = sqcc;
+
+	netdev_tx_completed_queue(sq->txq, npkts, nbytes);
 }
 
 #ifdef CONFIG_MLX5_CORE_IPOIB


