Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3441C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88694208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322807;
	bh=6mb25FkOw5ohSnBP7pmFf8WZ6p6jKa0VhuRgbk7vP94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1p9L3frZduVfSHLYpSYQw6FUrakXSXvwCeY+Jcw2ywolIzGnryhLBtegHCXFibBY/
	 WlxSZL1+IskzffaJOqnkvc/4FU+x8uFxQwwd6i1f4y1QfPG14CvnBiFxD4/SvIBs+w
	 YyDKS97AL0ehNOX/KITO0X/6D17yikynIfrVaRBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbgFPPxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732114AbgFPPxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:53:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B69FE207C4;
        Tue, 16 Jun 2020 15:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322802;
        bh=6mb25FkOw5ohSnBP7pmFf8WZ6p6jKa0VhuRgbk7vP94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRD7hGT9BCGxlvawj7FDWFseSmDIL3km/DkWitushGwHNq1G7lu7zWJj8Q+MGLbVw
         hJrdDdutG358NpGaQQyayKwTXzZKCKssO0fYfqZja0U1AV2bubxiDlqLig3QbJ6ZYO
         GlhmYcSVqrwZODWAMpM6g8nMipsWsguvYiIJceNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shay Drory <shayd@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.6 110/161] net/mlx5: Fix fatal error handling during device load
Date:   Tue, 16 Jun 2020 17:35:00 +0200
Message-Id: <20200616153111.597298264@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shay Drory <shayd@mellanox.com>

[ Upstream commit b6e0b6bebe0732d5cac51f0791f269d2413b8980 ]

Currently, in case of fatal error during mlx5_load_one(), we cannot
enter error state until mlx5_load_one() is finished, what can take
several minutes until commands will get timeouts, because these commands
can't be processed due to the fatal error.
Fix it by setting dev->state as MLX5_DEVICE_STATE_INTERNAL_ERROR before
requesting the lock.

Fixes: c1d4d2e92ad6 ("net/mlx5: Avoid calling sleeping function by the health poll thread")
Signed-off-by: Shay Drory <shayd@mellanox.com>
Reviewed-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -193,15 +193,23 @@ static bool reset_fw_if_needed(struct ml
 
 void mlx5_enter_error_state(struct mlx5_core_dev *dev, bool force)
 {
+	bool err_detected = false;
+
+	/* Mark the device as fatal in order to abort FW commands */
+	if ((check_fatal_sensors(dev) || force) &&
+	    dev->state == MLX5_DEVICE_STATE_UP) {
+		dev->state = MLX5_DEVICE_STATE_INTERNAL_ERROR;
+		err_detected = true;
+	}
 	mutex_lock(&dev->intf_state_mutex);
-	if (dev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
-		goto unlock;
+	if (!err_detected && dev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		goto unlock;/* a previous error is still being handled */
 	if (dev->state == MLX5_DEVICE_STATE_UNINITIALIZED) {
 		dev->state = MLX5_DEVICE_STATE_INTERNAL_ERROR;
 		goto unlock;
 	}
 
-	if (check_fatal_sensors(dev) || force) {
+	if (check_fatal_sensors(dev) || force) { /* protected state setting */
 		dev->state = MLX5_DEVICE_STATE_INTERNAL_ERROR;
 		mlx5_cmd_flush(dev);
 	}


