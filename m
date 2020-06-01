Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E043C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617BF206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037243;
	bh=zsnNwinp/DE+F74R59YrcglBgXtqUtkXfpuHn77ZXQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=buVoWWts0dI+KD0NZIzZLep56abnpCGwit9xd/dpqH3wo3iWEG/0pK/pfvkXrrTED
	 rnsxvE4SIxOp0uUDaEhwoDKAmWebT3Fw465B+qe2xRuuFhTUv/xX84MI4A8i0rGnQm
	 0ngyBSbvZmf24J6nDmYCxFa7hIjWg0UsJDd28OR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgFASrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbgFASIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:08:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 633772068D;
        Mon,  1 Jun 2020 18:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034896;
        bh=zsnNwinp/DE+F74R59YrcglBgXtqUtkXfpuHn77ZXQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tyB0Ky+ZjbcReJrKJiLDYMchoIyfRnljRep/Sb8UsK4QfxrUJIGmDNkzBhZ1WF7up
         qbU2c4lYkNqb8uWKDSlSsqKjLnBak61lrSKcQah+YZ8tuB7BQE2s7LMQKDyutOMhPJ
         oySQcc1gOq2s0Z3UKNV1X5ZYODo9g0fRjdr9muGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 021/142] net/mlx5e: kTLS, Destroy key object after destroying the TIS
Date:   Mon,  1 Jun 2020 19:52:59 +0200
Message-Id: <20200601174040.038365916@linuxfoundation.org>
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

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 16736e11f43b80a38f98f6add54fab3b8c297df3 ]

The TLS TIS object contains the dek/key ID.
By destroying the key first, the TIS would contain an invalid
non-existing key ID.
Reverse the destroy order, this also acheives the desired assymetry
between the destroy and the create flows.

Fixes: d2ead1f360e8 ("net/mlx5e: Add kTLS TX HW offload support")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -69,8 +69,8 @@ static void mlx5e_ktls_del(struct net_de
 	struct mlx5e_ktls_offload_context_tx *tx_priv =
 		mlx5e_get_ktls_tx_priv_ctx(tls_ctx);
 
-	mlx5_ktls_destroy_key(priv->mdev, tx_priv->key_id);
 	mlx5e_destroy_tis(priv->mdev, tx_priv->tisn);
+	mlx5_ktls_destroy_key(priv->mdev, tx_priv->key_id);
 	kvfree(tx_priv);
 }
 


