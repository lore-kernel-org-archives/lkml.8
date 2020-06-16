Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A24BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A93B20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592321994;
	bh=6mb25FkOw5ohSnBP7pmFf8WZ6p6jKa0VhuRgbk7vP94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2lZS6qE7T7jcYbZ0pK+y1fhWbTM350WQGjzse/OgiGcz3vuW11LPqLjWB/2wCcb+w
	 kapr9evm3Shr9t7hZjlIFw8uFMWyXeWpnVMPbxucAh7IyihRoYATs2TpQDFP3fXU8V
	 VogG8ImXM2mX5pMiGbo05yWWCJLZ35jTrRKWb9GY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgFPPjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbgFPPjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:39:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB5920B1F;
        Tue, 16 Jun 2020 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592321985;
        bh=6mb25FkOw5ohSnBP7pmFf8WZ6p6jKa0VhuRgbk7vP94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rz1wyFcHsrGkwx0WbOHXyhTJMge7OMWNNS9Xhtjg82w90dXZjESrCnRyApLic96/d
         e/XPm3o4ppucjEnJqI9ome+khnlJw6TpVf+aihea1MkiZatw6n9VC0fAqaCc8U0Z+K
         IWbAmJ/cjzYwpuK3xe2ixQOnC0u27XOiU06ub4cQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shay Drory <shayd@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 092/134] net/mlx5: Fix fatal error handling during device load
Date:   Tue, 16 Jun 2020 17:34:36 +0200
Message-Id: <20200616153105.190034484@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153100.633279950@linuxfoundation.org>
References: <20200616153100.633279950@linuxfoundation.org>
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


