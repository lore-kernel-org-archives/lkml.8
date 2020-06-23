Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3107C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18D12064B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943787;
	bh=a/lHXKCVrLSIa+JZAQDjfBCBrAxsRAXKYhxhhT2WEWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TAMaNVw2Rxkk2irbzhcdcy/pg+ZZ9SRKsC8assXclNi7+yWjsOQ8F5627LP7f+jTc
	 MW2231MIetgibuSXvat9Xxup+I0tKzNWmQuIvykhMgRp5lNzU6HtIHSf/z5XJ6hyGK
	 lVQlhf3FsGzlcTdSzwkMe73d34uobqyLhVgPElqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390252AbgFWUXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390196AbgFWUW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:22:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB512070E;
        Tue, 23 Jun 2020 20:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943776;
        bh=a/lHXKCVrLSIa+JZAQDjfBCBrAxsRAXKYhxhhT2WEWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=01mvzEwrYS+WHwuFNvcWgj1bKSEFIEnbJWq4sGGeBJDfQIgxD2CpVrjvRLust5Yr4
         e4M0oOmTuHUbi6KDRx3bRdtDCx9nhAh376fglr0DnZkOlyCQpFr0ODClclwCQ6ibwH
         GthSt3tH3oDUs85rt6Cx8goK4SAYBP92e/2vzIlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aharon Landau <aharonl@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 047/314] RDMA/mlx5: Add init2init as a modify command
Date:   Tue, 23 Jun 2020 21:54:02 +0200
Message-Id: <20200623195341.055550965@linuxfoundation.org>
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
index d609f4659afb7..bba7ab0784305 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -814,6 +814,7 @@ static bool devx_is_obj_modify_cmd(const void *in)
 	case MLX5_CMD_OP_SET_L2_TABLE_ENTRY:
 	case MLX5_CMD_OP_RST2INIT_QP:
 	case MLX5_CMD_OP_INIT2RTR_QP:
+	case MLX5_CMD_OP_INIT2INIT_QP:
 	case MLX5_CMD_OP_RTR2RTS_QP:
 	case MLX5_CMD_OP_RTS2RTS_QP:
 	case MLX5_CMD_OP_SQERR2RTS_QP:
-- 
2.25.1



