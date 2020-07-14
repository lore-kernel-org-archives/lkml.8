Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655E1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39271207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753079;
	bh=iAix+odTu5gBFd40uh7vpisp2QYBWz+szMkM3yv+AcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=syJVsBxQB/mf8Tds3eSJNRLi0M66HMtLxuLX9IIh1SjaQZBdCcluLhjRXpqOA7Fbm
	 g1bTYch87ttf2TvZPFfZIraC14Ndwr/u1IohUiGC6IS9ULh8gOxCgyFnN2Ib3G8C86
	 3CjEdtdGkjnsT0xtqcY8dHtxJOe3W6H5lqy+sL+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgGNS55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731105AbgGNS5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:57:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 704E0207F5;
        Tue, 14 Jul 2020 18:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753072;
        bh=iAix+odTu5gBFd40uh7vpisp2QYBWz+szMkM3yv+AcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JswMJrsYEBPirwtSrgDUL6M9n++eICTZvPLE8codxXE2ujeMHwbXtBYgb0zDClyqW
         1iQV6dPRvSZ8n2yDELs3Jk/MRPukHK06U4iG/SbfwRwaGkeLN6UvOQ0TH4xwLcD8Da
         Y2AHrDQTf1FQ+3zeG2vgiw3x6V2MtHLqhONrAo0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 091/166] IB/mlx5: Fix 50G per lane indication
Date:   Tue, 14 Jul 2020 20:44:16 +0200
Message-Id: <20200714184120.200773750@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 530c8632b547ff72f11ff83654b22462a73f1f7b ]

Some released FW versions mistakenly don't set the capability that 50G per
lane link-modes are supported for VFs (ptys_extended_ethernet capability
bit).

Use PTYS.ext_eth_proto_capability instead, as this indication is always
accurate. If PTYS.ext_eth_proto_capability is valid
(has a non-zero value) conclude that the HCA supports 50G per lane.

Otherwise, conclude that the HCA doesn't support 50G per lane.

Fixes: 08e8676f1607 ("IB/mlx5: Add support for 50Gbps per lane link modes")
Link: https://lore.kernel.org/r/20200707110612.882962-3-leon@kernel.org
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6679756506e60..820e407b3e260 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -515,7 +515,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 					   mdev_port_num);
 	if (err)
 		goto out;
-	ext = MLX5_CAP_PCAM_FEATURE(dev->mdev, ptys_extended_ethernet);
+	ext = !!MLX5_GET_ETH_PROTO(ptys_reg, out, true, eth_proto_capability);
 	eth_prot_oper = MLX5_GET_ETH_PROTO(ptys_reg, out, ext, eth_proto_oper);
 
 	props->active_width     = IB_WIDTH_4X;
-- 
2.25.1



