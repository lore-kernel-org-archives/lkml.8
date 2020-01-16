Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9149C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8404E2064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218379;
	bh=s8TLmbI5O28ao/0WFz+LLo1bxPeLMw8soqZjjhXbPtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ApdB/ONqbYCks0hBx7FbvgxYiKlfW+lvzi7akPu7vVL6rF71cPAwI7wUu/fHiBLl
	 cNyGettpK/xS5JHhTjdaSrf0B4y10TOJgNf1KOmgbIne2Yog6PL0Fy0vIlaAb4SFxM
	 G5S9g1du5OXhciDqsavNvLqpFRKUbhX5ZUyQvJkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbgAPXWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:22:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388394AbgAPXWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:22:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA3F2075B;
        Thu, 16 Jan 2020 23:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216922;
        bh=s8TLmbI5O28ao/0WFz+LLo1bxPeLMw8soqZjjhXbPtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ST6rDSsCD8IORsUu7D6G889UVLcd8M1asu+m4h3JHuySqrU5reDEscGoe6SnJv6PY
         +1dt6wmELfLmXc3Q5h9GxtPKIVJb8xUkxBGpb1d/rYHx81qlVSjVk0M+qIfGi1fgZI
         5A6BdKcJz4C/6TUnzCVl6LvBemt2Pzs/iQ2EBoJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 075/203] RDMA/mlx5: Return proper error value
Date:   Fri, 17 Jan 2020 00:16:32 +0100
Message-Id: <20200116231750.786477600@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

commit 546d30099ed204792083f043cd7e016de86016a3 upstream.

Returned value from mlx5_mr_cache_alloc() is checked to be error or real
pointer. Return proper error code instead of NULL which is not checked
later.

Fixes: 81713d3788d2 ("IB/mlx5: Add implicit MR support")
Link: https://lore.kernel.org/r/20191029055721.7192-1-leon@kernel.org
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/mr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -428,7 +428,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(s
 
 	if (entry < 0 || entry >= MAX_MR_CACHE_ENTRIES) {
 		mlx5_ib_err(dev, "cache entry %d is out of range\n", entry);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	ent = &cache->ent[entry];


