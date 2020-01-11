Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD2C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0043B2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738840;
	bh=bgXcfIByg55/2c4gGWxgG8H1jaDFW+ARq/kqI3jFuVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aQxgCebLZd5XJea7EdYmXa1dcNgzOiICSrEgLj3OIrJaZuuUsWcfuVq1ks3xJBUMG
	 j34qvUyQPxnuT7OLhz5MYE6U9L7qORtVyHRLMp00A7QS3r1sG3dKiaGOtPG23+bA3T
	 /ROkIzhTIjafUFh5UGVLo3GG+8DFkE2sIVAqDpM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbgAKKd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731211AbgAKKdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:33:54 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B785320880;
        Sat, 11 Jan 2020 10:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738833;
        bh=bgXcfIByg55/2c4gGWxgG8H1jaDFW+ARq/kqI3jFuVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/UbYnwGqkEqrw6wwRCw8BJfRSz7O7gjuYfV2olQYMszkqqCEtRftvqU9kgmJl6Y8
         95lm65mSxWYK/YLs+qYY5yTjjpH7qxHGP7DyFzP7olurgdXp3MFEzzt/MIujFuQ939
         eAYfGBGzz82JhB4o99G1qWKCV30uv2kZXfW+Wyhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Guralnik <michaelgur@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 156/165] net/mlx5: Move devlink registration before interfaces load
Date:   Sat, 11 Jan 2020 10:51:15 +0100
Message-Id: <20200111094941.826266859@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

[ Upstream commit a6f3b62386a02c1e94bfa22c543f82d63f5e631b ]

Register devlink before interfaces are added.
This will allow interfaces to use devlink while initalizing. For example,
call mlx5_is_roce_enabled.

Fixes: aba25279c100 ("net/mlx5e: Add TX reporter support")
Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1197,6 +1197,12 @@ static int mlx5_load_one(struct mlx5_cor
 	if (err)
 		goto err_load;
 
+	if (boot) {
+		err = mlx5_devlink_register(priv_to_devlink(dev), dev->device);
+		if (err)
+			goto err_devlink_reg;
+	}
+
 	if (mlx5_device_registered(dev)) {
 		mlx5_attach_device(dev);
 	} else {
@@ -1214,6 +1220,9 @@ out:
 	return err;
 
 err_reg_dev:
+	if (boot)
+		mlx5_devlink_unregister(priv_to_devlink(dev));
+err_devlink_reg:
 	mlx5_unload(dev);
 err_load:
 	if (boot)
@@ -1353,10 +1362,6 @@ static int init_one(struct pci_dev *pdev
 
 	request_module_nowait(MLX5_IB_MOD);
 
-	err = mlx5_devlink_register(devlink, &pdev->dev);
-	if (err)
-		goto clean_load;
-
 	err = mlx5_crdump_enable(dev);
 	if (err)
 		dev_err(&pdev->dev, "mlx5_crdump_enable failed with error code %d\n", err);
@@ -1364,9 +1369,6 @@ static int init_one(struct pci_dev *pdev
 	pci_save_state(pdev);
 	return 0;
 
-clean_load:
-	mlx5_unload_one(dev, true);
-
 err_load_one:
 	mlx5_pci_close(dev);
 pci_init_err:


