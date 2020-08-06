Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C01C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDF82177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwDiI7JR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgHFTZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:25:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1046C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:19:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so45050444wrl.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBU/pM3MYlEmZitwD1KhBWl8EEKhumB4q1qsW3XKr34=;
        b=DwDiI7JRoKfd2/50mvMUbKhYmterRGUW3oT7ZbKdfmD00qEpTgvlqq6Liqo6Xxq2Ac
         IDEOFJ9vfek3fTe4GivTbNOJSxdhPpmYXFlG57g17ii07PgbfsVHG/PdwRMVORw53WhR
         CTrupnia/072ruKaZKastIIW0MsEV7IeTagJyKabuBJpTF2SfOUA7lHgugcV47mvMl7o
         KN7OP25lO6CSsllz3c4NUUJNcoDAnhkK8ilWKZhHoDBgUSZX1tXrUddmHUzttCx9FhCU
         ySZGj/NdrmNx6vnPhU8CVcNRKqMPbudi25jZNGC/qzQZvjZQCx2aywWcIkn/XfHWm3jE
         2khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBU/pM3MYlEmZitwD1KhBWl8EEKhumB4q1qsW3XKr34=;
        b=trQUw2R8h80RQGahzE08MVDbnX6mcbBy9/D3lr8yLCLfKUYjQFDM8ddHUZIQs8PayV
         HdiTY40O5rhg8xLEFJWltmfjwUiHOLIXtMv/bz300M/3KPyamUB9yhOyzUI/6a+RD0s+
         6drSkScVMEaY8VYtih0G5EAcpzTXH2xYXE4N4Z7W8p1kJFszfFO6WgmZH51pA4Q1vWSK
         FJT3HETU06jUnLQgdbEe1ejYCkM6l15yI6c1xnj7wFp3IL4qHDlaPPQ+fyjLPbObMoYl
         PApDzY5Ahjeddy97QunCdlj4saxVJkztSjO98pfNL+GSgZwZzxNhoEI438PZsH5OUquG
         af4A==
X-Gm-Message-State: AOAM531jRFkzBcdp/2UEwYX54+OBL5vDWTpjmkvt53h0TBNSHm5Ms+na
        kBqtC/1rxHn+Dz3GVpEqeW0=
X-Google-Smtp-Source: ABdhPJwspMhA4inynCobhK/0zh+GzIEbqrp0SK1AaC9F08HZ3N5eUOyCbQjr+bHQfeHCb/tplUMHgg==
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr8464291wrf.309.1596741545387;
        Thu, 06 Aug 2020 12:19:05 -0700 (PDT)
Received: from localhost.localdomain (cpc83647-brig20-2-0-cust926.3-3.cable.virginm.net. [82.19.195.159])
        by smtp.gmail.com with ESMTPSA id f15sm7172154wmj.39.2020.08.06.12.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:19:04 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks
Date:   Thu,  6 Aug 2020 20:18:39 +0100
Message-Id: <20200806191849.82189-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In alloc_inout() in net/mlx5_vnet.c, there are a few places where memory
is allocated to *in and *out, but only the values of in and out are
null-checked (i.e. there is a missing dereference). Fix this.

Addresses-Coverity: ("CID 1496603: (REVERSE_INULL)")
Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3ec44a4f0e45..bcb6600c2839 100644
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
-- 
2.28.0

