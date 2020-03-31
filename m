Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D09920B80
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645523;
	bh=DPpZNpF3Vu+vM8Zu77MZehGo4UXKVkDd1qqj75mah7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WADLJuGGjII+TVm+KQCbocst3h/XLXJA9bKur8MhNEfX62S/DkaU4nOxef7VmRABZ
	 xJLSjWcOcaKnfGOx5hEs7jqmp/5ndQJz9lnnGHT3ZTuy03noNqp1JyHpkbtSmJfU/e
	 1XSnGJ9PEFsygv9OF5Osl0+Hp/2nWCKD4XsfhE5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbgCaJE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730403AbgCaJEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:04:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D66D20675;
        Tue, 31 Mar 2020 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645464;
        bh=DPpZNpF3Vu+vM8Zu77MZehGo4UXKVkDd1qqj75mah7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Re/QmIzx1HW4DChMRJKDKwjs3ee59BdL+M2Xn/GmPCnOnkGrzFkJiNVLuazL5E418
         ivGQ9J4fs/P+cgva4hhJQVmkDKbgLXP6J90880K89ZvNjeHswKRemdW1BSRuLdafZQ
         x7agaZ+wG5TQR5VZd7bnqTEr4oLSD12zTVMNytYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 061/170] net/mlx5_core: Set IB capability mask1 to fix ib_srpt connection failure
Date:   Tue, 31 Mar 2020 10:57:55 +0200
Message-Id: <20200331085431.001143650@linuxfoundation.org>
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

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit 306f354c67397b3138300cde875c5cab45b857f7 ]

The cap_mask1 isn't protected by field_select and not listed among RW
fields, but it is required to be written to properly initialize ports
in IB virtualization mode.

Link: https://lore.kernel.org/linux-rdma/88bab94d2fd72f3145835b4518bc63dda587add6.camel@redhat.com
Fixes: ab118da4c10a ("net/mlx5: Don't write read-only fields in MODIFY_HCA_VPORT_CONTEXT command")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -1071,6 +1071,9 @@ int mlx5_core_modify_hca_vport_context(s
 		MLX5_SET64(hca_vport_context, ctx, port_guid, req->port_guid);
 	if (req->field_select & MLX5_HCA_VPORT_SEL_NODE_GUID)
 		MLX5_SET64(hca_vport_context, ctx, node_guid, req->node_guid);
+	MLX5_SET(hca_vport_context, ctx, cap_mask1, req->cap_mask1);
+	MLX5_SET(hca_vport_context, ctx, cap_mask1_field_select,
+		 req->cap_mask1_perm);
 	err = mlx5_cmd_exec(dev, in, in_sz, out, sizeof(out));
 ex:
 	kfree(in);


