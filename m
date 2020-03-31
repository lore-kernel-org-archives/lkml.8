Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20984C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D837420B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645468;
	bh=3PC6TWgTDvSLeX/Jgr+1SwtX1haQuV2NKoab2HFbPJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1YjabYNXpN/n43BVEdLmFGyhO9tith7XTakgvrMNm660Acldv58hYYUCoKEW1wrij
	 bc4aV0C4uvs6ijlrsHnSVzcue7TIsE+unU7OGeWcQQtjwqipj09xPbMVagi018b5kJ
	 vMNqEQDMmur+n64csM/9Y7NP5Y9VLBV9TFz9tWSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgCaJE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbgCaJEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:04:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3BC20675;
        Tue, 31 Mar 2020 09:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645460;
        bh=3PC6TWgTDvSLeX/Jgr+1SwtX1haQuV2NKoab2HFbPJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGXFBdG0zqLagQiCjQp2G0Pal7gWQhMy8OR+2vXuddKNnZFdFbnuXm2dG6yBkcwCV
         rCl+jQ/1PqndcmdCl3tTUXh+ILj4HxexD9vLl7Adz5Dve/qnZgI9qu/Sw5XkjHPvuD
         3tBc8nEetB57qaFpWs2ERCS03+J/V0A11sCAhH24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 060/170] net/mlx5e: Do not recover from a non-fatal syndrome
Date:   Tue, 31 Mar 2020 10:57:54 +0200
Message-Id: <20200331085430.914003504@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 187a9830c921d92c4a9a8e2921ecc4b35a97532c ]

For non-fatal syndromes like LOCAL_LENGTH_ERR, recovery shouldn't be
triggered. In these scenarios, the RQ is not actually in ERR state.
This misleads the recovery flow which assumes that the RQ is really in
error state and no more completions arrive, causing crashes on bad page
state.

Fixes: 8276ea1353a4 ("net/mlx5e: Report and recover from CQE with error on RQ")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/health.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/health.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/health.h
@@ -10,8 +10,7 @@
 
 static inline bool cqe_syndrome_needs_recover(u8 syndrome)
 {
-	return syndrome == MLX5_CQE_SYNDROME_LOCAL_LENGTH_ERR ||
-	       syndrome == MLX5_CQE_SYNDROME_LOCAL_QP_OP_ERR ||
+	return syndrome == MLX5_CQE_SYNDROME_LOCAL_QP_OP_ERR ||
 	       syndrome == MLX5_CQE_SYNDROME_LOCAL_PROT_ERR ||
 	       syndrome == MLX5_CQE_SYNDROME_WR_FLUSH_ERR;
 }


