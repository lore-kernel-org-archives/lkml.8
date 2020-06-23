Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684FEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326AF20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946431;
	bh=zxQyyLtD996EZcvH5NyTe9/WJiecHNn8RzhHOeffVXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mn7QsHaRdrD1rMwYKmtivp6rO5/5Av50TfcRWhbVjYcV1HQU/9dXZ56BN8y5snsvS
	 6msG2FByKW4fA+H3Otg+4MLDpu8d1VMsARVNgLb88kopZm4avAE9+xyS9PYbak+k02
	 dyGKfzuhJCm11qFLSKfs5pruc+4zvkYQUXB9UfXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393208AbgFWVHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387904AbgFWUfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:35:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F462080C;
        Tue, 23 Jun 2020 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944532;
        bh=zxQyyLtD996EZcvH5NyTe9/WJiecHNn8RzhHOeffVXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHMcf1ywXasgwrwKD1rZJDxgoHUo1oMZK1ESbpQm0HDW313A7k5t/7HQlbt3dJMyq
         1aZEVmMXm3FrQ6RXv44swzo7/gupxuyqew/JQJM5Fp4t0h3oFhzUzcbXUZ0jqhGwiO
         xORz1Z/lS3LbaTuvtEsRA1vlUzNaWD/OBfkk3a68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aharon Landau <aharonl@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/206] RDMA/mlx5: Add init2init as a modify command
Date:   Tue, 23 Jun 2020 21:55:54 +0200
Message-Id: <20200623195318.265184999@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aharon Landau <aharonl@mellanox.com>

[ Upstream commit 819f7427bafd494ef7ca4942ec6322db20722d7b ]

Missing INIT2INIT entry in the list of modify commands caused DEVX
applications to be unable to modify_qp for this transition state. Add the
MLX5_CMD_OP_INIT2INIT_QP opcode to the list of allowed DEVX opcodes.

Fixes: e662e14d801b ("IB/mlx5: Add DEVX support for modify and query commands")
Link: https://lore.kernel.org/r/20200513095550.211345-1-leon@kernel.org
Signed-off-by: Aharon Landau <aharonl@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/devx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 02f36ab72ad42..4c90a007e09db 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -328,6 +328,7 @@ static bool devx_is_obj_modify_cmd(const void *in)
 	case MLX5_CMD_OP_SET_L2_TABLE_ENTRY:
 	case MLX5_CMD_OP_RST2INIT_QP:
 	case MLX5_CMD_OP_INIT2RTR_QP:
+	case MLX5_CMD_OP_INIT2INIT_QP:
 	case MLX5_CMD_OP_RTR2RTS_QP:
 	case MLX5_CMD_OP_RTS2RTS_QP:
 	case MLX5_CMD_OP_SQERR2RTS_QP:
-- 
2.25.1



