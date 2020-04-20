Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3788C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1DE32070B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386516;
	bh=P6Xpq1T2J2hl/E5cWmYXXXkMPPvkiK3T/FaviKoFQJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WVjgnFXMf8Aw5vAcAEvdoydHIba6UU3Gf5UHGjHEjNGMSpDS+I1LzCLpac/tpzMqu
	 CglfPI/g1zymTxViC6v7MXw3wNVtSztA25H75hHGQhZHjsCKTrIlBn3lAJFrSHlqpl
	 4D/FPaQFdp5Xu+neddxnzBPGeXiKMZkAzrdDL/6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgDTMl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgDTMlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:41:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49D72072B;
        Mon, 20 Apr 2020 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386511;
        bh=P6Xpq1T2J2hl/E5cWmYXXXkMPPvkiK3T/FaviKoFQJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUAVFCycfWmsyI32XWqZGZcvWDgzOb8/xP4MjthhnpDG0+ZXqG0pPFz92dcONKgoI
         A5W9vNLtsSfAOvnYOPeGKOc+G7QkNBI+Bpy0WxHhtwrxgjhB0qhkaWZ1lxyfbhQ3GE
         b6tTpTI5x7Og4qZTNKTUhHv8BKnNcmMYB8Q/aKQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxim Mikityanskiy <maximmi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 53/65] net/mlx5e: Rename hw_modify to preactivate
Date:   Mon, 20 Apr 2020 14:38:57 +0200
Message-Id: <20200420121518.351374201@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Mikityanskiy <maximmi@mellanox.com>

[ Upstream commit dca147b3dce5abb5284ff747211960fd2db5ec2e ]

mlx5e_safe_switch_channels accepts a callback to be called before
activating new channels. It is intended to configure some hardware
parameters in cases where channels are recreated because some
configuration has changed.

Recently, this callback has started being used to update the driver's
internal MLX5E_STATE_XDP_OPEN flag, and the following patches also
intend to use this callback for software preparations. This patch
renames the hw_modify callback to preactivate, so that the name fits
better.

Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 55ceabf077b29..3cb5b4321bf93 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1035,14 +1035,14 @@ int mlx5e_open_channels(struct mlx5e_priv *priv,
 			struct mlx5e_channels *chs);
 void mlx5e_close_channels(struct mlx5e_channels *chs);
 
-/* Function pointer to be used to modify WH settings while
+/* Function pointer to be used to modify HW or kernel settings while
  * switching channels
  */
-typedef int (*mlx5e_fp_hw_modify)(struct mlx5e_priv *priv);
+typedef int (*mlx5e_fp_preactivate)(struct mlx5e_priv *priv);
 int mlx5e_safe_reopen_channels(struct mlx5e_priv *priv);
 int mlx5e_safe_switch_channels(struct mlx5e_priv *priv,
 			       struct mlx5e_channels *new_chs,
-			       mlx5e_fp_hw_modify hw_modify);
+			       mlx5e_fp_preactivate preactivate);
 void mlx5e_activate_priv_channels(struct mlx5e_priv *priv);
 void mlx5e_deactivate_priv_channels(struct mlx5e_priv *priv);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 35b0acce425f8..25690d52d48ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2963,7 +2963,7 @@ void mlx5e_deactivate_priv_channels(struct mlx5e_priv *priv)
 
 static void mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
 				       struct mlx5e_channels *new_chs,
-				       mlx5e_fp_hw_modify hw_modify)
+				       mlx5e_fp_preactivate preactivate)
 {
 	struct net_device *netdev = priv->netdev;
 	int new_num_txqs;
@@ -2982,9 +2982,11 @@ static void mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
 
 	priv->channels = *new_chs;
 
-	/* New channels are ready to roll, modify HW settings if needed */
-	if (hw_modify)
-		hw_modify(priv);
+	/* New channels are ready to roll, call the preactivate hook if needed
+	 * to modify HW settings or update kernel parameters.
+	 */
+	if (preactivate)
+		preactivate(priv);
 
 	priv->profile->update_rx(priv);
 	mlx5e_activate_priv_channels(priv);
@@ -2996,7 +2998,7 @@ static void mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
 
 int mlx5e_safe_switch_channels(struct mlx5e_priv *priv,
 			       struct mlx5e_channels *new_chs,
-			       mlx5e_fp_hw_modify hw_modify)
+			       mlx5e_fp_preactivate preactivate)
 {
 	int err;
 
@@ -3004,7 +3006,7 @@ int mlx5e_safe_switch_channels(struct mlx5e_priv *priv,
 	if (err)
 		return err;
 
-	mlx5e_switch_priv_channels(priv, new_chs, hw_modify);
+	mlx5e_switch_priv_channels(priv, new_chs, preactivate);
 	return 0;
 }
 
-- 
2.20.1



