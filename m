Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A02EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A90220723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943824;
	bh=Rou7Pi7w8WXnxRB379Tan5LC0C0y7bJicDIcr4uoKCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PJS51DCgflbrLmV5GdM1dvHlbv6kt+s/5mN4EvU1nuBT0OB8d/fsITKD5v+mZqBgz
	 k8A5EYywt+jm5Sywkrx+R8oTqvq2EudHlQOoLlYLFn20HMcWOG3QHROQzSRSxQg3zr
	 /ndIm5r9Er4K/Phzild5HNvWoqn6FKydpTc49PbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbgFWUXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390319AbgFWUXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:23:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7892082F;
        Tue, 23 Jun 2020 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943814;
        bh=Rou7Pi7w8WXnxRB379Tan5LC0C0y7bJicDIcr4uoKCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iip5mx1m4tBRIJw8xSqttV9WAYp5J4gSa3+ZWISI6KjZikgJ4ERHj/Sr3SpWMM+t/
         oqWsLi+DJzAXzpblwqe01ebsP4UQt0XLeBvBNVWe1f0fZ6y0SVUBqGmKa25fqig3Uu
         lZTZ1pmFpWae898LUmGz+i4sbVJ4XyoXW6GPGdRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 060/314] IB/mlx5: Fix DEVX support for MLX5_CMD_OP_INIT2INIT_QP command
Date:   Tue, 23 Jun 2020 21:54:15 +0200
Message-Id: <20200623195341.685575311@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

[ Upstream commit d246a3061528be6d852156d25c02ea69d6db7e65 ]

The commit citied in the Fixes line wasn't complete and solved
only part of the problems. Update the mlx5_ib to properly support
MLX5_CMD_OP_INIT2INIT_QP command in the DEVX, that is required when
modify the QP tx_port_affinity.

Fixes: 819f7427bafd ("RDMA/mlx5: Add init2init as a modify command")
Link: https://lore.kernel.org/r/20200527135703.482501-1-leon@kernel.org
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/devx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index bba7ab0784305..fd75a9043bf15 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -489,6 +489,10 @@ static u64 devx_get_obj_id(const void *in)
 		obj_id = get_enc_obj_id(MLX5_CMD_OP_CREATE_QP,
 					MLX5_GET(rst2init_qp_in, in, qpn));
 		break;
+	case MLX5_CMD_OP_INIT2INIT_QP:
+		obj_id = get_enc_obj_id(MLX5_CMD_OP_CREATE_QP,
+					MLX5_GET(init2init_qp_in, in, qpn));
+		break;
 	case MLX5_CMD_OP_INIT2RTR_QP:
 		obj_id = get_enc_obj_id(MLX5_CMD_OP_CREATE_QP,
 					MLX5_GET(init2rtr_qp_in, in, qpn));
-- 
2.25.1



