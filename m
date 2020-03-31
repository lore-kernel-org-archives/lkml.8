Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFBEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C5F20772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646004;
	bh=NI9q/u06v9kRVfhBuo9S//WaNuaO7x3/q8Qyv348ZwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ALwEW2O9U8gaxqkEEiB5UqNuLFHN/e7+Rnnse5DExjfJD3jGsx0PJDFHOmC2tvNWf
	 XlL5iUsE8tI8uwNQpE7KFacYp6TR8RC2p/bBwm4a08urp7AW1LoEt2SXEjAFlIQD9l
	 5e9BmuzofXiTD9ijWD3lvy2yO2uCB5cyln9NWleo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgCaJNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730519AbgCaJNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:13:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C2A2072E;
        Tue, 31 Mar 2020 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646000;
        bh=NI9q/u06v9kRVfhBuo9S//WaNuaO7x3/q8Qyv348ZwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTFwBcCaAVL84Jdzp3p01jSX6D8DTAPSwT4mACo6r2TkSLus3C7kHEpdmy0BuHHFM
         aS/PDkY7D6FeaRTBxoT75/Otz1q03qiwBIz17oMilxoXyR2m21XEh17a/plInFJieO
         kqdI3YZDwiHja+44pJX/2wNiV3ILJlQ57fUl00f4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 051/155] net/mlx5e: Fix missing reset of SW metadata in Striding RQ reset
Date:   Tue, 31 Mar 2020 10:58:11 +0200
Message-Id: <20200331085424.233418335@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 39369fd536d485a99a59d8e357c0d4d3ce19a3b8 ]

When resetting the RQ (moving RQ state from RST to RDY), the driver
resets the WQ's SW metadata.
In striding RQ mode, we maintain a field that reflects the actual
expected WQ head (including in progress WQEs posted to the ICOSQ).
It was mistakenly not reset together with the WQ. Fix this here.

Fixes: 8276ea1353a4 ("net/mlx5e: Report and recover from CQE with error on RQ")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -181,10 +181,12 @@ mlx5e_tx_dma_unmap(struct device *pdev,
 
 static inline void mlx5e_rqwq_reset(struct mlx5e_rq *rq)
 {
-	if (rq->wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ)
+	if (rq->wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ) {
 		mlx5_wq_ll_reset(&rq->mpwqe.wq);
-	else
+		rq->mpwqe.actual_wq_head = 0;
+	} else {
 		mlx5_wq_cyc_reset(&rq->wqe.wq);
+	}
 }
 
 /* SW parser related functions */


