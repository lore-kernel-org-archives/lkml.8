Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC34FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE5B204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457721;
	bh=r6tonUaCA4yIVYEdGSKBGBpprLWVpRT7OC1j2tMOSAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JUldy5zEEIvfoC06onGi5QrEouTt9BN3pJXhsxJxRttLIiS5Vkppd+wXoSvGfmQ5H
	 Aaehpyf+fp/vX22XvOms/GRy+uQI56qnTE6twjUIn2N2bgF5xrXcYpeYuYn3zHzZHH
	 soovWuwzVU9fApdiL7uH8NQ8mZNoZaopUwUw/ocw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgHCM2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbgHCM2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:28:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE65B207DF;
        Mon,  3 Aug 2020 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457716;
        bh=r6tonUaCA4yIVYEdGSKBGBpprLWVpRT7OC1j2tMOSAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qrfpgBhKtIXB7GyQIq1pTc0BtfXtfgtlz/qmg0aS94lyAH4THWi2oHuWkao9Kmado
         byJet5klb02FRZM1vlzhUO35JezG7qwsazD83ynBAKyfZUgu/zTMpN7CoZTFLjWdDy
         sqDtFLmlUUB8qgb8w8UsEeJob3efBuZUElY7tG04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 48/90] net/mlx5e: Fix error path of device attach
Date:   Mon,  3 Aug 2020 14:19:10 +0200
Message-Id: <20200803121859.946272744@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 5cd39b6e9a420329a9a408894be7ba8aa7dd755e ]

On failure to attach the netdev, fix the rollback by re-setting the
device's state back to MLX5E_STATE_DESTROYING.

Failing to attach doesn't stop statistics polling via .ndo_get_stats64.
In this case, although the device is not attached, it falsely continues
to query the firmware for counters. Setting the device's state back to
MLX5E_STATE_DESTROYING prevents the firmware counters query.

Fixes: 26e59d8077a3 ("net/mlx5e: Implement mlx5e interface attach/detach callbacks")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c133beb6a7a56..15db4a8746dd7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5356,6 +5356,8 @@ err_cleanup_tx:
 	profile->cleanup_tx(priv);
 
 out:
+	set_bit(MLX5E_STATE_DESTROYING, &priv->state);
+	cancel_work_sync(&priv->update_stats_work);
 	return err;
 }
 
-- 
2.25.1



