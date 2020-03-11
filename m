Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0297EC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2BE208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgCKFGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:06:42 -0400
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:44512 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbgCKFGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:06:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 42C761802E2A0;
        Wed, 11 Mar 2020 05:06:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shelf51_1d1f85e6c0b09
X-Filterd-Recvd-Size: 2682
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:06:40 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Boris Pismenny <borisp@mellanox.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 001/491] MELLANOX ETHERNET INNOVA DRIVERS: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:15 -0700
Message-Id: <605f5d4954fcb254fe6fc5c22dc707f29b3b7405.1583896347.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index f260dd..42978f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -466,7 +466,7 @@ struct sk_buff *mlx5e_ktls_handle_tx_skb(struct net_device *netdev,
 			if (likely(!skb->decrypted))
 				goto out;
 			WARN_ON_ONCE(1);
-			/* fall-through */
+			fallthrough;
 		default: /* MLX5E_KTLS_SYNC_FAIL */
 			goto err_out;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
index 6102113..d35bbc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
@@ -339,14 +339,14 @@ static void mlx5_fpga_conn_handle_cqe(struct mlx5_fpga_conn *conn,
 	switch (opcode) {
 	case MLX5_CQE_REQ_ERR:
 		status = ((struct mlx5_err_cqe *)cqe)->syndrome;
-		/* Fall through */
+		fallthrough;
 	case MLX5_CQE_REQ:
 		mlx5_fpga_conn_sq_cqe(conn, cqe, status);
 		break;
 
 	case MLX5_CQE_RESP_ERR:
 		status = ((struct mlx5_err_cqe *)cqe)->syndrome;
-		/* Fall through */
+		fallthrough;
 	case MLX5_CQE_RESP_SEND:
 		mlx5_fpga_conn_rq_cqe(conn, cqe, status);
 		break;
-- 
2.24.0

