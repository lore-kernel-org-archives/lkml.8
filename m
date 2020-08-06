Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8882FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF709206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgHFRxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:53:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50371 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbgHFQa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:30:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k3iRR-0001NL-01; Thu, 06 Aug 2020 16:08:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <eli@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] vdpa/mlx5: fix memory allocation failure checks
Date:   Thu,  6 Aug 2020 17:08:28 +0100
Message-Id: <20200806160828.90463-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The memory allocation failure checking for in and out is currently
checking if the pointers are valid rather than the contents of what
they point to. Hence the null check on failed memory allocations is
incorrect.  Fix this by adding the missing indirection in the check.
Also for the default case, just set the *in and *out to null as
these don't have any thing allocated to kfree. Finally remove the
redundant *in and *out check as these have been already done on each
allocation in the case statement.

Addresses-Coverity: ("Null pointer dereference")
Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3ec44a4f0e45..55bc58e1dae9 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -867,7 +867,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
 		*outlen = MLX5_ST_SZ_BYTES(qp_2rst_out);
 		*in = kzalloc(*inlen, GFP_KERNEL);
 		*out = kzalloc(*outlen, GFP_KERNEL);
-		if (!in || !out)
+		if (!*in || !*out)
 			goto outerr;
 
 		MLX5_SET(qp_2rst_in, *in, opcode, cmd);
@@ -879,7 +879,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
 		*outlen = MLX5_ST_SZ_BYTES(rst2init_qp_out);
 		*in = kzalloc(*inlen, GFP_KERNEL);
 		*out = kzalloc(MLX5_ST_SZ_BYTES(rst2init_qp_out), GFP_KERNEL);
-		if (!in || !out)
+		if (!*in || !*out)
 			goto outerr;
 
 		MLX5_SET(rst2init_qp_in, *in, opcode, cmd);
@@ -896,7 +896,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
 		*outlen = MLX5_ST_SZ_BYTES(init2rtr_qp_out);
 		*in = kzalloc(*inlen, GFP_KERNEL);
 		*out = kzalloc(MLX5_ST_SZ_BYTES(init2rtr_qp_out), GFP_KERNEL);
-		if (!in || !out)
+		if (!*in || !*out)
 			goto outerr;
 
 		MLX5_SET(init2rtr_qp_in, *in, opcode, cmd);
@@ -914,7 +914,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
 		*outlen = MLX5_ST_SZ_BYTES(rtr2rts_qp_out);
 		*in = kzalloc(*inlen, GFP_KERNEL);
 		*out = kzalloc(MLX5_ST_SZ_BYTES(rtr2rts_qp_out), GFP_KERNEL);
-		if (!in || !out)
+		if (!*in || !*out)
 			goto outerr;
 
 		MLX5_SET(rtr2rts_qp_in, *in, opcode, cmd);
@@ -927,16 +927,15 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
 		MLX5_SET(qpc, qpc, rnr_retry, 7);
 		break;
 	default:
-		goto outerr;
+		goto outerr_nullify;
 	}
-	if (!*in || !*out)
-		goto outerr;
 
 	return;
 
 outerr:
 	kfree(*in);
 	kfree(*out);
+outerr_nullify:
 	*in = NULL;
 	*out = NULL;
 }
-- 
2.27.0

