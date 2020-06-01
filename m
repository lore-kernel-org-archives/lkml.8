Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4082CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D7220870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037821;
	bh=2kWCVXZYXUw1sPg7WO9hPr23Qd/vPlm0bq90WakJSmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1UpSMMv1UHbQzin59DVNNPHWm8ONOukeWDRUdy9VU/9RyKthh7O7yTBN609uIzGiM
	 Zv2GRJHfjDkYCU6fzIkUu8SlDssyp0HRIIELyngZK2V5g+LiNnlzFDLHMK+gjCEImD
	 Ha26saKzhZbax8jZF6NBvc9ASJG4YTi98mwlA0IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgFAS5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbgFASAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:00:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46531206E2;
        Mon,  1 Jun 2020 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034418;
        bh=2kWCVXZYXUw1sPg7WO9hPr23Qd/vPlm0bq90WakJSmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDnZXFVIPFZwDfgiQmlJ6hvoGTgkvOiuYH7Dp9GFnKLMa2AcPHWyxF6cvXNp4BGRG
         eEDWc74NsFWVpz1kGCoR88DJiqjYTy0PeYjGT+d+ZpHd11RktlVz8o/2Q34H93zyNa
         INbziuxQJVzIiRUhi6NM2WaWE55Kw953SWOHIbj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 08/77] net/mlx5e: Update netdev txq on completions during closure
Date:   Mon,  1 Jun 2020 19:53:13 +0200
Message-Id: <20200601174017.905106006@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174016.396817032@linuxfoundation.org>
References: <20200601174016.396817032@linuxfoundation.org>
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
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -496,8 +496,9 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *c
 void mlx5e_free_txqsq_descs(struct mlx5e_txqsq *sq)
 {
 	struct mlx5e_tx_wqe_info *wi;
+	u32 nbytes = 0;
+	u16 ci, npkts = 0;
 	struct sk_buff *skb;
-	u16 ci;
 	int i;
 
 	while (sq->cc != sq->pc) {
@@ -518,8 +519,11 @@ void mlx5e_free_txqsq_descs(struct mlx5e
 		}
 
 		dev_kfree_skb_any(skb);
+		npkts++;
+		nbytes += wi->num_bytes;
 		sq->cc += wi->num_wqebbs;
 	}
+	netdev_tx_completed_queue(sq->txq, npkts, nbytes);
 }
 
 #ifdef CONFIG_MLX5_CORE_IPOIB


